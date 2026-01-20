INSERT INTO feedback (text, source, user_type, confidence, theme, labels) VALUES
-- High Signal (~30 items)
('Workers cold start latency is killing our API performance. Measured 800ms+ delays on first request across all EU regions. This affects every single one of our customers.', 'github', 'power_user', 'high', 'performance', '["Technically precise", "Repeated across sources", "High impact"]'),
('Workers cold starts add ~900ms to the first request after deploy. Our SLOs assume sub-300ms p95 so this is a blocker for adoption.', 'support', 'enterprise', 'high', 'performance', '["SLO impact", "Cold start", "Enterprise account"]'),
('Every morning our first run of scheduled jobs hits a massive latency spike on Workers. It looks like the entire cluster is cold.', 'discord', 'power_user', 'high', 'performance', '["Pattern over time", "Cron jobs", "High signal"]'),
('We ran a controlled test comparing Workers vs Lambda and Workers was consistently slower for the first hit of any route. Subsequent hits are fast.', 'github', 'power_user', 'high', 'performance', '["Competitor comparison", "Measured", "High impact"]'),

('The D1 binding configuration in wrangler.toml keeps failing. Tried the exact example from docs - still getting "binding not found" errors. Spent 3 hours debugging this.', 'discord', 'power_user', 'high', 'docs', '["Specific error details", "Documentation gap", "Time-consuming"]'),
('Docs for D1 migrations are incomplete. The examples skip over how to run migrations in CI, which is where most teams actually need it.', 'github', 'power_user', 'high', 'docs', '["Missing CI guidance", "Repeated internal questions", "High friction"]'),
('KV docs bury basic examples under multiple advanced sections. I just want a simple read/write example for a Worker route.', 'support', 'new_user', 'high', 'docs', '["Onboarding friction", "Basic examples missing", "Common request"]'),

('Wrangler dev command crashes on M1 Macs when using D1 bindings. Happens 100% of the time. Error: "Cannot find module @esbuild/darwin-arm64". Multiple users confirming same issue.', 'github', 'power_user', 'high', 'dev_experience', '["Reproducible bug", "Platform-specific", "Multiple reports"]'),
('On Apple Silicon, wrangler dev fails unless we manually install a specific esbuild binary. This workaround is not in the docs.', 'discord', 'power_user', 'high', 'dev_experience', '["Apple Silicon", "Known workaround", "Docs missing"]'),
('Local dev loop is too slow. Any change in code forces a full rebuild of the Worker. We need hot reload or at least partial reload.', 'support', 'enterprise', 'high', 'dev_experience', '["Slow iteration", "Developer frustration", "Enterprise pilot at risk"]'),

('Local development workflow is broken. Every code change requires full restart of wrangler dev (takes 15-20 seconds). No hot reload support makes iteration painfully slow.', 'support', 'enterprise', 'high', 'dev_experience', '["Workflow blocker", "Productivity impact", "Enterprise user"]'),
('Our team of 12 devs is losing hours per week waiting for wrangler dev to restart. This makes it hard to justify moving more workloads to Workers.', 'support', 'enterprise', 'high', 'dev_experience', '["Time cost", "Scaling concern", "Decision blocker"]'),

('Workers AI responses are inconsistent. Same prompt gives different results on subsequent calls. This is a dealbreaker for production use - we need deterministic outputs.', 'discord', 'power_user', 'high', 'ai_reliability', '["Production blocker", "Consistency issue", "Critical for use case"]'),
('When using Workers AI for summarization, we get significantly different summaries for the same input across requests. We need a stability mode.', 'github', 'power_user', 'high', 'ai_reliability', '["AI variability", "Feature request", "High signal"]'),
('Our legal team requires deterministic AI behavior for audit reasons. Today, Workers AI feels non-deterministic even with fixed prompts.', 'support', 'enterprise', 'high', 'ai_reliability', '["Compliance risk", "Enterprise", "Clear requirement"]'),

