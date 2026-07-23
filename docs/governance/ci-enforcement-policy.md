# CI Enforcement Policy

## Purpose

CI enforcement keeps governance lightweight but real.

The goal is not bureaucracy. The goal is to prevent Claude Code and maintainers from drifting away from the operating rules.

## Enforced Checks

The governance workflow enforces:

- required governance documents exist
- critical context documents are non-empty
- `CLAUDE.md` references Lean Engineering and Repository Memory
- committed `.env` files are blocked
- meaningful changes update project context
- product implementation requires MVP Gate approval
- product implementation requires Scope Control review
- architecture, security, dependency and deployment changes require ADR updates
- AI, API, billing and usage-related changes require Unit Economics review

## Product Code Paths

The check treats a broad default list of directories as product code (src, app, lib, server, api, pages, components, prisma, migrations) so implementation cannot bypass the MVP Gate by living outside `src/`. Narrow this list to the real layout in the tech-stack ADR.

## Intentional Limits

CI does not attempt to judge business quality.

CI cannot know if customer validation is true.

CI cannot know if a PR checkbox was filled honestly.

Those remain human and Claude Code responsibilities.

## Founder Override

If a rule must be bypassed, use `docs/governance/founder-override.md`.

The override must include:

- reason
- risk
- expiry or cleanup action
- owner

## Local Usage

Run:

```bash
bash scripts/check-governance.sh
```

For PR-like checks locally, provide a base ref:

```bash
BASE_REF=origin/main bash scripts/check-governance.sh
```
