# adev-config-skill.ps1
# 対話型仕様選択スキル - Chat → adev.yaml 自動生成
# 機能：最適スタック提案、ADR 比較、Pro/Con 分析
# ask_user_question 対応

param(
    [string]$ChatContext,
    [string]$OutputPath = ".\adev.yaml"
)

# ============================================================================
# Stack Options Database - 最適候補と代替案
# ============================================================================
$StackOptions = @{
    ts = @{
        Name = "TypeScript"
        UseCases = @("Web アプリ", "SPA", "フルスタック")
        Pros = @("型安全性", "IDE サポート", "エコシステム")
        Cons = @("ビルド必要", "学習コスト")
        DefaultTest = "jest"
        DefaultRuntime = "node"
        Keywords = @("web", "spa", "react", "vue", "angular", "next", "nuxt", "frontend", "backend", "fullstack", "ブラウザ", "画面", "ui", "コンポーネント")
    }
    js = @{
        Name = "JavaScript"
        UseCases = @("プロトタイプ", "小規模", "スクリプト")
        Pros = @("設定不要", "広範なサポート")
        Cons = @("型なし", "ランタイムエラー")
        DefaultTest = "jest"
        DefaultRuntime = "node"
        Keywords = @("簡単", "手軽", "スクリプト", "ブラウザ", "dom", "jquery", "プロトタイプ", "mvp")
    }
    py = @{
        Name = "Python"
        UseCases = @("データ分析", "AI/ML", "バックエンド")
        Pros = @("可読性", "豊富なライブラリ")
        Cons = @("遅い", "GIL")
        DefaultTest = "pytest"
        DefaultRuntime = "python"
        Keywords = @("ai", "ml", "data", "analysis", "pandas", "numpy", "tensorflow", "pytorch", "scikit", "jupyter", "notebook", "統計", "機械学習", "ディープラーニング", "分析", "可視化", "matplotlib", "backtest", "automation", "script")
    }
    go = @{
        Name = "Go"
        UseCases = @("マイクロサービス", "CLI", "インフラ")
        Pros = @("高速", "並行処理", "単一バイナリ")
        Cons = @("総記的", "エラー処理冗長")
        DefaultTest = "gotest"
        DefaultRuntime = "go"
        Keywords = @("microservice", "api", "server", "cli", "tool", "infrastructure", "docker", "kubernetes", "k8s", "devops", "proxy", "gateway", "concurrent", "goroutine", "performance", "binary", "distribution")
    }
    rust = @{
        Name = "Rust"
        UseCases = @("システム", "パフォーマンス重視", "WASM")
        Pros = @("メモリ安全", "超高速", "所有権")
        Cons = @("学習曲線", "コンパイル遅い")
        DefaultTest = "cargo-test"
        DefaultRuntime = "rust"
        Keywords = @("system", "embedded", "wasm", "webassembly", "performance", "critical", "safety", "memory", "zero-cost", "no-segfault", "os", "kernel", "driver", "blockchain", "crypto")
    }
}

$DeployOptions = @{
    firebase = @{
        Name = "Firebase"
        UseCases = @("SPA", "モバイル", "スタートアップ")
        Pros = @("簡単", "リアルタイム", "認証込み")
        Cons = @("ベンダーロック", "コスト増")
        Keywords = @("spa", "mobile", "startup", "mvp", "realtime", "chat", "auth", "firestore", "database", "quick", "simple", "easy", "hosting", "functions")
    }
    vercel = @{
        Name = "Vercel"
        UseCases = @("Next.js", "静的サイト", "エッジ")
        Pros = @("最速デプロイ", "エッジ関数", "無料枠")
        Cons = @("Next.js 中心", "制限あり")
        Keywords = @("nextjs", "next.js", "static", "blog", "portfolio", "edge", "fast", "instant", "preview", "frontend", "jamstack")
    }
    aws = @{
        Name = "AWS"
        UseCases = @("大規模", "エンタープライズ")
        Pros = @("高機能", "スケーラブル", "信頼性")
        Cons = @("複雑", "コスト管理困難")
        Keywords = @("enterprise", "large", "scale", "microservice", "lambda", "ec2", "s3", "cloudfront", "reliable", "production", "critical", "global")
    }
    gcp = @{
        Name = "GCP"
        UseCases = @("データ分析", "AI/ML", "コンテナ")
        Pros = @("Kubernetes", "データ分析", "AI 機能")
        Cons = @("複雑", "ドキュメント不足")
        Keywords = @("kubernetes", "gke", "data", "analytics", "bigquery", "ai", "ml", "tensorflow", "container", "docker", "datascience")
    }
}

