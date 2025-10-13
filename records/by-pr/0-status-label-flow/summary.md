---
id: pr-0-status-label-flow
type: pr # 原則 pr を使用（issue/commit は例外時のみ）
status: open
relates_to:
  issues: ["#0"]
  prs: []            # 任意（関連PRがあれば）
  commits: []        # 任意（PRを通さないHotfix時など）
authors: ["@codex-agent"]
dates:
  created: 2025-01-13
  updated: 2025-01-13
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/0
  permalinks:
    - docs/10-governance/framework/README.md
    - docs/20-process/agents/README.md
    - docs/00-foundation/documentation/standard-procedures.md
    - scripts/setup_labels.sh
repos: []
decisions:
  - summary: "`status::` ラベルを triage→ready→in-progress→in-review→done（+ blocked）に再編し、対応する運用ルールとスクリプトを更新する。"
    impacts: [docs/10-governance/framework/README.md, docs/20-process/agents/README.md, docs/00-foundation/documentation/standard-procedures.md, scripts/setup_labels.sh]
next_actions:
  - "GitHub 上で Draft PR #0 を作成し、記載内容と records の情報を同期する。"
  - "実リポジトリの Issue へ新ステータスラベルを適用し、進行中タスクのラベルを整理する。"
---

## Summary
現行の `status::` ラベルが `needs-decision` / `blocked` / `ready` の3種のみで担当状況が不透明だったため、準備から完了までを追跡できる最小限の5段階（`triage`→`ready`→`in-progress`→`in-review`→`done`）へ再編した。  
フレームワークガバナンス文書、エージェントガイド、ドキュメントSOPを新ラベルに合わせて更新し、自動同期スクリプトの定義も刷新してDry-runで挙動を確認した。  
Exec Plan と Draft PR 素案を records 配下に保存し、残課題（実PR作成・ラベル本適用）を追跡できる状態にした。

## Key Points
- `status::` ラベルを 5 段階 + `blocked` へ簡素化し、重複担当を防ぐ運用を定義。
- `docs/10-governance/framework/README.md` ほか関連ドキュメントを同一コミットで更新。
- `scripts/setup_labels.sh` を更新し Dry-run テストで新セットを検証。
- `plans.md` と `PR_DRAFT.md` を基に Draft PR / 記録テンプレートを整備。

## Links
- Plan Snapshot: records/by-pr/0-status-label-flow/plans.md
- Draft PR: PR_DRAFT.md
