# MVP Gate

## Product

TBD_AFTER_PRODUCT_SELECTION

## Core Problem

## Paying Customer

## MVP Scope

## Payment Flow

## Build Estimate

## Unit Economics

## First 10 Customers Plan

For B2C, read "first 10 customers" as the first paying cohort giving an equivalent revenue signal: at consumer price points (€5–10/month) that is typically 50–200 paying users, not 10. The plan must name the channel that reaches them at acceptable cost (see `docs/sales/b2c-acquisition-channels.md`).

## Security and Compliance Review

## Checklist

- [ ] Solves one core problem
- [ ] Clear paying customer
- [ ] Payment possible in MVP
- [ ] Buildable within 60 days
- [ ] Positive unit economics likely
- [ ] First 10 customers path clear
- [ ] No major uncontrolled compliance risk
- [ ] Scope is minimal

## Decision

The gate is only considered approved when the line below literally reads `MVP Gate Approved: Yes` — CI greps for exactly that. Fill in all three fields when deciding.

MVP Gate Approved: No
Approved By: TBD
Approval Date: TBD

Outcome options: Approved / Rejected / Needs Revision (record rejections and revisions in the fields above with `No` plus a note).

## Lean MVP Gate

The MVP must be the smallest paid product that solves one core problem.

Before approval, confirm:

- No non-essential admin dashboards.
- No speculative integrations.
- No complex analytics unless required for the core workflow.
- No mobile app unless the customer workflow requires it.
- No public API unless the first paying customer requires it.
- No advanced roles unless required for payment or security.
- No unbounded AI/API usage.
- Payment path exists.
- First 10 customer path exists.

## Scope Control Requirement

MVP Gate approval requires a Scope Control review.

Any feature outside the validated MVP scope must be explicitly deferred.