$StyleOptions = @{
    TDD = @{
        Name = "Test-Driven Development"
        UseCases = @("品質重視", "リファクタ頻繁", "長期プロジェクト")
        Pros = @("バグ減少", "リファクタ容易", "ドキュメント代わり")
        Cons = @("初期コスト", "学習曲線")
        Keywords = @("quality", "bug", "refactor", "long-term", "test", "unit", "coverage", "ci", "cd", "reliable", "stable")
    }
    BDD = @{
        Name = "Behavior-Driven Development"
        UseCases = @("要件明確", "チーム連携", "_acceptance test")
        Pros = @("共通言語", "仕様明確", "自動テスト")
        Cons = @("オーバーヘッド", "維持コスト")
        Keywords = @("requirement", "team", "collaboration", "acceptance", "spec", "gherkin", "cucumber", "behavior", "user-story")
    }
    Agile = @{
        Name = "Agile Development"
        UseCases = @("変化対応", "短期リリース", "スタートアップ")
        Pros = @("柔軟", "フィードバック早い")
        Cons = @("ドキュメント軽視", "スコープクリープ")
        Keywords = @("agile", "scrum", "sprint", "fast", "iterate", "feedback", "startup", "mvp", "pivot", "flexible")
    }
}

# ============================================================================
# 曖昧キーワードからベストスタックを推論
# ============================================================================
$KeywordToStackMap = @{
    # Web/Frontend 系
    "web" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "website" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "サイト" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "ウェブ" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "ブラウザ" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "画面" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "ui" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "frontend" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "react" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "vue" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "angular" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "next" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "nuxt" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "spa" = @{ Stack = "ts"; Deploy = "firebase"; Style = "TDD" }
    
    # API/Backend 系
    "api" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "backend" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "server" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "microservice" = @{ Stack = "go"; Deploy = "aws"; Style = "TDD" }
    "マイクロサービス" = @{ Stack = "go"; Deploy = "aws"; Style = "TDD" }
    "rest" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "graphql" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    
    # Mobile 系
    "mobile" = @{ Stack = "ts"; Deploy = "firebase"; Style = "TDD" }
    "アプリ" = @{ Stack = "ts"; Deploy = "firebase"; Style = "TDD" }
    "スマホ" = @{ Stack = "ts"; Deploy = "firebase"; Style = "TDD" }
    "ios" = @{ Stack = "ts"; Deploy = "firebase"; Style = "TDD" }
    "android" = @{ Stack = "ts"; Deploy = "firebase"; Style = "TDD" }
    "react-native" = @{ Stack = "ts"; Deploy = "firebase"; Style = "TDD" }
    
    # Data/AI 系
    "ai" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "ml" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "data" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "分析" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "機械学習" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "ディープラーニング" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "pandas" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "numpy" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "tensorflow" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "pytorch" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "jupyter" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    "統計" = @{ Stack = "py"; Deploy = "gcp"; Style = "Agile" }
    
    # CLI/Tool 系
    "cli" = @{ Stack = "go"; Deploy = "aws"; Style = "TDD" }
    "tool" = @{ Stack = "go"; Deploy = "aws"; Style = "TDD" }
    "ツール" = @{ Stack = "go"; Deploy = "aws"; Style = "TDD" }
    "command" = @{ Stack = "go"; Deploy = "aws"; Style = "TDD" }
    "infrastructure" = @{ Stack = "go"; Deploy = "aws"; Style = "TDD" }
    "devops" = @{ Stack = "go"; Deploy = "aws"; Style = "TDD" }
    "docker" = @{ Stack = "go"; Deploy = "aws"; Style = "TDD" }
    "kubernetes" = @{ Stack = "go"; Deploy = "gcp"; Style = "TDD" }
    
    # System 系
    "system" = @{ Stack = "rust"; Deploy = "aws"; Style = "TDD" }
    "embedded" = @{ Stack = "rust"; Deploy = "aws"; Style = "TDD" }
    "performance" = @{ Stack = "rust"; Deploy = "aws"; Style = "TDD" }
    "safety" = @{ Stack = "rust"; Deploy = "aws"; Style = "TDD" }
    "wasm" = @{ Stack = "rust"; Deploy = "vercel"; Style = "TDD" }
    "blockchain" = @{ Stack = "rust"; Deploy = "aws"; Style = "TDD" }
    "crypto" = @{ Stack = "rust"; Deploy = "aws"; Style = "TDD" }
    
    # Startup/MVP 系
    "startup" = @{ Stack = "ts"; Deploy = "vercel"; Style = "Agile" }
    "mvp" = @{ Stack = "ts"; Deploy = "vercel"; Style = "Agile" }
    "prototype" = @{ Stack = "js"; Deploy = "vercel"; Style = "Agile" }
    "プロトタイプ" = @{ Stack = "js"; Deploy = "vercel"; Style = "Agile" }
    "quick" = @{ Stack = "ts"; Deploy = "vercel"; Style = "Agile" }
    "simple" = @{ Stack = "ts"; Deploy = "vercel"; Style = "Agile" }
    "簡単" = @{ Stack = "ts"; Deploy = "firebase"; Style = "Agile" }
    
    # Enterprise 系
    "enterprise" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "large" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "scale" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "production" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "business" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    
    # Blog/Content 系
    "blog" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "portfolio" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "static" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "cms" = @{ Stack = "ts"; Deploy = "vercel"; Style = "TDD" }
    "media" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    
    # Realtime 系
    "realtime" = @{ Stack = "ts"; Deploy = "firebase"; Style = "TDD" }
    "chat" = @{ Stack = "ts"; Deploy = "firebase"; Style = "TDD" }
    "live" = @{ Stack = "ts"; Deploy = "firebase"; Style = "TDD" }
    "websocket" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    
    # E-commerce 系
    "ecommerce" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "shop" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "store" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "決済" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
    "payment" = @{ Stack = "ts"; Deploy = "aws"; Style = "TDD" }
}

