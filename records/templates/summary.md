---
id: pr-<number>-<slug>
type: pr # issue | pr | commit
status: draft # open | merged | closed | draft
relates_to:
  issues: ["#<n>"]
  prs: []
  commits: []
authors: []
dates:
  created: YYYY-MM-DD
  updated: YYYY-MM-DD
links:
  thread: https://github.com/<org>/<repo>/pull/<n>
  permalinks:
    - url: https://github.com/<org>/<repo>/pull/<n>#discussion_rXXXX
      note: main discussion
repos:
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
