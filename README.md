<p align="center">
  <img src="logo.svg" width="80" alt="TrustLog Guard">
</p>

<h1 align="center">TrustLog Guard</h1>

<p align="center"><strong>Financial Governance for AI Agents</strong></p>

<p align="center"><em>Your AI agents spend money 24/7. Nobody's watching. Until now.</em></p>

<p align="center">
  <a href="#install-in-10-seconds">Install</a> · 
  <a href="#the-solution">Features</a> · 
  <a href="#roadmap">Roadmap</a> · 
  <a href="https://github.com/AnouarTrust/trustlog-guard">GitHub</a>
</p>

---

OpenClaw has **180,000+ users** generating millions of session logs. Every log contains exact cost data — down to fractions of a cent. **Nobody reads it.**

TrustLog Guard is the first tool that does. One file. 100% local. Your data never leaves your machine.

---

## ⚡ Install in 10 Seconds

```bash
clawhub install trustlog-guard
```

Open your next OpenClaw session. Type `/spend`. That's it.

<details>
<summary>Manual install</summary>

```bash
mkdir -p ~/.openclaw/workspace/skills/trustlog-guard
curl -o ~/.openclaw/workspace/skills/trustlog-guard/SKILL.md \
  https://raw.githubusercontent.com/AnouarTrust/trustlog-guard/main/SKILL.md
```
</details>

---

## The Problem

AI agents make API calls around the clock. Each call costs money. But there's **zero built-in visibility** into where that money goes.

The community knows this pain:

| Amount | What happened |
| --- | --- |
| **$6,000**/month | Unattended agents running Opus — no spend limits |
| **$3,600**/month | 1.8M tokens — discovered via credit card statement |
| **$200**/day | Automated task stuck in a loop overnight |
| **$141**/3 days | Telegram bot processing every group message |

The cost data existed in the log files the entire time. They just couldn't see it.

---

## The Solution

Three commands. Total visibility.

### `/spend` — Know Where Your Money Goes

```
💰 TrustLog Guard — Spend Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Today:       $2.34  (47 messages)
This week:   $14.20 (283 messages)
This month:  $31.50 (612 messages)

Cost by model:
  claude-opus-4-6    $22.10 (70%) ⚠️
  claude-sonnet-4.5  $7.40  (23%)
  claude-haiku-4.5   $2.00  (7%)

💡 214 Opus messages were simple tasks.
   Switching to Sonnet saves ~$18/month
```

### `/budget set daily $5` — Never Blow Your Budget Again

```
📊 Budget Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Daily:   $4.20 / $5.00 [████████░░] 84% ⚠️
Monthly: $31.50 / $100  [███░░░░░░░] 32% ✅

⚠️ At current rate, daily budget hit in 47 minutes.
```

### `/trustlog` — Catch Problems Before They Cost You

```
🚨 ANOMALY DETECTED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔄 Rapid-fire loop detected
   Session: agent-cron-backup
   Messages: 147 in 28 minutes
   Burn rate: $0.41/min (normal: $0.03/min)
```

**Detects:** Burn rate spikes · Runaway loops · Model escalation · Session explosions · Cache inefficiency

---

## How It Works

OpenClaw logs a cost object in every `.jsonl` session file:

```json
{
  "cost": {
    "input": 0.00003,
    "output": 0.00786,
    "cacheRead": 0,
    "cacheWrite": 0.0541,
    "total": 0.0620
  }
}
```

TrustLog Guard reads these files. That's the entire architecture. No backend. No servers. No accounts. The AI agent itself does the financial analysis based on instructions in the SKILL.md.

---

## Privacy-First Architecture

| | |
| --- | --- |
| 🔒 **100% Local** | Reads only local `.jsonl` files on your machine |
| 📖 **Read-Only** | Never modifies your session logs |
| 🔑 **No API Keys** | Reads cost data OpenClaw already calculated |
| 🚫 **No Servers** | Nothing external. Nothing phoning home |
| 📂 **Open Source** | MIT license. Read every line |

---

## The Bigger Picture

Every AI agent has a **financial signature** — how it spends, where it wastes, when it spikes.

Cloud cost management became a **$40B+ industry** because companies couldn't track what they spent on servers. AI agent costs are the next version of that problem — more volatile, less predictable, and growing 10x faster.

TrustLog Guard is the **financial governance layer** for the AI agent era. Starting with OpenClaw. Expanding everywhere.

> *Not slowing AI down. Making it go faster by making it go smarter.*

---

## Roadmap

- 🔬 **Cost Autopsy** — automatic financial post-mortem on expensive sessions
- 📬 **Weekly Digest** — Monday morning spend summary with trends and optimisations
- 🛡️ **Guardian Mode** — proactive alerts when spend spikes unexpectedly
- 🧬 **Financial Signatures** — pattern recognition and predictive cost modelling
- 🌐 **Cross-Platform** — expand beyond OpenClaw to Claude Code, Cursor, and more

---

## Built By

**Anouar** — MSc Finance · Founder of TrustLog Guard

Building financial governance tools for the AI agent era. The intersection of finance expertise and AI — because the people who understand money don't understand agents, and the people who understand agents don't think about money.

---

<p align="center">
  <strong>⭐ Star this repo if you're tired of surprise bills.</strong>
</p>
