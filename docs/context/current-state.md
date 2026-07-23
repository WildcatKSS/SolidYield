Last Updated: 2026-07-23

# Current State

## Summary

Repository is a product-neutral starter template for a SaaS or digital service (B2B or B2C). No product has been selected.

Governance duplication was removed and CI enforcement hardened per ADR-001 (2026-07-22): one canonical Definition of Done, one ADR template, no pre-committed stack files, anchored keyword checks, dependency-bot exemption, real freshness dates required.

Per ADR-002 (2026-07-22) the MVP Gate CI check now requires a literal `MVP Gate Approved: Yes` line (it previously matched the unapproved template), security requirements and the threat model carry a product-neutral B2B SaaS baseline, the session-start list lives only in the repository memory policy, and remaining stack assumptions are labeled as hypothesis.

Per ADR-003 (2026-07-23) the template scope is broadened from B2B SaaS to SaaS or digital service (B2B or B2C). The customer type is chosen during product selection; the security baseline applies to both models with "tenant" defined as the paying customer's account (organization in B2B, individual user account in B2C). All other non-negotiables are unchanged.

Follow-through on the broadening (2026-07-23): the governance check matches product code in common layouts (not only src/), the validation plan has separate B2B and B2C evidence thresholds, the MVP Gate defines the B2C reading of "first 10 customers", and a B2C acquisition-channels template complements the B2B outbound templates.

## Active Phase

Phase 0 complete / Phase 1 ready.

## Current Objective

Use market discovery and validation before any product implementation.

## Constraints

- No product code before MVP Gate
- No product assumptions without documentation
- No architecture commitment without ADR
