# Framework Governance & Label Strategy

このドキュメントは、YokaKit Studio のフレームワーク整備期における Issue / Label 運用や自動化スクリプトをまとめたものです。AI-DLC 本体のプロセスとは独立に参照できます。

---

## ラベル体系（初期セット）

フレームワーク構築中はラベル軸を最小限にし、`<軸>::<値>` で統一します。各 Issue には最低限 `track` / `artifact` / `status` / `impact` を付与し、必要に応じて `lifecycle` を追加します。

| 軸 | 値 | 用途 |
|----|----|------|
| `track::` | `framework` / `delivery` / `operations` | 作業の大枠。現状は `track::framework` が中心。 |
| `artifact::` | `process` / `documentation` / `tooling` | 触れている成果物の種別。AI-DLC 固有の階層は後日分割。 |
| `lifecycle::` | `draft` / `in-review` / `approved` | 合意プロセスの進行状況。必要な Issue のみに付与。 |
| `status::` | `needs-decision` / `blocked` / `ready` | 次のアクションを明示。1 Issue につき 1 種類。 |
| `impact::` | `high` / `medium` / `low` | 優先度や波及範囲の指標。 |

### 運用ルール

- `track::framework` でフレームワーク整備 Issue を集約し、合意後に `track::delivery` へ展開。
- `artifact::process` はワークフローや手順、`artifact::documentation` は README などの記述、`artifact::tooling` は CLI・スクリプト整備に割り当てる。
- レビュー待ちの段階で `lifecycle::in-review`、承認されドキュメント反映が完了したら `lifecycle::approved` とする。
- `status::needs-decision` は方針決定待ち、`status::ready` は実装・反映準備完了、`status::blocked` は外的要因待ちを示す。

### ラベル組み合わせ例

```
track::framework + artifact::process + status::needs-decision + impact::high
→ Submodule 更新フローの再設計（README.md:277 を根拠に議論開始）

track::framework + artifact::documentation + status::needs-decision + impact::medium
→ スラッシュコマンド実行環境の明文化（README.md:255, 327, 451）

track::framework + artifact::documentation + status::needs-decision + impact::medium
→ テスト先行プロセス記述の統一（README.md:342-347 と 405-410 の整合性確認）
```

---

## Issue テンプレート（推奨構成）

```
## 背景 / Context
- 何が起きているか、どのドキュメント/箇所が対象か

## 課題 / Problem
- 現状の問題点・リスク

## 提案 / Proposal
- 取りうる解決策や論点

## 影響 / Impact
- 波及範囲、想定されるメリット/デメリット

## 次のアクション / Next Actions
- 決定が必要なこと、作業オーナー、期限の目安
```

---

## スラッシュコマンドテンプレート運用

スラッシュコマンド（例: `/constitution`, `/inception`）は `.claude/commands/<name>.md` に定義されたテンプレートをもとに **Claude 環境**（Claude Web / Claude Desktop / Claude Code など）で実行する。テンプレートとドキュメントの整合性を保つため、以下の運用ルールに従う。

### 想定ツールチェーン
- Claude 環境（Claude Web / Claude Desktop / Claude Code など、スラッシュコマンドに対応したクライアント）
- Anthropic アカウントと必要な API/アクセス権
- `.claude/commands/` ディレクトリのテンプレート一式

### テンプレート整備フロー
> Claude Code のインストールや同期方法は [docs/tooling/claude/README.md](../../tooling/claude/README.md) を参照。
1. コマンドの挙動を変更・追加する場合、`.claude/commands/<name>.md` を新規作成（既存があれば編集）し、目的・入出力・フローを明文化する。  
2. テンプレートを更新したら、README や関連ドキュメントのコマンド例を確認し、説明と矛盾がないかチェックする。  
3. テンプレートに追加の入力が必要な場合は、`.aidlc/contexts/` や `docs/` にある関連ドキュメントから参照できるよう導線を張る。  
4. 新規コマンドを追加した際は、このセクションと README のコマンド一覧に必ず追記する。

### 実行方法（Claude のチャットコマンド）
1. Claude（Web / Desktop / Claude Code など）で本リポジトリを開く。
2. チャット欄で以下のように入力する。
   ```
   /constitution
   /inception "Intent text"
   /construction unit-1-account-management
   ```
3. コマンド実行中にテンプレートが差し込まれ、AIとの対話が開始されるので、案内に従って回答する。

> コマンドが候補に出ない場合は、対応する `.claude/commands/<name>.md` が存在し保存されているか、ファイル名が正しいか、リポジトリを再読み込みしたかを確認すること。

### トラブルシューティング
- `/constitution` が候補に出ない → Claude クライアントでリポジトリを再読み込みするか、`.claude/commands/` が正しく同期されているか確認する。  
- テンプレート変更後に期待した挙動が得られない → `.claude/commands/<name>.md` を保存したか、キャッシュが残っていないか確認する。  
- 認証エラーが発生する → Anthropic アカウントの権限やチーム設定を確認し、Claude クライアントのログイン状態を再確認する。  

> `.claude/commands/` の更新は必ず Issue を起点に行い、README / `docs/process-guides/agents/README.md` / 本ガバナンス文書の記述を同期させること。