('No way to see real-time console.log output during development. The wrangler tail command only works after deployment. This makes debugging nearly impossible.', 'twitter', 'power_user', 'high', 'observability_logs', '["Missing feature", "Development friction", "Common complaint"]'),
('Logs only show up reliably after deploy. During local dev we have almost no visibility into what the Worker is doing. Need a proper dev console.', 'discord', 'power_user', 'high', 'observability_logs', '["Logging gap", "Local dev", "High signal"]'),
('Our SRE team cannot correlate Worker errors to specific customer requests because logs lack correlation IDs out of the box.', 'support', 'enterprise', 'high', 'observability_logs', '["Correlation IDs", "SRE use case", "Observability"]'),

('D1 database migrations fail silently in production but work locally. No error messages, just empty database after deploy. Lost customer data twice before figuring this out.', 'support', 'enterprise', 'high', 'deployments', '["Data loss risk", "Production issue", "Silent failure"]'),
('Blue/green style deployments for Workers with D1 feel risky because schema mismatches fail quietly. We need migration checks before cutover.', 'github', 'enterprise', 'high', 'deployments', '["Pre-deploy checks", "Schema drift", "High impact"]'),

('Our billing spike last month was unexpected. It looks like Workers egress costs are not clearly shown in the dashboard until after the fact.', 'support', 'enterprise', 'high', 'billing', '["Billing surprise", "Dashboard gap", "Finance escalation"]'),
('Usage-based billing for Workers AI is hard to predict. We need a cost estimator based on token usage before enabling a feature.', 'support', 'product_manager', 'high', 'billing', '["Cost predictability", "Estimator needed", "High signal"]'),

('API ergonomics for handling request bodies is painful. Streaming vs buffering is inconsistent across examples and Typescript types.', 'github', 'power_user', 'high', 'api_ergonomics', '["DX issue", "Streaming confusion", "Types mismatch"]'),
('Workers router ergonomics lag behind frameworks like Next.js or Remix. Basic routing feels verbose and low-level.', 'discord', 'power_user', 'high', 'api_ergonomics', '["Routing pain", "Framework comparison", "High signal"]'),
('Security reviews keep flagging our Workers because CSP and headers are difficult to configure correctly across environments.', 'support', 'security_engineer', 'high', 'security', '["Security headers", "Env parity", "Risk for adoption"]'),
('Security scanning tools struggle to understand Workers deployment model. We need guidance on how to integrate standard SAST/DAST tools.', 'github', 'security_engineer', 'high', 'security', '["Tooling gap", "Security integrations", "High impact"]'),

-- Medium Signal (~60 items)
('Wrangler dev doesnt work on my M1 Mac. Not sure if its my setup or a bug? Getting weird errors.', 'twitter', 'new_user', 'medium', 'dev_experience', '["Vague error", "Possible user error", "Platform mention"]'),
('Sometimes wrangler dev hangs after a file change and I have to Ctrl+C and restart. Annoying but not a total blocker.', 'discord', 'power_user', 'medium', 'dev_experience', '["Intermittent issue", "Annoyance", "Hard to repro"]'),
('The docs for KV bindings are confusing. Took me an hour to figure out the syntax. Examples would help.', 'discord', 'new_user', 'medium', 'docs', '["Subjective complaint", "Learning curve", "Suggestion included"]'),
('KV namespacing rules are not obvious at first. We accidentally wrote to the wrong namespace in staging because of similar IDs.', 'support', 'product_engineer', 'medium', 'docs', '["Namespace confusion", "Staging", "Config"]'),
('Workers are slower than expected. My API endpoints take 200-300ms to respond. Is this normal?', 'github', 'new_user', 'medium', 'performance', '["Lacks context", "Possible misconfiguration", "Asking for baseline"]'),
('Our p95 latency is okay but tail latency spikes occasionally without clear reasons. Hard to debug.', 'support', 'enterprise', 'medium', 'performance', '["Tail latency", "Debug difficulty", "Observability"]'),
('AI model responses take 2-3 seconds. Is there a way to make this faster? Impacts user experience.', 'discord', 'power_user', 'medium', 'performance', '["Performance concern", "Limited details", "UX impact mentioned"]'),
('Workers dashboard feels a bit cluttered. Logs and traces are in different places and hard to correlate.', 'twitter', 'new_user', 'medium', 'observability_logs', '["Navigation issue", "UX", "Mild frustration"]'),

