---
id: pr-20-docs-foundation-records
type: pr
status: merged
relates_to:
  issues: ["#19"]
  prs: []
  commits: []
authors: ["@cycling777"]
dates:
  created: 2025-10-14
  updated: 2025-10-14
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/20
  permalinks: []
repos: []
decisions:
  - summary: "AGENTS.md に Start Here（Exec Plan 実行手順）を追加し最短導線を一本化"
    impacts: ["AGENTS.md"]
  - summary: "Exec Plan のスナップショットを records/by-pr に保存する運用を追加"
    impacts: ["scripts/records/archive_plan.sh", ".github/pull_request_template.md", "records/README.md"]
  - summary: "リポジトリカタログは任意・都度確認に縮小"
    impacts: ["studio/reference/repos/README.md", "studio/reference/repos/INDEX.md"]
  - summary: "旧 documentation-governance の不要ファイルを削除"
    impacts: ["studio/documentation-governance/directory-structure.md"]
next_actions:
  - "次回以降のPRで Permalink を追記（主要レビュー/議論）"
  - "クロスリポ作業時は records の repos に対象を列挙"
---

## Summary
docs 整備（Foundation フォローアップ）と records 運用開始のためのPR。
- AGENTSの簡素化、reposカタログの任意化、AIDLC SOPの更新、旧ファイル削除。

## Key Points
- カタログは恒常更新せず、毎回PR要約に対象リポを列挙
- records/by-pr のPR単位運用を開始

## Links
- PR スレッド: https://github.com/w-pinkietech/YokaKit_Studio/pull/20
- （レビュー後に主要スレッドの Permalink を追記）

- Exec Plan（plans.md）運用とrecords連携のガイドを追加
