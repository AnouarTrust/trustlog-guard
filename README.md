# 🛡️ TrustLog Guard

**Financial governance for OpenClaw agents.**

OpenClaw is great. Waking up to a $50 bill isn't. Get TrustLog Guard.

---

## What it does

TrustLog Guard reads your OpenClaw session logs and tells you exactly where your money is going. No external servers. No data leaves your machine. 100% local.

| Command | What it does |
|---------|-------------|
| `/spend` | Instant spend summary — today, this week, this month |
| `/budget set daily $5` | Set daily/monthly spending limits with warnings |
| `/trustlog` | Full financial report with anomaly detection |

## The Problem

OpenClaw agents make API calls 24/7. Each call costs money. But there's no built-in way to see:
- How much you've spent today
- Which sessions cost the most
- Whether a runaway loop is burning your budget
- Which model is eating your wallet

Users discover they've spent $50-$600/month only when the credit card bill arrives.

## The Solution

TrustLog Guard reads the `cost.total` field that OpenClaw already logs in every `.jsonl` session file. It surfaces what's hidden in plain sight.

### Spend Tracking
💰 TrustLog Guard — Spend Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Today:        $2.34  (47 messages)
This week:    $14.20 (283 messages)
This month:   $31.50 (612 messages)
Avg cost/message: $0.0515
Most expensive model: claude-opus-4-6 ($22.10)

### Budget Enforcement
📊 Budget Status
━━━━━━━━━━━━━━━━
Daily:   $4.20 / $5.00  [████████░░] 84%  ⚠️
Monthly: $31.50 / $100   [███░░░░░░░] 32%  ✅

### Anomaly Detection
- 🔥 **Burn rate spike** — 5x cost increase in last 5 messages
- 💥 **Session explosion** — single session exceeds $5
- 🔄 **Rapid-fire loop** — 20+ messages in 10 minutes
- 📈 **Model escalation** — unexpected switch to expensive model
- 💾 **Cache inefficiency** — paying for cache writes but never reading

### Optimization Tips
- Suggests cheaper models when Opus isn't needed
- Identifies cache inefficiencies
- Recommends session consolidation
- Shows cost per task type

## Install

Copy the `SKILL.md` file to your OpenClaw workspace:
```bash
mkdir -p ~/.openclaw/workspace/skills/trustlog-guard
curl -o ~/.openclaw/workspace/skills/trustlog-guard/SKILL.md \
  https://raw.githubusercontent.com/AnouarTrust/trustlog-guard/main/SKILL.md
```

## How it works

OpenClaw stores session data in `.jsonl` files at `~/.openclaw/agents/{agent}/sessions/`. Every assistant message includes a `cost` object:
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

TrustLog Guard reads these files. That's it. No API keys. No external servers. No data leaves your machine.

## Privacy

- ✅ 100% local — reads only local `.jsonl` files
- ✅ Read-only — never modifies session logs
- ✅ No API keys needed — reads cost data OpenClaw already calculated
- ✅ No external server — everything runs on your machine

## Built by

**Anouar** — MSc Finance graduate building financial governance tools for the AI agent era.

## License

MIT
