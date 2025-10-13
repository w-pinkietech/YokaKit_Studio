# Exec Plan ガイド（Process レイヤー）

Exec Plan は、複雑な作業を「計画→実装→検証→記録」で進めるための軽量な運用フレームです。本ガイドはレイヤーモデルに基づく配置・役割を明確化し、テンプレート/スクリプト/records との連携を一箇所に集約します。

## レイヤー対応
- Process（本書）: 手順・ワークフロー・実施基準
- Templates: `docs/60-templates/exec-plan.md`（雛形）
- Foundation: `docs/00-foundation/documentation/`（記述ルール/SOPの原則）
- Records: `records/by-pr/<pr>-<slug>/`（PR単位の履歴保存先）

## いつ使うか（適用基準）
- ステップが複数に分かれ、1時間以上の作業が見込まれる場合
- 複数リポジトリ（Cross-Repo）やレビュー論点が多い場合
- 設計判断（採用/却下）を記録して後方参照したい場合

## 手順（標準フロー）
0) Issue の確認 / 自動作成
```
ISSUE_LINE=$(scripts/exec_plan/bootstrap.sh --slug <slug> --filter-label track::framework \
  --title "[framework] <title>" --labels "track::framework,artifact::<type>,status::triage" \
  --repo <owner/repo>)
```
- 既存ブランチ名から Issue 番号を逆引きし、未登録の場合は GitHub を検索して紐づく Issue を特定します。
- `--title` を指定すると Issue が見つからない場合に自動で作成されます（Dry-run したい場合は `--dry-run` を付与）。
- 出力される `ISSUE=<number>` を Exec Plan とブランチ命名に反映してください。

1) 雛形の設置（作業ブランチ直下）
```
cp docs/60-templates/exec-plan.md plans.md
```
2) プラン初稿の作成・合意（レビュー）
- Spike/調査の結果や実行計画、リスク、決定ログを `plans.md` に記述し、必要に応じて人間レビューで合意を取る。

3) Issue/PR（Draft）を作成し、records の PR 要約を生成（推奨: プラン合意後）
```
bash scripts/records/new_pr_summary.sh <pr> <slug> --issue <n> \
  --repo-url https://github.com/<org>/<repo> --author @<you>
```
```
# Related Issues セクションを自動で埋めた PR 本文を生成
scripts/exec_plan/prepare_pr_body.sh --issue <n> --output PR_DRAFT.md
# Draft のまま PR を開く場合の例（ready の場合は --draft を外す）
gh pr create --draft --body-file PR_DRAFT.md --title "[framework] <title>"
```
> `--issue` は複数回指定でき、`--issues 12,34` のようにまとめて渡すことも可能です。生成された `PR_DRAFT.md` はそのまま編集してから `gh pr create` に渡せます。

4) 実装しながら `plans.md` を随時更新（進捗/決定ログ/リスク）
5) マージ前に `plans.md` をスナップショットとして保存
```
bash scripts/records/archive_plan.sh <pr> <slug>
```
→ `records/by-pr/<pr>-<slug>/plans.md` が作成され、`summary.md` にリンクが追記されます。
- スナップショット取得後はブランチ上の `plans.md` を削除し、最終差分から除外します。

### Worktree 環境での Exec Plan
- 複数エージェントが同時に作業する場合は、事前に `scripts/worktree/create.sh framework/<issue-number>-<slug>` で専用 worktree を作成し、**作業は常に worktree 内で実施**します。
- 親リポジトリ（最初にクローンしたディレクトリ）は `main` でクリーンな状態に保ち、worktree 作成の起点としてのみ利用してください。
- `scripts/exec_plan/bootstrap.sh` や `bash scripts/records/...` などのコマンドは worktree 内でも同様に利用できます。`--slug` はブランチ名由来のハイフン区切りで指定すれば、内部でタイトルマッチングに合わせて正規化されます。
- 作業完了後は `git worktree remove <path>` → `git worktree prune` で片付け、不要なディレクトリを残さないようにします。
- 詳細な worktree 運用ルールは [docs/20-process/agents/README.md](agents/README.md#multi-agent-worktrees) を参照してください。

補足（Deferred GitHub Ops）
- 小さな作業や即時性が高い場合は、従来どおり最初に Draft PR を作成しても良いが、基本は「プラン初稿→合意→Issue/PR 生成」を推奨する。

### bootstrap.sh の詳細
- 既存 Issue が複数検出された場合は一覧を表示して処理を停止します。タイトルやラベルを調整したうえで再実行してください。
- Branch 名が `framework/<issue-number>-<slug>` 形式であれば Issue 番号を自動認識します。
- `--labels` はカンマ区切りで指定します（例: `"track::framework,artifact::documentation,status::triage,lifecycle::draft"`）。
- Issue を新規作成した場合は、出力された番号を `plans.md` の「参照」欄とブランチ名に反映して整合を取ります。

## plans.md の構成（必須要素）
- 目的/ゴール（Doneの定義）
- 範囲/非範囲・前提
- 参照（Issue, ADR, 関連Docs）
- 全体像（背景/期待する振る舞い）
- 進捗チェックリスト（Spike/実装/テスト/Docs）
- 実行計画（Planの段階的タスク）
- 決定ログ（採用/却下と理由）
- 発見と驚き（Findings）
- リスク/代替案
- To-Do と 次アクション

雛形は `docs/60-templates/exec-plan.md` を使用してください。

## Cross-Repo の注意点
- PR要約（records）に対象リポジトリ/ブランチ/依存順序を列挙
- マージ順序やゲート（CI/レビュー承認）を `plans.md` に明記
- 変更対象が多い場合は親Issueで「パッケージ」を定義し、子PRを紐付け

## 役割分担（レイヤー再確認）
- ルール/原則は Foundation に集約（普遍的な書き方/命名/SOP原則）
- 実務の運び方は Process（本書）に集約
- 雛形そのものは Templates に配置
- 実行結果の保存・紐付けは Records（by-pr）で管理

## よくある質問
- Q: `plans.md` はどこに置く？
  - A: 作業ブランチ直下（短命文書）。マージ後は records/by-pr から参照。
- Q: 既存PRにもテンプレは適用できる？
  - A: 可能。`plans.md` を追加して以降の進捗を記録し、マージ前にスナップショットします。
