# Document Types

The seven document types that make up the Context Architecture Framework, their roles, size constraints, and usage rules.

## Summary

| Type             | Role                                        | Size Limit              |
| ---------------- | ------------------------------------------- | ----------------------- |
| Anchor Doc       | Single-page distillation of the entire idea | 500 words / ~650 tokens |
| Workstream Brief | Primary working document for one component  | 4 pages / ~3,000 tokens |
| Deep Dive Doc    | Detailed exploration of a specific topic    | 4 pages / ~3,000 tokens |
| Decision Log     | Running record of committed decisions       | 2 pages / ~2,000 tokens |
| Question Queue   | Prioritized list of open questions          | 1 page / ~650 tokens    |
| Inbox            | Zero-friction capture point for new ideas   | No limit                |
| Index            | Master navigation map of all documents      | 1 page / ~650 tokens    |

---

## The Anchor Doc

**Role:** Single-page distillation of the entire idea. Serves as the universal grounding document loaded at the start of every AI session.

**Size Limit:** 500 words maximum (~650 tokens)

**Rationale:** The Anchor Doc exists because conversational AI has no persistent memory between sessions. Every new conversation begins with a blank slate. The Anchor Doc re-establishes the complete shape of the idea in the minimum number of tokens, ensuring the AI always knows the full scope even when working on a narrow slice.

**Required Contents:**

- **Problem Statement:** What problem does this idea solve, stated in one to two sentences.
- **Target Audience:** Who experiences this problem, stated specifically enough to constrain design decisions.
- **Solution Summary:** What the idea proposes, at the highest possible level of abstraction.
- **Success Criteria:** What measurable outcomes define success.
- **Scope Exclusions:** A "This is NOT" section that explicitly names what the idea does not attempt to do. This prevents the AI from expanding into adjacent territories.
- **Workstream Index:** A numbered list of all workstreams by name only, with no elaboration. This gives the AI a map of the idea's full structure so it can identify when a question touches a workstream that isn't currently loaded.

**Maintenance Discipline:** The Anchor Doc should be updated whenever the fundamental shape of the idea changes — new workstreams are added, workstreams are merged or eliminated, or the core problem/solution framing evolves. It should not be updated for detail-level changes within individual workstreams.

---

## Workstream Briefs

**Role:** The primary working document for each major component of the idea. One brief per workstream, stored as a separate file.

**Size Limit:** 4 pages maximum (~3,000 tokens)

**Rationale:** The workstream brief is the document you load alongside the Anchor Doc when working on a specific area. By keeping each brief in its own file and within the token budget, you can load exactly one brief per session and still have the vast majority of the context window available for deep work.

**Required Contents:**

- **Header Block:** Workstream name, parent idea reference, one-line goal statement.
- **Scope:** What is included in this workstream. Be specific enough that there is no ambiguity about what belongs here.
- **Boundaries:** What is explicitly excluded and which other workstream owns it. This is the enforcement mechanism for MECE decomposition — the principle that workstreams must be mutually exclusive and collectively exhaustive (see [Foundations](01-foundations.md) for the full theory).
- **Dependencies:** What this workstream requires from other workstreams (inputs) and what it provides to other workstreams (outputs). Reference by workstream name only.
- **Key Decisions:** Significant decisions already made that constrain this workstream's direction. Reference Decision Log entries by ID where applicable.
- **Open Questions:** Unresolved items that need investigation or decision.
- **Current Status:** A brief summary of where this workstream stands — not started, in progress, or complete, with one to two sentences of elaboration.

**Critical Rule:** A workstream brief must not contain substantive content that belongs to another workstream. When a topic arises that crosses workstream boundaries, insert a cross-reference (e.g., "Revenue model details are maintained in Workstream 4: Monetization") and stop. Do not elaborate. The AI will use these cross-references to tell you when it needs a document that isn't currently loaded.

**Splitting Rule:** If a workstream brief exceeds the 4-page limit, this signals that the workstream is too broad and should be decomposed into sub-workstreams, each with its own brief. The size limit is not a formatting constraint — it is a structural signal.

---

## Deep Dive Docs

**Role:** Detailed exploration of a specific topic within a workstream that is too complex to cover adequately in the brief.

**Size Limit:** 4 pages maximum (~3,000 tokens)

**Rationale:** A workstream brief might state "The platform will use event-driven architecture with message queues for asynchronous processing." That single sentence is sufficient at the brief level. But when you need to actually design that architecture — select technologies, define message schemas, establish failure handling — you need a Deep Dive Doc. The Deep Dive absorbs this detail, keeping the parent brief lean and within budget.

**Required Contents:**

- **Header Block:** Topic name, parent workstream reference, one-line purpose statement.
- **Body:** The detailed analysis, design, specification, or exploration of the topic. Structure as appropriate for the content.
- **Cross-References:** Explicit pointers to related topics in other workstreams or other Deep Dives.
- **Open Questions:** Items surfaced during the deep dive that remain unresolved.

**Loading Pattern:** When working at the Deep Dive level, load the Anchor Doc plus the Deep Dive Doc. You typically do not need the full workstream brief, because the Deep Dive's header block provides sufficient context about where the topic sits in the hierarchy.

**Splitting Rule:** If a Deep Dive Doc exceeds 4 pages, split it into multiple Deep Dives and cross-reference them. There is no limit on the number of Deep Dive Docs that can exist under a single workstream.

---

## The Decision Log

**Role:** A running record of every significant decision made about the idea, with sufficient context to prevent the AI from suggesting previously rejected approaches.

**Size Limit:** 2 pages maximum (~2,000 tokens)

