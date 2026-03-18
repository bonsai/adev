# adev.yaml Evolution - 設定の進化と粒度

## 設定の進化プロセス

プロジェクトの成長とともに、設定ファイルは**進化**します。

```
txt → md → yaml → json
  ↓      ↓      ↓      ↓
 雑多   構造化  階層化  完全構造化
 会話   整理    明確    検証可能
```

---

## Stage 0: TXT (Chat Log)

**粒度：粗い**

```txt
Firebase で TypeScript のアプリ作りたい
TDD でやって
GitHub で管理
```

**特徴:**
- 自然言語の会話ログ
- 構造化されていない
- 人間には読みやすい
- 機械には曖昧

---

## Stage 1: MD (Structured Notes)

**粒度：やや細かい**

```markdown
# Project Config

## Stack
- TypeScript
- Firebase

## Style
- TDD

## Git
- GitHub
```

**特徴:**
- 見出しで整理
- 人間に非常に読みやすい
- 機械抽出が可能に
- 柔軟性が高い

---

## Stage 2: YAML (Layered Config)

**粒度：細かい**

```yaml
metadata:
  version: "1.0.0"
  confidence:
    stack: 0.95

stack:
  language:
    primary: ts
    version: "5.0"
  runtime:
    name: node
    version: "20"

style:
  methodology: TDD
```

**特徴:**
- 9 層構造
- 明確なセマンティクス
- 機械可読
- 人間にも読みやすい

---

## Stage 3: JSON (Validated Schema)

**粒度：非常に細かい**

```json
{
  "$schema": "https://adev.dev/schema/v1",
  "metadata": {
    "version": "1.0.0",
    "generated": "2026-03-19T00:00:00+09:00",
    "confidence": {
      "stack": 0.95,
      "style": 0.90,
      "deploy": 0.85
    }
  },
  "stack": {
    "language": {
      "primary": "ts",
      "version": "5.0",
      "strict": true
    },
    "runtime": {
      "name": "node",
      "version": "20"
    }
  }
}
```

**特徴:**
- JSON Schema で検証可能
- 完全な型安全性
- 機械処理に最適
- 厳密な構造

---

## 進化のトリガー

| トリガー | 進化 | 例 |
|---------|------|-----|
| **対話の開始** | → TXT | チャットログ |
| **整理の要求** | → MD | 仕様書として保存 |
| **自動化の開始** | → YAML | エージェントが実行 |
| **検証の必要性** | → JSON | CI/CD で検証 |

---

## 解像度の変化

### 粗い解像度 (Early Stage)

```yaml
stack: ts
deploy: firebase
```

**特徴:**
- 素早い決定
- 柔軟性が高い
- 変更が容易

---

### 細かい解像度 (Mature Stage)

```yaml
stack:
  language:
    primary: ts
    version: "5.0"
    strict: true
    jsx: "react-jsx"
    module: "esnext"
    target: "es2022"
  runtime:
    name: node
    version: "20"
    packageManager: pnpm
  framework:
    frontend:
      name: react
      version: "18"
    backend:
      name: express
      version: "4"
    build:
      name: vite
      version: "5"
```

**特徴:**
- 詳細な指定
- 一貫性の保証
- 自動生成の精度向上

---

## 進化の例

### プロジェクト開始時

```txt
[Chat]
新しいプロジェクト始めたい
TypeScript で Firebase 使いたい
```

↓ `adev-config-skill` が YAML 生成

```yaml
stack:
  language:
    primary: ts
deploy:
  platform: firebase
```

---

### プロジェクト成長後

```yaml
metadata:
  version: "2.0.0"
  generated: "2026-03-19T00:00:00+09:00"
  history:
    - version: "1.0.0"
      generated: "2026-03-01T00:00:00+09:00"
      changes: initial

stack:
  language:
    primary: ts
    version: "5.0"
    strict: true
    paths:
      "@/*": ["src/*"]
  runtime:
    name: node
    version: "20"
  framework:
    frontend: react
    backend: express
  data:
    database: firebase
    cache: redis
  test:
    framework: jest
    coverage_threshold: 85
    e2e: playwright

style:
  methodology: TDD
  git:
    provider: github
    workflow: gitflow
    branches:
      main: production
      develop: staging
      feature: feature/*

deploy:
  platform: firebase
  project: my-app-prod
  regions:
    - asia-northeast1
    - us-central1
  environments:
    - name: development
      url: https://dev.my-app.web.app
    - name: staging
      url: https://staging.my-app.web.app
    - name: production
      url: https://my-app.web.app

constraints:
  must:
    - "すべてのコードは型付きであること"
    - "カバレッジ 85% 以上を維持"
    - "main ブランチへの直接 push は禁止"
  should:
    - "関数は 20 行以内"
    - "コンポーネントは単一責任"
  must_not:
    - "TODO コメントを 7 日以上放置"
    - "シークレットをコードにハードコード"
    - "console.log を本番に残す"

quality:
  metrics:
    maintainability_index: 85
    technical_debt_ratio: 3
    code_duplication: 2
  checks:
    - type_check
    - lint
    - test
    - coverage
    - build
    - security_scan
  gates:
    pre_commit:
      - lint
      - type_check
      - format_check
    pre_merge:
      - test
      - coverage
      - security_scan
    pre_deploy:
      - build
      - e2e
      - performance_test
```

---

## 進化のメリット

| メリット | 説明 |
|---------|------|
| **漸進的詳細化** | 必要に応じて詳細化 |
| **早期スタート** | 粗い設定ですぐ開始 |
| **後方互換** | 古い設定も動作 |
| **検証可能性** | 進化とともに検証強化 |

---

## 使用例

### 粗い設定でスタート

```powershell
# 会話から始める
.\skills\adev-config-skill.ps1 -chat "TS で Firebase アプリ"

# 出力：シンプルな YAML
stack:
  language:
    primary: ts
deploy:
  platform: firebase
```

### 詳細化が必要になったら

```powershell
# 対話モードで詳細設定
.\skills\adev-config-skill.ps1 -i

# または
adev refine
```

### 検証可能にしたい

```powershell
# JSON Schema を生成
adev generate-schema

# 検証
adev validate
```

---

## スキーマバージョニング

```yaml
metadata:
  schema: "https://adev.dev/schema/v1"
  version: "1.0.0"
```

**スキーマ進化:**
- v1: 基本 9 レイヤー
- v2: プラグインシステム
- v3: マルチプロジェクト

---

**txt → md → yaml → json**

**粗い → 細かい → 検証可能**

**会話 → 仕様 → 設定 → 型**
