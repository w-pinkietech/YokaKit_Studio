---
description: Trace a Context Studio artifact across documentation, issues, and code mappings to provide end-to-end visibility.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding (if not empty).

User input:

$ARGUMENTS

## Purpose
- Given an artifact identifier (e.g., story ID, ADR number, unit name), collect all related references across the repository.
- Summarise linkages between Intent, Construction, Operations, Issues/PRs, and code implementations.
- Identify missing or stale links that need maintenance.

## Expected Arguments
`/trace <artifact-ref>`

Accepted formats:
- `story-001`, `unit:account-management`, `adr:001`, `nfr:latency`
- Context-qualified references like `001-multi-account/story-002`
- File paths or globs (fallback; confirm with user)

## Execution Flow
1. Normalise the input:
   - If context prefix missing, search all contexts; if multiple matches, show options and ask user to choose.
2. Collect data:
   - Intent artifacts (`intent.md`, `units.md`, `stories/`)
   - Construction artifacts (`domain-design`, `logical-design`, `tests/`, `code-mapping.md`)
   - Operations artifacts (`deployment-plan.md`, `observability.md`, playbooks)
   - Related Issues/PRs from `.github` templates or repository references (search for the artifact key).
   - Code references from `code-mapping.md` (paths, repositories).
3. For each source, extract contextual snippets (2-3 bullet summaries, acceptance criteria, ADR decisions).
4. Assemble a consolidated Markdown report:
```
# Trace Report — <artifact-ref>

## Summary
- Context: <id-slug>
- Type: <Story/Unit/ADR/NFR/Custom>
- Status: <Known status or TODO if undocumented>

## Origin Artifact
- File: <path>
- Key Details: <bullets>

## Linked Documentation
- <path> — <reason>

## Code Implementations
- <repo/path> — Commit: <hash> (if available)

## Open Issues / PRs
- <link> — <status> — <notes>

## Gaps & Recommendations
- [ ] <gap description>
- Suggestion: <next action>
```
5. Highlight missing links:
   - No code mapping → recommend updating `code-mapping.md`.
   - No tests for a story → recommend adding to Construction tests/specification.
6. Present report to the user. Ask whether they want follow-up commands (e.g., open Issue, run `/analyze`).

## Rules
- Read-only command: do **not** modify files.
- Limit report to top 20 linked items; collapse additional references into a summary note.
- If the artifact cannot be found, provide troubleshooting guidance (e.g., run `/inception` or verify spelling).

Context: $ARGUMENTS
