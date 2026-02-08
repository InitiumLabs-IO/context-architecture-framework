# AGENTS.md

This repository is a structured knowledge project managed under the Context Architecture Framework. It is not a traditional code repository. Every document follows strict size limits, carries YAML frontmatter declaring its type and authority, and is designed to be loaded into AI context windows in specific combinations.

**Your role:** You are responsible for maintaining this document set. When the user describes a decision, raises a question, has an idea, or wants to work on a topic, you determine which documents to load, which operations to perform, and execute them. Do not ask the user to manage files or formats — handle it yourself using the rules in this file.

---

## File Layout

```
project-repo/
├── AGENTS.md              # This file — AI operating instructions
├── anchor.md              # Anchor Doc (directive, ~650 tokens)
├── index.md               # Index (raw, ~650 tokens)
├── decision-log.md        # Decision Log (directive, ~2,000 tokens)
├── question-queue.md      # Question Queue (raw, ~650 tokens)
├── inbox.md               # Inbox (raw, no limit)
├── workstreams/
│   ├── 01-[name].md       # Workstream Brief (working, ~3,000 tokens)
│   ├── 02-[name].md
│   └── ...
└── deep-dives/
    ├── 01a-[topic].md     # Deep Dive Doc (working, ~3,000 tokens)
    ├── 02a-[topic].md
    └── ...
```

---

## Document Types

| Type             | Authority | Size Limit              | Role                                                    |
| ---------------- | --------- | ----------------------- | ------------------------------------------------------- |
| Anchor Doc       | directive | 500 words / ~650 tokens | Single-page distillation of the entire project          |
| Workstream Brief | working   | 4 pages / ~3,000 tokens | Primary working document for one component              |
| Deep Dive Doc    | working   | 4 pages / ~3,000 tokens | Detailed exploration of a specific topic                |
| Decision Log     | directive | 2 pages / ~2,000 tokens | Running record of committed decisions with rationale    |
| Question Queue   | raw       | 1 page / ~650 tokens    | Prioritized list of open, unresolved questions          |
| Inbox            | raw       | No limit                | Zero-friction capture point for unvetted ideas          |
| Index            | raw       | 1 page / ~650 tokens    | Master navigation map of all documents                  |

---

## Authority Levels

**directive** — Committed decisions and established constraints. Treat as ground truth. Do not contradict, reinterpret, or work around directive content without explicit human instruction. Documents: Anchor Doc, Decision Log.

**working** — Current best understanding, actively being developed. Use as context for your work. You may suggest modifications, identify gaps, or propose alternatives. Documents: Workstream Briefs, Deep Dive Docs.

**raw** — Unvetted, unvalidated, unevaluated. Do not treat any item as a decision, requirement, or constraint. Do not act on raw content autonomously. You may help organize or evaluate raw items only when explicitly asked. Documents: Inbox, Question Queue, Index.

---

## Frontmatter Contract

Every document carries a YAML frontmatter header. Read and respect this header before processing any document's contents. The header format is:

```yaml
---
type: [anchor | workstream-brief | deep-dive | decision-log | question-queue | inbox | index]
authority: [directive | working | raw]
status: [draft | active | stable | archived]
parent: [parent document reference]
handling: [plain-language instruction for how to treat this document]
---
```

The `handling` field is a direct instruction to you. Follow it.

---

## Context Loading Rules

Load the minimum set of documents that gives you complete information for the current task. Never load all documents at once. You are responsible for determining what to load based on what the user asks — do not wait for the user to specify files.

**How to determine what to load:**

1. **Always start with `anchor.md`.** Read it first in every session. It tells you the full project scope and lists all workstreams by name, so you can identify which documents are relevant to the user's request.
2. **Identify the workstream.** Match the user's request to a workstream from the Anchor Doc's workstream index. If the request clearly maps to one workstream, load that brief from `workstreams/`. If you are unsure which workstream applies, ask.
3. **Load the Decision Log.** Whenever you are doing substantive work (not just browsing), read `decision-log.md` so you do not propose approaches that contradict committed decisions.
4. **Load Deep Dives only when needed.** If the Workstream Brief contains a cross-reference to a Deep Dive (e.g., "See Deep Dive: Event Architecture"), and the user's task requires that detail, load the referenced Deep Dive from `deep-dives/`. Otherwise, skip it.
5. **Use the Index for navigation.** If you need to find a specific document or check what exists, read `index.md`. It is a lightweight navigation map (~650 tokens).
6. **Never load the Inbox into context.** The Inbox is append-only and potentially large. Only read it when the user explicitly asks to triage it.

