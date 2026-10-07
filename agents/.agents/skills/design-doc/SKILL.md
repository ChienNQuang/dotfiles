---
name: design-doc
description: "Turn a request into a design doc: decompose, product layer first, high-level implementation plan, then technical design. Use when starting a non-trivial design or when the real problem is still unclear."
---

# Design doc

The top-level driver. It turns one request into a design doc by composing the family:
**decompose** the request → design the **product** layer first → derive a **high-level
implementation plan** → then the **technical** layer. This skill *orchestrates* — it holds
the load-bearing rule and the priority scale doc-wide, and hands each piece to the skill
that owns it. It does **not** redefine the split (`decompose-problem`), the ladder
(`consideration`), the layer content (`product-design`, `technical-design`), the doc's
layout (`design-doc-style`), or who-decides routing (`design-doc-decisions`).

## The flow

```
Decompose ─▶ Product design ─▶ High-level implementation plan ─▶ Technical design
```

Left is **slow, hard, high-value**; right is **fast once the left is solid**. Never work
right-to-left — mechanism before settled behaviour is the most common and most expensive
failure.

## Steps

1. **Decompose the request.** Run **`decompose-problem`** — it splits the request into
   distinct problems and emits the numbered **problem map** before any detail. It lists
   problems only; it does not name decisions, and neither do you at this stage. Each
   problem on the map is later reasoned to a decision by `consideration`, one at a time,
   up the full ladder.

2. **Product design — first, and finish it before mechanism.** Run **`product-design`**
   for the product layer (Business Rules → Requirements → Product Concepts → product
   considerations). This is the slow, high-value layer; a solid product layer is what
   makes the technical layer cheap. (UI Screens belong to the wider philosophy but are
   `⌚` out of scope for now — until a screen-design skill joins.)

3. **High-level implementation plan.** Once the product layer holds, turn it into an
   ordered **TODO list** — the bridge `technical-design` takes as input:
   - **High-level language only** — "deduct credits by usage", *not* "add a `deduct()`
     method to `LedgerService`". Mechanism altitude belongs in the technical layer.
   - **Order by effort × dependency** — prerequisites and unblocking work first;
     cheap-and-independent early; heavy-and-dependent later. `P0` items anchor the plan.
   - For the *layout* of this list (stage-grouped, abstract one-liners, checkboxes), use
     **`design-doc-style`**.

4. **Technical design.** Run **`technical-design`**, feeding it the plan. Each technical
   decision **traces to a Requirement it serves**; each technical fork → `consideration`.
   When an implementation finding invalidates a product or technical assumption,
   `technical-design`'s reroute sends it back up as a new consideration — the load-bearing
   rule in action.

## The load-bearing rule (holds across the whole doc)

`consideration`'s within-a-record rule, applied to the whole ladder: **the top shapes
everything below**, like courses of brick. A crack up top invalidates everything under it
— a wrong Business Rule invalidates the mechanism built to serve it. So:
- **Gate each layer before descending.** Product before plan, plan before technical.
- **Climb back, don't paper over.** If a lower layer exposes a crack in a higher one, fix
  the higher one — that is the reroute in step 4.

## Priority — one P0–P6 scale across the whole doc

`consideration` defines the scale (`P0` = the definition of the task itself; `P1` highest
… `P3`–`P6` maybe-not). The driver holds it **doc-wide**: it scopes which **problems** are
in, which **Requirements** ship now vs next phase, and the order of the **implementation
plan**. `P0` is what the task *is* — lose a `P0` and you're building something else.

Don't confuse the two numberings: problems from `decompose-problem` are `#1`, `#2`,
`#1.a`; priorities are `P0`–`P6`.

## Who owns what

| Concern | Skill |
|---|---|
| splitting a request into problems + the problem map | `decompose-problem` |
| one problem reasoned to a decision (product or technical) | `consideration` |
| the product layer's content | `product-design` |
| the technical layer's content + reroute | `technical-design` |
| how the doc is laid out / organised / split | `design-doc-style` |
| who decides a mid-work choice + where it's recorded (product → user; technical → you) | `design-doc-decisions` |

Notation (`⇒` decision · `❓` open · `⌚` deferred · `P0`–`P6`) is defined in
`consideration`; every layer uses it.
