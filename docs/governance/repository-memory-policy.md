# Repository Memory Policy

## Purpose

Claude Code can lose context between sessions. Repository memory prevents drift.

## Required Session Start Files

At the start of every session, read:

- `CLAUDE.md`
- `docs/project-status.md`
- `docs/context/current-state.md`
- `docs/context/decisions-summary.md`
- `docs/context/open-issues.md`
- `docs/context/next-session.md`
- `docs/risk-register.md`
- `docs/unit-economics.md`
- `docs/scope-control.md`
- `docs/governance/lean-engineering.md`

## Required Session End Updates

After meaningful work, update:

- `docs/project-status.md`
- `docs/context/current-state.md`
- `docs/context/decisions-summary.md` if decisions changed
- `docs/context/open-issues.md` if issues changed
- `docs/context/next-session.md`
- `docs/risk-register.md` if risks changed

## Rule

If context files are stale, update them before new work.

## Protected Files

These files must never be deleted:

- docs/context/current-state.md
- docs/context/decisions-summary.md
- docs/context/open-issues.md
- docs/context/next-session.md
- docs/project-status.md
