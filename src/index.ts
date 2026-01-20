/**
 * Welcome to Cloudflare Workers! This is your first worker.
 *
 * - Run `npm run dev` in your terminal to start a development server
 * - Open a browser tab at http://localhost:8787/ to see your worker in action
 * - Run `npm run deploy` to publish your worker
 *
 * Bind resources to your worker in `wrangler.jsonc`. After adding bindings, a type definition for the
 * `Env` object can be regenerated with `npm run cf-typegen`.
 *
 * Learn more at https://developers.cloudflare.com/workers/
 */

interface Env {
	DB: D1Database;
	AI: any;
	EXPLANATIONS: KVNamespace;
  }
  
  interface Feedback {
	id: number;
	text: string;
	source: string;
	user_type: string;
	timestamp: string;
	confidence: string;
	theme: string;
	labels: string;
  }
  
  export default {
	async fetch(request: Request, env: Env): Promise<Response> {
	  const url = new URL(request.url);
	  
	  // CORS headers for development
	  const corsHeaders = {
		'Access-Control-Allow-Origin': '*',
		'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
		'Access-Control-Allow-Headers': 'Content-Type',
	  };
  
	  // Handle CORS preflight
	  if (request.method === 'OPTIONS') {
		return new Response(null, { headers: corsHeaders });
	  }
  
	  try {
		// API Routes
		if (url.pathname === '/api/feedback') {
		  return await handleGetFeedback(env, corsHeaders);
		}
  
		if (url.pathname.startsWith('/api/feedback/')) {
		  const id = url.pathname.split('/')[3];
		  return await handleGetFeedbackById(env, id, corsHeaders);
		}
  
		if (url.pathname.startsWith('/api/explain/')) {
		  const id = url.pathname.split('/')[3];
		  return await handleExplainFeedback(env, id, corsHeaders);
		}

		if (url.pathname === '/api/chat') {
		  return await handleChat(env, request, corsHeaders);
		}

		// Default: return error for undefined routes
		return new Response('Not Found', { 
		  status: 404,
		  headers: corsHeaders 
		});
  
	  } catch (error) {
		console.error('Error:', error);
		return new Response(JSON.stringify({ error: 'Internal Server Error' }), {
		  status: 500,
		  headers: { ...corsHeaders, 'Content-Type': 'application/json' },
		});
	  }
	},
  };
  
  // Get all feedback
  async function handleGetFeedback(env: Env, corsHeaders: Record<string, string>): Promise<Response> {
	const result = await env.DB.prepare(
	  'SELECT * FROM feedback ORDER BY timestamp DESC'
	).all();
  
	const feedback = result.results.map((item: any) => ({
	  ...item,
	  labels: JSON.parse(item.labels || '[]'),
	}));
  
	return new Response(JSON.stringify(feedback), {
	  headers: { ...corsHeaders, 'Content-Type': 'application/json' },
	});
  }
  
  // Get single feedback by ID
  async function handleGetFeedbackById(env: Env, id: string, corsHeaders: Record<string, string>): Promise<Response> {
	const result = await env.DB.prepare(
	  'SELECT * FROM feedback WHERE id = ?'
	).bind(id).first();
  
	if (!result) {
	  return new Response(JSON.stringify({ error: 'Feedback not found' }), {
		status: 404,
		headers: { ...corsHeaders, 'Content-Type': 'application/json' },
	  });
	}
  
	const feedback = {
	  ...result,
	  labels: JSON.parse((result as any).labels || '[]'),
	};
  
	return new Response(JSON.stringify(feedback), {
	  headers: { ...corsHeaders, 'Content-Type': 'application/json' },
	});
  }
  
  // Generate AI explanation for confidence score
  async function handleExplainFeedback(env: Env, id: string, corsHeaders: Record<string, string>): Promise<Response> {
	// Check KV cache first
	const cacheKey = `explanation:${id}`;
	const cached = await env.EXPLANATIONS.get(cacheKey);
	
	if (cached) {
	  return new Response(cached, {
		headers: { ...corsHeaders, 'Content-Type': 'application/json' },
	  });
	}
  
	// Get feedback from DB
	const feedback = await env.DB.prepare(
	  'SELECT * FROM feedback WHERE id = ?'
	).bind(id).first() as Feedback | null;
  
	if (!feedback) {
	  return new Response(JSON.stringify({ error: 'Feedback not found' }), {
		status: 404,
		headers: { ...corsHeaders, 'Content-Type': 'application/json' },
	  });
	}
  
	// Generate explanation with Workers AI
	const prompt = `You are a product manager assistant analyzing customer feedback confidence scores.
  
  Feedback: "${feedback.text}"
  Source: ${feedback.source}
  User Type: ${feedback.user_type}
  Confidence Level: ${feedback.confidence}
  Labels: ${feedback.labels}
  
  Explain in 2-3 sentences why this feedback received a ${feedback.confidence} confidence score. Focus on:
  - Specificity and actionability
  - User credibility and context
  - Evidence and reproducibility
  
  Keep it concise and PM-friendly.`;
  
	const aiResponse = await env.AI.run('@cf/meta/llama-3-8b-instruct', {
	  messages: [
		{ role: 'system', content: 'You are a helpful PM assistant. Be concise and clear.' },
		{ role: 'user', content: prompt }
	  ],
	  max_tokens: 200,
	});
  
	const explanation = aiResponse.response || 'Unable to generate explanation.';
  
	// Generate action recommendations for high confidence feedback
	let actions: string[] = [];
	if (feedback.confidence === 'high') {
	  const actionPrompt = `Based on this high-confidence feedback: "${feedback.text}"
  
  Suggest 2-3 specific, actionable next steps a PM should take. Be brief and concrete.`;
  
	  const actionResponse = await env.AI.run('@cf/meta/llama-3-8b-instruct', {
		messages: [
		  { role: 'system', content: 'You are a PM assistant. Provide specific, actionable recommendations.' },
		  { role: 'user', content: actionPrompt }
		],
		max_tokens: 150,
	  });
  
	  const actionText = actionResponse.response || '';
	  actions = actionText
		.split('\n')
		.filter((line: string) => line.trim().length > 0 && (line.includes('-') || line.includes('1.') || line.includes('2.')))
		.map((line: string) => line.replace(/^[-•*\d.]\s*/, '').trim())
		.slice(0, 3);
	}
  
	const result = {
	  explanation,
	  actions: feedback.confidence === 'high' ? actions : [],
	  confidence: feedback.confidence,
	};
  
	// Cache for 1 hour
	await env.EXPLANATIONS.put(cacheKey, JSON.stringify(result), {
	  expirationTtl: 3600,
	});
  
	return new Response(JSON.stringify(result), {
	  headers: { ...corsHeaders, 'Content-Type': 'application/json' },
	});
  }

  // Handle chat requests
  async function handleChat(env: Env, request: Request, corsHeaders: Record<string, string>): Promise<Response> {
	if (request.method !== 'POST') {
	  return new Response(JSON.stringify({ error: 'Method not allowed' }), {
		status: 405,
		headers: { ...corsHeaders, 'Content-Type': 'application/json' },
	  });
	}

	try {
	  const body = await request.json() as { question: string; feedbackSummary: any };
	  
	  if (!body.question || !body.feedbackSummary) {
		return new Response(JSON.stringify({ error: 'Missing question or feedbackSummary' }), {
		  status: 400,
		  headers: { ...corsHeaders, 'Content-Type': 'application/json' },
		});
	  }

	  // Build context from feedback summary
	  const themesList = body.feedbackSummary.themes
		.map((t: any) => `- ${t.theme}: ${t.count} items (${t.highCount} high, ${t.mediumCount} medium, ${t.lowCount} low)`)
		.join('\n');

	  const topThemesList = body.feedbackSummary.topItems
		.map((t: any) => `- ${t.theme}: ${t.highCount} high-confidence items`)
		.join('\n');

	  const prompt = `You are an AI assistant helping a product manager analyze customer feedback data.

Feedback Summary:
- Total feedback items: ${body.feedbackSummary.counts.total}
- High confidence: ${body.feedbackSummary.counts.high}
- Medium confidence: ${body.feedbackSummary.counts.medium}
- Low confidence: ${body.feedbackSummary.counts.low}

Themes:
${themesList}

Top Themes by High-Confidence Items:
${topThemesList}

User Question: "${body.question}"

Provide a helpful, concise answer (2-4 sentences) about the feedback data. Focus on actionable insights and patterns. Be conversational and PM-friendly.`;

	  const aiResponse = await env.AI.run('@cf/meta/llama-3-8b-instruct', {
		messages: [
		  { role: 'system', content: 'You are a helpful product management assistant. Provide clear, actionable insights about customer feedback data. Be concise and professional.' },
		  { role: 'user', content: prompt }
		],
		max_tokens: 300,
	  });

	  const response = aiResponse.response || 'I apologize, but I could not generate a response. Please try rephrasing your question.';

	  return new Response(JSON.stringify({ response }), {
		headers: { ...corsHeaders, 'Content-Type': 'application/json' },
	  });

	} catch (error) {
	  console.error('Chat error:', error);
	  return new Response(JSON.stringify({ error: 'Failed to process chat request', response: 'Sorry, there was an error processing your question. Please try again.' }), {
		status: 500,
		headers: { ...corsHeaders, 'Content-Type': 'application/json' },
	  });
	}
  }