('The Cloudflare dashboard UI for Workers is cluttered. Hard to find the logs section.', 'twitter', 'new_user', 'medium', 'observability_logs', '["Subjective opinion", "Navigation issue", "Minor complaint"]'),
('We would love a single view that shows Worker routes, error rates, and related logs without jumping between tabs.', 'support', 'product_manager', 'medium', 'observability_logs', '["Unified view", "PM request", "Signal"]'),

('Getting rate limited by Workers AI but cant find documentation on limits. How many requests can I make?', 'support', 'power_user', 'medium', 'docs', '["Documentation gap", "Unclear limits", "Valid question"]'),
('Rate limit errors from Workers AI are not very descriptive. We just see generic 429s without guidance.', 'github', 'power_user', 'medium', 'api_ergonomics', '["Error messaging", "Rate limits", "API clarity"]'),

('D1 database queries are timing out after 30 seconds. Is this configurable? Need longer timeout for complex queries.', 'github', 'enterprise', 'medium', 'deployments', '["Configuration question", "Use case specific", "Workaround possible"]'),
('We sometimes see D1 query errors at peak traffic, but logs dont clearly show which query failed.', 'support', 'enterprise', 'medium', 'deployments', '["Operational visibility", "D1", "Peak load"]'),

('Wrangler CLI error messages are cryptic. Just got "Error: failed to build" with no additional context.', 'discord', 'new_user', 'medium', 'dev_experience', '["Poor error handling", "Common complaint", "Lacks specifics"]'),
('When a deploy fails due to a bad binding, wrangler just says "deploy failed" without pointing to the specific binding.', 'github', 'power_user', 'medium', 'dev_experience', '["Binding errors", "Error clarity", "Medium signal"]'),

('Workers deployment takes 3-5 minutes. Is this normal? Other platforms deploy in under 1 minute.', 'twitter', 'power_user', 'medium', 'deployments', '["Comparison to competitors", "Lacks context", "Subjective timeline"]'),
('Staged rollouts would help a lot. Right now a bad deploy can impact all traffic immediately.', 'support', 'product_manager', 'medium', 'deployments', '["Gradual rollout", "Feature request", "Risk management"]'),

('The pricing page doesnt clearly explain D1 costs. How much will I pay for 1M database queries?', 'support', 'new_user', 'medium', 'billing', '["Documentation clarity", "Business concern", "Valid question"]'),
('Im still not sure how Workers AI billing works across multiple models. Are there per-model prices?', 'discord', 'new_user', 'medium', 'billing', '["Pricing confusion", "Multiple models", "Docs gap"]'),

('We need clearer guidance on logging PII safely. Right now it is easy to accidentally log sensitive data to analytics.', 'support', 'security_engineer', 'medium', 'security', '["PII handling", "Best practices", "Docs request"]'),
('Security headers examples in the docs are helpful but dont cover multi-tenant scenarios.', 'github', 'security_engineer', 'medium', 'security', '["Multi-tenant", "Security headers", "Docs incomplete"]'),

('API ergonomics around fetch and response handling are mostly fine, but streaming APIs still feel low-level.', 'github', 'power_user', 'medium', 'api_ergonomics', '["Streaming", "DX", "Medium signal"]'),
('Workers Sites integration with modern frameworks is confusing; too many different guides for React, Svelte, etc.', 'discord', 'new_user', 'medium', 'dev_experience', '["Framework fragmentation", "Docs", "DX"]'),

