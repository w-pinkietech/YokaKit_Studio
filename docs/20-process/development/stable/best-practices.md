# Best Practices

### ✅ DO

1. **Documentation-First**
   - Domain Design → Tests → Code の順序厳守
   - ADRで技術判断を明記

2. **TDD Strict**
   - テストコードを先にコミット
   - すべてのテストがパスするまで実装をマージしない
   - カバレッジ100%必須

3. **Continuous Verification**
   - 各ステップで人間が検証
   - CI/CDで自動検証
   - 早期発見・早期修正

4. **Traceability**
   - Code MappingでDomain ↔ Code対応を明記
   - PRにContext参照を必ず記載

### ❌ DON'T

1. **Documentation無しでCode生成**
   - Domain DesignなしでAIにコード書かせない
   - ADRなしで技術選定しない

2. **Tests無しでImplementation**
   - テストなしでコードを書かない
   - カバレッジ100%未満でマージしない

3. **人間検証スキップ**
   - AIの出力を盲信しない
   - 各ステップで必ず検証

4. **Traceability欠如**
   - Context参照なしでCode実装しない
   - Code Mapping更新を忘れない

---
