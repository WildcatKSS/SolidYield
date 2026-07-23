# Change Management

## Purpose

Ensure changes remain aligned with business goals, governance, Lean Engineering and production readiness.

## Changes Requiring ADR

An ADR is required for changes affecting:

- product selection
- tech stack
- authentication
- authorization
- billing
- deployment platform
- database architecture
- multi-tenancy model
- external vendors
- observability vendor
- security posture
- major cost profile
- public API design

## Change Procedure

1. Identify business reason.
2. Check current documentation.
3. Apply Lean Engineering Decision Ladder.
4. Check scope-control.
5. Check unit economics.
6. Create or update ADR if significant.
7. Update documentation.
8. Implement the smallest correct change.
9. Add minimal verification.
10. Update context memory.

## Emergency Changes

Emergency fixes may be implemented before full documentation only when needed to prevent:

- data loss
- security incident
- production outage
- payment failure

Afterward, documentation and ADRs must be updated immediately.