---

## Pull Request ワークフロー

フレームワーク関連の変更（本ドキュメント、README、AI-DLCワークフローの定義、スクリプトなど）はすべて PR を通して取り込む。以下の流れを原則とする。

1. **Issue を起票**  
   - 上記テンプレートとラベルを用いて背景・課題・提案を明文化。  
   - `status::needs-decision` で開始し、方向性合意後に `status::ready` へ更新。

2. **ブランチ命名**  
   - `framework/<issue-number>-<slug>` 形式を推奨。例: `framework/12-label-governance`.

3. **PR 作成時の要件**  
   - タイトル冒頭に `[framework]` を付け、関連 Issue を `Closes #<issue>` でリンク。  
   - 変更概要、影響範囲、検証手順（必要ならDry-runコマンド等）を記載。

4. **レビュー & 承認**  
   - 最低 1 名のレビュアー（プロダクトオーナー or テックリード）が必要。  
   - 合意済みであれば `lifecycle::in-review` → 承認後に `lifecycle::approved`。

5. **マージ条件**  
   - 必須レビューが承認済みであること。  
   - ラベル同期スクリプト等の動作確認結果をコメントで共有すること。  
   - 付随するドキュメント更新が含まれていること（README からの参照を忘れずに）。

6. **マージ後**  
   - Issue をクローズし、必要であればフォローアップのTODOを新規Issueで登録。

> 緊急対応が必要な場合でもドラフトPRを作成し、議論の場を一元化すること。

---

## サブモジュール運用チェックリスト

Context Studio で管理するサブモジュール（Code Output / References）は、必ず固定コミットハッシュで追跡し、`git submodule update --remote` による直接更新は禁止とする。

### 共通原則
- すべての更新は Issue 起点で議論し、Context Studio では追随 PR を作成する。
- コミット前に `bash scripts/verify_submodules.sh` を実行し、未初期化（`-`）や未記録コミット（`+`）がないことを確認する。
- PR 説明には「対象サブモジュール」「参照する Intent / ADR」「紐づく Code Output PR 番号（該当時）」を必ず記載する。

### Code Output（例: submodules/code-output/yokakit）
1. Code Output リポジトリでブランチを切り、PR を作成してレビューを完了させる。
2. Context Studio では専用ブランチ（例: `framework/<issue>-update-<name>`）を作成し、`git -C submodules/code-output/<name> pull --ff-only` で最新コミットを取得する。
3. `git status` で差分がサブモジュールのハッシュのみであることを確認し、`bash scripts/verify_submodules.sh` を実行する。
4. 追随 PR を作成し、Code Output 側 PR のリンクと確認済みのコミットハッシュを記載する。
5. レビューでは以下をチェックする：
   - 参照コミットが意図した Code Output PR と一致しているか。
   - `.aidlc/contexts/` の記録（Intent / ADR / code-mapping）が最新の状態と整合しているか。
   - 本リポジトリの他ファイルに差分が紛れ込んでいないか。

### References
- Bolt やリリースの節目で更新要否をレビューし、必要な場合のみ追随 PR を作成する。
- Breaking Change を取り込む際は、該当する Context の Logical Design に補足メモを追加し、Reference 更新の理由を残す。
- `git submodule update --remote` の利用は禁止。検証目的で試した場合もコミットには含めず、追随 PR によって反映する。

---

## ラベル同期スクリプト

`scripts/setup_labels.sh` はこのドキュメントで定義したラベルセットを GitHub リポジトリへ同期するためのユーティリティです。

### 必要要件

- `curl`
- `python3`
- ラベル管理が可能な GitHub Personal Access Token（`repo` 権限以上）

### 使い方

```bash
# Dry-run で適用内容を確認
GITHUB_TOKEN=ghp_xxx scripts/setup_labels.sh w-pinkietech/YokaKit_Studio --dry-run

# 実際にラベルを作成/更新
GITHUB_TOKEN=ghp_xxx scripts/setup_labels.sh w-pinkietech/YokaKit_Studio
```

> `GITHUB_TOKEN` は実行時の環境変数として渡してください。Dry-run 時は API には書き込みません。

### 実装メモ

- 既存ラベルがあれば `PATCH` で更新、なければ `POST` で新規作成。
- `--dry-run` オプションで API 呼び出しを行わずに適用内容を表示。
- カラーコードや説明文はこのファイル内の表と揃える。変更があれば本ファイルとスクリプトの双方を更新してください。

---

## 今後の拡張

- フレームワーク整備が落ち着いたら、`artifact::` 系ラベルを AI-DLC 階層（Intent / Domain Design など）へ細分化。
- Milestone や Project Boards での運用ルールが固まった段階で、別途 `Project Governance` セクションを追加予定。
- スクリプトの Node.js / Python 版 CLI などが必要になった場合は `scripts/` 以下でモジュール化し、本ドキュメントから参照する。
- ドキュメントは `docs/` ディレクトリに集約し、ヒューマン向け・AI向けガイド（`docs/README.md`, `docs/process-guides/agents/README.md`）を随時更新する。
