---
description: Simple smoke-test command to confirm Claude command templates are wired correctly.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding (if not empty).

User input:

$ARGUMENTS

## Goal
- Verify that `.claude/commands/` templates are detected by Claude and can execute basic workflows.
- Echo back repository status and user-provided arguments without modifying files.

## Execution Steps
1. Greet the user and confirm the working repo.
2. If `$ARGUMENTS` is non-empty, repeat the content back under a heading `## Received Arguments`.
3. Run `git status -sb` (read-only) and capture the output for reporting.
4. Present a short summary:
   ```
   # Test Command Report
   - Repository Root: <path>
   - Current Branch: <branch>
   - Pending Changes: <count or "None">
   ```
5. Offer next suggestions, e.g., “Run /inception <intent> to start a new feature” or “Run /construction <unit> to begin design”.

## Constraints
- Strictly read-only: do not create or edit files.
- Keep the response concise (<200 lines).
- If git command fails, report the error and advise the user to check permissions.

Context: $ARGUMENTS
