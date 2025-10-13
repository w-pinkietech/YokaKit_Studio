# Claude Toolkit Checklist

## 目的
- Claude 関連のセットアップやスラッシュコマンド運用を行う際に、エージェントが確認すべき事項をまとめる。

## セットアップ前チェック
- [ ] `Claude Code` や対応クライアントがインストールされているか。
- [ ] `.claude/commands/` に必要なテンプレートが揃っているか。
- [ ] `gh auth status` で GitHub CLI の認証が有効か確認したか。
- [ ] `GITHUB_TOKEN` や `GH_TOKEN` が必要に応じて設定されているか。
- [ ] `docs/policy/framework/README.md` のスラッシュコマンド運用ルールを確認したか。

## テンプレート更新時チェック
- [ ] 変更意図を Issue で共有したか。
- [ ] README / Policy / Agents ガイドとの記述整合性を確認したか。
- [ ] テンプレート更新後に `/test` などで動作検証を実施したか。
- [ ] 必要に応じて `docs/process-guides/agents/README.md` を更新したか。

## リンク集
- [Claude Guide](README.md)
- [Tooling Hub](../README.md)
- [Policy Framework](../../policy/framework/README.md)
- [Agents Guide](../../process-guides/agents/README.md)
