# Pull Request Template

## Summary

## Business Justification

## Related Docs

- Vision:
- PRD:
- ADR:
- Acceptance Criteria:
- Scope Decision:

## Type

- [ ] Documentation
- [ ] Governance
- [ ] Feature
- [ ] Bug fix
- [ ] Security
- [ ] Architecture
- [ ] DevOps

## Governance Checklist

- [ ] Vision conform
- [ ] Business model conform
- [ ] PRD conform
- [ ] Architecture conform
- [ ] Security conform
- [ ] Acceptance criteria conform
- [ ] Scope-control conform
- [ ] Tests added/updated or not applicable
- [ ] Documentation updated
- [ ] Unit economics reviewed
- [ ] No uncontrolled scope creep

## Testing Evidence

## Security Impact

## Deployment Impact

## Rollback Plan

## Lean Engineering Checklist

- [ ] Confirmed this change needs to exist.
- [ ] Existing workflow/documentation/process could not solve it.
- [ ] Standard library/platform capability considered.
- [ ] Existing dependency reuse considered.
- [ ] Existing code modification considered.
- [ ] Deletion/simplification considered.
- [ ] No unnecessary dependency added.
- [ ] No premature abstraction introduced.
- [ ] Smallest correct solution selected.
- [ ] Security, validation, reliability and observability preserved.
- [ ] Non-trivial logic includes a minimal runnable check.

## Governance Simplicity

- [ ] Checked `docs/governance/source-of-truth.md` before editing governance.
- [ ] Did not duplicate rules unnecessarily.
- [ ] Used `docs/governance/founder-override.md` if bypassing normal process.
- [ ] Confirmed `scripts/check-governance.sh` passes.
