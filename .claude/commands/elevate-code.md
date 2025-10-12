---
description: Elevate existing code into Context Studio artifacts by analysing the given path and updating the relevant code mapping and design documentation.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding (if not empty).

User input:

$ARGUMENTS

## Purpose
- Reverse-engineer an existing implementation file/folder and connect it back to Context Studio documentation.
- Produce updates to `.aidlc/contexts/<ctx>/construction/code-mapping.md`, Domain Design, and ADRs as required.
- Surface gaps between current code and documented intent.

## Expected Arguments
`/elevate-code <relative-path> [--context <ctx-id>]`

- `<relative-path>`: path within the repository or submodule (e.g., `submodules/code-output/yokakit/app/Services/AuthService.php`).
- `--context` (optional): explicit context ID; if omitted, inspect mapping files or ask the user which context applies.

## Pre-flight Checklist
1. Verify the path exists. If the path points into a Git submodule, note its repository and current commit.
2. Identify candidate context(s):
   - Prefer contexts whose `code-mapping.md` already references similar files.
   - If none, ask the user which feature this code belongs to.
3. Read the relevant Domain/Logical Design artifacts to understand expectations:
   - `.aidlc/contexts/<ctx>/construction/domain-design/`
   - `.aidlc/contexts/<ctx>/construction/logical-design/`
4. Inspect source code:
   - Summarise responsibilities, public API, dependencies, and side-effects.
   - Capture TODOs, missing tests, or deviations from design.

## Deliverables
1. Updated `code-mapping.md` entry including:
   - Artifact type (Entity/Service/Controller/etc.)
   - File path
   - Status (`existing`, `needs-refactor`, `deprecated`, etc.)
   - Notes (gaps, TODOs)
2. If the implementation introduces undocumented behavior:
   - Propose updates to Domain Design or ADRs.
   - Highlight NFR implications.
3. Optional: Generate a companion summary under `.aidlc-docs/plans/` if the elevation reveals significant refactor tasks (coordinate with the user).

## Execution Flow
1. Confirm file path and context with the user.
2. Parse the code (read-only) and produce a concise summary covering:
   - Purpose
   - Inputs/outputs
   - Collaborating components
   - Risks or tech debt indicators
3. Compare with existing documentation and note mismatches.
4. Present recommended documentation updates to the user for approval.
5. Apply updates using deterministic commands (`apply_patch`, `cat <<'EOF'`).
6. Conclude with suggested follow-up actions (e.g., create Issue for missing tests, schedule refactor).

## Validation
- `code-mapping.md` rows should remain sorted/grouped logically (e.g., by artifact type).
- Include hyperlinks to ADRs or stories when relevant.
- Do not modify source code unless the user explicitly requests it; focus on documentation alignment.

Context: $ARGUMENTS
