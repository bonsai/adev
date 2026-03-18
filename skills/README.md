# adev Skills

Configuration skills for adev.yaml generation and evolution.

## Quick Start

```powershell
# Interactive mode with recommendations
.\skills\adev-config-skill.ps1 -i

# From chat (auto-suggest optimal stack)
.\skills\adev-config-skill.ps1 -chat "Web アプリ作りたい"
```

## Available Skills

| Skill | Description |
|-------|-------------|
| [`adev-config-skill.ps1`](adev-config-skill.ps1) | 対話型仕様選択 + 最適スタック提案 + ADR |
| [`INPUT-FORMATS.md`](INPUT-FORMATS.md) | Supported input formats |
| [`LAYERS.md`](LAYERS.md) | 9-layer specification |
| [`EVOLUTION.md`](EVOLUTION.md) | Configuration evolution |
| [`ADR.md`](ADR.md) | Architecture Decision Record |

## Features

### 1. Keyword Inference (曖昧キーワード推論)

Auto-suggests best stack from ambiguous keywords:

| Input | Stack | Deploy | Matched Keywords |
|-------|-------|--------|------------------|
| "チャットアプリ" | TypeScript | Firebase | chat, mobile |
| "AI 分析ツール" | Python | GCP | ai, data, 分析 |
| "マイクロサービス" | Go | AWS | microservice |
| "ブログ" | TypeScript | Vercel | blog |
| "CLI ツール" | Go | AWS | cli, tool |
| "Web サイト" | TypeScript | Vercel | web, site |
| "決済システム" | TypeScript | AWS | payment, ecommerce |

**80+ keywords mapped** - See [`KEYWORD-INFERENCE.md`](KEYWORD-INFERENCE.md)

### 2. Pro/Con Comparison

Shows trade-offs for each option:

```
【Stack: TypeScript】
  Pros: Type safety, IDE support, ecosystem
  Cons: Build required, learning curve
```

### 3. ADR Generation

Records decisions with rationale:

```powershell
.\skills\adev-config-skill.ps1 -i
# → Answer "y" when asked about ADR
```

Output: `docs/adr/YYYYMMDD-HHMMSS-stack-decision.md`

## Usage

### Interactive Mode (Recommended)

```powershell
.\skills\adev-config-skill.ps1 -i
```

**Flow:**
1. Select project type
2. View optimal stack recommendation
3. Compare options (Pro/Con tables)
4. Make decision
5. Generate ADR (optional)
6. Output: `adev.yaml`

### From Chat

```powershell
.\skills\adev-config-skill.ps1 -chat "Firebase で TypeScript のアプリ"
```

Auto-extracts:
- Stack: ts
- Deploy: firebase
- Style: TDD (default)

### Generate ADR Only

```powershell
# ADR is generated automatically in interactive mode
# Or manually copy from docs/adr/
```

## Output Files

```
adev/
├── adev.yaml                 # 9-layer config
└── docs/
    └── adr/
        └── 20260319-120000-stack-decision.md
```

## Evolution Stages

```
txt → md → yaml → json
 │     │      │      │
 │     │      │      └─ Validated (schema/adev-v1.json)
 │     │      └──────── Layered (adev.yaml) + ADR
 │     └─────────────── Structured notes
 └───────────────────── Chat log
```

## Schema Validation

```powershell
# Validate adev.yaml
adev validate

# Generate JSON Schema
adev generate-schema
```

See [`schema/adev-v1.json`](schema/adev-v1.json) for the JSON Schema.

---

**Chat → Recommend → Compare → Decide → Document → Generate**
