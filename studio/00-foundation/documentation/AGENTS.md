# Documentation Governance for Agents

AI エージェントがドキュメントを作成・更新する際に守るべきポイントをまとめる。`AGENTS.md` は行動指針、`INDEX.md` は本ディレクトリの索引として機能するため、両方を併せて参照すること。

## クイックチェックリスト
- 対応する Issue とブランチが存在し、ドキュメント変更の理由が明確か確認する。
- 新規ドキュメントを追加する前に、人間向け README / AI 向け AGENTS / INDEX の導線が整っているかを確認する。
- 記述内容が既存ドキュメントと重複しないか確認し、必要に応じて参照リンクへ置き換える。
- 文体・書式ルールは `style/INDEX.md` から該当セクションを確認し、逸脱する場合は理由を明記する。
- 変更後は関連インデックス（例: `studio/README.md`, ルート `README.md`）の更新が必要かチェックする。

## 実務コマンド（抜粋）
- 相対リンクのざっくり点検（外部除外）:
  - `rg -n "\[[^\]]+\]\((?!https?://)[^)]+\)" docs`
- 三点セットの欠落検出（README/AGENTS/INDEX の存在確認・目視補助）:
  - `fd -td docs | while read d; do ls "$d" | rg -q "^(README\.md|AGENTS\.md|INDEX\.md)$" || echo "MISSING: $d"; done`
- ドキュメントツリー作成（除外例付き）:
  - `tree -a -F -I ".git|.DS_Store|node_modules|dist" docs`
- TODO/未整理の検出:
  - `rg -n "TODO|FIXME|TBD" docs`

## 推奨手順
1. `INDEX.md` から対象ドキュメント（`rules.md` / `standard-procedures.md`）を開き、最新ルールを確認する。
2. 編集対象ファイルに対する既存リンクや参照元を検索し、影響範囲を把握する。
3. 変更内容を最小限に保ち、説明が冗長にならないようにする。
4. レビューコメントやフォローアップ事項は Issue に記録し、必要なら TODO を残す。

## 参考ドキュメント
- ルール統合リファレンス: `rules.md`
- 標準手順作業書: `standard-procedures.md`
- ルート AI インデックス: `../../AGENTS.md`
- ドキュメントハブ: `../README.md`

## PR 運用メモ
- ブランチ命名: `framework/<issue-number>-<slug>`（例: `framework/16-aidlc-foundation-docs`）
- PR タイトル: `[foundation]` / `[policy]` / `[process]` など対象レイヤの接頭辞を推奨。
- PR 説明: 変更理由／影響範囲／検証結果（リンク検査、ツリー更新）を必ず記載。
- 新しい補助資料を追加した場合は、この一覧に追記すること。
