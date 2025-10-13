---
id: pr-39-git-worktree
type: pr # 原則 pr を使用（issue/commit は例外時のみ）
status: open
relates_to:
  issues: ["#28"]
  prs: []            # 任意（関連PRがあれば）
  commits: []        # 任意（PRを通さないHotfix時など）
authors: ["@cycling777"]
dates:
  created: 2025-10-14
  updated: 2025-10-14
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/39
  permalinks: []
repos: []
decisions:
  - summary: "Git worktree を標準フローに組み込むため、スクリプトとドキュメントを整備する。"
    impacts:
      - AGENTS.md
      - docs/20-process/agents/README.md
      - docs/20-process/exec-plan.md
      - scripts/worktree/create.sh
      - scripts/exec_plan/bootstrap.sh
next_actions:
  - "レビュー指摘への対応と Draft 解除の判断を進める。"
---

## Summary
AI エージェントが並列作業できるようにするため、Git worktree を公式ワークフローへ取り込みました。クイックスタート（`AGENTS.md`）と詳細ガイド（`docs/20-process/agents/README.md`, `docs/20-process/exec-plan.md`）に worktree セクションを追加し、セットアップ・日々の運用・クリーンアップの手順を明文化しています。

加えて、新しい `scripts/worktree/create.sh` で安全に worktree を生成できるようにしつつ、`scripts/exec_plan/bootstrap.sh` を正規化して slug がハイフン区切りでも Issue を特定できるよう改修しました。Worktree 環境で Exec Plan コマンドが動作することを手元で検証済みです。

マージ前には `plans.md` のスナップショットと PR チェックリストの消化を進め、records へのリンク整備を完了させます。

## Key Points
- Worktree 作成支援スクリプトを追加し、標準出力パスを `<repo>.worktrees/<branch>` に統一。
- エージェント向けドキュメントに Worktree 運用章を追加し、Exec Plan 手順と接続。
- `bootstrap.sh` の slug 正規化と JSON 依存の緩和で worktree 環境からも確実に Issue 検出。
- Worktree を用いた Exec Plan コマンド検証（生成 → 片付け）を実施済み。

## Links
- plans snapshot: records/by-pr/39-git-worktree/plans.md
- Script validation log: scripts/worktree/create.sh（doc内に手順）
