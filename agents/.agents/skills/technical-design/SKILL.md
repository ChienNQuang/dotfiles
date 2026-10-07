---
name: technical-design
description: "Design the technical layer for a work or personal product from settled product requirements: surface consequential technical forks, trace each to the requirement it serves, and reroute broken assumptions. Use only when delivering a product change whose implementation still needs meaningful architectural decisions. Do not infer product intent merely from a request to change code or configuration; do not use for dotfiles, environment setup, general tooling, routine maintenance, or an isolated fix unless explicitly framed as product development."
---

# Technical design

Produces the **technical layer**: the **mechanism** — *how* the system is delivered. Its
content is a set of **technical considerations** surfaced while designing and building,
each tracing to the **product behaviour it serves**, plus the **reroute** discipline that
stops implementation findings from silently drifting the product.

It follows **`product-design`** and is **fast** once the product is solid: behaviour is
already settled, so this layer only decides *how*. Mechanism rests on behaviour —
load-bearing — so don't start here until the product layer holds.

## Input — the high-level implementation plan

Required. A list of TODOs ordered by **effort × dependency**, each in high-level language
("implement credit top-up", "ensure the ledger balances"), never "add this method to this
class". `design-doc` produces it.

- **No plan, or the product layer still has open `❓`s that matter?** Stop and run
  `product-design` first. Mechanism built on unsettled behaviour is rework waiting to
  happen.

## Steps

1. **Walk the plan** in order. Each TODO names a behaviour to deliver, not a mechanism.
2. **Surface the technical forks it forces.** A fork = more than one reasonable
   *mechanism*: schema shape, data flow, idempotency, concurrency, library choice,
   algorithm, caching. An obvious / settled mechanism needs no consideration; a genuine
   fork does.
3. **Each fork → invoke `consideration`.** A technical consideration decides mechanism
   (not behaviour) and is *yours* to decide (see `design-doc-decisions`).
4. **Trace every decision up.** Tag each `serves: <the Requirement it delivers>`. A
   decision that serves no stated behaviour is an **orphan** — cut it, or you've found an
   unstated behaviour to surface back into the product layer.

## Reroute — the distinctive job

Implementation is where assumptions meet reality. When building surfaces a **finding that
invalidates an assumption** — product ("balances are exact to the cent") or technical
("the FX rate is available synchronously") — **do not code around it.** That buries a
design change inside a commit, silently.

Route the finding back into a **new consideration**:

| Finding invalidates a… | New consideration | Decided by |
|---|---|---|
| **product / behaviour / scope / policy** assumption | a product consideration, back in the product layer | user (via `design-doc-decisions`) |
| **technical** assumption | a technical consideration, here | you |

- **Back up, not around.** The top of the ladder shapes the bottom; a cracked product
  assumption invalidates every technical decision resting on it. Coding around it hides
  the crack until it's expensive.
- **The finding is the trigger.** Feed it in as the new consideration's concrete
  triggering scenario (use-case level) — evidence the problem is real, not a hunch.
- **Unsure product or technical?** Treat it as product and ask — a cheap question beats
  an unwanted product change.

## Example — AI Billing

Plan TODO: *"implement credit top-up in the USD ledger."* Mid-build you find Zoho returns
the FX rate with a lag, not synchronously.
- **Don't** quietly cache yesterday's rate and move on — that silently decides a product
  behaviour.
- **Do** reroute: is "top-ups convert at the live rate" a product behaviour? → product
  call → `design-doc-decisions` → ask → user confirms a daily rate is fine → record in
  the product layer → *then* the technical consideration ("how to source and store the
  daily rate") traces `serves:` it.

## Stay in lane

- **`consideration`** — the record format every fork (technical, or rerouted-to-product)
  is written in. Invoke it; don't restate the ladder.
- **`product-design`** — the layer this one follows; where rerouted product findings land.
- **`design-doc-decisions`** — who-decides routing when a finding turns out to be a
  product call, and where each consideration is recorded.