**Loading quick reference:**

| Scenario                            | What to Load                                 | Token Budget   |
| ----------------------------------- | -------------------------------------------- | -------------- |
| Broad exploration / brainstorming   | Anchor Doc only                              | ~650           |
| Working on a specific workstream    | Anchor Doc + Workstream Brief + Decision Log | ~6,000         |
| Going deep on a specific topic      | Anchor Doc + Deep Dive Doc + Decision Log    | ~6,000         |
| Cross-cutting question              | Anchor Doc + relevant Briefs + Decision Log  | ~6,000–9,000   |
| Reviewing overall progress          | Anchor Doc + Index + Question Queue          | ~2,000         |

Do not work on multiple workstreams in the same session. If a task touches a workstream not currently loaded, flag it rather than speculating.

---

## Handling Boundaries

**Always do:**

- Read the YAML frontmatter header before processing any document
- Respect authority levels — directive content is ground truth, raw content is unvetted
- Flag when you need information from a document not currently loaded
- Use the exact entry formats specified in the Document Operations section below

**Ask first:**

- Before modifying any document with `authority: directive` (Anchor Doc, Decision Log)
- Before acting on any content from a document with `authority: raw` (Inbox, Question Queue)
- Before creating a new document (Deep Dive, Workstream Brief)

**Never do:**

- Treat inbox entries as requirements or decisions
- Combine content from multiple workstreams without explicit instruction
- Speculate about content in documents you have not been given
- Exceed document size limits — if a document is too large, it needs splitting, not compression
- Skip the frontmatter header when creating or modifying documents

---

## Document Operations

These are the standard workflows for maintaining the document set. You are expected to recognize when an operation applies and execute it proactively. For example, if the user says "let's go with PostgreSQL," you should recognize that as a decision and perform the Adding a New Decision workflow without being asked. If the user wonders aloud about a topic in another workstream, capture it as a question. If they mention an unrelated idea, capture it in the Inbox. The user should not have to name the operation — you identify it from context and act.

**Scope enforcement:** Every document type has a defined scope and size limit. When performing any operation, actively route content to the document where it belongs. If the user provides extensive detail while making a decision, the Decision Log entry should stay concise (one sentence for the decision, one to two sentences for the rationale) — the detail belongs in the relevant Workstream Brief's scope, key decisions, or open questions sections. If a question comes with background context, the Question Queue entry should capture only the question itself — the context belongs in the Workstream Brief. If content does not fit any currently loaded document, flag it and identify which document it belongs in rather than forcing it into the wrong place.

### Adding a new decision

When a decision is made during a session, append it to `decision-log.md`.

**Entry format:**

```
### D-[next sequential ID]
- **Affected Workstreams:** [list of affected workstream names]
- **Decision:** [what was decided, one sentence]
- **Rationale:** [why this was decided and what alternatives were considered, one to two sentences]
```

**Scope check:** The Decision Log records _what_ was decided and _why_, not the full detail of how to implement it. If the user provides implementation details, technical specifications, or extended reasoning alongside a decision, route that detail to the relevant Workstream Brief (Key Decisions or scope sections) and keep the Decision Log entry concise.

**After adding:** Check if the Decision Log now exceeds 2 pages (~2,000 tokens). If it does, move older entries to a `decision-archive.md` file, retaining only recent and currently active decisions in the main log.

### Adding a new question

When a question arises that cannot be answered in the current session, append it to `question-queue.md`.

**Entry format:**

```
### Q-[next sequential ID]
- **Added:** [today's date, YYYY-MM-DD]
- **Workstream:** [which workstream this belongs to, or General if it doesn't map to one]
- **Priority:** [Now | Next | Later]
- **Question:** [the open question, stated concisely]
```

Not every question will belong to an existing workstream. Questions may arise before briefs exist, span multiple workstreams, or be project-level concerns. Use "General" for the workstream field when the question doesn't clearly map to one.

**Scope check:** The Question Queue captures only the question itself. If the user provides background context, constraints, or partial analysis alongside the question and a relevant Workstream Brief exists, route that detail to the brief's Open Questions section and keep the queue entry to a single concise question.