('Billing alerts would be helpful. Right now we only notice spikes at the end of the month.', 'support', 'finance_manager', 'medium', 'billing', '["Alerts", "Cost control", "Medium impact"]'),
('Id like to tag Workers by team or project so we can allocate cost back to the right budget.', 'support', 'product_manager', 'medium', 'billing', '["Cost allocation", "Tagging", "Feature request"]'),

('Logs from scheduled Workers are hard to discover. They dont show up where we expect them in the dashboard.', 'support', 'enterprise', 'medium', 'observability_logs', '["Cron logs", "Discoverability", "UX"]'),
('It would be useful to export logs directly to our existing observability stack (Datadog, New Relic) without extra glue code.', 'github', 'sre', 'medium', 'observability_logs', '["Integration", "3rd party", "Medium signal"]'),

('Performance is generally good, but we occasionally see p99 spikes without a clear reason.', 'support', 'enterprise', 'medium', 'performance', '["p99 spikes", "Unclear root cause", "Needs tooling"]'),
('For some endpoints, Workers is slower than our existing Node services in GCP, but we havent tuned anything yet.', 'support', 'backend_engineer', 'medium', 'performance', '["Baseline comparison", "Room to optimize", "Honest feedback"]'),

('I wish there was a guided onboarding flow for setting up a full stack app (API + KV + D1) rather than separate docs.', 'discord', 'new_user', 'medium', 'dev_experience', '["Onboarding", "End-to-end", "Medium signal"]'),
('Docs are okay once you know what to search for, but discoverability of new features is poor.', 'twitter', 'power_user', 'medium', 'docs', '["Discoverability", "Feature awareness", "Medium"]'),

('AI integration examples are mostly chatbots. Wed like to see more examples around analytics and internal tools.', 'github', 'product_manager', 'medium', 'api_ergonomics', '["Example coverage", "AI", "Medium"]'),
('The Workers AI playground is nice but doesnt show code snippets for all languages we use.', 'discord', 'power_user', 'medium', 'dev_experience', '["Playground gap", "Language coverage", "Medium"]'),

('Custom domains for Workers are powerful but the UX for configuring DNS + routes is still confusing for some teammates.', 'support', 'new_user', 'medium', 'dev_experience', '["DNS complexity", "Routes", "Medium signal"]'),
('Access logs for security audits are available, but exporting them for long-term retention is not obvious.', 'support', 'security_engineer', 'medium', 'security', '["Audit logs", "Retention", "Docs"]'),

('We sometimes hit 100ms+ DNS resolution times before Workers is even involved. Hard to debug where time is spent.', 'github', 'sre', 'medium', 'performance', '["DNS latency", "End-to-end", "Medium"]'),
('The CLI is powerful but feels overwhelming. Id love a "simple" mode with just init/dev/deploy.', 'twitter', 'new_user', 'medium', 'dev_experience', '["CLI complexity", "New user", "Medium"]'),

-- Low Signal (~40 items)
('Workers suck! Nothing works!', 'twitter', 'new_user', 'low', 'general', '["High emotion", "No specifics", "Vague complaint"]'),
('Why is everything so complicated???', 'discord', 'new_user', 'low', 'general', '["Emotional", "No actionable details", "Subjective"]'),
('I hate this. Going back to AWS.', 'twitter', 'new_user', 'low', 'general', '["Emotional reaction", "No explanation", "Competitor mention"]'),
('Cloudflare is the worst. Cant figure anything out.', 'twitter', 'new_user', 'low', 'general', '["Vague complaint", "Likely user error", "No specifics"]'),
('This is garbage. Deleted my account.', 'twitter', 'new_user', 'low', 'general', '["Pure emotion", "No feedback value", "Extreme reaction"]'),
('Workers might be slow? Or maybe my code is bad. Idk.', 'discord', 'new_user', 'low', 'performance', '["Uncertain", "Self-doubt", "No data"]'),
('I think theres a bug but Im not sure.', 'github', 'new_user', 'low', 'general', '["Uncertain", "No reproduction steps", "Vague"]'),
('Something is broken. Please fix.', 'support', 'new_user', 'low', 'general', '["No details", "Not actionable", "Generic complaint"]'),
('Your product is bad and you should feel bad.', 'twitter', 'new_user', 'low', 'general', '["Pure hostility", "No feedback", "Troll-like"]'),
('Why doesnt this work like Vercel?', 'discord', 'new_user', 'low', 'general', '["Different product expectations", "No specifics", "Competitor comparison"]'),
('Im confused.', 'twitter', 'new_user', 'low', 'general', '["Zero context", "Not actionable", "Too vague"]'),
('Workers are fine I guess. Could be better.', 'twitter', 'new_user', 'low', 'general', '["Lukewarm", "No specifics", "No actionable feedback"]'),
('The logo is ugly lol', 'twitter', 'new_user', 'low', 'design', '["Irrelevant", "Subjective", "Off-topic"]'),

