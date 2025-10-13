# Agents Guide

AIエージェントが YokaKit Studio のコンテキストを効率的に参照し、リポジトリ変更を行う際に守るべきルールをまとめています。概要のみ確認したい場合はリポジトリ直下の [../../AGENTS.md](../../AGENTS.md) を参照してください。

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
| フレームワークガバナンス | `10-governance/framework/README.md` | Issue/PR運用、ラベル体系、手続き確認。 |
| 開発プロセス | `20-process/development/README.md` | AI-DLC のTDD/ドキュメント駆動手順。 |
| ドキュメント集約 | `docs/README.md` | ヒューマン向けドキュメント一覧。 |
| ドキュメントルール/SOP | `00-foundation/documentation/INDEX.md` | 記述ルールと標準手順。 |

## Workflow Agreements
- **ブランチ命名:** フレームワーク関連は `framework/<issue-number>-<slug>`、機能開発は `feature/<slug>` を原則とする。
- **Issue ファースト:** すべての変更はIssueを起点とし、`status::triage`→`status::ready`→`status::in-progress`→`status::in-review`→`status::done` の遷移を意識して進める。
- **テンプレート活用:** Issue を起票する際は `.github/ISSUE_TEMPLATE/` のテンプレート（framework_task / feature_request / bug_report）を用いる。
- **PR必須:** `10-governance/framework/README.md` に記載されたレビューフローを遵守し、Draft PR でも議論を開始する。
- **PR本文:** Draft PR 作成前に `scripts/exec_plan/prepare_pr_body.sh --issue <n>` を実行し、Related Issues セクションへ `Closes #<n>` を自動挿入する（GitHub UI で作成する場合も同等の内容を必ず記入）。

## AI-DLC Execution
AI-DLC プロセスに沿って作業することが必須です。より詳しい手順は [development guide](../development/README.md) を参照しつつ、下記の要点を確認してください。

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
/docs/20-process/README.md        # プロセスガイド全体
/docs/20-process/agents/README.md # このガイド
/AGENTS.md                 # エージェント向けクイックスタート
/docs/00-foundation/documentation/README.md      # ドキュメントルール/SOP
/docs/00-foundation/documentation/INDEX.md       # ルール/SOP索引
/docs/10-governance/framework/README.md          # ガバナンス詳細
/docs/20-process/development/README.md # 開発プロセス詳細
/docs/50-tooling/claude/README.md            # Claude セットアップガイド
/scripts/setup_labels.sh   # ラベル同期スクリプト
```
> ドキュメントが更新された際は、このマップも随時アップデートしてください。`AGENTS.md` は AI 向け指示、`INDEX.md` は対応ディレクトリの索引である点を意識して運用すること。

## Command & Script Reference
- `scripts/setup_labels.sh <owner/repo>`: ラベルの同期。実行前に `GITHUB_TOKEN` または `GH_TOKEN` を設定。
- `scripts/exec_plan/bootstrap.sh --slug <slug>`: Exec Plan 着手時に紐づく Issue を自動検出/作成。`--title` を指定すると未存在時に新規作成。
- `scripts/exec_plan/prepare_pr_body.sh --issue <n>`: PR テンプレートを下書きし、Related Issues セクションに `Closes #<n>` を自動挿入する。Draft PR 作成前に実行。
- `gh auth status`: GitHub CLI の認証状態を確認。エラーがあれば再ログイン。
- `git submodule status`: 参照・コード出力リポジトリの現在のコミットを確認。
- `bash scripts/verify_submodules.sh`: サブモジュールの参照コミットがガバナンス違反になっていないか検証。
- `/constitution`, `/inception`, `/construction` などのスラッシュコマンドは Claude のチャット上で実行する。必要なコマンドが表示されない場合は `.claude/commands/<name>.md` を新規作成または更新する。テンプレート整備手順は [docs/10-governance/framework/README.md](../../10-governance/framework/README.md#スラッシュコマンドテンプレート運用) と [docs/50-tooling/claude/README.md](../../50-tooling/claude/README.md) を参照。

## Pull Request Checklist
1. Related Issues セクションに `Closes #<n>` を記載したか（`scripts/exec_plan/prepare_pr_body.sh` の出力を活用）。
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
