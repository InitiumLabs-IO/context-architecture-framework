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
| Workflows          | Step-by-step scenarios showing what gets created, modified, and transformed | [Workflows](07-workflows.md)               |

---

## Example Workflows

| Scenario                              | What Gets Created or Modified                                                  | Start Here                                     |
| ------------------------------------- | ------------------------------------------------------------------------------ | ---------------------------------------------- |
| Structuring a new idea from scratch   | Raw material → Anchor Doc → Workstream Briefs; creates all supporting docs     | [Workflows](07-workflows.md#structuring-a-new-idea-from-scratch) |
| Adopting the framework for an existing project | Existing knowledge → Anchor Doc + Briefs; backfills Decision Log       | [Workflows](07-workflows.md#adopting-the-framework-for-an-existing-project) |
| Working on a specific workstream      | Modifies Workstream Brief, Decision Log, Question Queue                        | [Workflows](07-workflows.md#working-on-a-specific-workstream) |
| Deepening a topic with a Deep Dive    | Brief reference → Deep Dive Doc; updates parent brief with cross-reference     | [Workflows](07-workflows.md#deepening-a-topic-with-a-deep-dive) |
| Setting up repository AI config       | Creates AGENTS.md; adds contract headers to all documents                      | [Workflows](07-workflows.md#setting-up-repository-ai-configuration) |
| Reconciling out-of-sync documents     | Updates Anchor Doc, Index, Question Queue, Decision Log; triages Inbox         | [Workflows](07-workflows.md#reconciling-out-of-sync-documents) |
| Understanding the theory              | Nothing modified — reading only                                                | [Workflows](07-workflows.md#understanding-the-theory) |

See [Workflows](07-workflows.md) for step-by-step detail on each scenario, including what documents are created, modified, and how entities transform at each step.

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
