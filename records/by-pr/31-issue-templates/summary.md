---
id: pr-31-issue-templates
type: pr # 原則 pr を使用（issue/commit は例外時のみ）
status: open
relates_to:
  issues: ["#29"]
  prs: []            # 任意（関連PRがあれば）
  commits: []        # 任意（PRを通さないHotfix時など）
authors: ["@codex-agent"]
dates:
  created: 2025-01-13
  updated: 2025-01-13
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/31
  permalinks:
    - .github/ISSUE_TEMPLATE/framework_task.md
    - .github/ISSUE_TEMPLATE/feature_request.md
    - .github/ISSUE_TEMPLATE/bug_report.md
    - docs/10-governance/framework/README.md
    - docs/20-process/agents/AGENTS.md
    - docs/20-process/agents/README.md
repos: []
decisions:
  - summary: "Issue 起票を標準化するため、framework / feature / bug のテンプレートを追加し、関連ドキュメントへ導線を整備する。"
    impacts: [.github/ISSUE_TEMPLATE/framework_task.md, .github/ISSUE_TEMPLATE/feature_request.md, .github/ISSUE_TEMPLATE/bug_report.md, docs/10-governance/framework/README.md, docs/20-process/agents/AGENTS.md, docs/20-process/agents/README.md]
next_actions: []
---

## Summary
framework / feature / bug の 3 種類の Issue テンプレートを追加し、背景・課題・提案・影響・受け入れ基準・次のアクションを共通化した。  
ガバナンス文書とエージェント向けチェックリストを更新し、テンプレート利用をルール化。  
`gh issue create` を用いたスモークテスト（#30）でテンプレートのレイアウトを確認済み。

## Key Points
- `.github/ISSUE_TEMPLATE/` に framework_task / feature_request / bug_report を追加。
- `docs/10-governance/framework/README.md` にテンプレートの参照方法と受け入れ基準を追記。
- `docs/20-process/agents/AGENTS.md` / `docs/20-process/agents/README.md` にテンプレート利用チェックを追加。
- Issue #30 を使ってスモークテストを実施し、その場でクローズ。

## Links
- Plan Snapshot: records/by-pr/31-issue-templates/plans.md
- Smoke Test: https://github.com/w-pinkietech/YokaKit_Studio/issues/30
