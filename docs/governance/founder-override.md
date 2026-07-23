# Founder Override

## Purpose

Sometimes a founder must intentionally bypass normal process for speed, customer urgency, or production safety.

This is allowed only when documented.

## Valid Reasons

A Founder Override may be used for:

- preventing data loss
- fixing a production outage
- resolving a security issue
- meeting an urgent customer commitment
- running a quick validation experiment
- reducing process overhead when the risk is clearly low

## Override Record

When using an override, document:

```text
Date:
Decision:
Normal rule bypassed:
Reason:
Risk:
Expected lifetime:
Follow-up action:
Owner:
```

## Expiry Rule

Every override must have one of:

- a reversal date
- a follow-up issue
- an ADR
- a documentation update

No permanent silent exceptions.

## Non-Overridable Areas

Founder Override may not bypass:

- basic security
- input validation at trust boundaries
- protection against data loss
- payment integrity
- legal/compliance obligations
- customer data confidentiality
