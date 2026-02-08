# Workflows

Common scenarios for using the Context Architecture Framework, with explicit detail on what gets created, modified, and how entities transform at each step.

Related pages: [Workflow](04-workflow.md) for the six-phase process and loading strategy, [Document Types](02-document-types.md) for document specifications, [Contract Headers](03-contract-headers.md) for header format.

---

## Structuring a new idea from scratch

You have raw material — notes, voice transcripts, scattered thoughts — and want to build a full document set.

### Step 1: Capture the Anchor Doc

- **Load:** Raw material (notes, transcripts, brain dumps)
- **Creates:** Anchor Doc (draft)
- **Transformation:** Unstructured raw material → 500-word structured distillation with problem statement, solution summary, and a preliminary workstream list

This is Phase 1 of the [six-phase workflow](04-workflow.md). Paste everything into a single AI session and work with the AI to compress it into the Anchor Doc format.

### Step 2: Validate the decomposition

- **Load:** Anchor Doc (draft)
- **Modifies:** Anchor Doc — refine workstream list, sharpen problem/solution framing
- **Creates:** Index (initial)
- **Transformation:** Anchor Doc (draft) → Anchor Doc (final) with validated 3–7 workstream structure

This is Phase 2. Challenge each workstream for overlap, test the full set for completeness, and verify no single workstream is trying to do too much. The workstream list in the Anchor Doc should be MECE — mutually exclusive and collectively exhaustive.

### Step 3: Elaborate each workstream

