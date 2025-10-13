---
id: pkg-<issue>-<slug>
type: package
status: active # active | paused | done | dropped
relates_to:
  issue: "#<n>"
  prs: []
  repos:
    - name: frontend
      pr: https://github.com/<org>/frontend/pull/<n>
    - name: backend
      pr: https://github.com/<org>/backend/pull/<n>
owners: ["@owner"]
dates:
  started: YYYY-MM-DD
  target: YYYY-MM-DD
risks:
  - desc: "..."
    mitigation: "..."
gates:
  - name: unit-tests
    required: true
  - name: integration-tests
    required: true
done_when:
  - "All PRs merged and deployed to staging"
  - "Docs/links updated; records updated"
---

## Summary
目的・背景・スコープを簡潔に。成果物とステークホルダーを記載。

## Plan
- リポ別の作業順序とマイルストン。

## Tracking
- 進捗、ブロッカー、決定事項のメモ。

