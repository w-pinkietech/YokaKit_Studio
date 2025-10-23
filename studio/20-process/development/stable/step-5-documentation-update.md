# Step 5: Documentation Update

### 5.1 Code Mapping Update（AI）

**AI Prompt Template**:
```
Context: {Domain Design, Implementation}

Task: Domain DesignとCode実装のマッピングを更新してください。

Domain Design: .aidlc/contexts/001-*/construction/domain-design/
Implementation: submodules/code-output/yokakit/app/

Output Format:
# Code Mapping

## Entities
| Domain Entity | Code Path | Status |
|---------------|-----------|--------|
| Account | app/Models/Account.php | ✅ Implemented |
| ... | ... | ... |

## Services
| Domain Service | Code Path | Status |
|----------------|-----------|--------|
| SwitchAccountService | app/Services/SwitchAccountService.php | ✅ Implemented |

## Repositories
| Domain Repository | Code Path | Status |
|-------------------|-----------|--------|
| AccountRepository | app/Repositories/AccountRepository.php | ✅ Implemented |

## Detailed Mapping

### Account Entity
- **Domain**: `.aidlc/contexts/001-*/construction/domain-design/static-model.md#Account`
- **Code**: `submodules/code-output/yokakit/app/Models/Account.php`
- **Tests**: `submodules/code-output/yokakit/tests/Unit/Models/AccountTest.php`
- **ADR**: ADR-001
- **Methods**:
  - `create(array $data)` → Domain: Account生成
  - `validate(array $data)` → Domain: バリデーション
```

**Output**: `.aidlc/contexts/001-*/construction/code-mapping.md`

---

### 5.2 API Documentation Generation（AI）

**AI Prompt Template**:
```
Context: {Implementation}

Task: 以下の実装のAPIドキュメントを生成してください。

Implementation: app/Services/SwitchAccountService.php

Output Format (OpenAPI):
```yaml
openapi: 3.0.0
info:
  title: Account Switching API
  version: 1.0.0

paths:
  /api/accounts/switch:
    post:
      summary: アカウント切り替え
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                accountId:
                  type: string
                  format: uuid
      responses:
        200:
          description: 成功
        401:
          description: 認証エラー
        404:
          description: アカウントが見つからない
```
```

**Output**: `submodules/code-output/yokakit/studio/api/account-switching.yml`

---

### 5.3 Commit: Documentation

```bash
# Context Studio側
cd /path/to/context-studio
git checkout construction/001-multi-account
git add .aidlc/contexts/001-*/construction/code-mapping.md
git commit -m "docs: Update code mapping for Account Entity

Mapped:
- Account Entity → app/Models/Account.php
- SwitchAccountService → app/Services/SwitchAccountService.php
- AccountRepository → app/Repositories/AccountRepository.php

Implementation: yokakit feature/001-account-entity-tests"
git push

# Code Output側
cd submodules/code-output/yokakit
git checkout feature/001-account-entity-tests
git add studio/api/account-switching.yml
git commit -m "docs: Add API documentation for account switching

OpenAPI spec for Account Switching API

Based on: ADR-001, Domain Design"
git push
```

---
