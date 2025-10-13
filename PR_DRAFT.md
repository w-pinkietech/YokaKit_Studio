## Summary
Git worktree を前提としたマルチエージェント運用を実現するために、以下を実施しました。
- `AGENTS.md` / `docs/20-process/agents/README.md` / `docs/20-process/exec-plan.md` に Worktree セクションを追加し、セットアップ〜クリーンアップ手順を明文化
- `scripts/worktree/create.sh` を追加して安全な worktree 生成を自動化
- `scripts/exec_plan/bootstrap.sh` の slug 正規化と `gh issue create` フォールバック対応で worktree 環境でも Issue 検出・作成を保証
- worktree 上で Exec Plan コマンド群が動作することを手元で検証済み

## Related Issues
<!-- 必須: 少なくとも1行の `Closes #<issue-number>` を記載。`scripts/exec_plan/prepare_pr_body.sh` が自動で更新します。 -->
<!-- autop:related-issues:start -->

- Closes #28
<!-- autop:related-issues:end -->
<!-- 追加の Issue がある場合は `- Relates to #<issue-number>` などを追記 -->

## Discussion Summary (records)
- [x] `records/by-pr/39-git-worktree/summary.md` を作成し、要約を記載した
 - [x] PR本文に上記ファイルへのリンクを追記した
 - [x] マージ前に `plans.md` を `records/by-pr/<number>-<slug>/plans.md` へスナップショット保存（`scripts/records/archive_plan.sh`）

ヒント: 作成コマンド
```
bash scripts/records/new_pr_summary.sh <pr-number> <slug> --issue <issue-number> --repo-url https://github.com/<org>/<repo> --author @<you>
```

## Checklist
- [x] Related Issues セクションに `Closes #<n>` を記載している
- [x] docs の導線（README/AGENTS/INDEX）が必要に応じて更新されている
- [x] リンク切れ・誤字・表記ゆれを確認した

## Notes
- records summary: [records/by-pr/39-git-worktree/summary.md](records/by-pr/39-git-worktree/summary.md)
