## AIDLC for Agents

### クイックチェック
- 対応 Issue / ブランチの確認（`framework/<issue-number>-<slug>`）
- 参照順序: `rules.md` → `standard-procedures.md`
- 変更後はリンク検査・索引更新を実施

### よく使うコマンド
- 相対リンク検査: `rg -n "\[[^\]]+\]\((?!https?://)[^)]+\)" docs`
- TODO 検出: `rg -n "TODO|FIXME|TBD" docs`

### 導線
- ルール: `rules.md`
- SOP: `standard-procedures.md`
- Foundation: `../README.md`
