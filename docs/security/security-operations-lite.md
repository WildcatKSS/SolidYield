# Security Operations Lite

## Purpose

A minimal security operations guide for a solo-founder SaaS.

This is intentionally lightweight.

## Secrets Lifecycle

- Store secrets only in the deployment platform or GitHub secrets.
- Never commit `.env` files.
- Rotate secrets after suspected exposure.
- Rotate production secrets when changing vendors or maintainers.
- Once a stack is selected, provide a `.env.example` with placeholder values only; keep it current and never include real values.

## Dependency Hygiene

- Use Dependabot or equivalent.
- Review security updates before merging.
- Avoid dependencies that are unmaintained, overbroad, or unnecessary.
- Prefer platform and standard-library features when possible.

## Access Control

- Use least privilege.
- Remove unused accounts and tokens.
- Separate development and production access where feasible.

## Incident Minimum

For any suspected security issue:

1. Contain the issue.
2. Preserve evidence.
3. Rotate relevant secrets.
4. Patch the issue.
5. Document what happened.
6. Add a regression check if possible.

## Third-Party Risk

Before adding a vendor:

- Why is it needed?
- What data does it receive?
- Can the platform already solve this?
- What is the cost?
- What is the lock-in risk?
- Is there a simpler alternative?
