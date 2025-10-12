---
description: Orchestrate Operations-phase activities such as deployment planning, playbook creation, and observability alignment for an existing context.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding (if not empty).

User input:

$ARGUMENTS

## Purpose
- Prepare deployment documentation, runbooks, and monitoring plans for a specific context.
- Validate that operational requirements derived from NFRs are addressed.
- Update `.aidlc/contexts/<ctx>/operations/` artifacts.

## Expected Arguments
`/operations <action> <context-id>`

Supported actions:
- `deploy` — craft or update deployment plan.
- `monitor` — define observability/alerting strategy.
- `recommend` — assess operational readiness and propose next steps.

If arguments are omitted, prompt the user to choose an action and context interactively.

## Pre-flight Checklist
1. Ensure the target context exists and Construction artifacts are complete enough for deployment (`.aidlc/contexts/<ctx>/construction/` must be present).
2. Review NFRs (`.aidlc/contexts/<ctx>/inception/nfrs.md`) and risks (`risks.md`).
3. Check whether `.aidlc/contexts/<ctx>/operations/` already contains files and whether you are updating or creating anew.

## Directory Layout
```
.aidlc/contexts/<ctx>/operations/
├── deployment-plan.md
├── playbooks/
│   └── <scenario>.md
└── observability.md
```
Create missing files/directories as needed.

## Artifact Templates

### deployment-plan.md
```
# Deployment Plan — <Context>

## Overview
- Target Environment(s): <dev/stg/prod>
- Release Cadence: <batch/continuous + frequency>
- Change Approval: <process/person>

## Steps
| Step | Description | Owner | Validation |
|------|-------------|-------|------------|
| 1 | <action> | <role> | <tests/metrics> |

## Rollback Strategy
- Trigger Criteria: ...
- Rollback Procedure: ...

## Dependencies
- <services, migrations, feature flags>
```

### observability.md
```
# Observability & Monitoring — <Context>

## KPIs / SLIs
| Metric | Target | Source | Alert Threshold |
|--------|--------|--------|-----------------|

## Dashboards
- <tool> — <link or TODO>

## Alerts
| Condition | Channel | Owner | Runbook |
|-----------|---------|-------|---------|

## Logging & Tracing
- Log schema: ...
- Trace spans: ...
```

### playbooks/<scenario>.md
For each high-impact failure scenario (derive from risks and NFRs):
```
# Playbook: <Scenario Name>

## Trigger
<How we detect the issue>

## Immediate Actions
1. ...

## Investigation
- Logs: ...
- Metrics: ...

## Resolution
- Steps to recover service.

## Post-Incident Tasks
- RCA owner: ...
- Follow-up tickets: ...
```

## Execution Flow
1. Identify the action (deploy / monitor / recommend).
2. Load relevant NFR and risk information; confirm with the user any updates since Construction.
3. For `deploy`:
   - Draft deployment steps, validation checks, and rollback.
   - Ensure responsibilities align with labels or roles defined in governance.
4. For `monitor`:
   - Define metrics, dashboards, alert thresholds, and logging strategy.
   - Cross-check against NFRs to ensure coverage (e.g., latency, error rate).
5. For `recommend`:
   - Evaluate readiness, list gaps, and propose follow-up tasks or Issues (label suggestions).
6. Present a summary to the user before writing files.
7. Persist updates using deterministic commands.
8. End with actionable next steps (e.g., "Create Issue for missing PagerDuty runbook").

## Validation
- Files must be Markdown-valid with headings starting at `#`.
- Every metric/alert references a data source or TODO placeholder with explanation.
- Ensure no conflicting instructions with `.aidlc/constitution.md`.
- Record TODOs clearly with `TODO(<owner>): description`.

Context: $ARGUMENTS
