---
id: pr-18-records-hub
type: pr
status: merged
relates_to:
  issues: []
  prs: ["#18"]
  commits: []
authors: []
dates:
  created: 2025-10-13
  updated: 2025-10-13
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/18
  permalinks: []
repos: []
decisions:
  - summary: "Introduce records/ hub (PR-centric) with templates and scripts; add repository catalog; extend AIDLC SOP for cross-repo; add PR template hook"
    impacts:
      - "records/*"
      - "docs/reference/repos/*"
      - "docs/00-foundation/aidlc/standard-procedures.md"
      - ".github/pull_request_template.md"
next_actions:
  - "Adopt PR template and create records entries for subsequent PRs"
  - "Populate repository catalog with actual repos (frontend/backend etc.)"
---

## Summary
議論・決定の索引と要約を docs から分離して管理するため、PR中心の `records/` を導入。最小テンプレとスクリプトで雛形生成を自動化し、PR テンプレートに Discussion Summary チェックを追加した。複数リポ横断に備えて Change Package の型も提供。

## Key Points
- records は PR 中心（by-pr）で記録。issue/commit は例外時のみ。
- 複数リポ横断は packages（親）＋各 PR 要約（子）でひも付け。
- スクリプトで雛形作成: `scripts/records/new_pr_summary.sh`, `scripts/records/new_package.sh`。
- docs 側は権威（Rules/SOP/ADR）。records からリンクで追跡性を担保。

## Links
- PR #18 thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/18

