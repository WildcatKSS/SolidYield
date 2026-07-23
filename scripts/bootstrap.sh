#!/usr/bin/env bash
set -euo pipefail

# Template bootstrap.
#
# Usage:
#   scripts/bootstrap.sh init [--owner @github-owner] [--dry-run]
#
# Run `init` once in a fresh copy of this template. It resets the template's
# own repository memory (change log, template ADRs, decision registers,
# context files) to a clean starting state for a new product, dated today.
#
# After product and stack selection, extend this script with install/setup
# commands for the chosen stack.

cmd="${1:-}"

if [[ "$cmd" != "init" ]]; then
  echo "Product-neutral template bootstrap."
  echo
  echo "Usage: scripts/bootstrap.sh init [--owner @github-owner] [--dry-run]"
  echo
  echo "  init       Reset template repository memory for a new product copy."
  echo "  --owner    Set the CODEOWNERS owner (e.g. --owner @your-github-name)."
  echo "  --dry-run  Show what would change without writing anything."
  exit 0
fi
shift

owner=""
dry_run=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    --owner) owner="${2:?--owner requires a value}"; shift 2 ;;
    --dry-run) dry_run=true; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

today="$(date +%F)"

say() { echo "→ $1"; }

write() {
  local path="$1"
  if $dry_run; then
    say "[dry-run] would reset $path"
    cat >/dev/null
  else
    cat > "$path"
    say "reset $path"
  fi
}

remove() {
  local f
  for f in "$@"; do
    if [[ -e "$f" ]]; then
      if $dry_run; then say "[dry-run] would remove $f"; else rm "$f"; say "removed $f"; fi
    fi
  done
}

# Template ADRs describe the template's own construction, not this product.
remove docs/adrs/ADR-0*.md

write docs/change-log.md <<EOF
# Change Log

## Unreleased

## Added

## Changed

## Removed

## Fixed

## Security
EOF

write docs/tech-decisions.md <<EOF
# Technical Decisions Summary

| ADR | Decision | Status | Date |
|---|---|---|---|

## Pending Decisions

The following decisions require an ADR before implementation. ADRs are created from \`docs/adrs/ADR-template.md\` when the decision is actually made, not in advance.

- Product selection
- Tech stack
- Authentication
- Billing
- Observability
- Deployment platform
EOF

write docs/context/decisions-summary.md <<EOF
# Decisions Summary

| Date | Decision | Rationale | ADR |
|---|---|---|---|
| $today | Documentation is source of truth | Prevents Claude context drift | |
| $today | Product-neutral until selection | Prevents premature implementation | |
| $today | MVP Gate before code | Prevents building unvalidated product | |
EOF

write docs/context/open-issues.md <<EOF
# Open Issues

| ID | Issue | Priority | Status |
|---|---|---|---|
| O-001 | Product not selected | High | Open |
| O-002 | Target customer unknown | High | Open |
| O-003 | Pricing unknown | High | Open |
| O-004 | Stack not finalized | Medium | Open |
| O-005 | Deployment platform unknown | Medium | Open |
EOF

write docs/project-status.md <<EOF
Last Updated: $today

# Project Status

## Current Phase

Phase 0 – Repository Governance Foundation

## Current Objective

Prepare the product-neutral template for product selection.

## Completed

- Claude Code operating system
- Governance documents with CI enforcement
- Context memory system
- ADR structure
- Scope control
- MVP Gate template
- Commercial validation kit
- Compliance/security templates
- GitHub templates and workflow skeletons

## Open Decisions

- Product category
- Target customer
- Pricing
- Final tech stack
- Deployment platform
- Auth provider
- Observability vendor

## Open Risks

See docs/risk-register.md.

## Next Milestone

Phase 1 – Market Discovery

## Next Session Instruction

Read CLAUDE.md and docs/prompts/phase-1-market-discovery.md. Do not write product code.
EOF

write docs/context/current-state.md <<EOF
Last Updated: $today

# Current State

## Summary

Repository is a freshly initialized product-neutral starter template for a SaaS or digital service (B2B or B2C). No product has been selected.

## Active Phase

Phase 0 complete / Phase 1 ready.

## Current Objective

Use market discovery and validation before any product implementation.

## Constraints

- No product code before MVP Gate
- No product assumptions without documentation
- No architecture commitment without ADR
EOF

write docs/context/next-session.md <<EOF
Last Updated: $today

# Next Session

## Recommended Prompt

Read CLAUDE.md and docs/prompts/phase-1-market-discovery.md. Start Phase 1. Do not write product code.

## Expected Output

- 10 SaaS or digital-service opportunities (B2B or B2C)
- Scored shortlist
- Top 3 candidates
- Recommendation only if score threshold is met

## Do Not

- Do not write implementation code
- Do not choose a product without scoring
- Do not invent validation evidence
EOF

write docs/unit-economics.md <<EOF
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
EOF

if [[ -n "$owner" ]]; then
  write .github/CODEOWNERS <<EOF
* $owner
EOF
fi

if $dry_run; then
  say "[dry-run] no files were changed."
else
  say "Template memory reset for a new product (dated $today)."
  say "Running governance checks..."
  bash scripts/check-governance.sh
fi
