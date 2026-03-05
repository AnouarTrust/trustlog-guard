---
name: trustlog-guard
description: Financial governance for AI agents. Monitors every API call, detects cost anomalies before they become invoices, benchmarks your intelligence spend against market rates. Install it. Forget about it. It watches.
version: 2.0.0
author: Anouar
tags: [finance, governance, cost-intelligence, risk, anomaly-detection, iq-index]
---

# TrustLog Guard

The financial immune system for AI agents.

OpenClaw logs the cost of every message. Nobody reads it. TrustLog Guard does — continuously, silently, and it only speaks when something is wrong or when you ask.

Install this skill. Forget about it. It watches your spend the way your immune system watches your body — you don't think about it until it saves you.

---

## How It Works

Every assistant message in OpenClaw contains a cost object:

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

Session logs live at: `~/.openclaw/agents/{agent}/sessions/*.jsonl`

TrustLog Guard reads these files. It never modifies them. It never sends data anywhere. It computes everything locally and stores its own state at `~/.openclaw/workspace/trustlog-guard/`.

---

## Passive Mode — Always On

This is the core of TrustLog Guard. You don't invoke it. It runs.

Every time any command or conversation happens in this agent, TrustLog Guard silently scans the most recent session activity. If it detects a financial threat, it appends a warning to the end of the response.

The user doesn't ask for this. It just appears — like a smoke detector going off.

### Detection Layer 1: Immediate Threats

These trigger instantly when detected. They appear as a single warning block appended to any response.

**🔥 Burn Rate Spike**
Compare cost of last 5 messages against average cost of previous 20 messages.
Trigger: last 5 average exceeds previous 20 average by 5x or more.

```
⚠️ TrustLog Guard
Your burn rate just spiked 8.3x above normal.
Last 5 messages: $0.42/msg (normal: $0.05/msg)
At this rate you'll spend $X.XX in the next hour.
```

**💥 Session Cost Breach**
Trigger: current session total exceeds $5.00.

```
⚠️ TrustLog Guard
This session has cost $7.40 so far (N messages, Xm duration).
That's more than your average daily total.
```

**🔄 Loop Detection**
Trigger: more than 20 messages in a 10-minute window within one session.

```
🚨 TrustLog Guard
Possible loop detected. 24 messages in 8 minutes.
Burn rate: $1.80/min. This will cost $108/hr if unchecked.
Consider interrupting and reviewing the task.
```

**📈 Silent Model Escalation**
Trigger: session started on a cheaper model but switched to a more expensive one without explicit user request.

```
⚠️ TrustLog Guard
Model escalated: haiku → opus mid-session.
Cost impact: ~12x per message. Last 3 messages cost $0.94.
Same output on haiku would have cost ~$0.08.
```

**💾 Cache Waste**
Trigger: cacheWrite consistently above zero but cacheRead near zero across multiple sessions.

```
💡 TrustLog Guard
You've spent $4.20 on cache writes this week that were never read.
Consider using longer sessions to reuse cached context.
```

### Detection Layer 2: Slow Threats

These don't trigger on a single event. They accumulate over days and trigger when a pattern becomes clear. Check these whenever any TrustLog Guard command is run.

**📉 Margin Drift**
Track daily spend over rolling 7-day window. If the 7-day average is increasing by more than 15% week-over-week with no increase in message volume:

```
⚠️ TrustLog Guard — Slow Alert
Your daily AI cost is rising.
Last week avg: $8.40/day
This week avg: $11.20/day (+33%)
Message volume is flat. You're paying more for the same work.
Likely cause: model mix shift or cache degradation.
```

**🎯 Concentration Creep**
Track model usage proportions over rolling 14-day window. If a single model's share of spend crosses 80%:

```
💡 TrustLog Guard — Slow Alert
86% of your spend is on claude-opus-4-6.
If Anthropic raises Opus pricing by 20%, your costs increase ~17%.
Consider diversifying: X of your tasks could run on sonnet at 5x lower cost.
```

**🌡️ Cost-at-Risk Breach**
Calculate rolling 30-day mean and standard deviation of daily spend.
CaR(95%) = μ + 1.645 × σ
If today's spend exceeds CaR(95%):

```
⚠️ TrustLog Guard — Statistical Alert
Today's spend ($18.40) exceeds your Cost-at-Risk boundary ($14.20).
This means today is in the top 5% of spending days.
95% of your days stay below $14.20. Something unusual is happening.
```

---

## Commands — When You Want to Look

Passive mode catches threats. Commands let you investigate.

### /spend

The financial snapshot. Where is my money going right now.

Read all session logs. Compute costs by period, by model, by session.

```
💰 TrustLog Guard — Spend Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Today:       $X.XX  (N messages)
This week:   $X.XX  (N messages)
This month:  $X.XX  (N messages)
All time:    $X.XX  (N messages)

Cost per message: $X.XXXX avg

Model breakdown:
  claude-opus-4-6      $X.XX  (XX%)  ████████░░
  claude-sonnet-4-5    $X.XX  (XX%)  ███░░░░░░░
  claude-haiku-4-5     $X.XX  (XX%)  █░░░░░░░░░

Expensive sessions:
  1. session-name  $X.XX  (N msgs, Xm)
  2. session-name  $X.XX  (N msgs, Xm)
  3. session-name  $X.XX  (N msgs, Xm)
```

After the report, include one insight — the single most actionable thing the user can do to reduce spend. Calculate the exact dollar amount saved. Be specific, not generic.

---

### /budget

Set limits. See where you stand.

