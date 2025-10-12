# Documentation Governance: 更新フロー

ドキュメント変更時の標準プロセスを定義する。Issue と PR を通じた管理を徹底する。

## 手順
1. Issue を起票し、`track::framework` + `artifact::documentation` を付与する（初期ステータスは `status::needs-decision`）。
2. 合意後に `status::ready` へ更新し、`framework/<issue-number>-<slug>` ブランチで作業する。
3. 変更差分を確認し、以下をチェックする:
   - 自動生成ファイルが含まれていないか。
   - README / AGENTS / INDEX の導線が途切れていないか。
   - スタイルガイドへ反映が必要か。
4. PR では `[framework]` プレフィックスを付け、関連 Issue を `Closes #<n>` でリンクする。
5. レビューコメントは Issue にフィードバックし、フォローアップがあれば TODO として記録する。

## 補足
- 本手順は Issue #8 をベースに整備された。運用に変更が生じた際はガイドラインを更新する。
- PR マージ後に他ディレクトリへ影響がある場合、必要な連鎖更新を追跡する。
