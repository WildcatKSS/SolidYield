Last Updated: 2026-07-24

# Phase 1 – Market Discovery: SolidYield

## Method and scope

This is a **focused validation of a single, founder-provided product idea** (SolidYield),
not the template's standard scan of ≥10 opportunities. That deviation is recorded as a
**Founder Override** in `docs/context/decisions-summary.md`, with follow-up tracked as
issue **O-006** (reconfirm the product choice against evidence at the MVP Gate).

Substantive risks are **not** waived: regulatory viability (criterion A) and
yield/unit-economics feasibility (criterion B) are assessed as explicit sections below.

Every claim and score in this document is an **assumption** based on general market
knowledge unless a source is named. No customer evidence has been collected yet; that is
Phase 2 work. Assumptions are marked as such and no validation evidence is invented.

The product idea itself is documented in the founder's business plan; the concise,
current definition being validated is: an online platform where consumers and businesses
deposit funds into a wallet and lock chosen amounts for fixed terms (3, 6, 12, 24, 36 or
60 months) at a predetermined fixed interest rate, with **interest paid out monthly** and
principal returned at the end of the term. The rate is the European base rate plus a fixed
markup that increases with term length. There is no separated e-money/investment-entity
structure; the platform operates as one integrated whole. Revenue is the margin between
the interest paid to users and the return earned on the deposited funds.

## Problem

A broad group of people and businesses have money they want to grow, but run into a
split in the market: either a regular savings account with a low rate that often lags
inflation, or investing with market risk, complexity, and the need for knowledge and time.
For those in between, there is no attractive, accessible option:

- **Savers** watch the purchasing power of their savings erode through low rates.
- **People without the time, knowledge or interest to invest** are effectively excluded
  from higher returns, because the existing route there demands expertise and effort they
  do not want to spend.
