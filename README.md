# adev

**Plagger for the Agent Era** — 20 years later.

> Plagger (2006) was a personal RSS aggregator that lived on your server.  
> **adev (2026)** is an autonomous development agent that lives in your YAML.

---

## What is adev?

**adev** is a YAML-only configuration file that spawns an entire development team of AI agents.

**Everything starts from chat.**

```
Chat → YAML (auto-generated) → Specs → Code → Test → Deploy
       ↑ stack, style, platform
          determined from conversation
```

You talk. Agents listen. **YAML is created.** Software appears.

- 💬 **Chat** — Your conversation becomes requirements + config
- 📝 **YAML generation** — Stack, style, deploy target auto-decided from chat
- 📋 **Spec writing** — Auto-generated from chat context
- 💻 **Implementation** — Code generation in your chosen stack
- ✅ **Testing** — TDD cycle automation
- 🚀 **Deployment** — One-command deploys to your platform
- 🔄 **Iteration** — Continuous improvement from feedback

No CLI. No complex setup. **Just Chat → YAML → Software.**

---

## Philosophy

> *"The best interface is no interface."*

20 years ago, Plagger let you configure RSS feeds in YAML.  
Today, adev lets you configure **software development** in YAML.

| Era | Tool | Configuration | Output |
|-----|------|---------------|--------|
| 2006 | Plagger | `config.yaml` | RSS Feed |
| 2026 | adev | `adev.yaml` | **Working Software** |

---

## Quick Start

### 1. Create `adev.yaml`

**Minimal:**
```yaml
stack:
  language:
    primary: ts
```

**Full (9 Layers):**
```yaml
metadata:
  version: "1.0.0"
  generated: "2026-03-19T00:00:00+09:00"

context:
  chat:
    url: https://gemini.google.com/app/your-session

stack:
  language:
    primary: ts
  runtime:
    name: node
    version: "20"

style:
  methodology: TDD

deploy:
  platform: firebase

team:
  workflow: chat-to-impl

structure:
  root:
    - src/
    - tests/

constraints:
  must:
    - "すべてのコードは型付きであること"

quality:
  metrics:
    maintainability_index: 80
```

### Or: Auto-generate from chat

```bash
# Anywhere, anytime
adev run
```

### Or: Use Interactive Config Skill

```powershell
# 対話型仕様選択
.\skills\adev-config-skill.ps1 -i

# チャットから自動抽出
.\skills\adev-config-skill.ps1 -chat "Firebase で TypeScript のアプリを作りたい"
```

### 3. Watch the agents work

```
[adev] Spawning team...
[spec_writer] Reading chat context...
[spec_writer] Generated 3 user stories
[code_reviewer] Reviewing architecture...
[implementer] Creating src/functions.ts...
[tester] Running jest... 12/12 passed
[deploy] Deploying to firebase... ✓
```

---

## Configuration Layers

See [`skills/LAYERS.md`](skills/LAYERS.md) for the full 9-layer specification.

**Quick reference:**

| Layer | Purpose | Example |
|-------|---------|---------|
| 0. METADATA | 設定のメタデータ | version, generator, confidence |
| 1. CONTEXT | 開発の文脈 | chat URL, project vision |
| 2. STACK | 技術スタック | language, runtime, framework |
| 3. STYLE | 開発スタイル | TDD, git workflow |
| 4. DEPLOY | デプロイ | firebase, vercel, aws |
| 5. TEAM | エージェント構成 | roles, responsibilities |
| 6. STRUCTURE | プロジェクト構造 | directories |
| 7. CONSTRAINTS | 制約条件 | must, should, must_not |
| 8. QUALITY | 品質基準 | metrics, gates |

---

## Evolution: txt → md → yaml → json

Settings evolve as your project grows:

```
txt → md → yaml → json
 │     │      │      │
 │     │      │      └─ Validated, typed
 │     │      └──────── Layered, semantic
 │     └─────────────── Structured notes
 └───────────────────── Chat log
```

**Stage 0: TXT** - "Firebase で TypeScript のアプリ作りたい"
**Stage 1: MD** - Structured markdown notes
**Stage 2: YAML** - 9-layer configuration
**Stage 3: JSON** - Validated schema

See [`skills/EVOLUTION.md`](skills/EVOLUTION.md) for details.

---

## How It Works

