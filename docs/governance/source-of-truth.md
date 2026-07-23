# Source of Truth Map

## Purpose

This file prevents governance duplication from becoming confusing.

When the same topic appears in multiple documents, use this map to know which document is authoritative.

## Canonical Documents

| Topic | Canonical Source | Supporting Documents |
|---|---|---|
| Master operating rules | `CLAUDE.md` | `docs/governance/governance-charter.md` |
| Governance hierarchy | `docs/governance/governance-charter.md` | `CLAUDE.md` |
| Lean Engineering | `docs/governance/lean-engineering.md` | PR template, ADR template, Scope Control |
| Work readiness | `docs/governance/definition-of-ready.md` | PRD, Acceptance Criteria |
| Completion criteria | `docs/governance/definition-of-done.md` | PR template |
| Phase transitions | `docs/governance/phase-gates.md` | `docs/prompts/*` |
| Context memory | `docs/governance/repository-memory-policy.md` | `docs/context/*`, `docs/project-status.md` |
| Scope control | `docs/scope-control.md` | PRD, MVP Gate |
| Unit economics | `docs/unit-economics.md` | Business Model, MVP Gate |
| Product requirements | `docs/prd.md` | Acceptance Criteria, Roadmap |
| Architecture decisions | `docs/adrs/` | Architecture, Tech Decisions |
| Decision format and criteria | `docs/governance/decision-framework.md` | `docs/adrs/ADR-template.md` |
| Security requirements | `docs/security-requirements.md` | Security Checklist, Threat Model |
| Founder override | `docs/governance/founder-override.md` | Change Management |

## Rule

Do not duplicate full rules across many documents.

When editing governance:
1. Update the canonical source.
2. Add only short references elsewhere.
3. Avoid creating another document unless the topic has no clear owner.

## Documentation Style
Canonical source: `docs/governance/documentation-style-guide.md`
