# Claude Code セットアップ & 運用ガイド

Claude Code (以下「Claude」) を利用して Context Studio のスラッシュコマンドやテンプレートを実行するための手順をまとめています。AIエージェント/開発者が同じ前提で作業できるよう、環境構築から実行確認までを標準化します。

---

## 1. 前提条件
- Anthropic アカウント (Claude へのアクセス権が付与されていること)
- Claude Code / Claude Desktop / Claude Web のいずれか
- Node.js 18 以上 (Claude Code CLI を使用する場合)
- 本リポジトリをローカルまたはリモートで開ける環境 (Git clone 済みを推奨)

## 2. 推奨インストール手順

### 2.1 Claude Code CLI (ターミナル用途)
```bash
npm install -g claude-code
claude login
```
- `claude login` でブラウザ認証を完了させます。
- CLI が提供する `claude code --workspace <path>` コマンドは、スラッシュコマンド実行時の補助として利用できますが、執筆時点ではチャット画面での実行が主なワークフローです。

### 2.2 Claude Desktop / Web
- [https://www.anthropic.com/claude](https://www.anthropic.com/claude) からアクセスし、チームで共有されたプロジェクトに参加します。
- Desktop アプリを利用する場合は、アプリ内で Git リポジトリを開いてから `.claude/commands/` のテンプレートを認識させます。

---

## 3. リポジトリの同期

1. リポジトリをローカルにクローンします。  
   ```bash
   git clone <repo-url>
   cd YokaKit_Studio
   ```
2. `.claude/commands/` ディレクトリに必要なコマンドテンプレートが存在することを確認し、新規コマンドを追加した場合は必ずコミット＆プッシュします。
3. Claude でリポジトリを開く（または再読み込み）ことで最新テンプレートを取り込みます。

> **Note:** テンプレート追加後にコマンドが表示されない場合は、アプリケーションを再起動するか、リポジトリを再読み込みしてください。

---

## 4. スラッシュコマンドの運用フロー

1. **テンプレート整備**  
   - `.claude/commands/<name>.md` を新規作成するか、既存テンプレートを更新します。
   - コマンドの目的、必要な引数、ファイル出力場所、ガバナンス制約などを明記してください。
2. **Claude での実行**  
   - Claude のチャット欄に `/command-name` を入力すると、テンプレート内容に従った対話が開始されます。
   - ファイル書き込みが発生する場合、テンプレート内で `apply_patch` などの安全な方法を利用します。
3. **成果物確認**  
   - 更新されたファイル（例: `.aidlc/contexts/` 配下や `.aidlc-docs/`）をレビューし、必要に応じて追加調整します。
4. **コミット & プルリクエスト**  
   - 生成された成果物は通常通り Git でコミットし、関連 Issue／PR にリンクします。

---

## 5. よくある質問 (FAQ)

### Q1. コマンドが候補に表示されません
- `.claude/commands/<name>.md` が存在し、保存されているか。
- ファイル名に大文字・スペースなどが入っていないか。
- Claude でリポジトリを再読み込みまたはアプリを再起動したか。

### Q2. CLI から直接コマンドは実行できないのですか？
- 2025年時点では、スラッシュコマンドは Claude のチャット画面での使用が前提です。CLI は補助的に利用してください。

### Q3. テンプレート更新時の注意は？
- 必ず Issue を起点に変更意図を明確化し、README・docs/10-governance/framework/README.md・docs/20-process/agents/README.md の説明と整合を取ってください。
- 大幅な挙動変更を行う場合は、テスト用コマンド (`/test`) などで動作確認してください。

---

## 6. 関連ドキュメント
- [docs/10-governance/framework/README.md](../../10-governance/framework/README.md) — スラッシュコマンドテンプレート運用セクション
- [docs/20-process/agents/README.md](../../20-process/agents/README.md) — エージェント向けのコマンドリファレンス
- [`README.md`](../../README.md) — Commands Reference セクション
- [.claude/commands/](../../../.claude/commands/) — テンプレート本体

---

## 7. トラブルシューティング Contact
問題が解決しない場合は、Issue を作成して以下を添えてください。
- 発生した現象と試した手順
- 使用している Claude クライアント種類（Web / Desktop / CLI）
- `.claude/commands/` の該当テンプレート内容
- `gh auth status` や `git status -sb` の出力（必要に応じて）

運用チームまたはプロダクトオーナーが順次対応します。
