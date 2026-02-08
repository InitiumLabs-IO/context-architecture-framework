# The Context Architecture Framework

### A Methodology for Decomposing Complex Ideas Into AI-Workable Units

**Version 0.1**

---

The Context Architecture Framework is a structured methodology for breaking down large, complex ideas into modular documents optimized for collaboration with AI language models. It treats AI context as a finite, engineerable resource — every document is designed to fit within strict size limits, carry enough internal structure to be independently understandable, and include explicit markers that tell the AI what information it does and does not have access to. The result is a system where the AI always operates with complete information for the task at hand, rather than partial information about the entire idea.

---

## Quick Reference

| Concept            | What It Is                                                                 | Learn More                                 |
| ------------------ | -------------------------------------------------------------------------- | ------------------------------------------ |
| Anchor Doc         | 500-word distillation of your entire idea, loaded in every AI session      | [Document Types](02-document-types.md)     |
| Workstream Brief   | Primary working document for one component of the idea (4 pages max)       | [Document Types](02-document-types.md)     |
| Deep Dive Doc      | Detailed exploration of a specific topic within a workstream (4 pages max) | [Document Types](02-document-types.md)     |
| Decision Log       | Running record of committed decisions with rationale (2 pages max)         | [Document Types](02-document-types.md)     |
| Question Queue     | Prioritized list of open questions across all workstreams                  | [Document Types](02-document-types.md)     |
| Inbox              | Zero-friction capture point for ideas and tangential thoughts              | [Document Types](02-document-types.md)     |
| Index              | Master navigation map of all documents in the system                       | [Document Types](02-document-types.md)     |
| Contract Headers   | YAML frontmatter declaring document type, authority, and handling rules    | [Contract Headers](03-contract-headers.md) |
| Authority Levels   | Three tiers — directive, working, raw — controlling how AI treats content  | [Contract Headers](03-contract-headers.md) |
| MECE Decomposition | Workstreams must be mutually exclusive and collectively exhaustive         | [Foundations](01-foundations.md)           |
| Context Loading    | Load the minimum documents needed for the current task                     | [Workflow](04-workflow.md)                 |
| AGENTS.md          | Repository-root file that teaches AI tools the framework's rules           | [Repository Setup](05-repository-setup.md) |
| Size Limits        | Non-negotiable token budgets derived from how attention mechanisms work    | [Reference](06-reference.md)               |

---

## Example Workflows

### I have a new idea and want to structure it from scratch

1. Gather your raw material — notes, transcripts, scattered thoughts
2. Follow **Phase 1: Capture** and **Phase 2: Decompose** to create your Anchor Doc and identify 3–7 workstreams
3. Follow **Phase 3: Elaborate** to build a Workstream Brief for each workstream in separate AI sessions
4. Create your Decision Log, Question Queue, Inbox, and Index files with proper [contract headers](03-contract-headers.md)

Start with [Workflow](04-workflow.md) for the full six-phase process, and [Document Types](02-document-types.md) for what goes in each document.

### I have an existing project and want to adopt this framework

1. Write an Anchor Doc (500 words max) that distills your project's problem, solution, and workstream structure
2. Identify your natural workstreams — areas of the project that can be worked on independently
3. Create a Workstream Brief for each one, being strict about [MECE boundaries](01-foundations.md)
4. Set up your repository with [AGENTS.md](05-repository-setup.md) so AI tools understand the structure
5. Add [contract headers](03-contract-headers.md) to every document

Start with [Document Types](02-document-types.md) for document specs and [Repository Setup](05-repository-setup.md) for file layout.

### I need to work on a specific workstream with my AI

1. Load three documents: Anchor Doc + the relevant Workstream Brief + Decision Log (~6,000 tokens total)
2. Work on the specific task in a focused session
3. At session end, capture any new decisions in the Decision Log, new questions in the Question Queue, and update the Brief if needed

See [Workflow](04-workflow.md) for loading patterns and the full loading quick reference table.

### I need to set up my repo so AI tools understand my project

1. Place an `AGENTS.md` file at the repository root with document hierarchy, authority levels, and handling boundaries
2. Add YAML frontmatter contract headers to every document
3. For tools that don't read AGENTS.md (e.g., Claude Code), add a `CLAUDE.md` redirect

See [Repository Setup](05-repository-setup.md) for the full AGENTS.md specification and file layout, and [Contract Headers](03-contract-headers.md) for the header format.

### My documents feel out of sync and need reconciliation

1. Load the Anchor Doc, the Index, and the Question Queue
2. Follow **Phase 6: Reconcile** — check for scope drift, stale questions, missing coverage, and untriaged inbox items
3. Update documents as needed; archive old Decision Log entries if it exceeds 2 pages

See [Workflow](04-workflow.md) for the reconciliation process and [Reference](06-reference.md) for anti-patterns that cause drift.

### I want to understand the theory behind this approach

Read [Foundations](01-foundations.md) for the theoretical basis: context engineering, MECE decomposition, progressive elaboration, architecture decision records, and why bigger context windows produce worse results.

---

## System Overview

```
AGENTS.md (repository root — AI operating instructions)
│
ANCHOR DOC (500 words max)
│
│   Loaded in every AI session
│
├── WORKSTREAM BRIEF 1 (4 pages max)
│   ├── Deep Dive 1A (4 pages max)
│   └── Deep Dive 1B (4 pages max)
│
├── WORKSTREAM BRIEF 2 (4 pages max)
│   └── Deep Dive 2A (4 pages max)
│
├── WORKSTREAM BRIEF 3 (4 pages max)
│
├── DECISION LOG (2 pages max)
│   │   Loaded when working on any workstream
│   └── Decision Archive (loaded on demand)
│
├── QUESTION QUEUE (1 page max)
│   │   Loaded during reconciliation
│
├── INBOX (no limit, never loaded directly)
│   │   Reviewed and triaged weekly
│
└── INDEX (1 page max)
        Loaded when navigating or reviewing
```

**Standard working session load:**
Anchor Doc (~650) + Workstream Brief (~3,000) + Decision Log (~2,000) = **~6,000 tokens**

This leaves approximately 122,000 tokens (in a 128K window) or 194,000 tokens (in a 200K window) available for the conversation, reasoning, and response generation.
