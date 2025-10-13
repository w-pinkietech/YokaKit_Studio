# AI-DLC Development Process: TDD & Documentation-Driven

**AI主導コード生成 × TDD × ドキュメント駆動の開発プロセス最適化**

AIがほぼすべてのコードを書く前提において、品質を担保するための徹底したプロセス定義。

---

## Core Principles

### 1. Documentation-First（ドキュメント先行）

```
Domain Design → ADR → Tests Specification → Code
```

**理由**: 
- AIはドキュメント（文脈）からコードを生成
- ドキュメントが不完全 → コードも不完全
- **ドキュメント = 人間の意図の明示化**

### 2. Test-Driven Development（テスト駆動開発）

```
Test Cases (Human Verified) → AI Generates Code → Tests Pass
```

**理由**:
- AIが書くコードは予測不可能
- テストが仕様の明確化
- **テスト = AIへの制約条件**

### 3. Continuous Verification（継続的検証）

```
各ステップで人間が検証 → 下流の無駄削減（Loss Function）
```

**理由**:
- 早期発見・早期修正
- AIの誤りを早い段階で補正
- **検証 = 品質の担保**

---

## Construction Phase: Detailed Workflow

### Phase Overview

```mermaid
graph TB
    subgraph "Step 1: Domain Design"
        DD1[AI: Static Model提案]
        DD2[Human: 検証・修正]
        DD3[AI: Dynamic Model提案]
        DD4[Human: 検証・承認]
        DD5[Commit: Domain Design]
    end
    
    subgraph "Step 2: Logical Design"
        LD1[AI: Architecture提案]
        LD2[Human: ADR作成・承認]
        LD3[Commit: ADR]
    end
    
    subgraph "Step 3: Test Specification"
        TS1[AI: Test Cases生成]
        TS2[Human: Test Cases検証]
        TS3[AI: Test Code生成]
        TS4[Human: Test Code承認]
        TS5[Commit: Tests Only]
    end
    
    subgraph "Step 4: Code Generation"
        CG1[AI: Implementation生成]
        CG2[Run Tests]
        CG3{All Pass?}
        CG4[Human: Code Review]
        CG5[Commit: Implementation]
        CG6[AI: 修正提案]
    end
    
    subgraph "Step 5: Documentation Update"
        DU1[AI: Code Mapping更新]
        DU2[AI: API Doc生成]
        DU3[Human: ドキュメント検証]
        DU4[Commit: Documentation]
    end
    
    DD1 --> DD2 --> DD3 --> DD4 --> DD5
    DD5 --> LD1 --> LD2 --> LD3
    LD3 --> TS1 --> TS2 --> TS3 --> TS4 --> TS5
    TS5 --> CG1 --> CG2 --> CG3
    CG3 -->|No| CG6 --> CG1
    CG3 -->|Yes| CG4 --> CG5
    CG5 --> DU1 --> DU2 --> DU3 --> DU4
    
    style DD5 fill:#1f4068,stroke:#2ec4b6,stroke-width:3px,color:#fff
    style LD3 fill:#1f4068,stroke:#2ec4b6,stroke-width:3px,color:#fff
    style TS5 fill:#2d2d44,stroke:#7f5af0,stroke-width:3px,color:#fff
    style CG5 fill:#2d2d44,stroke:#7f5af0,stroke-width:3px,color:#fff
    style DU4 fill:#162447,stroke:#1dd1a1,stroke-width:3px,color:#fff
    style CG3 fill:#5c2e7e,stroke:#e63946,stroke-width:2px,color:#fff
```

---
