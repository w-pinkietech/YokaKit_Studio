---
description: Kick off the AI-DLC Inception workflow, capture intent context, and scaffold the `.aidlc/contexts` structure for a new feature.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding (if not empty).

User input:

$ARGUMENTS

## Purpose
- Collect the business intent, success metrics, and scope clarifications for a new feature.
- Produce the canonical Inception artifacts under `.aidlc/contexts/<id>-<slug>/inception/`.
- Record Non-Functional Requirements, risks, PRFAQ, and the proposed Bolt plan.
- Ensure everything aligns with the project constitution (`.aidlc/constitution.md`) and existing governance.

## Pre-flight Checklist
1. Ask the user which GitHub Issue drives this work and confirm it is in `status::ready`.
2. Read `.aidlc/constitution.md` if present and note any constraints that impact the feature.
3. Derive the short intent summary:
   - Prefer the text supplied in `$ARGUMENTS`.
   - If missing, ask the user to provide a one-line intent description.
4. Confirm with the user that they are ready to create a new Inception context.

## Context ID Allocation
1. Inspect `.aidlc/contexts/` for existing directories.
2. Determine the next numeric ID (3 digits, zero-padded). Example: existing `001-*`, `002-*` → new ID `003`.
3. Generate a slug from the intent (kebab-case, ≤6 words). Example: `"multi account switching"` → `multi-account-switching`.
4. Compose the context path: `.aidlc/contexts/<ID>-<slug>/`.
5. Present the proposed path to the user and obtain explicit confirmation before creating files.

## Directory & File Layout
Create the following structure relative to repo root (use `mkdir -p` where required):
```
.aidlc/contexts/<ID>-<slug>/
└── inception/
    ├── intent.md
    ├── units.md
    ├── stories/
    │   └── story-001.md (one file per user story, increment as needed)
    ├── nfrs.md
    ├── risks.md
    ├── prfaq.md
    └── bolts.md
```

## Artifact Templates
Populate each file with Markdown headings as below. Replace placeholders with collected data; leave `TODO(...)` markers only when the user intentionally defers information.

### intent.md
```
# Intent
- **Issue**: <GitHub issue link/number>
- **Summary**: <1-2 sentence business intent>
- **Primary Actor(s)**: <roles/personas>
- **Problem Statement**: <what pain we solve>
- **Desired Outcomes**: <business metrics or success criteria>
- **In Scope**: <bullet list>
- **Out of Scope**: <bullet list>
```

### units.md
```
# Units Breakdown
| Unit ID | Name | Purpose | Notes |
|---------|------|---------|-------|
| U1 | <name> | <what this unit delivers> | <dependencies/remarks> |
```
(Add one row per unit. Synthesise IDs U1, U2, ... in the order agreed with the user.)

### stories/story-XXX.md
Create one file per user story:
```
# User Story <number>: <title>
- **As a** <role>
- **I want** <capability>
- **So that** <value>

## Acceptance Criteria
- [ ] <criterion 1>
- [ ] <criterion 2>

## Notes
- <assumptions, open questions, links>
```

### nfrs.md
```
# Non-Functional Requirements
| Category | Requirement | Metric/Threshold | Notes |
|----------|-------------|------------------|-------|
| Security | <statement> | <metric> | <evidence/validation plan> |
```

### risks.md
```
# Risks & Mitigations
| ID | Description | Impact | Likelihood | Mitigation | Owner |
|----|-------------|--------|------------|------------|-------|
| R1 | <risk> | <High/Med/Low> | <High/Med/Low> | <plan> | <role/person> |
```

### prfaq.md
```
# PRFAQ
## Press Release
<one-paragraph announcement tone summary>

## FAQs
### Q: <question>
A: <answer>
```

### bolts.md
```
# Bolt Plan
| Bolt | Scope | Duration | Success Criteria | Notes |
|------|-------|----------|------------------|-------|
| Bolt 1 | <units/stories covered> | <timebox> | <definition of done> | <dependencies> |
```

## Execution Flow
1. Gather intent summary and validate constitution constraints.
2. Collaboratively define Units with the user; capture them in `units.md`.
3. For each unit, elicit at least one user story; ensure acceptance criteria are testable.
4. Capture NFRs (performance, security, compliance, observability). Ask follow-up questions if gaps remain.
5. Identify top risks and mitigation strategies; assign provisional owners (even if role-based).
6. Draft PRFAQ content using the collected narrative.
7. Propose Bolt plan (timeboxed iterations) aligned with Units and Stories.
8. Before saving files, present a summary to the user highlighting:
   - Context path
   - Units list
   - Story titles
   - NFR categories
   - Bolt outline
9. On approval, write the files using `apply_patch` (or another deterministic method).
10. Conclude with next-step suggestions (typically `/construction <unit-name>` or `/plan`).

## Validation
- Ensure all Markdown files render without placeholders like `[TODO]` unless user-approved.
- Confirm numbering/order consistency (story-001, story-002...).
- Verify links to GitHub Issues or ADRs are relative paths or proper markdown links.
- Mention in the summary if any sections remain TODO with explicit reasons.

Context: $ARGUMENTS