# ============================================================================
# ADR (Architecture Decision Record) 生成
# ============================================================================
function New-ADR {
    param(
        [string]$Title,
        [string]$Context,
        [array]$Options,
        [string]$Decision,
        [array]$Consequences
    )
    
    $adr = @"
# ADR: $Title

## Context

$Context

## Options

$(foreach ($opt in $Options) {
    $opt
})

## Decision

**$Decision**

## Consequences

$(foreach ($c in $Consequences) {
    "- $c"
})

## References

- Generated by adev-config-skill
- Date: $(Get-Date -Format "yyyy-MM-dd")
"@
    
    return $adr
}

# ============================================================================
# Pro/Con 比較表 生成
# ============================================================================
function Get-StackComparison {
    param([array]$Stacks)
    
    $table = @"

## Stack Comparison

| Stack | Pros | Cons | Best For |
|-------|------|------|----------|
"@
    
    foreach ($stack in $Stacks) {
        $info = $StackOptions[$stack]
        if ($info) {
            $pros = ($info.Pros -join ", ")
            $cons = ($info.Cons -join ", ")
            $uses = ($info.UseCases -join ", ")
            $table += "| $($info.Name) | $pros | $cons | $uses |`n"
        }
    }
    
    return $table
}

function Get-DeployComparison {
    param([array]$Deploys)
    
    $table = @"

## Deploy Comparison

| Platform | Pros | Cons | Best For |
|----------|------|------|----------|
"@
    
    foreach ($deploy in $Deploys) {
        $info = $DeployOptions[$deploy]
        if ($info) {
            $pros = ($info.Pros -join ", ")
            $cons = ($info.Cons -join ", ")
            $uses = ($info.UseCases -join ", ")
            $table += "| $($info.Name) | $pros | $cons | $uses |`n"
        }
    }
    
    return $table
}

