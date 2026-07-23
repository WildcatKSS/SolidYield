# Security Requirements

## Purpose

Canonical security source document. These are the minimum requirements for any SaaS or digital service (B2B or B2C) built from this template, independent of the product selected. Product-specific requirements are added after product selection.

Throughout this document, "tenant" means the paying customer's account: an organization in B2B, an individual user account in B2C. The isolation requirements apply equally to both.

## Authentication

- Protected functionality requires authentication.
- Session tokens are unpredictable, expire, and are invalidated on logout and password change.
- Credential endpoints (login, signup, password reset) are rate-limited to resist credential stuffing and brute force.
- Password storage uses a modern adaptive hash (e.g. argon2 or bcrypt) — never reversible encryption or plain hashes.

## Authorization

- Least privilege.
- Access only to authorized resources.
- Authorization checks live close to data access, not only in the UI.

## Multi-Tenant Isolation

- Every query touching tenant data is scoped to the authenticated tenant; tenant ID comes from the session, never from client input.
- Cross-tenant access is treated as a critical defect, tested for explicitly, and covered in the threat model.
- Background jobs, exports and webhooks carry and enforce tenant scope.

## Input Validation

- Validate all external input at trust boundaries (requests, forms, webhooks, uploads, third-party API responses).
- Incoming webhooks verify signatures before processing.

## Rate Limiting and Abuse

- Sensitive and expensive endpoints are rate-limited.
- Free-tier and trial usage is capped so abuse cannot create unbounded cost.

## Secrets

- Never commit secrets.
- Store secrets in approved secret stores.
- Rotate secrets after suspected exposure or maintainer changes.

## Data Protection

- All traffic uses TLS; no plaintext transport in production.
- Data at rest is encrypted (platform-level encryption is acceptable).
- Avoid secrets and unnecessary PII in logs.
- Protect sensitive data; retain personal data no longer than needed.

## Audit and Logging

- Security-relevant events are logged: authentication attempts, permission changes, billing changes, data exports, admin actions.
- Logs support answering "who did what, when" for customer-facing incidents.

## Dependency Security

- Minimize dependencies.
- Review updates regularly.

## Reading Order

1. docs/security-requirements.md
2. docs/security/threat-model.md
3. docs/security/security-operations-lite.md
