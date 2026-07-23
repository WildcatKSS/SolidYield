# ADR-002: Security Baseline and MVP Gate Enforcement Fix

## Status

Accepted

## Context

A second critical template review found:

- The CI check gating product code on MVP Gate approval was vacuous: its pattern accepted the bare word "Approved", which the unapproved template itself contained in the option line "Approved / Rejected / Needs Revision". Product code in `src/` would have passed the gate today.
- `docs/security-requirements.md`, the self-declared canonical security source, consisted of six one-liners and omitted B2B-SaaS-critical requirements: multi-tenant isolation, session management, encryption, audit logging, rate limiting.
- `docs/security/threat-model.md` was an empty skeleton although a product-neutral baseline for multi-tenant B2B SaaS is possible.
- `CLAUDE.md` duplicated the session-start file list, diverging from the canonical list in `docs/governance/repository-memory-policy.md` (which also includes lean-engineering.md).
- `docs/coding-standards.md` and `docs/operational-runbook.md` stated Default Stack Hypothesis choices (TypeScript, Stripe) as settled fact, while `docs/architecture.md` correctly labels them a hypothesis pending an ADR.
- `docs/templates/decision-template.md` overlapped with the ADR template and the Decision Output list in `docs/governance/decision-framework.md`, with no owner in the source-of-truth map.

## Decision

1. The MVP Gate check greps for a literal line `MVP Gate Approved: Yes`; `docs/product/mvp-gate.md` carries explicit `MVP Gate Approved` / `Approved By` / `Approval Date` fields, defaulting to `No`.
2. Expand `docs/security-requirements.md` into a product-neutral B2B SaaS baseline covering multi-tenant isolation, session management, credential-endpoint rate limiting, webhook signature verification, TLS/at-rest encryption, audit logging and abuse caps.
3. Fill `docs/security/threat-model.md` with a baseline multi-tenant SaaS threat model; product-specific rows marked `TBD_AFTER_PRODUCT_SELECTION`.
4. `CLAUDE.md` references the repository-memory-policy session-start list instead of duplicating it.
5. Label the language section in `docs/coding-standards.md` and the billing reference in `docs/operational-runbook.md` as Default Stack Hypothesis items pending the tech-stack ADR.
6. Delete `docs/templates/decision-template.md`; `docs/governance/decision-framework.md` owns decision format and criteria (added to the source-of-truth map).

## Alternatives Considered

- Keep the loose "Approved" grep and rely on discipline: rejected, the whole point of the gate is that CI does not rely on discipline.
- Leave the threat model empty until product selection: rejected, most threats to a multi-tenant B2B SaaS are known before the product is.
- Keep the decision template as a lighter-weight alternative to ADRs: rejected, three overlapping formats caused the ambiguity; non-architectural decisions fit `docs/context/decisions-summary.md`.

## Decision Confidence

High

## Evidence Source

Founder Assumption

## Lean Engineering Impact

One file deleted, none added beyond this ADR. The security expansion adds requirements, not process: no new tools, dependencies or workflow steps. The gate fix tightens an existing check without adding one.

## Risks

- The stricter gate grep fails if the approval line is reformatted (e.g. bolded); mitigated by the instruction in mvp-gate.md stating the literal expected line.
- The baseline threat model could be mistaken for a complete one; mitigated by explicit TBD rows and the extension instruction.

## Rollback Plan

Revert the commit; the previous check behavior and documents are recoverable from git history.

## ADR Quality Checklist

- [x] Problem clearly defined
- [x] Alternatives documented
- [x] Business impact described
- [x] Lean Engineering impact described
- [x] Risks documented
- [x] Rollback documented

## Date

2026-07-22
