# Lean Engineering Principles

## Purpose

Lean Engineering exists to maximize delivered customer value while minimizing code, dependencies, complexity, operational burden and maintenance cost.

The best code is the code that never has to be written.

The second-best code is the smallest correct implementation.

Lean does not mean careless. Lean means deliberately choosing the smallest safe solution that satisfies the validated business need.

---

## Decision Ladder

Before writing any code, stop at the first rung that solves the problem.

1. Does this need to be built at all?
2. Can the existing product workflow solve it?
3. Can documentation solve it?
4. Can a process change solve it?
5. Does the standard library already solve it?
6. Does the platform already provide it?
7. Does an already-installed dependency solve it?
8. Can existing code be modified instead?
9. Can existing code be deleted instead?
10. Can this be implemented as a single simple change?
11. Only then write new code.

---

## Core Principles

## Build Less

Every line of code creates future maintenance obligations.

Prefer:
- deletion over addition
- modification over expansion
- simplification over abstraction
- existing capabilities over custom implementations
- boring solutions over clever solutions

## No Premature Abstractions

Do not create reusable frameworks, plugin systems, extension mechanisms, generic architectures or shared libraries unless there is demonstrated repetition and business need.

The first implementation may be specific.

Abstraction is earned through repeated evidence.

## Dependencies Are Liabilities

Every dependency adds:
- security risk
- upgrade risk
- operational risk
- cognitive load
- maintenance cost

Before adding a dependency:
1. Check standard library.
2. Check platform capabilities.
3. Check existing dependencies.
4. Justify why the dependency is worth the cost.

If the dependency is not clearly beneficial, do not add it.

## Configuration Is Complexity

Do not add configuration without a real use case.

Every configuration option increases:
- testing burden
- support burden
- documentation burden
- maintenance cost

Prefer sensible defaults.

---

## Deletion First

Before adding code ask:

- Can existing code be removed?
- Can multiple implementations become one?
- Can this feature be eliminated?
- Can this requirement be simplified?
- Can another workflow absorb this requirement?

Removing code is often the highest ROI engineering change.

---

## MVP Bias

Prefer:
- one customer solved well
- one workflow solved well
- one problem solved well
- one paid use case solved well

over:
- broad feature sets
- complex customization
- speculative functionality
- enterprise flexibility before enterprise customers

---

## Non-Negotiables

Lean Engineering never reduces:

- security
- authentication
- authorization
- input validation
- data integrity
- error handling that prevents data loss
- accessibility
- observability needed to diagnose production failures
- compliance obligations
- calibration required by real hardware or external systems

Security shortcuts are defects, not optimizations.

---

## Trust Boundaries

All external input must be validated.

Examples:
- HTTP requests
- forms
- webhooks
- uploaded files
- environment variables
- third-party APIs
- CLI arguments
- database records from untrusted sources

Assume external input is hostile until validated.

---

## Observability Requirement

Production systems must provide enough information to diagnose failures.

At minimum:
- meaningful logs
- actionable error messages
- visibility into critical flows
- failure signals for payment/auth/core workflow

If a production failure cannot be diagnosed, the implementation is incomplete.

---

## Intentional Simplifications

When deliberately choosing a simpler implementation, document the shortcut with a `lean:` comment.

Format:

```text
lean:
Reason:
Current limitation:
Upgrade path:
```

Example:

```text
lean:
Reason: linear scan is simpler and dataset is expected to remain under 1,000 records.
Current limitation: performance degrades at larger scale.
Upgrade path: add indexed lookup when benchmark or customer usage requires it.
```

---

## Verification Rule

Every non-trivial implementation must leave behind one minimal verification mechanism.

Acceptable examples:
- assert-based self-check
- small unit test
- integration test
- reproducible validation script
- smoke test

The verification should be the smallest thing that fails when the logic breaks.

Trivial one-line operations do not require tests.

---

## Cost Awareness

Engineering decisions must consider:
- development cost
- operational cost
- infrastructure cost
- support cost
- AI/API cost
- maintenance cost
- cognitive cost for future sessions

The cheapest correct solution wins.

---

## Final Rule

Every implementation must answer:

Why does this need to exist?

If the answer is unclear, do not build it.