- **Entrepreneurs and self-employed (zzp'ers)** have business or private capital sitting
  idle and want it to earn a predictable return without tying it to market volatility.
- **Families** save toward a concrete goal on a horizon and want certainty about the
  outcome, not the uncertainty of the stock market.

Existing fixed-return alternatives (term deposits, bonds) feel outdated, cumbersome or
inaccessible to these groups, and their terms are often not transparent. The common
thread: a need for *a clear, predictable return on a fixed amount, without market risk and
without hassle.*

**Assumption (to validate):** that this combined group is large and dissatisfied enough to
switch to a new platform. No evidence collected yet.

## Target customer

- **Private savers** with surplus savings who are dissatisfied with low savings rates.
- **People without the time/knowledge/interest to invest**, but who want more than the
  savings rate.
- **Entrepreneurs and zzp'ers** who want business or private capital to earn a predictable
  return.
- **Families** saving toward a goal on a horizon (education, a home, pension top-up).

**Beachhead — deliberately left open.** Which subgroup is easiest to reach and convert
first is not decided here; it is an explicit question to validate in Phase 2 rather than
assume now.

## Market and alternatives

What SolidYield competes with, seen from the customer's point of view:

| Alternative | What it offers | Weakness SolidYield targets |
|---|---|---|
| Savings account (major bank) | Instant access, safe (deposit guarantee up to €100k) | Low rate, often lags inflation |
| Savings/deposits via savings platforms (e.g. Raisin) | Higher rate via foreign banks, fixed terms | Feels cumbersome/unfamiliar; fixed rate only at longer terms |
| Term deposit at own bank | Fixed, predictable rate | Dated UX, little flexibility in terms |
| Bonds / bond funds | Interest income, tradable | Market risk, complexity, knowledge needed |
| Broker / investing (e.g. Trade Republic, DEGIRO) | Potentially higher return; some pay interest on cash | Market risk, choice stress, no fixed outcome |
| P2P lending / crowdfunding (e.g. Mintos) | High rate | Higher risk, less transparent/regulated, defaults |
| Doing nothing / current account | Full flexibility | 0% rate, loss of purchasing power |

**Positioning (assumption):** SolidYield sits in the gap between "safe but low" (saving) and
"high but risky/complex" (investing), with its promised differentiators being a fixed,
pre-known rate + monthly payout + transparent terms + a modern digital UX, without the
customer having to invest.

**Key caveat (assumption; feeds criteria A and B):** the safe alternatives above are safe
because they fall under deposit guarantees or strict regulation. SolidYield promises a
*fixed* rate but carries the return risk itself — so the "safe feeling" the target group
wants must be delivered without the guarantees banks do have. That is exactly what criteria
A and B must examine.

## A) Regulatory viability

**Not legal advice.** This section names the regulatory question as a gate-determining
unknown. Everything here is an assumption to be confirmed by a qualified financial-law
adviser (counsel) in Phase 2.

**Core question:** may this be offered in the EU/NL, and if so, under which licence or
structure?

**Why this is the determining question (assumptions, to be confirmed by counsel):**

- **Attracting repayable funds from the public.** Taking money from consumers with a
  promise to repay it (with interest) closely resembles *attracting repayable funds*
  (opvorderbare gelden), which in NL is in principle prohibited without a banking licence
  (Wft), supervised by DNB. This is historically the primary red flag for regulators.
- **Dropping the separated structure increases this.** In the original plan the separation
  (e-money institution + a separate investment entity) served precisely to operate
  *without* a licence. With it removed, the activity is more likely to fall fully within
  licensed territory.
- **Promising interest while generating the return yourself.** Depending on how the return
  is generated, this can touch investment services (MiFID), management of an investment
  fund (AIFMD), or an offer of securities with a prospectus obligation.
- **Structural risk (feeds criterion B).** If monthly interest payouts and principal
  returns were to come (partly) from new deposits rather than from a genuinely earned
  return, the structure becomes the kind regulators scrutinise most heavily. Viability
  hangs entirely on a real, safe return — that is criterion B.

**Two €100,000 thresholds — do not conflate them:**

- **Deposit guarantee (DGS): €100k.** A *protection* amount (per person, per licensed
  bank). It does not change whether a licence is required; the prohibition on attracting
  repayable funds applies regardless of amount.
- **Exemption threshold: €100k.** Attracting repayable funds (and offering without a
  prospectus) is often exempt when aimed solely at professional/qualified parties, or in
  denominations/amounts of at least €100,000 per participant. Above that per-participant
  threshold the retail-protection rationale falls away and a lighter regime may apply.

**Two scenarios to validate legally in Phase 2:**

- **Scenario Retail** — open to everyone, low minimum deposit. Serves the target groups
  defined above (savers, families, zzp'ers). Carries the **heaviest** licensing question;
  likely requires a licence or operating under an existing licence holder.
- **Scenario ≥ €100k / professional** — minimum deposit of €100,000 per participant, or
  restricted to professional/qualified parties. May fall under a **lighter** regime, but
  narrows the audience to high-net-worth individuals / professional parties and largely
  excludes the current retail target group. **Kept open as a serious strategic option**,
  not merely a legal check.

  The two scenarios are a genuine strategic fork: the €100k route may be *legally* easier
  but is *commercially* narrower (away from mass retail). This is a trade-off, not a free
  fix. Exact conditions (per-participant vs aggregate, interaction with MiFID/AIFMD/e-money,
  ongoing conduct rules) determine whether it actually helps — counsel must confirm.

**Possible compliant directions to research in Phase 2 (assumptions, non-exhaustive):**

- Operate *under* an existing licence holder (bank/investment firm) as an intermediary /
  technology layer, rather than attracting the funds yourself.
- Reintroduce a legally confirmed separated structure (back toward the original plan).
- The ≥ €100k / professional scenario above.

**Preliminary verdict on A:** **gate-determining and uncertain.** Without confirmation from
a qualified financial-law adviser that a legal route exists, the idea cannot proceed to
build. This is not a "no" but a **"confirm legally first"**, with two routes to test: the
Retail scenario and the ≥ €100k / professional scenario.

<!-- Sections still to be built with founder review:
     B) Yield / unit-economics feasibility;
     Competition; Distribution; Willingness to pay/adopt; Scoring; Verdict. -->
