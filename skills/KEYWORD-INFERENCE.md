# Keyword Inference Map

曖昧なキーワードからベストスタックを推論するマップ。

## Inference Engine

```powershell
$recommendation = Get-OptimalStack -ProjectType "" -Requirements "チャットアプリ作りたい"
```

**Output:**
```
【Recommendation】
  キーワード「chat, mobile」から推論
  Stack: TypeScript (confidence: 80%)
  Deploy: Firebase
  Style: TDD
```

---

## Keyword Categories

### Web/Frontend 系 → TypeScript + Vercel

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| web, website, サイト | ts | vercel | 標準的な Web アプリ |
| react, vue, angular | ts | vercel | フロントエンド框架 |
| next, nuxt | ts | vercel | SSR/SSG |
| spa | ts | firebase | シングルページ |
| 画面，ui, frontend | ts | vercel | UI 中心 |

### API/Backend 系 → TypeScript/Go + AWS

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| api, backend, server | ts | aws | 汎用バックエンド |
| microservice, マイクロサービス | go | aws | 並行処理・高速 |
| rest, graphql | ts | aws | API 設計 |

### Mobile 系 → TypeScript + Firebase

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| mobile, アプリ，スマホ | ts | firebase | モバイル向け |
| ios, android | ts | firebase | ネイティブ連携 |
| react-native | ts | firebase | クロスプラットフォーム |

### Data/AI 系 → Python + GCP

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| ai, ml, 機械学習 | py | gcp | AI/ML ライブラリ |
| data, 分析，統計 | py | gcp | データ処理 |
| pandas, numpy | py | gcp | データ分析 |
| tensorflow, pytorch | py | gcp | ディープラーニング |
| jupyter, notebook | py | gcp | 対話的分析 |

### CLI/Tool 系 → Go + AWS

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| cli, tool, ツール | go | aws | 単一バイナリ |
| command, infrastructure | go | aws | インフラ制御 |
| docker, kubernetes, k8s | go | aws/gcp | コンテナ |
| devops | go | aws | 運用ツール |

### System 系 → Rust + AWS

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| system, embedded | rust | aws | システム制御 |
| performance, 高速 | rust | aws | パフォーマンス |
| safety, memory | rust | aws | メモリ安全 |
| wasm, webassembly | rust | vercel | WebAssembly |
| blockchain, crypto | rust | aws | 暗号通貨 |

### Startup/MVP 系 → TypeScript/JS + Vercel

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| startup, mvp | ts | vercel | 最速立ち上げ |
| prototype, プロトタイプ | js | vercel | 手軽さ重視 |
| quick, simple, 簡単 | ts | firebase | 簡単デプロイ |

### Enterprise 系 → TypeScript + AWS

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| enterprise, business | ts | aws | 信頼性 |
| large, scale | ts | aws | スケーラビリティ |
| production, critical | ts | aws | 本番運用 |

### Blog/Content 系 → TypeScript + Vercel

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| blog, portfolio | ts | vercel | 静的サイト |
| static, cms | ts | vercel | コンテンツ管理 |

### Realtime 系 → TypeScript + Firebase

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| realtime, chat, live | ts | firebase | リアルタイム DB |
| websocket | ts | aws | WebSocket 制御 |

### E-commerce 系 → TypeScript + AWS

| Keyword | Stack | Deploy | Reason |
|---------|-------|--------|--------|
| ecommerce, shop, store | ts | aws | 決済・在庫 |
| 決済，payment | ts | aws | 決済システム |

---

## Scoring Algorithm

```
1. KeywordToStackMap でマッチしたキーワードに +2 点
2. Stack 固有キーワードにマッチしたら +1 点
3. Deploy 固有キーワードにマッチしたら +1 点
4. Style 固有キーワードにマッチしたら +1 点
5. 最高スコアのスタックを選択
6. Confidence = min(1.0, score * 0.2)
```

### Example

**Input:** "チャットアプリ作りたい"

```
Matched keywords:
- "chat" → ts +2, firebase +2, TDD +1
- "mobile" (アプリ) → ts +2, firebase +2, TDD +1

Scores:
- ts: 4 点 → confidence 80%
- firebase: 4 点
- TDD: 2 点

Result: TypeScript + Firebase + TDD
```

---

## Usage

```powershell
# 曖昧なキーワードから推論
.\skills\adev-config-skill.ps1 -chat "チャットアプリ作りたい"

# 出力:
# 【Recommendation】
#   キーワード「chat, mobile」から推論
#   Stack: TypeScript (confidence: 80%)
#   Deploy: Firebase
#   Style: TDD
```

---

**80+ keywords mapped → Intelligent stack inference**
