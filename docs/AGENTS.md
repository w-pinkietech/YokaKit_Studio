# Agents Guide

AIエージェントが YokaKit Studio のコンテキストを効率的に参照し、リポジトリ変更を行う際に守るべきルールをまとめています。概要のみ確認したい場合はリポジトリ直下の [../AGENTS.md](../AGENTS.md) を参照してください。

## 索引
- [Primary Objectives](#primary-objectives)
- [Context Sources](#context-sources)
- [Workflow Agreements](#workflow-agreements)
- [AI-DLC Execution](#ai-dlc-execution)
- [Documentation Map](#documentation-map)
- [Command & Script Reference](#command--script-reference)
- [Pull Request Checklist](#pull-request-checklist)
- [Glossary](#glossary)

## Primary Objectives
- ヒューマンチームが定義したガバナンス・プロセスに従って実装/ドキュメント作業を行う。
- 変更前にコンテキスト（Intent, Units, ADRなど）を確認し、差分理由を明確にする。
- 作業後は必ず検証ステップとフォローアップを提案する。

## Context Sources
| 種別 | 参照先 | 用途 |
|------|---------|------|
| プロジェクト概要 | `README.md` | 全体アーキテクチャとComposite構成の把握。 |
| フレームワークガバナンス | `framework-governance.md` | Issue/PR運用、ラベル体系、手続き確認。 |
| 開発プロセス | `development-process.md` | AI-DLC のTDD/ドキュメント駆動手順。 |
| ドキュメント集約 | `docs/README.md` | ヒューマン向けドキュメント一覧。 |

## Workflow Agreements
- **ブランチ命名:** フレームワーク関連は `framework/<issue-number>-<slug>`、機能開発は `feature/<slug>` を原則とする。
- **Issue ファースト:** すべての変更はIssueを起点とし、`status::needs-decision`→`status::ready`の遷移を追う。
- **PR必須:** `framework-governance.md` に記載されたレビューフローを遵守し、Draft PR でも議論を開始する。

## AI-DLC Execution
AI-DLC プロセスに沿って作業することが必須です。より詳しい手順は [development-process.md](development-process.md) を参照しつつ、下記の要点を確認してください。

1. **Domain Design チェック**  
   `.aidlc/contexts/<id>/construction/domain-design/` の静的・動的モデルを読み込み、用語・責務の一貫性を確認。欠落があれば Issue 化。

2. **Logical Design / ADR**  
   `.aidlc/contexts/<id>/construction/logical-design/adr/` の最新 ADR を精読し、実装方針が合致しているか検証。

3. **Test Specification → FAIL 確認**  
   テストケースが揃っているか確認し、必要なら追加。テストは先に FAIL 状態でコミットしてから実装に進む。

4. **Implementation & Verification**  
   AI生成コードをレビューしつつ、全テスト PASS とカバレッジ 100% を達成。必要に応じてリファクタリング。

5. **Documentation Update**  
   `code-mapping.md` や関連ドキュメントを更新し、PR では参照した Intent / ADR / Domain Design を明記。

6. **Follow-up**  
   残タスクは Issue/TODO に残し、必要な承認を取得してからマージする。

## Documentation Map
```
/README.md                 # リポジトリ概要
/docs/README.md            # ヒューマン向けハブ
/docs/AGENTS.md            # このガイド
/AGENTS.md                 # エージェント向けクイックスタート
/docs/framework-governance.md  # ガバナンス詳細
/docs/development-process.md   # 開発プロセス詳細
/scripts/setup_labels.sh   # ラベル同期スクリプト
```
> ドキュメントが更新された際は、このマップも随時アップデートしてください。

## Command & Script Reference
- `scripts/setup_labels.sh <owner/repo>`: ラベルの同期。実行前に `GITHUB_TOKEN` または `GH_TOKEN` を設定。
- `gh auth status`: GitHub CLI の認証状態を確認。エラーがあれば再ログイン。
- `git submodule status`: 参照・コード出力リポジトリの現在のコミットを確認。
- `/constitution`, `/inception`, `/construction` などのスラッシュコマンドは専用CLIを介して実行する。詳細は Issue #2 にて整備予定。

## Pull Request Checklist
1. 変更に紐づく Issue を `Closes #<n>` でリンクしたか。
2. フレームワーク関連の場合、タイトルに `[framework]` を付与したか。
3. 主要ファイル・行番号を記載した説明を提供したか。
4. テスト/検証ステップを実施し、結果を記述したか。
5. レビュー後のフォローアップタスクを TODO として整理したか。

## Glossary
- **Context Studio**: 文脈統合リポジトリ。本リポジトリを指す。
- **Code Output**: Submoduleとして接続される実装リポジトリ群。
- **Bolt**: AI-DLCにおける最小イテレーション単位。
- **Disposability**: AIが成果物を再生成できる難易度。低いほど永続化が重要。

---
更新が必要な場合は、関連Issueにコメントを残してから編集を行ってください。
