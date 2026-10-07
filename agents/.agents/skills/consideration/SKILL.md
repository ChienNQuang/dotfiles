---
name: consideration
description: "Reason through and record one consequential decision about a work or personal product. Use when the user is creating, defining, or materially evolving a product and a product-behavior or product-implementation choice has multiple reasonable answers, or a related open question must be recorded. Do not infer product intent merely from a request to change code or configuration; do not use for dotfiles, environment setup, general tooling, routine maintenance, or an isolated fix unless the user explicitly frames that work as product development."
---

# Consideration

A consideration records the reasoning behind one thing that we need to solve or decide.
That thing can be a problem, a choice between several possible behaviours or
mechanisms, or an edge case nobody has handled yet. A consideration has seven sections,
written in order. It ends in a decision, or in an open question when the information to
decide is missing.

Product and technical considerations use the same sections. A product consideration
decides how the system behaves for a stakeholder. A technical consideration decides how
the system is built.

## Rules

- **Aim for a decision, but do not invent one.** Often the reasoning shows that more
  context is needed before anyone can decide. Then the result is a list of what is
  missing, not a decision.
- **Each section depends on the sections before it.** An error in an early section makes
  every later section wrong. So:
  - finish a section before you start the next one.
  - if a later section shows that an earlier one is wrong, go back and correct the
    earlier one. Do not work around the error in the later section.

## The sections

### 1. Background
How the current system behaves **before this project**.

### 2. Context
What the reader must know to follow this consideration. Mostly, this is decisions
already made elsewhere that this one depends on. Link to them.

### 3. Use cases — is the problem real?
Where you find out whether there is actually a problem. Trace each use case to a
**concrete triggering scenario** — a customer request, a specific flow in the
behaviour design, a real limitation you hit — that forces this consideration to exist.
- If you can't name a concrete trigger, treat the problem as *suspected*, not real, and
  challenge it rather than documenting it as fact.

### 4. Problem statement
One clear, concise statement naming **exactly one** problem.
- **Singular.** Facets are fine — "a task that is (1) repetitive, (2) at scale,
  (3) unattended" is still one problem, sharpened. But if you need "and" to join two
  different *failure modes*, that's two problems — split them.
- **No solution language.** Say what's wrong or what's needed, never what to build.
- **Testable.** Someone can later ask "solved? yes/no" and agree.

### 5. Solution criteria
What any acceptable option must satisfy.
- **Every criterion traces upward** — to a use case, a non-functional requirement, or a
  real constraint. A criterion that traces to nothing is cargo-cult that silently rigs
  the comparison; cut it.
- Cover functional needs (from the use cases), non-functional ones (performance,
  reliability, security, operability, cost, maintainability, compliance — only those
  actually demanded), and real constraints (budget, deadline, skills, existing stack,
  regulation, backward-compat).
- Separate **must-haves** (fail = disqualified) from **nice-to-haves** (tie-breakers).
- Criteria must **discriminate** — if every option passes every one, they're too vague.
- Tag each with the priority system (below).

This section is the most important, since it shapes our options and decision. During consideration, look at actually important aspects that we lack. For example:
- Have a criteria been confirmed by anyone? If lack from stakeholders -> need to communicate
- Have most of the criteria been explored with justification? E.g. reliability is important for a balance ledger, has it been considered here? If a criterion is just technical terms with no justification, then it should be either dropped or left as an open question.

### 6. Options
The realistic candidates.
- Each must be **scoreable against the criteria** — that relevance is the entry ticket.
- Reach first for the **obvious / default** option and the options that fall **directly
  out of the problem statement**.
- Each option must have pros/cons that either ties directly to a point above, or raise another problem that we haven't anticipated.
- Each option might have multiple sub-consideration that we have to analyze immediately
  - either explore further
  - or a mitigation for a cons

Two options for how options can be viewed, choose based on occasion.
- Indented list: for example:
```
  - Approaches
    - 1. Separate table (`llm_calls`/`request_metadata`)
        - Idea: dedicated table to store metadata with different retention periods from the actual conversational content
            - tenant_id
            - conversation_id
            - chat message id
            - user id
            - token_usage
            - (pricing_snapshot)
            - created
        - When to insert a row
            - On /chat-messages
            - Event-driven
        - Pros:
            - Easier control of retention
        - Cons:
            - One more table
    - 2. Keep the same table as `chat_messages` , same retention period
        - Pros:
            - Easier implementation
        - Cons:
            - Chat messages deleted → token monitoring usage metadata gone → can only monitor for 30 days
            - Currently, non-conversational agents’ chat messages (Suga, VerifySecret,…) have `skip_conversation=True`, which don’t persist them to the DB
    - 3. Keep the same table as `chat_messages`, soft delete chat messages and remove conversational data
        - Pros:
            - Metadata are per day
        - Cons:
            - Currently, non-conversational agents’ chat messages (Suga, VerifySecret,…) have `skip_conversation=True`, which don’t persist them to the DB
    - 4. Aggregate `chat_messages`'s usage metadata in `conversations` table
        - Idea: add `usage_metadata` column to `conversations` table
            - ⇒ when delete chat messages, soft delete the conversation record
        - Pros:
            - Reuse table
        - Cons:
            - Chat messages are not isolated per day, but per conversation → not accurate monitoring
                - If a conversation is created on 13th, but updated on 14th, all messages are rolled over to 14th
                    - Might confuse admins if they see that yesterday’s tokens have moved on to today
                - Mitigation
                    - Accept the inconsistency
                    - Store the messages’ usage metadata independently
                        - Cons
                            - Aggregating performance
                            - Slow down current chat request
            - Currently, non-conversational agents’ chat messages (Suga, VerifySecret,…) have `skip_conversation=True`, which don’t persist them to the DB
```
- A **comparison table** (Pros / Cons, or option × criteria with ✓/✗) is *one* form —
  use it when a side-by-side genuinely makes the tradeoff clearer. Skip it when each
  option's own description already implies how it scores. Pick the lightest form that
  makes the tradeoff obvious.


### 7. The decision

When deciding, if an obvious decision cannot be drawn, then REVISE. What information we need to justify our choices?

If a decision can be made, write it in the ADR / Y-statement form:

> In the context of `<use case / user story u>`, facing `<concern c>`,
> we decided for `<option o>`, to achieve `<quality q>`,
> accepting `<downside d>`.

If we choose an option with a cons, remember to always find a way to mitigate it.

- **Don't force closure.** Mark an unresolved fork honestly: `❓` for an open question,
  `⌚` / "decide later" for a deliberately deferred decision. A premature `⇒` is worse
  than an honest `❓`.
- **Every `⌚` carries a trigger** — the condition that will make it live. "Defer"
  without a trigger is just "forget".
- **Surface the residual risk, scored.** A decision isn't done at "accepting
  `<downside>`". Name the failure modes the chosen option leaves open or introduces, and
  score each by **impact × likelihood**; anything deferred or accepted also carries a
  trigger.
- **Checkpoint:** does the choice satisfy every must-have? is the downside named? is
  each residual / deferred risk scored and given a trigger? A decision with only
  upsides — or a deferral with no trigger — is a red flag that the analysis flinched.

## Priority system (tag every criterion)

- **P0** — the definition of what the task itself is.
- **P1** — highest priority.
- **P2** — medium; may not be needed immediately, but next phase.
- **P3–P6** — low; may not be needed for this project at all.

## Notation

| Mark | Means |
|---|---|
| `⇒` | the decision — the chosen resolution |
| `❓` | open question — needs an answer to proceed |
| `⌚` | deliberately deferred — must carry a trigger |
| `P0`–`P6` | priority tag |