- **Load:** Anchor Doc only (one fresh session per workstream)
- **Creates:** One Workstream Brief per workstream
- **Modifies:** Index — add each new brief
- **Transformation:** Workstream name (from Anchor Doc's numbered list) → full Workstream Brief with scope, boundaries, dependencies, and status

This is Phase 3. Start a fresh AI session for each workstream. Do not work on multiple workstreams in the same session.

### Step 4: Set up supporting documents

- **Creates:** Decision Log (empty, with [contract header](03-contract-headers.md)), Question Queue (empty, with contract header), Inbox (empty, with contract header)
- **Modifies:** Index — add all supporting documents

No AI session needed. Create these files with proper contract headers so they are ready to receive entries during future working sessions.

---

## Adopting the framework for an existing project

You have a project already in progress — code, documentation, decisions already made — and want to bring it into the framework.

### Step 1: Distill the Anchor Doc

- **Load:** Existing project documentation, README, or your own knowledge of the project
- **Creates:** Anchor Doc
- **Transformation:** Existing project knowledge → 500-word Anchor Doc with problem, solution, audience, success criteria, scope exclusions, and workstream index

Work with the AI to compress your project's current state into the Anchor Doc format. The workstream list should reflect the project's natural independent components.

### Step 2: Create Workstream Briefs

- **Load:** Anchor Doc (one fresh session per workstream)
- **Creates:** One Workstream Brief per workstream
- **Transformation:** Existing project component → structured Workstream Brief with scope, boundaries, dependencies, key decisions, open questions, and status

Pull from existing documentation where possible. Be strict about [MECE boundaries](01-foundations.md) — each brief owns exactly one area with no overlap.

### Step 3: Backfill the Decision Log

- **Load:** Anchor Doc + one Workstream Brief at a time
- **Creates:** Decision Log with entries for decisions already made
- **Transformation:** Implicit or scattered decisions → explicit Decision Log entries with ID, rationale, and affected workstreams

Review each workstream and extract decisions that have already been made. These are often embedded in code, config files, or team conversations. Each becomes a formal entry so the AI knows what has been decided.

### Step 4: Set up remaining documents and repository

- **Creates:** Question Queue, Inbox, Index, AGENTS.md
- **Modifies:** All documents — add [contract headers](03-contract-headers.md) with type, authority, status, parent, and handling fields
- **Transformation:** Headerless documents → contract-bearing documents with explicit authority levels and AI handling instructions

See [Repository Setup](05-repository-setup.md) for the full AGENTS.md specification and file layout. For tools that don't read AGENTS.md (e.g., Claude Code), add a `CLAUDE.md` redirect.

---

## Working on a specific workstream

You have a document set already built and need to do focused work on one area.

### Step 1: Load working context

- **Load:** Anchor Doc (~650 tokens) + the relevant Workstream Brief (~3,000 tokens) + Decision Log (~2,000 tokens) = ~6,000 tokens total

This is the standard working configuration from Phase 5. The Anchor Doc grounds the AI in the full project scope, the brief provides the working detail, and the Decision Log prevents the AI from revisiting settled decisions.

### Step 2: Execute the work

- **Modifies:** Workstream Brief — update scope, status, open questions, or key decisions as work progresses
- **Transformation:** Workstream Brief (prior state) → Workstream Brief (updated to reflect session outcomes)

Work with the AI on the specific task. If a topic needs more depth than the brief can hold, that signals the need for a Deep Dive Doc.

### Step 3: Capture session outputs

- **Modifies:** Decision Log — append new entries for any decisions made during the session
- **Modifies:** Question Queue — append new entries for questions that arose; remove entries that were resolved during the session
- **Modifies:** Workstream Brief — update current status section
- **Transformation:** Session decisions → Decision Log entries (with ID, rationale, affected workstreams); session questions → Question Queue entries (with ID, workstream, priority); resolved Question Queue entries → Decision Log entries (if a decision was made) or removed (if no longer relevant)

Do this before closing the session. Decisions and questions not captured here are lost.

---

## Deepening a topic with a Deep Dive

A workstream brief references a topic too complex to cover in the brief itself, and you need to explore it in detail.

### Step 1: Load focused context

- **Load:** Anchor Doc + the relevant Workstream Brief (to identify the topic and its constraints)

### Step 2: Create the Deep Dive

- **Creates:** Deep Dive Doc
- **Transformation:** Brief's one-line reference to a complex topic → full Deep Dive Doc with detailed analysis, design, or specification (~3,000 tokens)
- **Modifies:** Index — add the new Deep Dive Doc under its parent workstream

The parent brief might say "The platform will use event-driven architecture with message queues." The Deep Dive expands this into technology selection, message schemas, failure handling, and integration points.

### Step 3: Update the parent brief

- **Modifies:** Workstream Brief — replace the inline detail with a cross-reference to the Deep Dive Doc
- **Transformation:** Brief with embedded complex detail → Brief with cross-reference pointer (e.g., "See Deep Dive: Event Architecture for details")

This keeps the brief within its 4-page budget while the detail lives in its own scoped document.

---

## Setting up repository AI configuration

You want AI tools to understand your project's document structure and rules when working in your repository.

### Step 1: Create AGENTS.md

- **Creates:** AGENTS.md at repository root
- **Transformation:** Framework rules (from [Repository Setup](05-repository-setup.md)) → repository-specific AGENTS.md with document hierarchy, authority levels, loading rules, and handling boundaries

This file teaches AI tools the framework's operating rules for your specific project.

### Step 2: Add contract headers to all documents

- **Modifies:** Every document in the system — add YAML frontmatter
- **Transformation:** Plain documents → contract-bearing documents with type, authority, status, parent, and handling fields

See [Contract Headers](03-contract-headers.md) for the full header specification and authority level definitions.

### Step 3: Add tool-specific redirects

- **Creates:** CLAUDE.md (if using Claude Code) or equivalent tool-specific config files
- **Transformation:** AGENTS.md → tool-specific redirect that points the tool to AGENTS.md

Only needed for tools that don't natively read AGENTS.md.

---

## Reconciling out-of-sync documents

Your documents have drifted — scope boundaries are blurring, decisions haven't propagated, questions have gone stale.

### Step 1: Load reconciliation context

- **Load:** Anchor Doc + Index + Question Queue (~2,000 tokens total)

This gives the AI a high-level view of the entire document set without loading any working-level detail.

### Step 2: Review for drift

Check for:
- Workstreams that have grown beyond their defined scope in the Anchor Doc
- Open questions in the Question Queue that have already been resolved
- Gaps where the Anchor Doc promises something no workstream owns
- Stale information that no longer reflects the current state

### Step 3: Apply corrections

- **Modifies:** Anchor Doc — correct scope descriptions, add or remove workstreams if the project shape has changed
- **Modifies:** Index — update document statuses (draft → active, active → archived)
- **Modifies:** Question Queue — remove resolved questions, reprioritize remaining ones
- **Modifies:** Decision Log — archive entries if it exceeds 2 pages
- **Transformation:** Resolved Question Queue entries → new Decision Log entries (if a decision was made); stale entries → removed; Inbox entries → Question Queue entries (if promoted) or discarded

### Step 4: Triage the Inbox

- **Load:** Inbox (reviewed manually, not loaded into AI context)
- **Modifies:** Inbox — remove triaged entries
- **Modifies:** Question Queue — append promoted entries
- **Transformation:** Inbox entries → Question Queue entries (if promoted), new Anchor Doc (if the item deserves its own project), kept (if not yet ready to act on), or discarded

Inbox entries are raw and unvetted. The user must decide what to do with each entry — the AI should present entries one at a time and ask, not make assumptions about intent, relevance, or destination.

---

## Understanding the theory

You want to understand the research and principles behind the framework before using it.

No documents are created or modified. Read these pages in order:

1. [Foundations](01-foundations.md) — Context engineering, MECE decomposition, progressive elaboration, architecture decision records, and why bigger context windows produce worse results
2. [Document Types](02-document-types.md) — The seven document types, their roles, and size constraints
3. [Contract Headers](03-contract-headers.md) — YAML frontmatter format and authority levels
4. [Workflow](04-workflow.md) — The six-phase process and context loading strategy
5. [Reference](06-reference.md) — Size limits, anti-patterns, and guiding principles
