---
name: decompose-problem
description: "Split a request into distinct problems and the decisions each one forces, then list them as a numbered map. Use whenever someone brings a mess, a complaint, a list of symptoms, a feature idea, or a request like sort this out / fix this / what should we do about X / should we build A or B / how do I approach X — anything that may tangle more than one problem. Trigger even when the request sounds like a straightforward fix, and even when the user sounds sure of the solution: the value is separating the problems before any of them gets solved. Do NOT trigger for a factual lookup, or for one specific error with an already-settled cause."
---

# Decompose problem

A single request often hides several problems inside what looks like one ask. This skill
is the check for that: run the split test, and if the request really does tangle more than
one problem, name them before any one of them gets worked on.

If the request really holds several distinct problems, surface them (below) then let the user choose where to start.

Or else it's really one problem, or nothing worth splitting, say so and carry on with the request as normal.

## What counts as a problem

Two candidates are genuinely different problems — split them — when they differ in any of:

- **stakeholder** — who feels the pain
- **failure mode** — what "broken" looks like
- **success metric** — how you'd measure "solved"
- **time horizon**
- **subsystem**

They're the same problem — keep them together — when one decision resolves both *and* they
share a stakeholder and a metric. When unsure, split; merging is the costlier mistake.

## How

Start from what the user thinks they asked for, then reveal the tangle:

> Sounds like you want to fix the top-up flow — but there are really four separate problems in here, and one change won't solve all of them.

Then lay out the map. Offer to take them one at a time; don't force an order.

While you're surfacing a split, hold off on solving any single one — that's the whole point of stopping to look. Once they're all on the table, the user picks where to go.

Name the problems, not the choices they force. "Cached column or ledger sum?" is solution language — it belongs to `consideration`, one problem at a time, after that problem's use cases and criteria exist. Here, stop at the problems.

Mark a problem the request only *implies*, not states, as **unconfirmed** until the user
agrees it's real. Cut anything with no concrete situation where someone actually hits it —
say so plainly rather than padding the map.

## Notation

A problem should be noted as Problen #1, #2,...

with a priority:
  - P0 - the definition of what the task is itself, meaning that the problem is that the task hasn't been fully implemented
	- P1 - the highest priority
	- P2 - medium priority, might not need immediately, but will do next phase
	- P3 - P6 - low priority, might not need to do this project
