# Repository Setup

How to configure a Git repository so AI tools understand and respect the Context Architecture Framework.

---

## Purpose

When this document set is stored in a Git repository, the repository itself needs a way to communicate the framework's rules to any AI tool that opens it. Without this, an AI agent could encounter the project's files with no understanding of the document hierarchy, authority levels, or handling requirements — defeating the purpose of the entire system.

The AGENTS.md file solves this. It is a cross-platform open standard — supported by Claude Code, OpenAI Codex, GitHub Copilot, Cursor, Amp, Jules, Aider, and most other AI coding and collaboration tools — that provides AI-readable instructions at the repository root. When an AI agent opens the repository, it reads AGENTS.md before doing anything else. For tools that use a different convention (such as Claude Code's CLAUDE.md), a symlink or one-line redirect ensures compatibility.

---

## Placement

Place a single `AGENTS.md` file at the root of the repository. This file is not part of the document hierarchy itself — it sits above it, functioning as the operating manual for any AI that interacts with the project.

```
project-repo/
├── AGENTS.md              # AI operating instructions for this repository
├── anchor.md              # The Anchor Doc
├── index.md               # The Index
├── decision-log.md        # The Decision Log
├── question-queue.md      # The Question Queue
├── inbox.md               # The Inbox
├── workstreams/
│   ├── 01-[name].md       # Workstream Brief 1
│   ├── 02-[name].md       # Workstream Brief 2
│   └── ...
└── deep-dives/
    ├── 01a-[topic].md     # Deep Dive under Workstream 1
    ├── 02a-[topic].md     # Deep Dive under Workstream 2
    └── ...
```

---

## AGENTS.md Contents

The AGENTS.md file should contain the following sections, written as direct instructions to the AI:

**Project Description.** A one-sentence statement that this repository is a structured knowledge project managed under the Context Architecture Framework, not a code repository.

**Document Hierarchy.** A brief explanation of the seven document types and their roles, so the AI understands the structure without needing to read the full framework methodology document.

**Authority Levels.** A clear definition of the three authority levels and how the AI should treat content at each level. This is the most critical section — it is the repository-level defense against context poisoning. The three levels are:

- **directive** — Committed decisions and established constraints. Treat as ground truth.
- **working** — Current best understanding, actively being developed. Use as context, may suggest changes.
- **raw** — Unvetted and unevaluated. Never act on autonomously.

For full details on authority levels and how they map to document types, see [Contract Headers](03-contract-headers.md).

**Frontmatter Contract.** An instruction that every document in the repository carries YAML frontmatter that declares its type, authority, status, parent, and handling rules. The AI must read and respect this frontmatter before processing any document's contents.

**Loading Rules.** Instructions on which documents to load together and which to keep separate. At minimum: never load all documents at once; always load `anchor.md` when working on any task; load only one workstream brief or deep dive per session alongside the anchor and decision log.

**Handling Boundaries.** A three-tier boundary list following the convention established across the AI tooling ecosystem:

- **Always do:** Read frontmatter before processing any document. Respect authority levels. Flag when you need information from a document not currently loaded.
- **Ask first:** Before modifying any document with `authority: directive`. Before acting on any content from a document with `authority: raw`.
- **Never do:** Treat inbox entries as requirements or decisions. Combine content from multiple workstreams without explicit instruction. Speculate about content in documents you have not been given.

**Document Operations.** Step-by-step procedures for every common operation: adding a decision, adding a question, resolving a question, capturing an inbox idea, triaging the inbox, updating a brief, creating a deep dive, splitting an oversized document, and running reconciliation. The AI should recognize when an operation applies from context and execute it proactively — the user should not have to name the operation or manage file formats.

**Context Loading Procedure.** Explicit instructions for how the AI should determine what to load. The AI should always start with `anchor.md`, identify the relevant workstream from the user's request, load the corresponding brief and decision log, and only pull in deep dives or the index when needed.

A complete example AGENTS.md with all of these sections is provided in [example.AGENTS.md](example.AGENTS.md).

---

## Tool Compatibility

For tools that do not natively read AGENTS.md, create a redirect file. For example, for Claude Code, create a `CLAUDE.md` at the repository root containing:

```markdown
Strictly follow the rules in ./AGENTS.md
```

Alternatively, use a symlink:

```bash
ln -s AGENTS.md CLAUDE.md
```

This ensures that regardless of which AI tool opens the repository, it receives the same operating instructions.