**Rationale:** The Decision Log exists because the AI has no memory of prior conversations. Without it, the AI will repeatedly suggest approaches you have already considered and rejected, propose solutions that violate constraints you have already established, or generate output that contradicts decisions you have already made. The Decision Log is the mechanism that gives the AI awareness of your decision history. It is modeled on Architecture Decision Records (ADRs), a pattern from software engineering — see [Foundations](01-foundations.md) for background.

**Required Fields Per Entry:**

- **Decision ID:** A sequential identifier (D-001, D-002, etc.) for cross-referencing from other documents.
- **Decision:** What was decided, in one sentence.
- **Rationale:** Why this decision was made and what alternatives were considered, in one to two sentences.
- **Affected Workstreams:** Which workstreams are impacted by this decision.

**Entry Format:** Use a flat list format per entry, not a table. Tables are difficult to read and maintain in raw Markdown when entries are being added frequently. Order fields so that short metadata fields come first and long content fields come last — this keeps metadata visible when scanning entries, rather than burying it after a lengthy block of text. Each entry should look like:

```
### D-001
- **Affected Workstreams:** Platform Architecture, Data Model
- **Decision:** Use PostgreSQL as the primary database.
- **Rationale:** Relational model fits our data structure; considered MongoDB but rejected due to lack of transaction support.
```

**Archival Rule:** When the Decision Log exceeds 2 pages, archive older decisions into a separate Decision Archive file. Retain only recent and currently active decisions in the main log. The archive can be loaded on demand for historical context but should not be part of the standard session load.

---

## The Question Queue

**Role:** A prioritized list of open questions, unknowns, and items that need investigation across all workstreams.

**Size Limit:** 1 page maximum (~650 tokens)

**Rationale:** During any working session, questions will arise that belong to a different workstream or require investigation you cannot do immediately. Without a capture mechanism, these items are lost between sessions. The Question Queue provides a lightweight, persistent store for these threads so they can be picked up in the appropriate context later.

**Required Fields Per Entry:**

- **Question ID:** A sequential identifier (Q-001, Q-002, etc.).
- **Added:** The date the question was captured, in YYYY-MM-DD format.
- **Question:** The open question, stated concisely.
- **Workstream:** Which workstream this question belongs to, or "General" if it doesn't map to a specific workstream (e.g., project-level concerns, cross-cutting questions, or questions raised before workstream briefs exist).
- **Priority:** Now (blocking current work), Next (needed soon), or Later (important but not urgent).

**Entry Format:** Use a flat list format per entry, not a table. Tables are difficult to read and maintain in raw Markdown when entries are being added frequently. Order fields so that short metadata fields come first and the question itself comes last — this keeps metadata like priority and workstream visible when scanning entries, rather than burying them after a lengthy question. Each entry should look like:

```
### Q-001
- **Added:** 2026-02-07
- **Workstream:** Platform Architecture
- **Priority:** Now
- **Question:** What authentication provider should we use?
```

**Triage Discipline:** During the weekly reconciliation session, review all entries. Promote resolved questions into the Decision Log if a decision was made. Remove questions that are no longer relevant. Reassign priorities as the project evolves. Use the Added date to identify stale entries — a question marked "Now" that has been open for several weeks may indicate a blocked decision or a priority that needs escalation.

---

## The Inbox

**Role:** A zero-friction capture point for new ideas, tangential thoughts, and items that arise while working on something else.

**Size Limit:** None (append-only, reviewed periodically)

**Rationale:** The Inbox solves a different problem than the Question Queue. The Question Queue captures open questions within the current project. The Inbox captures anything — new project ideas, "what if" thoughts, research leads, feature inspirations, tangential observations — that occurs while you are focused on something else. The critical requirement is that appending an entry takes no more than thirty seconds and requires no categorization, prioritization, or elaboration. Any friction in the capture process means ideas will be lost.

The Inbox applies David Allen's GTD (Getting Things Done) inbox principle: the mind releases an idea once it trusts it has been captured in a reliable external system, allowing you to maintain focus on the current task without the cognitive overhead of holding unrelated thoughts. See [Foundations](01-foundations.md) for more on structured note-taking and agentic memory.

**Required Fields Per Entry:**

- **Date:** The date of capture, in YYYY-MM-DD format, prefixed to the entry (e.g., `2026-02-07: Maybe the onboarding flow should support SSO`).
- **Content:** The idea, observation, or thought in one to two sentences. Capture only — no elaboration.

**Entry Format:** Use a simple date-prefixed line per entry, not a table. The Inbox is optimized for speed of capture — any formatting beyond a date and a sentence adds friction that causes ideas to be lost. Each entry should look like:

```
2026-02-07: Maybe the onboarding flow should support SSO
2026-02-08: Look into whether Stripe supports our pricing model
```

**Triage Discipline:** During the weekly reconciliation session, review all inbox entries. For each entry, take one of three actions: promote to the Question Queue of a specific workstream if it is an open question about an existing project; create a new Anchor Doc if the idea deserves its own project; or discard if the thought no longer seems valuable.

---

## The Index

**Role:** A one-page master navigation map of all documents in the system.

**Size Limit:** 1 page maximum (~650 tokens)

**Rationale:** As the document set grows, you need a way to quickly identify which documents to load for any given question. The Index provides this at a glance, preventing the common failure of loading too many documents (bloating the context) or too few (creating information gaps).

**Required Fields Per Entry:**

- **Document Name:** Including type designation (Brief, Deep Dive, etc.).
- **Status:** Draft, Active, Stable, or Archived.
- **Summary:** One-line description of what the document contains.

**Additional Content:**

- **Dependency Map:** A brief notation of which workstreams depend on each other, enabling you to identify which documents to load for cross-cutting questions.
