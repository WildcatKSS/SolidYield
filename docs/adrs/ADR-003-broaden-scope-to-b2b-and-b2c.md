# ADR-003 – Broaden Template Scope to SaaS or Digital Service (B2B or B2C)

Date: 2026-07-23
Status: Accepted

## Context

The template was scoped exclusively to B2B SaaS: `docs/vision.md` declared "Must be B2B SaaS unless explicitly changed by ADR", and `CLAUDE.md`, `README.md`, the Phase 1 discovery prompt, the phase gates, the security baseline and the threat model all assumed a business customer. The founder wants the template to also support services aimed at consumers (B2C), so that product selection in Phase 1 is not artificially restricted to business customers.

The governance machinery itself (phases, MVP Gate, validation kit, unit economics, lean engineering, Definition of Ready/Done) is already business-model-neutral; only the wording of a small set of documents encoded the B2B assumption.

## Decision

Broaden the template scope from "B2B SaaS" to "SaaS or digital service (B2B or B2C)":

- `docs/vision.md` non-negotiable becomes "Must be a SaaS or digital service (B2B or B2C) unless explicitly changed by ADR". The customer-type choice is made during product selection.
- `CLAUDE.md`, `README.md`, `docs/prompts/phase-1-market-discovery.md`, `docs/governance/phase-gates.md` and `scripts/bootstrap.sh` are reworded to cover both models.
- `docs/security-requirements.md` and `docs/security/threat-model.md` keep the full baseline, with "tenant" defined as the paying customer's account: an organization in B2B, an individual user account in B2C. Account-level data isolation remains mandatory in both models.
- All other non-negotiables (one developer, €1.000 MRR path, no ad-dependence, no marketplace dependency for MVP) remain unchanged and apply equally to B2C candidates.

Historical records (change log entries, ADR-001/ADR-002, past decision rows) are not rewritten.

## Alternatives Considered

- Keep B2B-only scope: rejected; the founder explicitly wants consumer services in scope, and the restriction adds no protective value at template stage.
- Fork a separate B2C template: rejected; duplicates all governance documents and violates lean engineering (source-of-truth duplication).
- Remove the business-model constraint entirely: rejected; "SaaS or digital service" still usefully excludes hardware, agencies and other models the template's economics and security baseline do not cover.

## Decision Confidence

High

## Evidence Source

Founder Assumption

## Lean Engineering Impact

Wording-only change across a small set of documents; no new documents besides this ADR, no new process, no code. The security baseline is reused, not duplicated.

## Risks

- B2C candidates can have weaker willingness to pay; the existing validation gates (payment intent, unit economics) mitigate this and remain mandatory.
- Consumer products raise consumer-privacy expectations (e.g. GDPR consumer rights); the existing privacy-by-design principle and compliance templates cover this, product-specific obligations are assessed after product selection.

## Rollback Plan

Revert this ADR and the wording changes; restore "Must be B2B SaaS" in `docs/vision.md`. No code or structure depends on the broader scope.

## ADR Quality Checklist

- [x] Problem clearly defined
- [x] Alternatives documented
- [x] Business impact described
- [x] Lean Engineering impact described
- [x] Risks documented
- [x] Rollback documented
