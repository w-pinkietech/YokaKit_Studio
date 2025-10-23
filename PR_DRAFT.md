## Summary
プロダクトドキュメントとフレームワークドキュメントを明確に分離するため、以下の構造変更を実施しました：

- 現在の `docs/` を `studio/` にリネーム（Context Studioフレームワーク開発用ドキュメント）
- 新しい `docs/` ディレクトリをYokaKitプロダクト用に作成
- 全てのリンク・スクリプト・参照を `docs/` → `studio/` に更新（80ファイル変更）

この変更により、ドキュメントの責任範囲が明確になり、YokaKitプロダクトのユーザー向けドキュメントを適切に配置できるようになります。

## Related Issues
<!-- 必須: 少なくとも1行の `Closes #<issue-number>` を記載。`scripts/exec_plan/prepare_pr_body.sh` が自動で更新します。 -->
<!-- autop:related-issues:start -->

- Closes #40
<!-- autop:related-issues:end -->
<!-- 追加の Issue がある場合は `- Relates to #<issue-number>` などを追記 -->

## Discussion Summary (records)
- [x] `records/by-pr/41-separate-docs-studio/summary.md` を作成し、要約を記載した
- [x] PR本文に上記ファイルへのリンクを追記した
- [ ] マージ前に `plans.md` を `records/by-pr/41-separate-docs-studio/plans.md` へスナップショット保存（`scripts/records/archive_plan.sh`）

Records summary: [records/by-pr/41-separate-docs-studio/summary.md](records/by-pr/41-separate-docs-studio/summary.md)

## Checklist
- [x] Related Issues セクションに `Closes #40` を記載している
- [x] studio/ の導線（README/AGENTS/INDEX）が更新されている
- [x] 全てのスクリプト内パス参照を更新済み
- [x] リンク切れがないことを確認済み
- [ ] records に plans.md を保存（マージ前に実施）

## Notes
### 変更内容の詳細
- **リネーム**: `docs/` → `studio/`（58ファイル）
- **リンク更新**: マークダウンファイル、スクリプト、.claude/commands、records内の履歴ドキュメント
- **新規作成**: `docs/README.md`（YokaKitプロダクトドキュメントのエントリーポイント）
- **パス修正**: 古いパス参照（`studio/tooling/` → `studio/50-tooling/` など）を正しいレイヤー構造に修正

### 検証済み項目
- スクリプトが正常に動作すること（`scripts/exec_plan/bootstrap.sh --help` で確認）
- テンプレートが正しいパスを参照していること（`studio/60-templates/exec-plan.md`）
- リンク切れがないこと（grep で確認）