('This whole serverless thing is overrated. Give me a plain VM any day.', 'twitter', 'new_user', 'low', 'general', '["Opinion", "Not specific", "Low signal"]'),
('Docs are long. I dont like reading docs.', 'discord', 'new_user', 'low', 'docs', '["Docs fatigue", "Subjective", "Low"]'),
('Our PM said we have to use Workers so here we are.', 'support', 'developer', 'low', 'general', '["Org decision", "Mild resentment", "Low signal"]'),
('Why cant everything just be one big server?', 'twitter', 'new_user', 'low', 'general', '["Conceptual confusion", "Infra", "Low"]'),
('Theres too many products in the dashboard. I get lost.', 'twitter', 'new_user', 'low', 'dashboard_ux', '["Overwhelmed", "Too many options", "Low"]'),

('Billing is always confusing no matter which cloud we use.', 'twitter', 'new_user', 'low', 'billing', '["General cloud complaint", "Low", "Not specific"]'),
('AI is scary. Not sure I trust any vendor with this.', 'discord', 'new_user', 'low', 'ai_reliability', '["Fear", "Not specific", "Low"]'),
('Security seems important but I dont know what to look for.', 'twitter', 'new_user', 'low', 'security', '["Vague", "Uninformed", "Low signal"]'),
('Logs, metrics, traces… its all too much.', 'discord', 'new_user', 'low', 'observability_logs', '["Overwhelmed", "Conceptual", "Low"]'),
('I clicked around the dashboard and got bored.', 'twitter', 'new_user', 'low', 'dashboard_ux', '["Apathy", "Short session", "Low"]'),

('Make it more like Vercel but also cheaper.', 'twitter', 'new_user', 'low', 'general', '["Competitor mention", "Unrealistic", "Low"]'),
('Why cant I deploy from my phone?', 'twitter', 'new_user', 'low', 'dev_experience', '["Edge case", "Low", "Not a priority"]'),
('Too many YAML and JSON files. I just want a button.', 'discord', 'new_user', 'low', 'dev_experience', '["Config fatigue", "Low", "Subjective"]'),
('I only read the marketing page and it looked complicated.', 'twitter', 'new_user', 'low', 'general', '["Shallow review", "Low", "No usage"]'),
('The orange color is too bright on my monitor.', 'twitter', 'new_user', 'low', 'design', '["Color preference", "Subjective", "Low"]'),

('I expected a magic AI that writes all my Workers for me.', 'discord', 'new_user', 'low', 'dev_experience', '["Unrealistic expectation", "AI", "Low"]'),
('Security settings have too many toggles, I just ignored them.', 'twitter', 'new_user', 'low', 'security', '["User skipped", "Not product fault", "Low"]'),
('I dont like CLIs in general.', 'twitter', 'new_user', 'low', 'dev_experience', '["Personal preference", "Low", "Non-actionable"]'),
('Workers sound cool but I probably wont use them.', 'discord', 'new_user', 'low', 'general', '["Non-commitment", "Low signal", "Anecdote"]'),
('Our intern tried Workers once and was confused.', 'support', 'manager', 'low', 'dev_experience', '["Second-hand report", "Low", "Needs detail"]');