# ============================================================================
# 曖昧キーワードからベストスタックを推論
# ============================================================================
function Get-OptimalStack {
    param(
        [string]$ProjectType,
        [string]$Requirements
    )
    
    $inputText = ($ProjectType + " " + $Requirements).ToLower()
    
    # キーワードマッチングでスコア計算
    $scores = @{
        ts = 0
        js = 0
        py = 0
        go = 0
        rust = 0
    }
    
    $deployScores = @{
        firebase = 0
        vercel = 0
        aws = 0
        gcp = 0
    }
    
    $styleScores = @{
        TDD = 0
        BDD = 0
        Agile = 0
    }
    
    # KeywordToStackMap からマッチしたキーワードのスコアを加算
    foreach ($kv in $KeywordToStackMap.GetEnumerator()) {
        if ($inputText -match $kv.Key) {
            $scores[$kv.Value.Stack] += 2
            $deployScores[$kv.Value.Deploy] += 2
            $styleScores[$kv.Value.Style] += 1
        }
    }
    
    # 各スタックのキーワードもチェック
    foreach ($stack in $StackOptions.Keys) {
        $info = $StackOptions[$stack]
        foreach ($keyword in $info.Keywords) {
            if ($inputText -match $keyword.ToLower()) {
                $scores[$stack] += 1
            }
        }
    }
    
    # デプロイのキーワードチェック
    foreach ($deploy in $DeployOptions.Keys) {
        $info = $DeployOptions[$deploy]
        foreach ($keyword in $info.Keywords) {
            if ($inputText -match $keyword.ToLower()) {
                $deployScores[$deploy] += 1
            }
        }
    }
    
    # スタイルのキーワードチェック
    foreach ($style in $StyleOptions.Keys) {
        $info = $StyleOptions[$style]
        foreach ($keyword in $info.Keywords) {
            if ($inputText -match $keyword.ToLower()) {
                $styleScores[$style] += 1
            }
        }
    }
    
    # 最高スコアを取得
    $bestStack = ($scores.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 1).Key
    $bestDeploy = ($deployScores.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 1).Key
    $bestStyle = ($styleScores.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 1).Key
    
    # デフォルト値
    if (-not $bestStack -or $scores[$bestStack] -eq 0) { $bestStack = "ts" }
    if (-not $bestDeploy -or $deployScores[$bestDeploy] -eq 0) { $bestDeploy = "firebase" }
    if (-not $bestStyle -or $styleScores[$bestStyle] -eq 0) { $bestStyle = "TDD" }
    
    # 推論理由を生成
    $reason = ""
    $matchedKeywords = @()
    
    foreach ($kv in $KeywordToStackMap.GetEnumerator()) {
        if ($inputText -match $kv.Key) {
            $matchedKeywords += $kv.Key
        }
    }
    
    if ($matchedKeywords.Count -gt 0) {
        $reason = "キーワード「$($matchedKeywords -join ', ')」から推論"
    } else {
        $reason = "デフォルト推奨スタック"
    }
    
    return @{
        Stack = $bestStack
        Deploy = $bestDeploy
        Style = $bestStyle
        Reason = $reason
        Scores = $scores
        Confidence = [math]::Min(1.0, ($scores[$bestStack] * 0.2))
    }
}

# ============================================================================
# 自然言語から設定を抽出
# ============================================================================
function Extract-ConfigFromChat {
    param([string]$ChatText)
    
    $config = @{}
    
    # Stack 抽出
    foreach ($lang in $StackOptions.Keys) {
        if ($ChatText -match "\b$lang\b") {
            $config.Stack = $lang
            break
        }
    }
    
    # Deploy 抽出
    foreach ($deploy in $DeployOptions.Keys) {
        if ($ChatText -match "\b$deploy\b") {
            $config.Deploy = $deploy
            break
        }
    }
    
    # Style 抽出
    foreach ($style in $StyleOptions.Keys) {
        if ($ChatText -match "\b$style\b") {
            $config.Style = $style
            break
        }
    }
    
    return $config
}