```
┌─────────────────┐
│     You Chat    │
│  (natural lang) │
└────────┬────────┘
         │
         ▼
┌─────────────────────────────────────────────────────────┐
│              adev Agent: config_writer                  │
│                                                         │
│  "I want a Firebase app with TypeScript, TDD style"    │
│                          ↓                              │
│  Generates: adev.yaml                                   │
│  - stack: ts                                            │
│  - style: TDD                                           │
│  - deploy: firebase                                     │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                   adev.yaml (config)                    │
│  context:                                               │
│    chat: https://gemini.google.com/app/your-session     │
│  dev:                                                   │
│    style: TDD                                           │
│    stack: ts                                            │
│  deploy:                                                │
│    platform: firebase                                   │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│              adev Agent Orchestrator                    │
│                                                         │
│  [spec_writer] Reads chat → Generates specs             │
│  [code_reviewer] Reviews architecture                   │
│  [implementer] Writes code                              │
│  [tester] Runs TDD cycle                                │
│  [deployer] Deploys to platform                         │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
                  ┌─────────────────┐
                  │  Working Software│
                  │  + Tests + Docs  │
                  └─────────────────┘
```

**Flow:**
1. You chat naturally about what you want
2. `config_writer` agent → generates `adev.yaml` (stack, style, platform)
3. `spec_writer` agent reads chat → generates formal specs
4. Team implements, tests, deploys automatically
5. You review. Iterate via more chat.

**YAML is auto-generated. You just chat.**

---

## Why adev?

### 🎯 Zero Learning Curve
If you can write YAML, you can use adev.

### 🌍 Works Anywhere
Local, CI, cloud — adev runs wherever your code lives.

### 🤖 Agent-Native
Built for the age of AI agents, not CLI tools.

### 📦 YAML is the Interface
No GUI. No complex config. Just one file.

### 💬 Flexible Input Formats

Natural language, Markdown, YAML, JSON — any format works:

```
# Natural Language
"Firebase で TypeScript のアプリを作りたい、TDD で"

# Markdown
## Stack: TypeScript
## Style: TDD
## Deploy: Firebase

# Keywords
ts TDD firebase jest github
```

All inputs are converted to `adev.yaml` automatically.

---

## Skills

**adev** includes built-in skills for configuration:

### `adev-config-skill` - 対話型仕様選択

```powershell
# Interactive mode with recommendations
.\skills\adev-config-skill.ps1 -i

# Auto-extract with optimal stack suggestion
.\skills\adev-config-skill.ps1 -chat "Web アプリ作りたい"
```

**Features:**
- 🎯 **Optimal Stack Recommendation** - Suggests best stack from project type
- 📊 **Pro/Con Comparison** - Shows trade-offs for each option
- 📝 **ADR Generation** - Records decisions with rationale

### ADR (Architecture Decision Record)

```powershell
# Generate ADR during config
.\skills\adev-config-skill.ps1 -i
# → Answer "y" when asked about ADR
```

Outputs: `docs/adr/YYYYMMDD-HHMMSS-stack-decision.md`

**ADR includes:**
- Context
- Options considered (with comparison tables)
- Decision & rationale
- Consequences (positive/negative/risks)

See [`skills/ADR.md`](skills/ADR.md) for details.

---

## Comparison: Plagger vs adev

| Feature | Plagger (2006) | adev (2026) |
|---------|----------------|-------------|
| Config | Manual YAML | **Auto-generated from chat** |
| Input | RSS feed URLs | Chat conversation |
| Specs | Manual config | **Auto-generated from chat** |
| Output | Aggregated feed | Working software |
| Plugins | Perl modules | AI agents |
| Automation | Cron | Event-driven |
| Portability | Server-bound | Anywhere |

---

## Roadmap

- [x] Config skill - 対話型仕様選択
- [ ] Plugin system for custom agents
- [ ] Multi-chat context support
- [ ] State persistence across sessions
- [ ] Agent memory & learning
- [ ] Team collaboration features

---

## License

MIT — Just like Plagger was.

---

## Tribute

> This project is inspired by **Plagger**, the legendary RSS aggregator created by miyagawa in 2006.
> Plagger proved that flexible, plugin-based architecture could be configured entirely in YAML.
> 
> 20 years later, we're applying that same philosophy to AI-driven development.
> 
> **miyagawa, thank you for showing us the power of YAML.**

---

```
adev — Chat → YAML → Ship software.
```
