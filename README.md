# Signal — Feedback Prioritization Engine (Cloudflare PM Intern Assignment)

**Signal** is a prototype feedback aggregation and analysis tool designed for Product Managers.  
It helps teams move from raw, noisy feedback → prioritized insights → focused action.

Built as part of the **Cloudflare Product Manager Intern take-home assignment**.

---

## 🎯 Problem

Product teams receive feedback from many sources (support tickets, GitHub issues, social media, internal channels), but:

- Not all feedback is equally actionable
- High-signal issues get buried in noise
- PMs lack a fast way to see *what actually matters now*

---

## 💡 Solution

Signal introduces a **Signal-based prioritization model** that evaluates feedback by **severity and actionability**, not volume alone.

The product provides:
- **Executive summary** for fast decision-making
- **Theme-based exploration** for deeper analysis
- **AI-assisted focus mode** for working through individual feedback
- **Conversational AI** to query insights across all feedback

---

## 🧭 Product Structure

Signal has **three primary surfaces**, optimized for PM workflows:

### 1. Home (Executive Overview)
- Top themes by **High / Medium / Low Signal**
- Key insights and recommended actions
- Designed for quick alignment and prioritization

### 2. Explorer (Deep Analysis)
- Browse all feedback by theme
- Filter and search across large datasets
- Identify patterns and cross-cutting issues

### 3. Focus Mode (Single-Feedback Deep Dive)
- Dedicated page for one feedback item
- AI chat scoped to that feedback
- PM notes (auto-saved) for synthesis and decision-making

---

## 🤖 AI Capabilities

Signal uses Workers AI to:
- Explain *why* feedback is categorized as high / medium / low signal
- Generate recommended actions
- Answer ad-hoc PM questions via chat (e.g. “What should we prioritize this week?”)

---

## 🛠️ Tech Stack (Cloudflare-Native)

- **Cloudflare Workers** — Full-stack application runtime
- **Cloudflare D1** — SQL database for structured feedback storage
- **Workers AI** — LLM-powered explanations and chat
- **Workers KV** — Caching AI responses for performance
- **React + Tailwind + shadcn/ui** — Frontend UI

The architecture intentionally leverages Cloudflare-native primitives to minimize operational overhead and keep feedback analysis close to the edge.

---

## 🧪 Data

- Uses **mock but realistic feedback data** (~130 entries)
- Multiple sources: support, GitHub, Discord, Twitter
- Multiple themes: performance, DX, docs, billing, observability, security, etc.
- Designed to simulate scale and real PM workflows

---

## 🌐 Deployment

The app is deployed on Cloudflare Workers:

👉 **Live Demo:**  
https://feedback-signal.feedback-signal.workers.dev

---

## 🧠 Design Notes

- The prototype intentionally favors **decision clarity over feature completeness**
- Visual hierarchy guides PM attention to high-signal issues
- Explorer and Focus Mode prevent information overload
- Known limitations and future improvements are documented separately as product insights

---

## 📄 Assignment Context

This project was built under time constraints and focuses on:
- Product thinking
- Tradeoffs
- Cloudflare platform usage
- Ability to identify friction and improvement opportunities

---

## 👤 Author

**Abdulsaboor Shaikh**  
Product Manager

