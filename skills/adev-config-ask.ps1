# adev-config-ask.ps1
# ask_user_question wrapper for adev-config-skill
# 
# Usage: 
#   .\skills\adev-config-ask.ps1
#
# This script outputs questions in ask_user_question format

# 質問定義
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
    },
    @{
        header = "Stack"
        question = "使用する言語/フレームワークは？"
        options = @(
            @{ label = "TypeScript"; description = "型安全性，Web アプリに最適" },
            @{ label = "JavaScript"; description = "設定不要，プロトタイプに" },
            @{ label = "Python"; description = "AI/ML，データ分析に" },
            @{ label = "Go"; description = "マイクロサービス，CLI に" },
            @{ label = "Rust"; description = "システム，パフォーマンス重視" }
        )
        multiSelect = $false
    },
    @{
        header = "Deploy"
        question = "デプロイ先は？"
        options = @(
            @{ label = "Firebase"; description = "簡単，リアルタイム，モバイル" },
            @{ label = "Vercel"; description = "最速デプロイ，Next.js" },
            @{ label = "AWS"; description = "高機能，スケーラブル" },
            @{ label = "GCP"; description = "Kubernetes，AI/ML" }
        )
        multiSelect = $false
    },
    @{
        header = "Style"
        question = "開発スタイルは？"
        options = @(
            @{ label = "TDD"; description = "テスト駆動開発，品質重視" },
            @{ label = "BDD"; description = "振る舞い駆動開発，チーム連携" },
            @{ label = "Agile"; description = "アジャイル，柔軟な開発" }
        )
        multiSelect = $false
    }
)

# JSON 出力
$questions | ConvertTo-Json -Depth 10
