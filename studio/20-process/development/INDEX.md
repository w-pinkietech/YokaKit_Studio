# Development Process Index

AI-DLC の開発プロセスに関する資料への導線です。各ファイルは `stable/` 配下に分割され、ステップごとの詳細と補助資料を参照できます。

## フェーズ別ドキュメント（`stable/`）
- [Overview](stable/overview.md) — プロセス全体像とコア原則。
- [Step 1: Domain Design](stable/step-1-domain-design.md) — 静的/動的モデルの作成とコミット基準。
- [Step 2: Logical Design](stable/step-2-logical-design.md) — ADR 作成とレビュー観点。
- [Step 3: Test Specification](stable/step-3-test-specification.md) — テスト仕様・コード生成・コミット手順。
- [Step 4: Code Generation](stable/step-4-code-generation.md) — 実装生成、テスト実行、レビュー。
- [Step 5: Documentation Update](stable/step-5-documentation-update.md) — Code Mapping 更新とフォローアップ。

## 補助ドキュメント
- [Verification & Gates](stable/verification-and-gates.md) — 各ゲートのチェックリスト。
- [CI/CD Pipeline](stable/ci-cd-pipeline.md) — Context Studio / Code Output のパイプライン構成。
- [Quick Command Reference](stable/quick-command-reference.md) — AI 指示用のコマンドサマリ。
- [Best Practices](stable/best-practices.md) — 推奨事項とアンチパターン。
- [Appendix: Templates](stable/appendix-templates.md) — テスト仕様・コードレビュー等のテンプレート。

## 更新チェック
- [ ] 変更したファイルに対応する README / AGENTS / INDEX を同時更新したか。
- [ ] リンク切れがないかプレビューまたはテストで確認したか。
- [ ] `.aidlc/contexts/` や Policy 文書と整合しているか。
- [ ] ライフサイクル区分（`stable/`, `iterative/`, `archive/`）が最新の状態に合っているか。
