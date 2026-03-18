# adev.yaml Layer Specification

## 9-Layer Architecture

`adev.yaml` is structured in 9 distinct layers for clear separation of concerns.

```
┌─────────────────────────────────────────┐
│ LAYER 0: METADATA                       │ ← 設定自体のメタデータ
├─────────────────────────────────────────┤
│ LAYER 1: CONTEXT                        │ ← 開発の文脈・背景
├─────────────────────────────────────────┤
│ LAYER 2: STACK                          │ ← 技術スタック (明示的定義)
├─────────────────────────────────────────┤
│ LAYER 3: STYLE                          │ ← 開発スタイル・プラクティス
├─────────────────────────────────────────┤
│ LAYER 4: DEPLOY                         │ ← デプロイ・運用
├─────────────────────────────────────────┤
│ LAYER 5: TEAM                           │ ← エージェントチーム構成
├─────────────────────────────────────────┤
│ LAYER 6: STRUCTURE                      │ ← プロジェクト構造
├─────────────────────────────────────────┤
│ LAYER 7: CONSTRAINTS                    │ ← 制約条件・ガードレール
├─────────────────────────────────────────┤
│ LAYER 8: QUALITY                        │ ← 品質基準
└─────────────────────────────────────────┘
```

---

## Layer Details

### LAYER 0: METADATA

設定ファイル自体に関するメタデータ。

```yaml
metadata:
  version: "1.0.0"
  generated: "2026-03-19T00:00:00+09:00"
  generator: adev-config-skill
  source:
    type: chat
    url: https://gemini.google.com/app/...
    extracted_at: "2026-03-19T00:00:00+09:00"
  confidence:
    stack: 0.95
    style: 0.90
    deploy: 0.85
```

**Purpose**: 設定の出所・信頼性・バージョン管理

---

### LAYER 1: CONTEXT

プロジェクトの文脈・背景。

```yaml
context:
  chat:
    url: https://gemini.google.com/app/...
    provider: gemini
  project:
    name: ""
    description: ""
    vision: ""
```

**Purpose**: 開発の目的・ステークホルダーの理解

---

### LAYER 2: STACK

技術スタックの**明示的**定義。

```yaml
stack:
  language:
    primary: ts
    version: "5.0"
    strict: true
  
  runtime:
    name: node
    version: "20"
  
  framework:
    frontend: react
    backend: express
    build: vite
  
  data:
    database: firebase
    cache: redis
    storage: firebase
  
  test:
    framework: jest
    coverage_threshold: 80
    e2e: playwright
  
  infra:
    deploy: firebase
    ci_cd: github_actions
    monitoring: sentry
```

**Purpose**: 技術選定の明確化・自動生成の指針

---

### LAYER 3: STYLE

開発スタイル・プラクティス。

```yaml
style:
  methodology: TDD
  cycle:
    - write_test
    - run_test_fail
    - implement
    - run_test_pass
    - refactor
  git:
    provider: github
    workflow: trunk_based
    branch: main
    commit_convention: conventional_commits
  code:
    formatter: prettier
    linter: eslint
    style_guide: ""
```

**Purpose**: 開発プロセスの標準化

---

### LAYER 4: DEPLOY

デプロイ・運用設定。

```yaml
deploy:
  platform: firebase
  project: ""
  regions:
    - asia-northeast1
  environments:
    - name: development
      url: ""
    - name: production
      url: ""
  features:
    hosting:
      enabled: true
      public_dir: public
    functions:
      enabled: false
      runtime: nodejs20
```

**Purpose**: デプロイ先の明確化・環境管理

---

### LAYER 5: TEAM

エージェントチーム構成。

```yaml
team:
  workflow: chat-to-impl
  roles:
    - name: spec_writer
      responsibility: Chat → 仕様書
    - name: code_reviewer
      responsibility: アーキテクチャレビュー
    - name: implementer
      responsibility: 実装
    - name: tester
      responsibility: テスト作成・実行
    - name: deployer
      responsibility: デプロイ
  automation:
    spec_from_chat: true
    auto_commit: false
    run_tests: true
```

**Purpose**: 責務分担の明確化

---

### LAYER 6: STRUCTURE

プロジェクト構造。

```yaml
structure:
  root:
    - src/
    - functions/
    - public/
    - tests/
    - configs/
  src:
    - components/
    - hooks/
    - utils/
    - types/
  test:
    - unit/
    - integration/
    - e2e/
```

**Purpose**: 一貫したディレクトリ構成

---

### LAYER 7: CONSTRAINTS

制約条件・ガードレール。

```yaml
constraints:
  must:
    - "すべてのコードは型付きであること"
    - "カバレッジ 80% 以上を維持"
  should:
    - "関数は 20 行以内"
  must_not:
    - "シークレットをコードにハードコード"
```

**Purpose**: 品質維持のための制約

---

### LAYER 8: QUALITY

品質基準・ゲート。

```yaml
quality:
  metrics:
    maintainability_index: 80
    technical_debt_ratio: 5
    code_duplication: 3
  checks:
    - type_check
    - lint
    - test
    - coverage
    - build
  gates:
    pre_commit:
      - lint
      - type_check
    pre_merge:
      - test
      - coverage
    pre_deploy:
      - build
```

**Purpose**: 品質保証の自動化

---

## Benefits of Layered Structure

| Benefit | Description |
|---------|-------------|
| **Separation of Concerns** | 各レイヤーが単一責任 |
| **Extensibility** | 新しいレイヤーを追加可能 |
| **Validation** | レイヤーごとに検証可能 |
| **Diff Clarity** | 変更箇所が明確 |
| **Agent Routing** | 担当エージェントに振り分け容易 |

---

## Usage

```yaml
# Minimal (Stack only)
stack:
  language:
    primary: ts

# Full (All 9 layers)
metadata: ...
context: ...
stack: ...
style: ...
deploy: ...
team: ...
structure: ...
constraints: ...
quality: ...
```

---

**9 Layers → Clear Stack → Autonomous Implementation**
