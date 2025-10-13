# Documentation Standard Procedures

ドキュメントを更新・維持するための標準手順（Standard Operating Procedures, SOP）をまとめる。原則やスタイルは `rules.md` を参照する。

## 1. ドキュメント更新フロー
1. Issue を起票し、`track::framework` + `artifact::documentation` を付与する（初期ステータス: `status::triage`）。
2. 合意後に `status::ready` とし、`framework/<issue-number>-<slug>` ブランチを切る。
3. 作業開始時に `status::in-progress` へ更新し、変更予定のファイルを `rg` 等で洗い出し、三点セットや関連リンクを把握する。
4. 差分を作成したらセルフレビューで誤字・表記ゆれ・リンク切れを修正する。
5. PR タイトルに `[framework]` を付け、`Closes #<n>` 形式で Issue を関連付ける。説明には変更理由・影響範囲・検証結果を記載し、レビュー依頼時に `status::in-review` へ更新する。
6. レビューコメントは対象ドキュメントへ反映し、必要に応じて TODO / フォローアップ Issue を残す。
7. マージ後、影響するドキュメントやテンプレートを連鎖更新し、完了を Issue で報告して `status::done` に切り替える。

**チェック項目**
- [ ] 影響範囲を把握し、関連ファイルのリンクや INDEX を更新した。  
- [ ] PR 説明に理由・影響範囲・検証内容を記載した。  
- [ ] レビュー指摘の反映漏れがなく、フォローアップが整理されている。  
- [ ] 自動生成ファイルや不要差分が混入していない。  

### 命名/書式（推奨）
- ブランチ: `framework/<issue-number>-<slug>`（例: `framework/16-aidlc-foundation-docs`）
- PR タイトル: `[foundation]` / `[policy]` / `[process]` / `[reference]` / `[tooling]` / `[templates]` を先頭に付与
- コミット: 目的を1行で端的に（例: `docs(policy/documentation): add link audit snippet`）

## 2. ディレクトリツリー更新手順
1. ルートで `tree -a -F -I ".git|.DS_Store"` などを用いて現状の構造を取得する（利用不可な場合は `find <path> -maxdepth <n>` 等を使用）。
2. 掲載範囲に合わせて不要行を整理し、三点セットを先頭、残りはアルファベット順になるよう整形する。
3. Markdown のコードブロックに貼り付け、README や関連文書へ反映する。
4. 同一コミットで `README.md` / `AGENTS.md` / `INDEX.md` の記述を更新し、齟齬がないか確認する。

**チェック項目**
- [ ] 実際のファイル構成とツリーが一致している。  
- [ ] 非公開情報や生成物がツリーに混ざっていない。  
- [ ] 三点セットを含む導線がすべて更新された。  
- [ ] 変更差分を Issue / PR に添付し、経緯を残した。  

**運用メモ**
- フラットなディレクトリでもツリー上で階層を示したい場合はプレースホルダー名を揃え、README でマッピングを明示する。
- `tree` コマンド利用時は `.treeignore` 等で不要ファイルを除外すると整形が容易。
- 大規模な再編では PR 説明に変更前後のツリーを掲載する。

## 5. バージョニングと周知
- 重大なルール変更（Breaking）は PR タイトルに `[breaking]` を追加し、`docs/CHANGELOG.md`（存在する場合）やリリースノートで周知する。
- ルール変更に伴いテンプレート更新が必要な場合は、`docs/60-templates/` の該当テンプレートを同一PRで更新し、利用者に告知する。

## 3. テンプレートライフサイクル
1. **Proposal**: 目的・利用局面・対象読者を Issue に記載し、`track::framework` と `artifact::documentation` を付ける。
2. **Drafting**: `docs/60-templates/` に新規ファイル（またはブランチ）を作成し、必要な README / AGENTS / INDEX を整備する。
3. **Verification**: テンプレートを最低 1 つのドキュメントで試用し、差分と使い勝手を確認する。
4. **Review & Approval**: Human Maintainer が内容・リンク・スタイル準拠を確認して承認する。
5. **Rollout**: テンプレートを利用している既存ドキュメントを更新し、導線や INDEX を同期させる。
6. **Maintenance**: 変更理由と影響範囲を PR / CHANGELOG に記録し、関係者に告知する。

**役割の要約**
- Human Maintainer: Issue 起票、影響判断、レビュー承認、最終合意の記録。
- AI Maintainer: 提案作成、初期案編集、リンク更新、チェックリスト実行。
- Repository User: テンプレートを利用し、不備や改善点をフィードバック。

**チェック項目**
- [ ] テンプレートの目的・利用シナリオが Issue で合意済み。  
- [ ] README / AGENTS / INDEX の導線が整備されている。  
- [ ] 少なくとも 1 つの実ドキュメントでテンプレート適用を検証した。  
- [ ] 影響範囲を洗い出し、利用者へ周知した。  

## 4. 定期レビュー
- 実施タイミング: 各 Bolt の終了時、主要リリース直前、大きなプロセス変更後。
- 重点確認項目:
  - 重複や陳腐化した内容がないか。
  - スタイルガイド違反や表記ゆれがないか。
  - INDEX / ツリーが最新構造を反映しているか。
  - 関連 Issue / TODO が放置されていないか。
- 結果は Issue で共有し、必要に応じて追跡タスクを作成する。サブモジュールや `.aidlc/contexts/` と整合するかも確認する。

**レビュー後のフォロー**
- 問題点は新規 Issue に切り出し、優先度を設定する。
- 修正計画を共有し、次回レビューのスケジュールを更新する。
- 重要な変更はチームへ周知し、テンプレートやルールの改訂を検討する。
