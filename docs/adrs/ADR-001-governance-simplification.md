# ADR-001: Governance Simplification and Template Cleanup

## Status

Accepted

## Context

A template review found internal contradictions that would trigger the repository's own stop-on-conflict rule:

- Two diverging Definitions of Done (`docs/definition-of-done.md` and `docs/governance/definition-of-done.md`), plus a third inline copy in `CLAUDE.md`, violating the anti-duplication rule in `docs/governance/source-of-truth.md`.
- Two diverging ADR templates (`docs/adrs/ADR-template.md` and `docs/templates/adr-template.md`); only the first is enforced by CI, while `docs/governance/governance-index.md` pointed to the second.
- Governance hierarchies in `CLAUDE.md` (8 levels) and `docs/governance/governance-charter.md` (9 levels) disagreed.
- `docker-compose.yml` and `.env.example` pre-selected vendors (Postgres, Redis, Stripe, OpenAI, Sentry, Node) while the tech stack is explicitly undecided, contradicting the Product-Neutral Template Rule.
- `scripts/check-governance.sh` matched keywords as substrings (e.g. "ai" inside "email"), always failed Dependabot PRs (workflow changes require an ADR a bot cannot write), accepted the literal placeholder `YYYY-MM-DD` as freshness metadata, and defined an unused `STRICT_GOVERNANCE` variable.
- Five one-off audit snapshot reports in `docs/governance/` and leftover iteration sections in `README.md` added noise that decays.
- Six empty pre-numbered ADR stubs existed for decisions not yet made, in the non-enforced template format.

## Decision

1. Keep `docs/governance/definition-of-done.md` as the only Definition of Done; delete the root duplicate and reduce the `CLAUDE.md` section to a reference.
2. Keep `docs/adrs/ADR-template.md` as the only ADR template; delete `docs/templates/adr-template.md` and fix the index reference.
3. Align the `CLAUDE.md` governance hierarchy with the charter (lean-engineering at level 8, code at 9) and declare the charter canonical for the hierarchy.
4. Delete `docker-compose.yml` and `.env.example`; stack files return only after a tech-stack ADR is accepted.
5. Harden `scripts/check-governance.sh`: anchor keyword matching to path segments, skip diff-based checks for dependency bots, require a real `Last Updated` date, remove the unused variable.
6. Delete the five audit snapshot reports and rewrite `README.md` to a single start procedure.
7. Delete the empty ADR stubs; ADRs are created when a decision is actually made. Numbering restarts at this ADR.
8. Fill in `CODEOWNERS` with the repository owner.

## Alternatives Considered

- Keep both Definitions of Done and both ADR templates, synchronized manually: rejected, recurring drift cost with no benefit.
- Keep `docker-compose.yml`/`.env.example` and document them in a tech-stack ADR now: rejected, that would decide the stack before Phase 1–4 evidence exists.
- Exempt bots by skipping the whole governance job in the workflow: rejected, baseline checks (required files, env-file scan) should still run on bot PRs.

## Decision Confidence

High

## Evidence Source

Founder Assumption

## Lean Engineering Impact

Net deletion: 15 files removed, 1 added. No new dependencies, no new configuration, no new process steps. Enforcement got stricter (real dates, fewer false positives) while total governance surface shrank.

## Risks

- The stricter freshness check fails if context files are updated without a real date; mitigated by the check's explicit error message.
- Keyword anchoring could miss an exotic filename (e.g. `aicosts.ts`); accepted, path-segment matching covers conventional naming.

## Rollback Plan

Revert the commit; all deleted files are recoverable from git history.

## ADR Quality Checklist

- [x] Problem clearly defined
- [x] Alternatives documented
- [x] Business impact described
- [x] Lean Engineering impact described
- [x] Risks documented
- [x] Rollback documented

## Date

2026-07-22
