# Definition of Done

A task, feature, phase or release is only done when all relevant criteria are met.

## Business

- Business justification is documented.
- Customer problem is linked.
- Scope-control decision is documented.
- Unit economics impact is known.

## Product

- Acceptance criteria are met.
- PRD is updated if scope changed.
- Out-of-scope items are documented.

## Lean Engineering

- Decision Ladder was applied.
- No unnecessary abstraction was introduced.
- No unjustified dependency was added.
- Existing code reuse was considered.
- Deletion or simplification was considered.
- The smallest correct solution was selected.
- Intentional simplifications are documented with a `lean:` comment.

## Code

- Code compiles.
- Type checks pass where applicable.
- Linting passes where applicable.
- No unapproved TODOs.
- No hardcoded secrets.
- No demo-only implementation in production paths.

## Tests and Verification

- Non-trivial logic has one minimal runnable check.
- Unit tests exist where relevant.
- Integration tests exist where relevant.
- E2E tests exist for critical flows.
- Regression tests exist for bug fixes.

## Security

- Input validation exists at trust boundaries.
- Authorization checks are present.
- Sensitive data is protected.
- Dependency risk is reviewed.
- Logs avoid secrets and unnecessary PII.

## Operations

- Logging exists where needed.
- Monitoring impact is known.
- Deployment impact is known.
- Rollback path is known.

## Documentation

- `docs/project-status.md` updated.
- `docs/context/current-state.md` updated.
- `docs/context/next-session.md` updated.
- ADR updated or created if needed.
- Changelog updated if user-visible behavior changed.
