# Specification Workflow (.specify)

## Overview
YokaKit_Studio uses a structured specification and planning workflow managed through `.specify/` directory and Claude Code slash commands.

## Directory Structure
```
.specify/
├── scripts/bash/          # Automation scripts
│   ├── common.sh         # Shared utilities
│   ├── check-prerequisites.sh
│   ├── create-new-feature.sh
│   ├── setup-plan.sh
│   └── update-agent-context.sh
├── templates/            # Document templates
│   ├── spec-template.md
│   ├── plan-template.md
│   ├── tasks-template.md
│   └── agent-file-template.md
└── memory/
    └── constitution.md   # Project principles and governance
```

## Workflow Phases

### Phase 1: Specification (/specify)
**Purpose**: Create feature specification from natural language description

**Process**:
1. Run `/specify <feature description>`
2. Script creates new branch and initializes spec file
3. Agent writes specification using spec-template.md
4. Output: BRANCH_NAME, SPEC_FILE path

**Key Sections**:
- Feature requirements and user stories
- Functional and non-functional requirements
- Success criteria and acceptance criteria
- Technical constraints and dependencies

### Phase 2: Clarification (/clarify)
**Purpose**: Identify underspecified areas and refine specification

**Process**:
1. Run `/clarify` on feature branch
2. Agent asks up to 5 targeted clarification questions
3. User provides answers
4. Agent updates spec.md with clarifications

**Important**: Should be run before `/plan` to reduce rework

### Phase 3: Planning (/plan)
**Purpose**: Generate implementation plan and design artifacts

**Process**:
1. Run `/plan` (optionally with additional implementation details)
2. Script runs setup-plan.sh for context
3. Agent reads spec.md and constitution.md
4. Agent executes plan-template.md workflow
5. Generates artifacts in $SPECS_DIR

**Generated Artifacts**:
- Phase 0: research.md
- Phase 1: data-model.md, contracts/, quickstart.md
- Phase 2: tasks.md

**Prerequisites**:
- Spec must have Clarifications section OR user override

### Phase 4: Task Generation (/tasks)
**Purpose**: Create actionable, dependency-ordered tasks.md

**Process**:
1. Run `/tasks`
2. Agent analyzes spec.md and plan.md
3. Generates tasks.md using tasks-template.md
4. Tasks ordered by dependencies

### Phase 5: Analysis (/analyze)
**Purpose**: Cross-artifact consistency and quality check

**Process**:
1. Run `/analyze` after task generation
2. Non-destructive analysis across spec.md, plan.md, tasks.md
3. Reports inconsistencies and quality issues

### Phase 6: Implementation (/implement)
**Purpose**: Execute implementation plan

**Process**:
1. Run `/implement`
2. Agent processes and executes all tasks from tasks.md
3. Follows task dependencies and order
4. Verifies task completion checklist

## Constitution Management (/constitution)
**Purpose**: Create or update project principles

**Process**:
1. Run `/constitution`
2. Interactive or batch principle input
3. Updates constitution.md
4. Ensures dependent templates stay in sync

## Best Practices

1. **Always follow the workflow order**: specify → clarify → plan → tasks → implement
2. **Don't skip clarification**: Prevents rework in later phases
3. **Read constitution**: Understand project principles before planning
4. **Use absolute paths**: All file operations should use absolute paths
5. **Verify prerequisites**: Scripts check for required tools and files
6. **Track progress**: Update task status in tasks.md during implementation

## Integration with Git
- Feature branches created automatically by create-new-feature.sh
- Branch naming convention managed by scripts
- Each feature gets its own branch and specification
- Constitution changes require documentation and approval

## Template-Driven Development
All phases use templates for consistency:
- Templates are self-contained and executable
- Follow template structure strictly
- Templates guide artifact generation
- Error handling and gates built into templates