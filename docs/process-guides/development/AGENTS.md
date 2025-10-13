# Development Process Checklist

## 目的
- AI-DLC のドキュメント駆動・TDD プロセスを実行する際に、エージェントが確認すべきポイントを即座に参照できるようにする。
- ボルトごとの作業前に必要なドキュメントを読み込み、手順の抜け漏れを防止する。

## 作業前チェック
- [ ] `.aidlc/contexts/<id>/construction/domain-design/` の `static-model.md` / `dynamic-model.md` を確認したか。
- [ ] 最新 ADR（`.aidlc/contexts/<id>/construction/logical-design/adr/`）を読み、実装方針に矛盾がないか。
- [ ] テスト仕様が網羅されているか、`stable/step-3-test-specification.md` を確認したか。
- [ ] 実装前にテストを FAIL 状態でコミットする計画を立てたか。
- [ ] `policy/framework/README.md` で定義されたブランチ/PR ルールに沿っているか。

## 実装時チェック
1. テストケースを追加し、`FAIL` を確認したか（参照: `stable/step-3-test-specification.md`）。
2. 実装を生成後、全テストが `PASS` になるまで反復したか（参照: `stable/step-4-code-generation.md`）。
3. カバレッジ 100% を満たしているか。
4. ドキュメント (`code-mapping.md`, ADR など) の更新が必要か見直したか（参照: `stable/step-5-documentation-update.md`）。

## 参照リンク
- [Process Overview](stable/overview.md)
- [Step-by-Step Guides](stable/step-1-domain-design.md)
- [Process Index](INDEX.md)
- [Policy Framework](../../policy/framework/README.md)
- [Documentation Rules / SOP](../../00-foundation/documentation/README.md)
