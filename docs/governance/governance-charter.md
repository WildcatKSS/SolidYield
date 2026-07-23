# Governance Charter

## Purpose

This charter defines how this repository must be operated by Claude Code and human maintainers.

The repository is designed to prevent:
- building before validation
- scope creep
- context loss between sessions
- architecture drift
- security shortcuts
- over-engineering
- unbounded AI/API cost
- undocumented decisions

## Enforced Governance System

The following documents are mandatory controls:

- `CLAUDE.md`
- `docs/vision.md`
- `docs/business-model.md`
- `docs/prd.md`
- `docs/architecture.md`
- `docs/security-requirements.md`
- `docs/acceptance-criteria.md`
- `docs/scope-control.md`
- `docs/unit-economics.md`
- `docs/project-status.md`
- `docs/governance/lean-engineering.md`
- `docs/product/mvp-gate.md`
- `docs/context/current-state.md`
- `docs/context/decisions-summary.md`
- `docs/context/open-issues.md`
- `docs/context/next-session.md`
- `docs/adrs/`

## Operating Rules

1. Documentation is the source of truth.
2. Code must conform to documentation.
3. Significant decisions require ADRs.
4. Product implementation requires MVP Gate approval.
5. All implementation must comply with Lean Engineering.
6. Every phase requires explicit approval before the next phase.
7. Context files must be updated after every meaningful session.
8. Unit economics must be considered before usage-intensive features.
9. Security and validation are never optional.
10. Scope creep must be stopped, documented and re-scoped.

## Conflict Resolution

When documents conflict:

1. Stop.
2. Identify the conflict.
3. Determine the highest-priority document in the governance hierarchy.
4. Propose a resolution.
5. Update documentation first.
6. Only then update code.

## Governance Hierarchy

1. `docs/vision.md`
2. `docs/business-model.md`
3. `docs/prd.md`
4. `docs/architecture.md`
5. `docs/security-requirements.md`
6. `docs/acceptance-criteria.md`
7. `docs/scope-control.md`
8. `docs/governance/lean-engineering.md`
9. Code
