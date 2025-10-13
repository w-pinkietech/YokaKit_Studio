## Summary
この変更の目的・背景・主要な差分を簡潔に記載してください。

## Related Issues
<!-- 必須: 少なくとも1行の `Closes #<issue-number>` を記載。`scripts/exec_plan/prepare_pr_body.sh` が自動で更新します。 -->
<!-- autop:related-issues:start -->
- Closes #<issue-number>
<!-- autop:related-issues:end -->
<!-- 追加の Issue がある場合は `- Relates to #<issue-number>` などを追記 -->

## Discussion Summary (records)
- [ ] `records/by-pr/<number>-<slug>/summary.md` を作成し、要約を記載した
- [ ] PR本文に上記ファイルへのリンクを追記した
- [ ] マージ前に `plans.md` を `records/by-pr/<number>-<slug>/plans.md` へスナップショット保存（`scripts/records/archive_plan.sh`）

ヒント: 作成コマンド
```
bash scripts/records/new_pr_summary.sh <pr-number> <slug> --issue <issue-number> --repo-url https://github.com/<org>/<repo> --author @<you>
```

## Checklist
- [ ] Related Issues セクションに `Closes #<n>` を記載している
- [ ] docs の導線（README/AGENTS/INDEX）が必要に応じて更新されている
- [ ] リンク切れ・誤字・表記ゆれを確認した

## Notes
必要に応じてスクリーンショットや補足を記載してください。
