---
id: pr-41-separate-docs-studio
type: pr # 原則 pr を使用（issue/commit は例外時のみ）
status: open
relates_to:
  issues: ["#40"]
  prs: []            # 任意（関連PRがあれば）
  commits: []        # 任意（PRを通さないHotfix時など）
authors: ["@wataken"]
dates:
  created: 2025-10-23
  updated: 2025-10-23
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/41
  permalinks: []
repos: []
decisions:
  - summary: "docs/ をプロダクトドキュメント用に、studio/ をフレームワークドキュメント用に分離"
    impacts: [全ドキュメント, スクリプト, テンプレート]
  - summary: "一括置換で docs/ → studio/ へ全参照を更新"
    impacts: [README.md, AGENTS.md, INDEX.md, scripts/*, .claude/commands/*, records/*]
next_actions:
  - "マージ前に plans.md をアーカイブ（archive_plan.sh）"
  - "マージ後、Issue #40 をクローズ"
  - "YokaKit プロダクトドキュメントの内容を順次追加"
---

## Summary
現在の `docs/` が Context Studio フレームワーク開発用ドキュメントで占有されており、YokaKit プロダクトのユーザー向けドキュメントを配置する場所がない問題を解決しました。

`docs/` を `studio/` にリネームし、フレームワーク開発用ドキュメントとして明確化。新しい `docs/` をYokaKitプロダクト用に作成し、責任範囲を分離しました。全てのリンク・スクリプト・参照を一括で更新し（80ファイル変更）、リンク切れなく動作することを確認済みです。

この変更により、ドキュメントの責任範囲が明確になり、プロダクトドキュメントとフレームワークドキュメントを独立して管理できるようになりました。

## Key Points
- **ディレクトリ構造変更**: `docs/` → `studio/`（Context Studioフレームワーク用）、新規 `docs/`（YokaKitプロダクト用）
- **全参照更新**: 80ファイル変更（マークダウン、スクリプト、.claude/commands、records）
- **リンク検証**: grep および手動確認でリンク切れゼロを確認
- **スクリプト動作確認**: bootstrap.sh などが正常動作することを確認
- **worktree運用**: PR #39 で実装した worktree 機能を実際に使用して動作検証

## Links
- Issue: https://github.com/w-pinkietech/YokaKit_Studio/issues/40
- PR: https://github.com/w-pinkietech/YokaKit_Studio/pull/41
- Plans: `records/by-pr/41-separate-docs-studio/plans.md`（マージ前に保存予定）

- Plan Snapshot: plans.md
