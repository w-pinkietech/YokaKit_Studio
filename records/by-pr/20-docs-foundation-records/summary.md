id: pr-20-docs-foundation-records
type: pr # 原則 pr を使用（issue/commit は例外時のみ）
status: open
relates_to:
  issues: ["#19"]
  prs: []            # 任意（関連PRがあれば）
  commits: []        # 任意（PRを通さないHotfix時など）
authors: ["@cycling777"]
dates:
  created: 2025-10-14
  updated: 2025-10-14
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/20
  permalinks:
    - url: https://github.com/<org>/<repo>/pull/<n>#discussion_rXXXX
      note: main discussion
repos: # 複数リポ横断時のみ記載
  - name: frontend
    url: https://github.com/<org>/frontend
    branch: feature/<slug>
    pr: https://github.com/<org>/frontend/pull/<n>
    commits: []
  - name: backend
    url: https://github.com/<org>/backend
    branch: feature/<slug>
    pr: https://github.com/<org>/backend/pull/<n>
    commits: []
decisions:
  - summary: "..."
    impacts: [docs path or module]
next_actions:
  - "..."
---

## Summary
背景 → 議題 → 論点 → 合意 → フォローアップを1〜3段落で要約。

## Key Points
- 主要な論点/合意/未決事項を箇条書きで。

## Links
- 本文の一次情報（Permalink）を列挙。

## Summary
docs 整備（Foundation フォローアップ）と records 運用開始のためのPR。
- AGENTSの簡素化、reposカタログの任意化、AIDLC SOPの更新、旧ファイル削除。

## Key Points
- カタログは恒常更新せず、毎回PR要約に対象リポを列挙
- records/by-pr のPR単位運用を開始

## Links
- PR 本文参照（以後、主要スレッドのPermalinkを追記）

- Exec Plan（plans.md）運用とrecords連携のガイドを追加
