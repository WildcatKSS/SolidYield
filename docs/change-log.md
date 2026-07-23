# Change Log

## Unreleased

## 1.1.0 – 2026-07-23

### Added
- `docs/sales/b2c-acquisition-channels.md`: consumer counterpart to the outbound B2B templates, with per-channel first tests and cost signals

### Changed
- Broadened template scope from B2B SaaS to SaaS or digital service (B2B or B2C); reworded CLAUDE.md, README, vision non-negotiables, Phase 1 prompt, phase gates, security baseline and threat model accordingly (ADR-003)
- Governance check now matches product code in common layouts (src, app, lib, server, api, pages, components, prisma, migrations) instead of only src/ and prisma/, so implementation cannot bypass the MVP Gate; list to be narrowed in the tech-stack ADR
- Validation plan carries separate B2B and B2C minimum-evidence thresholds; interview script gains B2C variants of the budget/decision-maker questions; MVP Gate defines the B2C reading of "first 10 customers"
- Outbound email/LinkedIn templates marked as B2B channels

### Fixed
- Bootstrap reset left `docs/vision.md` citing the deleted ADR-003; the inline citation is removed so fresh copies have no dangling references
- Documentation style guide showed identical Good/Avoid path examples
- Bootstrap changelog reset was missing the Removed section

## 1.0.0 – 2026-07-22

### Added
- Product-neutral Claude Code SaaS starter
- `scripts/bootstrap.sh init`: resets template repository memory in a fresh copy (change log, template ADRs, decision registers, context files), with `--dry-run` and `--owner` options

### Changed
- Consolidated Definition of Done and ADR template to single canonical versions (ADR-001)
- Aligned CLAUDE.md governance hierarchy with the governance charter
- Rewrote README to a single start procedure
- Hardened governance CI checks: anchored keyword matching, dependency-bot exemption, real freshness dates

### Removed
- Pre-committed stack files (docker-compose.yml, .env.example) to restore product neutrality
- One-off governance audit snapshot reports
- Empty pre-numbered ADR stubs
- Redundant decision-template.md; decision format is owned by the decision framework (ADR-002)
- npm ecosystem entry in dependabot.yml; it produced config warnings without a manifest and returns with the tech-stack ADR

### Fixed
- MVP Gate CI check was vacuous: it matched the word "Approved" in the unapproved template's option line; it now requires a literal `MVP Gate Approved: Yes` (ADR-002)

### Security
- Expanded security requirements to a product-neutral B2B SaaS baseline: multi-tenant isolation, session management, rate limiting, encryption, audit logging (ADR-002)
- Added a baseline multi-tenant SaaS threat model (ADR-002)