# ============================================================================
# 柔軟なフォーマットから YAML 生成 (Layered Structure)
# ============================================================================
function Convert-ToAdevYaml {
    param(
        [object]$Config,
        [string]$ChatUrl = ""
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ss+09:00"
    
    $yaml = @"
# adev.yaml - Auto-generated by adev-config-skill
# Layers: metadata → context → stack → style → deploy → team → structure → constraints → quality

metadata:
  version: "1.0.0"
  generated: "$timestamp"
  generator: adev-config-skill
  source:
    type: chat
    url: "$ChatUrl"
    extracted_at: "$timestamp"
  confidence:
    stack: 0.95
    style: 0.90
    deploy: 0.85

context:
  chat:
    url: "$ChatUrl"
    provider: gemini
  project:
    name: ""
    description: ""
    vision: ""

stack:
  language:
    primary: $($Config.Stack)
    version: "5.0"
    strict: true
  
  runtime:
    name: node
    version: "20"
  
  framework:
    frontend: ""
    backend: ""
    build: ""
  
  data:
    database: $($Config.Deploy)
    cache: ""
    storage: $($Config.Deploy)
  
  test:
    framework: $($Config.Test)
    coverage_threshold: 80
    e2e: ""
  
  infra:
    deploy: $($Config.Deploy)
    ci_cd: github_actions
    monitoring: ""

style:
  methodology: $($Config.Style)
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

deploy:
  platform: $($Config.Deploy)
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
    firestore:
      enabled: false
    storage:
      enabled: false
    auth:
      enabled: false

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
    auto_deploy: false

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

constraints:
  must:
    - "すべてのコードは型付きであること"
    - "カバレッジ 80% 以上を維持"
  should:
    - "関数は 20 行以内"
  must_not:
    - "シークレットをコードにハードコード"

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
"@
    
    return $yaml
}

# ============================================================================
# ADR ファイル生成
# ============================================================================
function New-ADRFile {
    param(
        [object]$Config,
        [string]$OutputDir = ".\docs\adr"
    )
    
    if (-not (Test-Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir | Out-Null
    }
    
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $adrPath = "$OutputDir\$timestamp-stack-decision.md"
    
    $stackInfo = $StackOptions[$Config.Stack]
    $deployInfo = $DeployOptions[$Config.Deploy]
    $styleInfo = $StyleOptions[$Config.Style]
    
    $adr = @"
# ADR-0001: Technology Stack Decision

## Date

$(Get-Date -Format "yyyy-MM-dd")

## Context

プロジェクトの技術スタックを決定する必要がある。

## Options Considered

### Stack Options

$(Get-StackComparison -Stacks @("ts", "js", "py", "go", "rust"))

### Deploy Options

$(Get-DeployComparison -Deploys @("firebase", "vercel", "aws", "gcp"))

## Decision

**Language:** $($stackInfo.Name) ($($Config.Stack))
**Deploy:** $($deployInfo.Name) ($($Config.Deploy))
**Style:** $($styleInfo.Name) ($($Config.Style))

### Rationale

- **$($stackInfo.Name)** を選択:
$(foreach ($pro in $stackInfo.Pros) { "  - $pro" })

- **$($deployInfo.Name)** を選択:
$(foreach ($pro in $deployInfo.Pros) { "  - $pro" })

- **$($styleInfo.Name)** を選択:
$(foreach ($pro in $styleInfo.Pros) { "  - $pro" })

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

## Compliance

- [x] Stack selected
- [x] Deploy selected
- [x] Style selected
- [x] ADR documented

---
*Generated by adev-config-skill*
"@
    
    $adr | Out-File -FilePath $adrPath -Encoding UTF8
    Write-Host "`n✅ ADR を生成しました：$adrPath" -ForegroundColor Green
    
    return $adrPath
}

# ============================================================================
# メイン処理
# ============================================================================
function Invoke-AdevConfigSkill {
    param(
        [switch]$Interactive,
        [string]$ChatText,
        [string]$ChatUrl,
        [string]$OutputPath,
        [hashtable]$Answers  # ask_user_question からの回答
    )
    
    $config = @{}
    
    if ($Answers -ne $null) {
        # ask_user_question からの回答を使用
        Write-Host "`n【Processing Answers】" -ForegroundColor Cyan
        
        # Project → Stack 変換
        $projectMap = @{
            "Web アプリケーション" = "web"
            "SPA" = "spa"
            "API/Backend" = "api"
            "モバイルアプリ" = "mobile"
            "データ分析/AI" = "data"
            "CLI ツール" = "cli"
            "システムプログラミング" = "system"
        }
        
        if ($Answers.ContainsKey("project") -and $projectMap.ContainsKey($Answers["project"])) {
            $projectKey = $projectMap[$Answers["project"]]
            $recommendation = Get-OptimalStack -ProjectType $projectKey -Requirements ""
        } else {
            $recommendation = Get-OptimalStack -ProjectType "" -Requirements ""
        }
        
        # 推奨値を使用
        $config.Stack = $recommendation.Stack
        $config.Deploy = $recommendation.Deploy
        $config.Style = $recommendation.Style
        
        Write-Host "  Stack:  $($StackOptions[$config.Stack].Name)" -ForegroundColor White
        Write-Host "  Deploy: $($DeployOptions[$config.Deploy].Name)" -ForegroundColor White
        Write-Host "  Style:  $($config.Style)" -ForegroundColor White
        
    }
    elseif ($Interactive) {
        # 対話モード (従来の Read-Host フォールバック)
        Write-Host "`n=== ADEV Interactive Config ===" -ForegroundColor Cyan
        
        # 質問を JSON 形式で出力 (ask_user_question 用)
        $questions = @(
            @{
                header = "Project"
                question = "どのようなプロジェクトですか？"
                options = @(
                    @{ label = "Web アプリケーション"; description = "標準的な Web アプリ" },
                    @{ label = "SPA"; description = "Single Page App (React, Vue, etc)" },
                    @{ label = "API/Backend"; description = "REST/GraphQL API" },
                    @{ label = "モバイルアプリ"; description = "iOS/Android アプリ" },
                    @{ label = "データ分析/AI"; description = "機械学習、データ分析" },
                    @{ label = "CLI ツール"; description = "コマンドラインツール" },
                    @{ label = "システムプログラミング"; description = "組み込み、パフォーマンス重視" }
                )
                multiSelect = $false
            }
        )
        
        $questionsJson = $questions | ConvertTo-Json -Depth 10
        Write-Host "`nQuestions (JSON format for ask_user_question):" -ForegroundColor Gray
        Write-Host $questionsJson -ForegroundColor White
        Write-Host ""
        
        # 従来対話フォールバック
        Write-Host "【Project】どのようなプロジェクトですか？" -ForegroundColor Yellow
        Write-Host "  1) Web アプリケーション"
        Write-Host "  2) SPA (Single Page App)"
        Write-Host "  3) API / バックエンド"
        Write-Host "  4) モバイルアプリ"
        Write-Host "  5) データ分析 / AI"
        Write-Host "  6) CLI ツール"
        Write-Host "  7) システムプログラミング"
        $projectType = Read-Host "選択 (1-7) または自由入力"
        
        $projectMap = @{
            "1" = "web"
            "2" = "spa"
            "3" = "api"
            "4" = "mobile"
            "5" = "data"
            "6" = "cli"
            "7" = "system"
        }
        
        $projectKey = if ($projectMap.ContainsKey($projectType)) { $projectMap[$projectType] } else { $projectType }
        
        # 最適スタックを提案
        $recommendation = Get-OptimalStack -ProjectType $projectKey -Requirements ""
        
        Write-Host "`n【Recommendation】" -ForegroundColor Green
        Write-Host "  $($recommendation.Reason)" -ForegroundColor White
        Write-Host "  Stack: $($StackOptions[$recommendation.Stack].Name) (confidence: $($recommendation.Confidence.ToString("P0")))" -ForegroundColor White
        Write-Host "  Deploy: $($DeployOptions[$recommendation.Deploy].Name)" -ForegroundColor White
        Write-Host "  Style: $($recommendation.Style)" -ForegroundColor White
        
        $config.Stack = $recommendation.Stack
        $config.Deploy = $recommendation.Deploy
        $config.Style = $recommendation.Style
        
    }
    elseif ($ChatText) {
        # 自動抽出モード
        $config = Extract-ConfigFromChat -ChatText $ChatText
        
        # 最適スタック提案
        $recommendation = Get-OptimalStack -ProjectType "" -Requirements $ChatText
        
        Write-Host "`n【Recommendation】" -ForegroundColor Green
        Write-Host "  $($recommendation.Reason)" -ForegroundColor White
        Write-Host "  Stack: $($StackOptions[$recommendation.Stack].Name) ($($recommendation.Stack))" -ForegroundColor White
        Write-Host "  Deploy: $($DeployOptions[$recommendation.Deploy].Name) ($($recommendation.Deploy))" -ForegroundColor White
        Write-Host "  Style: $($recommendation.Style)" -ForegroundColor White
        
        if (-not $config.Stack) { $config.Stack = $recommendation.Stack }
        if (-not $config.Deploy) { $config.Deploy = $recommendation.Deploy }
        if (-not $config.Style) { $config.Style = $recommendation.Style }
        if (-not $config.Test) {
            $config.Test = if ($config.Stack -eq "ts") { "jest" }
                          elseif ($config.Stack -eq "py") { "pytest" }
                          elseif ($config.Stack -eq "go") { "gotest" }
                          else { "jest" }
        }
    }
    else {
        # デフォルト
        $config = @{
            Stack = "ts"
            Style = "TDD"
            Deploy = "firebase"
            Test = "jest"
            ChatUrl = $ChatUrl
        }
    }
    
    # Test default
    if (-not $config.Test) {
        $config.Test = if ($config.Stack -eq "ts") { "jest" }
                      elseif ($config.Stack -eq "py") { "pytest" }
                      elseif ($config.Stack -eq "go") { "gotest" }
                      else { "jest" }
    }
    
    # YAML 生成
    $yaml = Convert-ToAdevYaml -Config $config -ChatUrl $ChatUrl
    
    # 出力
    if ($OutputPath) {
        $yaml | Out-File -FilePath $OutputPath -Encoding UTF8
        Write-Host "`n✅ adev.yaml を生成しました：$OutputPath" -ForegroundColor Green
        
        # 生成された設定を表示
        Write-Host "`n--- 生成された設定 ---" -ForegroundColor Cyan
        Write-Host "Stack:  $($StackOptions[$config.Stack].Name) ($($config.Stack))" -ForegroundColor White
        Write-Host "  Pros: $($StackOptions[$config.Stack].Pros -join ', ')" -ForegroundColor Green
        Write-Host "  Cons: $($StackOptions[$config.Stack].Cons -join ', ')" -ForegroundColor Red
        Write-Host "Style:  $($config.Style)" -ForegroundColor White
        Write-Host "Deploy: $($DeployOptions[$config.Deploy].Name) ($($config.Deploy))" -ForegroundColor White
        Write-Host "  Pros: $($DeployOptions[$config.Deploy].Pros -join ', ')" -ForegroundColor Green
        Write-Host "  Cons: $($DeployOptions[$config.Deploy].Cons -join ', ')" -ForegroundColor Red
        Write-Host "Test:   $($config.Test)" -ForegroundColor White
    }
    else {
        # stdout に出力
        $yaml
    }
}

# ============================================================================
# エクスポート (モジュール内からのみ実行)
# ============================================================================
if ($MyInvocation.MyCommand.Module -ne $null) {
    Export-ModuleMember -Function Invoke-AdevConfigSkill, Extract-ConfigFromChat, Get-OptimalStack, New-ADRFile
}

# スクリプト直接実行時の処理
if ($MyInvocation.ScriptName -and $MyInvocation.ScriptName -ne $PROFILE) {
    Write-Host "`n=== adev-config-skill ===" -ForegroundColor Cyan
    
    if ($args[0] -eq "-i" -or $args[0] -eq "-interactive") {
        Invoke-AdevConfigSkill -Interactive
    }
    elseif ($args[0] -eq "-chat") {
        $chatText = $args[1..($args.Length-1)] -join " "
        Invoke-AdevConfigSkill -ChatText $chatText -OutputPath ".\adev.yaml"
    }
    else {
        Invoke-AdevConfigSkill -OutputPath ".\adev.yaml"
    }
}
