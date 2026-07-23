#!/usr/bin/env bash
set -euo pipefail

BASE_REF="${BASE_REF:-origin/main}"

fail() {
  echo "❌ $1"
  exit 1
}

warn() {
  echo "⚠️  $1"
}

pass() {
  echo "✅ $1"
}

required=(
  "CLAUDE.md"
  "README.md"
  "docs/security-requirements.md"
  "docs/governance/governance-charter.md"
  "docs/governance/source-of-truth.md"
  "docs/governance/documentation-style-guide.md"
  "docs/governance/lean-engineering.md"
  "docs/governance/definition-of-ready.md"
  "docs/governance/definition-of-done.md"
  "docs/governance/phase-gates.md"
  "docs/governance/decision-framework.md"
  "docs/governance/change-management.md"
  "docs/governance/repository-memory-policy.md"
  "docs/governance/founder-override.md"
  "docs/governance/governance-index.md"
  "docs/project-status.md"
  "docs/scope-control.md"
  "docs/unit-economics.md"
  "docs/product/mvp-gate.md"
  "docs/context/current-state.md"
  "docs/context/decisions-summary.md"
  "docs/context/open-issues.md"
  "docs/context/next-session.md"
)

for file in "${required[@]}"; do
  [[ -f "$file" ]] || fail "Missing required governance file: $file"
done
pass "Required governance files exist."

grep -q "lean-engineering.md" CLAUDE.md || fail "CLAUDE.md must reference docs/governance/lean-engineering.md"
grep -q "repository-memory-policy.md" CLAUDE.md || fail "CLAUDE.md must reference docs/governance/repository-memory-policy.md"
pass "CLAUDE.md references core governance."

for file in docs/project-status.md docs/context/current-state.md docs/context/next-session.md docs/scope-control.md docs/unit-economics.md docs/product/mvp-gate.md; do
  [[ -s "$file" ]] || fail "$file is empty."
done
pass "Critical context and governance documents are non-empty."

if find . \( -name ".env" -o -name ".env.local" -o -name ".env.production" \) -not -path "./node_modules/*" | grep -q .; then
  fail "Committed environment file detected."
fi
pass "No committed environment files detected."

# ADR template quality fields.
if [[ -f "docs/adrs/ADR-template.md" ]]; then
  grep -q "Decision Confidence" docs/adrs/ADR-template.md || fail "ADR template missing Decision Confidence."
  grep -q "Evidence Source" docs/adrs/ADR-template.md || fail "ADR template missing Evidence Source."
  grep -q "ADR Quality Checklist" docs/adrs/ADR-template.md || fail "ADR template missing Quality Checklist."
fi
pass "ADR template contains required quality fields."

# Freshness metadata must contain a real date, not a placeholder.
for file in docs/project-status.md docs/context/current-state.md docs/context/next-session.md; do
  grep -Eq "Last Updated: [0-9]{4}-[0-9]{2}-[0-9]{2}" "$file" \
    || fail "$file missing a valid 'Last Updated: YYYY-MM-DD' date."
done
pass "Freshness metadata contains valid dates."

# Determine changed files if possible.
changed=""
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if git rev-parse "$BASE_REF" >/dev/null 2>&1; then
    changed="$(git diff --name-only "$BASE_REF"...HEAD || true)"
  else
    changed="$(git diff --name-only HEAD~1...HEAD 2>/dev/null || true)"
  fi
fi

# Automated dependency updates cannot author ADRs or context updates.
if [[ "${GITHUB_ACTOR:-}" == dependabot* || "${GITHUB_ACTOR:-}" == renovate* \
   || "${GITHUB_HEAD_REF:-}" == dependabot/* || "${GITHUB_HEAD_REF:-}" == renovate/* ]]; then
  warn "Dependency-bot change detected; skipping diff-based governance checks."
  changed=""
fi

# Keywords are matched as whole path segments/words (bounded by / . _ -)
# so that e.g. "email.md" does not trigger the "ai" rule.
usage_keywords='(^|[/._-])(openai|anthropic|ai|llm|stripe|billing|subscriptions?|usage|quotas?|rate-?limits?|tokens?|webhooks?)([/._-]|$)'
security_keywords='(^|[/._-])(auth|authn|authz|authentication|authorization|middleware|security|permissions?|roles?|access)([/._-]|$)'

# Product code can live in different layouts depending on the stack, which is
# not selected yet. Keep this list broad so implementation cannot bypass the
# MVP Gate by living outside src/; narrow it in the tech-stack ADR.
product_code_paths='^(src|app|lib|server|api|pages|components|prisma|migrations)/'

if [[ -z "$changed" ]]; then
  warn "No git diff available; running baseline governance checks only."
else
  echo "Changed files:"
  echo "$changed"

  # Context memory must be updated in meaningful PRs.
  if echo "$changed" | grep -E "$product_code_paths|^(docs/|\.github/workflows/|package.json|pnpm-lock.yaml|package-lock.json|yarn.lock|docker-compose.yml)" >/dev/null; then
    echo "$changed" | grep -E '^(docs/project-status.md|docs/context/current-state.md|docs/context/next-session.md)' >/dev/null \
      || fail "Meaningful changes require updates to project-status.md, current-state.md or next-session.md."
  fi

  # Product implementation requires MVP Gate approval.
  if echo "$changed" | grep -E "$product_code_paths" >/dev/null; then
    grep -Eq '^MVP Gate Approved:[[:space:]]*Yes[[:space:]]*$' docs/product/mvp-gate.md \
      || fail "Product implementation changed, but MVP Gate is not marked 'MVP Gate Approved: Yes'."

    echo "$changed" | grep -E '^docs/scope-control.md$' >/dev/null \
      || fail "Product implementation changed; docs/scope-control.md must be updated or reviewed in the same PR."

    echo "$changed" | grep -E '^docs/context/' >/dev/null \
      || fail "Product implementation changed; context memory must be updated."
  fi

  # Architecture/security/dependency/deployment-impacting changes require ADR.
  if echo "$changed" | grep -E '^(docs/architecture|docs/security|docs/security-requirements.md|\.github/workflows/|package.json|pnpm-lock.yaml|package-lock.json|yarn.lock|docker-compose.yml|infrastructure/)' >/dev/null; then
    echo "$changed" | grep -E '^docs/adrs/ADR-.*\.md$' >/dev/null \
      || fail "Architecture/security/dependency/deployment-impacting change detected; update or add an ADR."
  fi

  # Security-sensitive code changes require ADR updates.
  if echo "$changed" | grep -Ei "$security_keywords" >/dev/null; then
    echo "$changed" | grep -E '^docs/adrs/ADR-.*\.md$' >/dev/null \
      || fail "Security-sensitive change detected; update or add an ADR."
  fi

  # AI/API/billing/usage-heavy changes require unit economics review.
  if echo "$changed" | grep -Ei "$usage_keywords" >/dev/null; then
    echo "$changed" | grep -E '^docs/unit-economics.md$' >/dev/null \
      || fail "AI/API/billing/usage-related change detected; docs/unit-economics.md must be updated or reviewed."
  fi

  # Feature requests or product docs require scope control alignment.
  if echo "$changed" | grep -E '^(docs/product/|docs/prd.md|docs/acceptance-criteria.md|\.github/ISSUE_TEMPLATE/feature_request.md)' >/dev/null; then
    echo "$changed" | grep -E '^(docs/scope-control.md|docs/product/mvp-gate.md|docs/acceptance-criteria.md)' >/dev/null \
      || fail "Product/feature change detected; scope-control, MVP Gate or acceptance criteria must be updated."
  fi
fi

pass "Governance enforcement completed."
