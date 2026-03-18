# ADR - Architecture Decision Record

技術的な決定を記録するドキュメント。

## 生成方法

```powershell
# 対話モードで ADR 自動生成
.\skills\adev-config-skill.ps1 -i

# ADR を生成するか聞かれるので "y" と回答
```

## 出力例

`docs/adr/YYYYMMDD-HHMMSS-stack-decision.md`

```markdown
# ADR-0001: Technology Stack Decision

## Date

2026-03-19

## Context

プロジェクトの技術スタックを決定する必要がある。

## Options Considered

### Stack Comparison

| Stack | Pros | Cons | Best For |
|-------|------|------|----------|
| TypeScript | 型安全性，IDE サポート，エコシステム | ビルド必要，学習コスト | Web アプリ，SPA |
| JavaScript | 設定不要，広範なサポート | 型なし，ランタイムエラー | プロトタイプ，小規模 |
| Python | 可読性，豊富なライブラリ | 遅い，GIL | データ分析，AI/ML |
| Go | 高速，並行処理，単一バイナリ | 総記的，エラー処理冗長 | マイクロサービス，CLI |
| Rust | メモリ安全，超高速，所有権 | 学習曲線，コンパイル遅い | システム，パフォーマンス |

### Deploy Comparison

| Platform | Pros | Cons | Best For |
|----------|------|------|----------|
| Firebase | 簡単，リアルタイム，認証込み | ベンダーロック，コスト増 | SPA，モバイル |
| Vercel | 最速デプロイ，エッジ関数，無料枠 | Next.js 中心，制限あり | Next.js，静的サイト |
| AWS | 高機能，スケーラブル，信頼性 | 複雑，コスト管理困難 | 大規模，エンタープライズ |
| GCP | Kubernetes，データ分析，AI 機能 | 複雑，ドキュメント不足 | データ分析，AI/ML |

## Decision

**Language:** TypeScript
**Deploy:** Firebase
**Style:** TDD

### Rationale

- **TypeScript** を選択:
  - 型安全性
  - IDE サポート
  - エコシステム

- **Firebase** を選択:
  - 簡単
  - リアルタイム
  - 認証込み

- **TDD** を選択:
  - バグ減少
  - リファクタ容易
  - ドキュメント代わり

## Consequences

### Positive
- 型安全性によるバグ減少
- 迅速なデプロイ
- テストによる品質保証

### Negative
- 初期設定コスト
- 学習曲線

### Risks
- ベンダーロックインの可能性
- スケーリング時のコスト増
```

## 機能

### 1. 最適スタック提案

プロジェクトタイプから最適なスタックを自動提案：

```
Project: Web アプリ → TypeScript + Vercel
Project: SPA → TypeScript + Firebase
Project: データ分析 → Python + GCP
Project: CLI → Go + AWS
```

### 2. Pro/Con 比較表

各オプションのメリット・デメリットを自動表示：

```
【Stack: TypeScript】
  Pros: 型安全性，IDE サポート，エコシステム
  Cons: ビルド必要，学習コスト
```

### 3. ADR 自動生成

決定理由と比較表を記録：

- Context（文脈）
- Options（検討した選択肢）
- Decision（決定と理由）
- Consequences（結果・リスク）

## 使用例

```powershell
# 対話モード（推奨）
.\skills\adev-config-skill.ps1 -i

# チャットから（推奨スタック自動提案）
.\skills\adev-config-skill.ps1 -chat "Web アプリ作りたい"

# 出力：
# ✅ adev.yaml を生成しました
# ✅ ADR を生成しました：docs\adr\20260319-120000-stack-decision.md
```

## 出力ファイル

```
adev/
├── adev.yaml                 # 設定ファイル
└── docs/
    └── adr/
        ├── 20260319-120000-stack-decision.md
        └── 20260319-150000-deploy-change.md
```

## ADR テンプレート

```markdown
# ADR-000X: [Title]

## Date

[YYYY-MM-DD]

## Context

[状況説明]

## Options Considered

[比較表]

## Decision

**[Decision]**

### Rationale

[理由]

## Consequences

### Positive
- 

### Negative
- 

### Risks
- 
```

---

**ADR で決定を記録 → 一貫性のあるアーキテクチャ**
