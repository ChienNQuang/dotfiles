---
name: product-design
description: "Design the product layer — Business Rules, Requirements, Product Concepts, product considerations. Use when settling what a system must do, before any mechanism."
---

# Product design

Produces the **product layer**: WHAT the system does and how a stakeholder
experiences it. This is the **slow, hard, high-value** layer — a solid product layer
is what makes the technical layer cheap — so do it **first**, before any mechanism.
Every fork here decides *behaviour* (never mechanism) and is recorded by invoking
**`consideration`**.

The layer stacks **Business Rules → Requirements → Product Concepts**, each resting on
the one above — `consideration`'s load-bearing rule applied across the whole layer. A
crack up top invalidates everything below: climb back and fix it, don't paper over it.

## Steps

Build the content types in order. Everything is **use-cases-first** and stays at product
altitude — if a line names a table, id, column, or interval, it's mechanism pitched too
low: raise it, and push the detail down to the technical layer.

1. **Use cases first — is the problem real?**
   - Name the **concrete triggering scenarios** that force this project to exist: a
     customer request, a specific flow, a real limitation hit.
   - No concrete trigger → the problem is *suspected*, not real. Challenge it; don't
     document it as fact.
   - These are the evidence every Business Rule and Requirement below traces back to.

2. **Business Rules** — the highest-level description of the project's **output**.
   - Name the **components** the project must produce and the **expected outcome**.
   - Written so any stakeholder (Sales / PM / customer) gets the shape in one pass.
   - This is the **root** the rest of the layer derives from.

3. **Requirements** — the decided behaviours, **synthesized and threaded**, never
   transcribed as a flat list.
   - Find the requirement *behind* each phrasing, dedupe, and **thread** them: one
     **root** requirement the rest derive from, dependents nested under what they depend
     on, interactions explicit.
   - Each states an **observable behaviour** — no mechanism.
   - A resolved product consideration (step 5) **graduates up** into a Requirement here.

4. **Product Concepts** — the new **nouns** the behaviour introduces.
   - Define each by **behaviour, not implementation**: "a *credit entry* is immutable
     once written and signed" — not "a row in table X".
   - Every noun a rule leans on must be a defined Concept. Question a name that promises
     behaviour the system doesn't deliver — an `owner` that's only metadata.

5. **Product considerations** — one per fork.
   - A **fork** = a behaviour with more than one reasonable shape, or an edge case /
     limitation / constraint surfaced while designing. Settled → it's a Requirement
     (step 3); open → it's a consideration.
   - For each fork, **invoke `consideration`** — it climbs the ladder to a `⇒` (or an
     honest `❓` / `⌚`). A product consideration decides *behaviour the stakeholder
     experiences*, never mechanism.
   - Once `⇒`, fold the decision back up into Requirements (step 3).

## Worked shape

A product layer for a USD credit-ledger billing system — nothing lower:

> **Business Rules.** Keep a USD credit balance per account, top it up through Zoho
> Billing, debit it as AI usage is metered. Components: a credit **ledger**, a **top-up**
> flow, an **FX** step. Outcome: the balance always reflects every settled top-up and
> every metered debit, in USD.
>
> **Requirements** (threaded from a root):
> - The **ledger is the source of truth** for balance. `P0`
>   - every top-up appends a credit line; every metered use appends a debit line. `P0`
>   - balance is *derived* from the ledger, never stored on its own. `P0`
>   - a non-USD top-up converts to USD **when it's captured**, at a daily snapshot rate. `P1`
>
> **Product Concepts.**
> - **Credit entry** — append-only, immutable once written, signed (+ credit / − debit).
> - **Balance** — the running sum of entries; never set directly.
>
> **Product consideration** (→ `consideration`):
> - `❓` A metered debit that would take the balance negative — reject it, or allow it and
>   flag the account? Decides what the customer experiences; invoke `consideration`.

## Stay in lane

- **The decision-record format** — the Background → … → Decision ladder, notation
  (`⇒ ❓ ⌚`), `P0`–`P6`, scored residual risk — is **`consideration`**. Invoke it; don't
  restate the ladder.
- **Who decides & where it's recorded** — product / scope / policy calls go to the
  **user** and the high-level doc — is **`design-doc-decisions`**. Never make a product
  call silently.
- **How to lay the content out** in the doc (ladder of abstraction, bullets, rule
  matrices, companion splits) is **`design-doc-style`**.
- **UI Screens** — part of the wider product philosophy, but `⌚` out of scope here.
  Trigger: a screen-design skill joins the family.
