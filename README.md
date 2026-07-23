# Claude Code Production SaaS Starter

A product-neutral, governance-first starter repository for building a production-ready SaaS or digital service (B2B or B2C) with Claude Code.

This template is intentionally not tied to a specific product or customer type. It is designed to become the operating system for a SaaS or digital-service project once a product direction is selected and validated.

## What This Includes

- Claude Code master instructions
- Phase-specific prompts
- Repository memory system
- Governance hierarchy
- ADR system
- MVP Gate
- Definition of Done
- Unit economics framework
- Scope control system
- Commercial validation kit
- Customer interview scripts
- Sales and launch templates
- Security and compliance templates
- Observability planning
- GitHub PR and issue templates
- CI/security/release workflow skeletons

## How To Use

1. Copy this template into a new GitHub repository. Marking the source repository as a GitHub "Template repository" is recommended: "Use this template" then gives every copy a fresh git history.
2. Run `scripts/bootstrap.sh init --owner @your-github-name` in the copy. This resets the template's own repository memory (change log, template ADRs, decision registers, context files) to a clean starting state dated today. Use `--dry-run` first to preview.
3. Open Claude Code in the repository and start with the command below.
4. Do not allow product code until the MVP Gate is approved.
5. Keep `docs/context/` updated after every session.

## Recommended First Claude Command

```text
Read CLAUDE.md, docs/governance/governance-index.md, docs/governance/repository-memory-policy.md, docs/project-status.md, docs/context/current-state.md, and docs/context/next-session.md. Confirm the current phase and perform only that phase's work. Do not write product code until the MVP Gate is approved.
```

## Core Rule

```text
No product implementation before business validation, MVP Gate approval and Lean Engineering review.
```

## Template Philosophy

This template treats documentation as the repository memory and source of truth. This helps Claude Code stay consistent across multiple sessions and prevents product, architecture, and scope drift.

Governance is enforced, not just described: `scripts/check-governance.sh` runs in CI via `.github/workflows/governance.yml`.

## Important Limitation

No template can prove market demand. Customer interviews, pricing tests, waitlists, outreach, and actual payment intent remain mandatory.