### Resolving a question (promoting to a decision)

When a question from the Question Queue has been answered and a decision was made:

1. Create a new Decision Log entry in `decision-log.md` using the decision entry format above
2. Remove the resolved question entry from `question-queue.md`
3. If the decision affects any Workstream Brief's Key Decisions or Open Questions sections, flag that those documents need updating

When a question is resolved but no formal decision was needed (e.g., it was answered by research or became irrelevant), simply remove the entry from `question-queue.md`.

### Capturing an idea in the Inbox

When a tangential thought, new idea, or unrelated observation comes up during a session, append it to `inbox.md`.

**Entry format:**

```
[today's date, YYYY-MM-DD]: [the idea in one to two sentences — capture only, no elaboration]
```

Do not categorize, prioritize, or evaluate inbox entries at capture time. The only goal is to record the thought so it is not lost.

### Triaging the Inbox

When the user asks to triage the inbox, present each entry one at a time and ask the user what to do with it. Do not decide on your own — inbox entries are raw and unvetted, and you cannot reliably determine their intent, relevance, or destination. For each entry, present it and ask the user to choose one of:

- **Promote to Question Queue:** Create a new Question Queue entry in `question-queue.md` using the question entry format above. Ask the user which workstream it belongs to and what priority to assign. Remove the entry from `inbox.md`.
- **Promote to new project:** Flag it as a candidate for a new Anchor Doc. Remove the entry from `inbox.md`.
- **Keep:** Leave the entry in the inbox for future triage.
- **Discard:** Remove it from `inbox.md`.

If the user's intent for an entry is ambiguous, ask for clarification before acting. Never assume what an inbox entry means or where it should go.

### Updating a Workstream Brief

When modifying a workstream brief in `workstreams/`:

- Only modify the brief for the workstream currently loaded in the session
- Update the Current Status section to reflect the session's outcomes
- If a new decision was made, add it to the Key Decisions section with a reference to the Decision Log entry (e.g., "See D-012")
- If an open question was resolved, remove it from the Open Questions section
- If a new question was identified, add it to the Open Questions section and also create a Question Queue entry
- If a topic within the brief grows too complex, flag it as a candidate for a Deep Dive Doc rather than expanding the brief beyond its 4-page limit
- Do not add content that belongs to another workstream — insert a cross-reference instead (e.g., "Revenue model details are maintained in Workstream 4: Monetization")

### Creating a Deep Dive Doc

When a topic needs more detail than a Workstream Brief can hold:

1. Create a new file in `deep-dives/` following the naming convention `[workstream-number][letter]-[topic].md` (e.g., `01a-event-architecture.md`)
2. Add the standard YAML frontmatter with `type: deep-dive`, `authority: working`, and `parent:` pointing to the parent workstream brief
3. Include a header block with the topic name, parent workstream reference, and one-line purpose statement
4. After creating the Deep Dive, update the parent Workstream Brief to replace inline detail with a cross-reference (e.g., "See Deep Dive: Event Architecture for details")
5. Add the new Deep Dive to `index.md` under its parent workstream

### Splitting an oversized document

When any document exceeds its size limit:

- **Workstream Brief over 4 pages:** The workstream is too broad. Propose splitting it into sub-workstreams, each with its own brief. This requires updating the Anchor Doc's workstream list and the Index.
- **Deep Dive Doc over 4 pages:** The topic should be divided into multiple Deep Dives with cross-references between them. Update the Index.
- **Decision Log over 2 pages:** Archive older decisions into `decision-archive.md`. Retain only recent and currently active decisions in the main log.
- **Question Queue over 1 page:** Review for stale or resolved questions that should be removed or promoted.

### Reconciliation

When the user asks to reconcile or review the document set:

1. Load: Anchor Doc + Index + Question Queue
2. Check for: workstreams that have grown beyond their defined scope, questions that should have been resolved, gaps where the Anchor Doc promises something no workstream owns, stale information
3. Update the Anchor Doc if the project shape has changed
4. Update the Index with current document statuses
5. Remove resolved questions from the Question Queue, promote any that resulted in decisions to the Decision Log
6. Triage the Inbox if the user requests it
7. Flag any documents that need individual attention in a follow-up session

### Updating the Index

Whenever a document is created, archived, or changes status, update `index.md` to reflect the current state. Each entry should include the document name (with type designation), its current status, and a one-line summary.
