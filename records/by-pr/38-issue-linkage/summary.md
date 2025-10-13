---
id: pr-38-issue-linkage
type: pr # 原則 pr を使用（issue/commit は例外時のみ）
status: open
relates_to:
  issues: ["#35", "#36", "#37"]
  prs: []            # 任意（関連PRがあれば）
  commits: []        # 任意（PRを通さないHotfix時など）
authors: ["@cycling777"]
dates:
  created: 2025-10-14
  updated: 2025-10-14
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/38
  permalinks: []
repos: []
decisions:
  - summary: "PR本文の Related Issues セクションをテンプレートで必須化し、自動生成スクリプトに対応させる"
    impacts:
      - ".github/pull_request_template.md"
  - summary: "Draft PR 作成時に `scripts/exec_plan/prepare_pr_body.sh` を利用し Closes 行を自動挿入する運用を採用"
    impacts:
      - "scripts/exec_plan/prepare_pr_body.sh"
  - summary: "Agents/Exec Plan/Governance ドキュメントへ Issue 連携必須手順と新コマンドを追記"
    impacts:
      - "docs/20-process/agents/README.md"
      - "docs/20-process/agents/AGENTS.md"
      - "docs/20-process/exec-plan.md"
      - "docs/10-governance/framework/README.md"
next_actions:
  - "Plan スナップショット取得後に `plans.md` をブランチから削除"
  - "環境に shellcheck が入ったら `scripts/exec_plan/prepare_pr_body.sh` を lint する"
---

## Summary
関連 Issue #35/#36/#37 をまとめて対応し、PR テンプレートと Exec Plan フロー全体で「Closes #<n>」を必須にする運用へ統一した。テンプレートには自動挿入用のマーカーを追加し、新規スクリプトで Draft PR 本文を生成できるようにした。Agents/Exec Plan/Framework ガイドも更新し、作業手順とチェックリストから Issue 連携が漏れないよう整理した。

## Key Points
- `scripts/exec_plan/prepare_pr_body.sh` で PR 本文の Related Issues を自動生成。
- PR テンプレートに `## Related Issues` セクションとチェックリストを追加。
- Agents ガイド・Exec Plan ドキュメント・Framework ガバナンスに新手順を反映。
- shellcheck が利用できないため、現状は手動レビューとサンプル実行で検証。

## Links
- PR: https://github.com/w-pinkietech/YokaKit_Studio/pull/38
- plans.md: records/by-pr/38-issue-linkage/plans.md
