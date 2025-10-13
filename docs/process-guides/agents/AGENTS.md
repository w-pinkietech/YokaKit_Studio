# Agents Operations Checklist

## 目的
- エージェントが作業を始める前に必要な情報源とガイドを素早く確認できるようにする。
- `docs/process-guides/agents/README.md` の要点を抜粋し、タスク遂行時のチェックリストとして利用する。

## 事前確認
- [ ] 対応する Issue に `track::`, `artifact::`, `status::`, `impact::` ラベルが付与されているか。
- [ ] 作業ブランチが `framework/<issue-number>-<slug>` 等の命名規則に従っているか。
- [ ] `.aidlc/contexts/<id>/` で関連する Intent / Domain Design / ADR を確認したか。
- [ ] `gh auth status` を実行し、GitHub CLI の認証が有効か確認したか。
- [ ] `scripts/setup_labels.sh --dry-run` を実行してラベル差異を把握したか。

## 実行時チェック
- [ ] 作業対象ドキュメントの参照先（Policy / Process Guides）を最新化したか。
- [ ] 必要なテスト・検証ステップを `docs/process-guides/development/README.md` で確認したか。
- [ ] 変更後に `code-mapping.md` と関連ドキュメントの同期が必要か判断したか。
- [ ] PR で `Closes #<issue>` を記載し、検証手順結果を共有したか。

## リンク集
- [Process Guide (Full)](README.md)
- [Development Process](../development/README.md)
- [Policy Framework](../../policy/framework/README.md)
