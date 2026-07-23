# Threat Model

This is a baseline threat model for a generic multi-tenant SaaS or digital service (B2B or B2C). A "tenant" is the paying customer's account: an organization in B2B, an individual user account in B2C. It applies regardless of the product selected. Extend it with product-specific assets, entry points and threats after product selection; product-specific rows are marked `TBD_AFTER_PRODUCT_SELECTION`.

## Assets

- Customer (tenant) data
- Customer credentials and sessions
- Billing and payment state
- API keys and secrets
- Availability of the core paid workflow
- Product-specific assets: TBD_AFTER_PRODUCT_SELECTION

## Actors

- Anonymous internet users
- Authenticated users of one tenant
- Malicious or compromised users of another tenant
- Compromised third-party dependencies or vendors
- The founder/operator (privileged access)

## Trust Boundaries

- Browser/client ↔ application
- Application ↔ database
- Application ↔ third-party APIs (billing, email, AI)
- Incoming webhooks ↔ application
- CI/CD ↔ production

## Entry Points

- Login, signup and password-reset endpoints
- Authenticated application endpoints
- Incoming webhooks (billing, integrations)
- File uploads if present
- Product-specific entry points: TBD_AFTER_PRODUCT_SELECTION

## Threats

| Threat | Impact | Likelihood | Mitigation |
|---|---:|---:|---|
| Cross-tenant data access (isolation failure) | Critical | Medium | Tenant scoping from session on every query; explicit isolation tests |
| Credential stuffing / brute force | High | High | Rate limiting on credential endpoints; adaptive password hashing; monitoring |
| Webhook spoofing (fake billing events) | High | Medium | Signature verification before processing; idempotent handlers |
| Billing manipulation (plan/entitlement tampering) | High | Medium | Server-side entitlement checks; billing state from provider, not client |
| Secret leakage (repo, logs, error messages) | Critical | Medium | No secrets in repo or logs; secret stores; rotation procedure |
| Dependency compromise | High | Medium | Minimal dependencies; Dependabot; review before merge |
| Unbounded AI/API cost abuse | High | Medium | Usage caps, rate limits, trial limits per unit economics guardrails |
| Account takeover via session theft | High | Medium | Expiring sessions; invalidation on logout/password change; TLS everywhere |
| Product-specific threats | TBD | TBD | TBD_AFTER_PRODUCT_SELECTION |

## Abuse Cases

- A trial user scripts the free tier to extract paid value or run up API cost.
- A customer's departing employee exports tenant data before access is revoked.
- An attacker replays or forges billing webhooks to gain entitlements.
- A user enumerates object IDs to reach another tenant's resources.

## Security Requirements

Canonical requirements live in `docs/security-requirements.md`. This model justifies them; when a new threat is added here, check whether a requirement must be added there.
