---
name: decompose-problem
description: "Split a request into separate problems and list them as a numbered map. Use when someone brings a mess, a complaint, a list of symptoms, a feature idea, or a request like sort this out / fix this / what should we do about X / should we build A or B / how do I approach X. Trigger even when the request sounds like a simple fix, and even when the user sounds sure of the answer — the value is separating the problems before any of them gets solved. Do NOT trigger for a factual lookup, or for one specific error with a known cause."
---

# Decompose problem

One request often hides several problems inside what looks like a single ask. This skill is the
check for that.

Run the test below. If the request really holds more than one problem, name them all before
anyone starts solving one. If it is really one problem, say so in a line and carry on with the
request as normal — do not force a map onto a simple ask.

## What counts as a separate problem

Two things are **separate problems** — split them — if they differ in any of these:

| Test | Question |
|---|---|
| Stakeholder | Who feels the pain? |
| Failure mode | What does "broken" look like? |
| Success metric | How would you measure "solved"? |
| Time horizon | Does one need fixing now and the other next quarter? |
| Subsystem | Do they live in different parts of the system? |

They are the **same problem** if one decision fixes both, *and* they share a stakeholder and a
metric.

When you are not sure, split. Merging two problems is the more expensive mistake: you end up
with one solution that half-solves both.

## How to run it

Start from what the user thinks they asked for, then show what is actually in there:

> Sounds like you want to fix the top-up flow. There are really four separate problems in here,
> and one change won't solve all of them.

Then list them. Offer to take them one at a time. Do not choose the order for the user.

**While you are splitting, do not solve any of them.** That is the whole job of this step. Once
they are all listed, the user picks where to start.

**Name the problems, not the choices they force.** "Cached column or ledger sum?" is a choice,
not a problem. Choices belong to `consideration`, one problem at a time, after that problem has
use cases and criteria.

- Wrong: "Should we cache the balance or sum the ledger?"
- Right: "Reading a balance gets slower as an account gets older."

## Two things to mark

- **Unconfirmed.** If the request only *implies* a problem and does not state it, mark it
  unconfirmed until the user agrees it is real.
- **Cut it.** If you cannot name a real situation where someone hits it, say so plainly and drop
  it. Do not pad the map to look thorough.

## How to write the map

Number them `#1`, `#2`, `#3`. Sub-problems get `#1.a`, `#1.b`.

Give each one a priority (`P0`–`P6`, defined in `design-protocol`):

- `P0` — this is what the task **is**. The problem is that the task is not done yet.
- `P1` — highest priority.
- `P2` — medium. Not needed now, but next phase.
- `P3`–`P6` — low. May never be needed for this project.

Example:

```
#1  P0  A metered debit can take the balance below zero, and nothing stops it.
#2  P1  Reading a balance gets slower as an account collects entries.
#3  P2  Non-USD top-ups have no agreed conversion time.  (unconfirmed)
#4  P4  Admins have no view of usage per day.
```

Keep each line to one sentence. Detail belongs in the consideration for that problem, not here.

## After the map

The user picks one. That problem then goes to `consideration`, which decides its size and works
it through.

Do not run considerations for all of them at once.

## Related

- `design-protocol` — priorities, notation, and how the session runs.
- `consideration` — takes one problem from this map and works it to a decision.
- `design-doc` — the driver that runs this first, then the product layer.