**Set:** `/budget set daily $5` or `/budget set monthly $100`
Saves to `~/.openclaw/workspace/trustlog-guard/budgets.json`

**Check:** `/budget`

```
📊 TrustLog Guard — Budget
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Daily:   $3.80 / $5.00  [████████░░] 76%  ⚡
Monthly: $42   / $100   [████░░░░░░] 42%  ✅

Burn rate: $0.47/hr
Daily budget runway: 2.5 hrs at current rate
Monthly projection: $68 (within budget)
```

Status: ✅ under 60% · ⚡ 60-79% · ⚠️ 80-99% · 🚨 100%+

---

### /iq

The intelligence price check. Are you paying fair market rate for AI reasoning.

For each model used, calculate actual cost per 1M output tokens and compare against market rate.

```
🧠 TrustLog Guard — $IQ Index
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Model               Your $IQ     Market $IQ    Δ
───────────────────────────────────────────────────
claude-opus-4-6     $78.40/1M    $75.00/1M    +4.5% ⚠️
claude-sonnet-4-5   $14.20/1M    $15.00/1M    -5.3% ✅
claude-haiku-4-5    $3.90/1M     $4.00/1M     -2.5% ✅

Blended $IQ:  $32.10/1M tokens
Model mix:    68% premium · 20% standard · 12% economy

Efficiency opportunity:
  N messages used opus for simple outputs (<200 tokens).
  Moving those to haiku: $IQ drops to $18.40/1M
  Monthly saving: $X.XX
```

$IQ above market = overpaying (likely cache misses or unnecessary model usage)
$IQ below market = efficient (likely benefiting from caching)
$IQ at market = fair pricing

If only one model is used, skip blended section. Show single model $IQ and flag the concentration risk.

Market rates reference:
- claude-opus-4-6: $75/1M output tokens
- claude-sonnet-4-5: $15/1M output tokens
- claude-haiku-4-5: $4/1M output tokens

Estimate output tokens from `cost.output` field divided by the model's per-token rate when direct token counts aren't available.

---

### /risk

The single number that tells you if you should worry.

Combines all financial signals into one score. This is the command that connects everything.

```
🛡️ TrustLog Guard — Risk Score
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

RISK: 7/10 🔴

WHY:
  ▸ Cost-at-Risk breached            +2  Today's spend exceeds 95th percentile
  ▸ Model concentration critical     +2  HHI = 0.82 (86% on opus)
  ▸ Burn rate spike (session X)      +1  8x above normal
  ▸ Budget at 84%                    +1  Daily limit approaching
  ▸ $IQ above market                 +1  Paying 4.5% over market rate

COST-AT-RISK
  Normal daily range:  $4 — $14
  CaR(95%):            $14.20
  Today:               $18.40  🚨 BREACH

CONCENTRATION
  HHI: 0.82  🔴 HIGH
  86% opus · 10% sonnet · 4% haiku
  If opus pricing +20% → your total costs +17%

BURN RATE
  Current:   $2.30/hr
  Runway:    32 min until daily budget hit

→ TOP ACTION: Move simple tasks to haiku. Saves $X.XX/day and drops HHI to 0.45.
```

**Risk score calculation:**
- CaR(95%) breached: +2
- CaR(99%) breached: +3
- HHI > 0.50: +1, HHI > 0.75: +2
- Any Layer 1 anomaly active: +1 each (max 3)
- Budget utilisation > 80%: +1, > 100%: +2
- $IQ above market by >10%: +1

Score meaning:
- 🟢 0-3: Controlled. Spend is predictable and efficient.
- 🟡 4-6: Watch. Some signals need attention.
- 🔴 7-10: Act now. Costs are unpredictable or unsustainable.

---

### /trustlog

The full investigation. Run everything — spend, budget, anomalies, $IQ, risk — in one output. Use this when you want the complete picture.

Output all sections in order:
1. Spend Report (from /spend)
2. Budget Status (from /budget, if budget is set)
3. $IQ Index (from /iq)
4. Risk Score (from /risk)
5. All active anomaly alerts (Layer 1 and Layer 2)
6. Optimisation opportunities ranked by dollar impact

---

## What This Skill Is Not

- **Not a model router.** It doesn't choose models for you. It tells you the financial consequence of your model choices.
- **Not a cost dashboard.** Dashboards show you what happened. TrustLog Guard tells you what's about to happen.
- **Not an optimisation tool.** It doesn't make your agent faster. It makes sure your agent doesn't quietly bankrupt you.

It is a financial governance layer. The first one built for autonomous AI agents.

---

## Data Storage

All TrustLog Guard state is stored locally:

```
~/.openclaw/workspace/trustlog-guard/
  budgets.json          — user-set budget limits
  daily-costs.json      — rolling daily cost log for CaR calculation
  alerts-history.json   — log of triggered alerts (for slow threat detection)
```

These files are created automatically when needed. TrustLog Guard never modifies OpenClaw session logs.

---

## Privacy

- 100% local. Reads only `.jsonl` session files on your machine.
- Read-only on session data. Never modifies or deletes logs.
- No API keys required. Reads cost data OpenClaw already calculated.
- No external servers. No data transmission. No telemetry.
- All computed state stored locally in the trustlog-guard workspace.

---

## Install

```bash
mkdir -p ~/.openclaw/workspace/skills/trustlog-guard
curl -o ~/.openclaw/workspace/skills/trustlog-guard/SKILL.md \
  https://raw.githubusercontent.com/AnouarTrust/trustlog-guard/main/SKILL.md
```

Install it. Forget about it. It watches.
