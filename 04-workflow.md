# Workflow

The six-phase workflow and context loading strategy for the Context Architecture Framework.

---

## Context Loading Strategy

Not all documents should be loaded in every session. The framework defines specific loading patterns based on the type of work being performed. Every loading decision should follow a single principle: **load the minimum set of documents that gives the AI complete information for the current task.** "Complete" means the AI does not need to guess or infer anything that exists in an unloaded document. "Minimum" means nothing is loaded that is not directly relevant.

If you are unsure whether a document is needed, err on the side of not loading it and instead instruct the AI to flag any questions that require information it does not have.

---

## The Six Phases

The framework follows a six-phase workflow. Each phase builds on the previous one, and the phases are designed to be executed in separate AI sessions to maintain clean context.

### Phase 1: Capture

**Objective:** Transform raw, unstructured thinking into a clean Anchor Doc.

**What to load:** This is the only phase where you load a large volume of unstructured text into the context — messy notes, voice transcripts, scattered thoughts, a stream-of-consciousness brain dump.

**Process:** Paste the raw material into a single AI session and work with the AI to distill it into a 500-word Anchor Doc. The goal is to exit this phase with a tight, structured summary and a preliminary list of 3–7 workstreams.

**Output:** Anchor Doc (draft).

---

### Phase 2: Decompose

**Objective:** Validate and refine the workstream structure using MECE principles.

**What to load:** The draft Anchor Doc only.

**Process:** Work with the AI to challenge the decomposition. Test each workstream for overlap (are any two workstreams covering the same territory?), test the full set for completeness (is anything missing?), and test each workstream for appropriate scope (is any single workstream trying to do too much?). Adjust the workstream list and update the Anchor Doc.

**Output:** Anchor Doc (final), initial Index.

---

### Phase 3: Elaborate

**Objective:** Create a Workstream Brief for each workstream.

**What to load:** The Anchor Doc only (one fresh session per workstream).

**Process:** For each workstream, start a fresh AI session. Load the Anchor Doc and build the brief through structured conversation. Do not work on multiple workstreams in the same session. Context pollution between workstreams — where the AI starts blending details from one area into another — is one of the most common sources of drift and hallucination.

**Output:** One Workstream Brief per workstream, updated Index.

---

### Phase 4: Deepen

**Objective:** Create Deep Dive Docs for topics flagged during elaboration as needing more detail.

**What to load:** The Anchor Doc (one fresh session per Deep Dive topic).

**Process:** For each topic requiring a Deep Dive, start a fresh AI session. Load the Anchor Doc and work on the specific topic. Not every workstream will require Deep Dives immediately — apply progressive elaboration and only deepen where depth is currently needed.

**Output:** Deep Dive Docs as needed, updated Index.

---

### Phase 5: Build

**Objective:** Execute on the idea — write code, create designs, draft content, build systems.

**What to load:** Anchor Doc + the relevant Brief or Deep Dive + the Decision Log. This is the standard working configuration, consuming approximately 6,000 tokens and leaving the vast majority of the context window free.

**Process:** For each working session, load the standard context package. Work with the AI on the specific task. At the end of each session, extract any decisions made, questions raised, and document updates needed. Update the Decision Log, Question Queue, and any modified documents before the next session.

**Output:** Work product, updated Decision Log and Question Queue.

---

### Phase 6: Reconcile

**Objective:** Maintain coherence across the entire document set.

**Frequency:** Weekly, or whenever you sense that documents may have drifted out of sync.

**What to load:** The Anchor Doc, the Index, and the Question Queue.

**Process:** Review for: workstreams that have grown beyond their defined scope, open questions that should have been resolved, gaps in coverage where the Anchor Doc promises something no workstream owns, stale information that no longer reflects the current state of the idea, and inbox items that need triage. Update documents as needed.

**Output:** Updated Anchor Doc, Index, Question Queue, and triaged Inbox.

---

## Loading Quick Reference

| Scenario                                      | What to Load                                 | Token Budget |
| --------------------------------------------- | -------------------------------------------- | ------------ |
| Broad exploration / brainstorming             | Anchor Doc only                              | ~650         |
| Working on a specific workstream              | Anchor Doc + Workstream Brief + Decision Log | ~6,000       |
| Going deep on a specific topic                | Anchor Doc + Deep Dive Doc + Decision Log    | ~6,000       |
| Cross-cutting question (multiple workstreams) | Anchor Doc + relevant Briefs + Decision Log  | ~6,000–9,000 |
| Reviewing overall progress                    | Anchor Doc + Index + Question Queue          | ~2,000       |

**Cross-cutting questions:** Use the Index to identify exactly which documents are relevant. Do not load all documents — load only those that are directly involved.
