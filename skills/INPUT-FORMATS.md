# Input Spec - 柔軟な入力フォーマット

人間の読み書きするフォーマットは柔軟に対応します。
以下の任意の形式で入力できます。

---

## 1. 自然言語 (Natural Language)

```
Firebase で TypeScript のアプリを作りたい
TDD でやって、GitHub で管理
デプロイは Vercel がいい
```

**抽出されるレイヤー:**
- LAYER 2 (STACK): language.primary = ts
- LAYER 3 (STYLE): methodology = TDD
- LAYER 4 (DEPLOY): platform = firebase/vercel

---

## 2. Markdown

```markdown
## Stack
- Language: TypeScript
- Test: Jest

## Style
TDD

## Deploy
Firebase
```

**抽出されるレイヤー:**
- LAYER 2 (STACK): language, test
- LAYER 3 (STYLE): methodology
- LAYER 4 (DEPLOY): platform

---

## 3. YAML (Minimal)

```yaml
stack:
  language:
    primary: ts
style:
  methodology: TDD
deploy:
  platform: firebase
```

**抽出されるレイヤー:**
- LAYER 2, 3, 4 を直接指定

---

## 4. YAML (Full 9 Layers)

```yaml
metadata:
  version: "1.0.0"
  confidence:
    stack: 0.95

context:
  chat:
    url: https://gemini.google.com/app/...

stack:
  language:
    primary: ts
  runtime:
    name: node

style:
  methodology: TDD

deploy:
  platform: firebase

team:
  workflow: chat-to-impl

structure:
  root:
    - src/

constraints:
  must:
    - "すべてのコードは型付きであること"

quality:
  metrics:
    maintainability_index: 80
```

**抽出されるレイヤー:**
- 全 9 レイヤー

---

## 5. JSON

```json
{
  "stack": {
    "language": { "primary": "ts" },
    "test": { "framework": "jest" }
  },
  "style": { "methodology": "TDD" },
  "deploy": { "platform": "firebase" }
}
```

**抽出されるレイヤー:**
- LAYER 2, 3, 4

---

## 6. キーワード羅列

```
ts TDD firebase jest github
```

**抽出されるレイヤー:**
- LAYER 2 (STACK): ts
- LAYER 3 (STYLE): TDD
- LAYER 4 (DEPLOY): firebase
- LAYER 2 (STACK.test): jest

---

## 7. 対話形式 (Interactive)

```
Q: どの言語を使いますか？
A: TypeScript

Q: 開発スタイルは？
A: TDD で

Q: デプロイ先は？
A: Firebase
```

**抽出されるレイヤー:**
- 対話から全レイヤーを構築

---

## 8. Chat ログ形式

```
[User] 新しいプロジェクト始めたい
[User] TypeScript で Firebase 使いたい
[Assistant] TDD でやりますか？
[User] それでお願い
```

**抽出されるレイヤー:**
- LAYER 1 (CONTEXT): chat log
- LAYER 2 (STACK): ts
- LAYER 3 (STYLE): TDD
- LAYER 4 (DEPLOY): firebase

---

## Output: 9-Layer YAML

すべての入力は 9 層構造の `adev.yaml` に統一されます：

```yaml
# LAYER 0: METADATA
metadata:
  version: "1.0.0"
  generated: "2026-03-19T00:00:00+09:00"
  generator: adev-config-skill
  confidence:
    stack: 0.95
    style: 0.90
    deploy: 0.85

# LAYER 1: CONTEXT
context:
  chat:
    url: "..."
    provider: gemini

# LAYER 2: STACK
stack:
  language:
    primary: ts
  runtime:
    name: node
  test:
    framework: jest

# LAYER 3: STYLE
style:
  methodology: TDD

# LAYER 4: DEPLOY
deploy:
  platform: firebase

# LAYER 5: TEAM
team:
  workflow: chat-to-impl

# LAYER 6: STRUCTURE
structure:
  root:
    - src/

# LAYER 7: CONSTRAINTS
constraints:
  must:
    - "すべてのコードは型付きであること"

# LAYER 8: QUALITY
quality:
  metrics:
    maintainability_index: 80
```

---

## 使用方法

```powershell
# 対話モード
.\skills\adev-config-skill.ps1 -i

# チャットテキストから自動抽出
.\skills\adev-config-skill.ps1 -chat "Firebase で TypeScript のアプリを作りたい"

# デフォルト実行 (9 layers)
.\skills\adev-config-skill.ps1
```

---

**柔軟な入力 → 9 層構造 → 自動実装**

See [`LAYERS.md`](LAYERS.md) for layer details.
