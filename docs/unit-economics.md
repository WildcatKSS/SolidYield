# Unit Economics

## Purpose

Ensure the product can make money after hosting, AI/API, support, and payment costs.

## Pricing

| Plan | Monthly Price | Expected Usage | Expected Gross Margin | Status |
|---|---:|---:|---:|---|
| Starter | TBD | TBD | TBD | Hypothesis |
| Pro | TBD | TBD | TBD | Hypothesis |

## Variable Cost per Customer

| Category | Cost per Month | Notes |
|---|---:|---|
| Hosting | TBD | |
| Database | TBD | |
| AI/API | TBD | |
| Email | TBD | |
| Monitoring | TBD | |
| Support | TBD | |
| Payment fees | TBD | |

## Guardrails

- Target gross margin: 70%+
- AI/API cost should ideally stay below 20% of revenue per customer
- Free tier must not create unbounded cost
- Trial usage must be rate-limited
- High-cost workflows require usage caps

## Break-Even

TBD_AFTER_PRODUCT_SELECTION

## Review Cadence

Review after:
- Product selection
- MVP Gate
- Pricing change
- AI/API usage change
- Launch

## Review Log

| Date | Trigger | Outcome |
|---|---|---|
| 2026-07-22 | Governance cleanup (ADR-001) removed the empty billing ADR stub | Reviewed; no unit economics impact |

## Cost Governance

Before implementing usage-heavy features, especially AI/API workflows:

- Estimate cost per customer.
- Estimate worst-case abuse cost.
- Define usage caps.
- Define rate limits.
- Define free trial limits.
- Confirm gross margin remains acceptable.

Guardrail:
AI/API cost per customer should not exceed 20% of subscription revenue unless explicitly approved and documented.
