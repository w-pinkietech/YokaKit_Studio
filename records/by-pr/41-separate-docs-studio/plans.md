# Exec Plan Snapshot (2025-10-23 17:32:00)

> branch: framework/40-separate-docs-studio  commit: fdce090

---
# Exec Plan: Separate product docs from framework docs (docs/ → studio/)

## 目的 / ゴール
- 現在の `docs/` ディレクトリを `studio/` にリネームし、Context Studio フレームワークのドキュメントとして明確化する
- 新しい `docs/` ディレクトリを YokaKit プロダクト用に作成する
- 全てのリンク・スクリプト・参照を正しく更新し、リンク切れをゼロにする

## 範囲 / 非範囲
### 対象
- `docs/` → `studio/` へのディレクトリリネーム
- 全ドキュメント内のリンク更新（53ファイル）
- スクリプト内のパス参照更新（7スクリプト）
- ルート階層のREADME/AGENTS/INDEX更新
- .claude/commands内の参照更新

### 非範囲
- `.aidlc/contexts/` 内のドキュメント（今回は対象外）
- 新しい `docs/` の詳細なコンテンツ作成（基本構造のみ）

## 参照 / コンテキスト
- Issue: #40
- 関連Issue: #10（ドキュメントディレクトリ構成の基準策定）
- PR: （後で記載）
- Records: `records/by-pr/<pr>-separate-docs-studio/summary.md`

## 全体像
現在の `docs/` は Context Studio フレームワーク自体の開発ドキュメント（00-foundation, 10-governance, 20-process など）で構成されている。しかし、YokaKit プロダクトのユーザー向けドキュメントを配置する場所がなく、責任範囲が不明確になっている。

この作業では、フレームワークドキュメントを `studio/` に移動し、プロダクトドキュメント用に `docs/` を再定義する。これにより、ドキュメントの責任範囲が明確になり、メンテナンス性が向上する。

## 進捗状況（Checklist）
- [x] Issue 作成 (#40)
- [x] Worktree セットアップ
- [x] スパイク / 調査（影響範囲の特定）
- [x] 実装（コア）
  - [x] `docs/` → `studio/` リネーム
  - [x] ドキュメント内リンク更新
  - [x] スクリプト内パス更新
  - [x] ルートファイル更新
  - [ ] 新しい `docs/` 構造作成
- [ ] テスト追加 / 検証（リンク切れチェック）
- [ ] ドキュメント更新 / リンク確認
- [ ] Plan スナップショット保存（`archive_plan.sh` 実行）

## 実行計画（Plan）

### Phase 1: 影響範囲の詳細調査
1. `docs/` への参照を持つ全ファイルをリストアップ（完了: 53ファイル）
2. スクリプト内の `docs/` 参照を確認（完了: 7スクリプト）
3. 相対パス vs 絶対パスの使用状況を確認

### Phase 2: ディレクトリリネームとリンク更新
1. `git mv docs studio` を実行
2. ドキュメント内の全リンクを `docs/` → `studio/` に更新
   - `README.md`
   - `AGENTS.md`
   - `INDEX.md`
   - `studio/` 配下の全ドキュメント
   - `records/` 内の履歴ドキュメント
3. スクリプト内のパス参照を更新
   - `scripts/exec_plan/bootstrap.sh`
   - `scripts/exec_plan/prepare_pr_body.sh`
   - `scripts/records/*.sh`
4. `.claude/commands/` 内の参照を更新

### Phase 3: 新しい docs/ 構造の作成
1. 新しい `docs/` ディレクトリを作成
2. 基本的な構造を定義
   ```
   docs/
   ├── README.md        # YokaKit プロダクトドキュメントのエントリーポイント
   ├── INDEX.md         # 索引
   └── .gitkeep         # または初期コンテンツ
   ```
3. README.md に説明を追加（このディレクトリの目的と studio/ との違い）

### Phase 4: 検証
1. 全てのリンクが正しく動作することを確認
2. スクリプトが正常に動作することを確認
3. リンク切れがないことを grep/手動で確認

## 決定ログ（Decision Log）

### 2025-10-23: ディレクトリ名を `studio/` に決定
- **検討案**:
  - `framework/`: 汎用的すぎる
  - `studio/`: プロジェクト名 "YokaKit Studio" と一致し、Context Studio の意味も含む
  - `.studio/`: ドットファイルは一般的に設定ファイル用
- **採用**: `studio/`
- **理由**: プロジェクト固有の名前で、Context Studio フレームワークであることが明確

### 2025-10-23: Worktree 環境での作業を採用
- **理由**: PR #39 で実装した worktree 機能を実際に使用し、動作確認も兼ねる
- **メリット**: メインブランチをクリーンに保ちつつ、大規模な変更を安全に実施できる

## 発見と驚き（Findings）

### 影響範囲の調査結果
- `docs/` への参照: **53ファイル**
  - ドキュメント内のリンク: 約50箇所
  - スクリプト: 7ファイル
  - .claude/commands: 2ファイル
  - records/: 複数の履歴ファイル

- 主な影響を受けるスクリプト:
  1. `scripts/exec_plan/bootstrap.sh`
  2. `scripts/exec_plan/prepare_pr_body.sh`
  3. `scripts/records/new_pr_summary.sh`
  4. `scripts/records/archive_plan.sh`
  5. `scripts/records/new_package.sh`
  6. `scripts/setup_labels.sh`
  7. `scripts/verify_submodules.sh`

## リスク / 代替案

### リスク
1. **リンク切れの見落とし**
   - 回避策: grep で徹底的に検索し、手動でも主要リンクを確認
2. **スクリプトの動作不良**
   - 回避策: 各スクリプトを個別にテスト実行
3. **records/ 内の履歴ドキュメントの整合性**
   - 回避策: 履歴ドキュメントは過去のスナップショットなので、リンク更新は慎重に判断

### 代替案
- **案1**: `docs/` をそのままにして `product/` を作る
  - 却下理由: 一般的に `docs/` はプロダクトドキュメント用として認識されるため
- **案2**: シンボリックリンクで対応
  - 却下理由: 根本的な解決にならず、混乱を招く

## To-Do
1. [x] Issue 作成
2. [x] Worktree セットアップ
3. [x] plans.md 作成と調査
4. [x] `git mv docs studio` 実行
5. [x] ドキュメント内リンク一括更新
6. [x] スクリプト内パス更新
7. [ ] 新しい `docs/` 構造作成
8. [ ] 全リンクの動作確認
9. [ ] records に plans.md を保存（`bash scripts/records/archive_plan.sh <pr-number> separate-docs-studio`）
10. [ ] records/by-pr/<pr>-separate-docs-studio/summary.md に作業内容を記述
11. [ ] records への保存後、ブランチ上の `plans.md` を削除

## 次アクション
- [x] ドキュメント内の `docs/` 参照パターンを詳細分析
- [ ] リネーム実行と一括置換スクリプトの検討
- [ ] 段階的なコミットで進捗を記録

---
メモ
- 本ファイルは作業ブランチ（短命文書）。`archive_plan.sh` で保存した後はブランチから削除し、PR（records/by-pr）から参照可能にする。
