# The Context Architecture Framework

### A Methodology for Decomposing Complex Ideas Into AI-Workable Units

**Version 0.1**

---

## 1. Purpose and Scope

The Context Architecture Framework is a structured methodology for breaking down large, complex ideas into modular documents optimized for collaboration with AI language models. It is designed for solo operators — entrepreneurs, indie developers, researchers, and creators — who use conversational AI assistants as their primary thinking and execution partners.

The framework addresses a specific failure mode: as an idea grows in complexity, it eventually exceeds the AI's ability to hold everything in working memory at once. When the AI operates on incomplete information, it compensates by generating plausible-sounding output that may contradict prior decisions, ignore established constraints, or fabricate details. This is not a reasoning failure. It is a context failure.

The framework treats AI context as a finite, engineerable resource. Every document is designed to fit within strict size limits, carry enough internal structure to be independently understandable, and include explicit markers that tell the AI what information it does and does not have access to. The result is a system where the AI always operates with complete information for the task at hand, rather than partial information about the entire idea.

---

## 2. Theoretical Foundations

The framework draws on established methodologies from consulting, project management, software engineering, and the emerging discipline of context engineering.

### 2.1 Context Engineering

Context engineering, formalized as a discipline in mid-2025, is the practice of curating and managing the information provided to a language model during inference. The term was popularized by Andrej Karpathy, who described it as "the delicate art and science of filling the context window with just the right information for the next step." The mental model is that the language model functions as a processor (CPU), the context window serves as working memory (RAM), and the human operator acts as the operating system — deciding what data to load, when to load it, and when to discard it.

Anthropic's Applied AI team further established that context must be treated as a resource with diminishing marginal returns. As the volume of tokens in the context window increases, the model's ability to accurately recall and reason over that information degrades — a phenomenon known as context rot. Research has demonstrated that models effectively utilize only 10–20% of very long contexts, and that material positioned in the middle of a large document receives less attention than material at the beginning or end (the "lost in the middle" effect).

The practical implication is that the optimal context is not the largest context, but the smallest set of high-signal information that enables the model to accomplish the current task.

### 2.2 MECE Decomposition

The MECE principle — Mutually Exclusive, Collectively Exhaustive — originates from McKinsey & Company and Barbara Minto's Pyramid Principle. It requires that any decomposition of a problem satisfy two properties: no element overlaps with another (mutually exclusive), and all elements together cover the full scope of the problem (collectively exhaustive).

This principle governs how the framework decomposes ideas into workstreams. Each workstream must own a distinct, non-overlapping territory. Together, all workstreams must account for the complete idea. When the AI works on one workstream, it should never need to reason about another workstream's content, because the boundaries are clearly drawn.

### 2.3 Progressive Elaboration

Borrowed from project management (PMBOK), progressive elaboration is the practice of developing plans in increasing levels of detail as more information becomes available. The framework applies this principle by starting with a high-level summary and only deepening detail where and when it is needed. Not every workstream requires the same depth at the same time.

### 2.4 Architecture Decision Records

The Decision Log within the framework is modeled on Architecture Decision Records (ADRs), a pattern from software engineering originally proposed by Michael Nygard. ADRs capture not just what was decided, but why it was decided and what alternatives were considered. This prevents the same ground from being relitigated and provides essential context for future work.

### 2.5 Structured Note-Taking and Agentic Memory

Anthropic's engineering team identified structured note-taking as a key technique for long-horizon AI work. The pattern involves the agent periodically writing notes to persistent storage outside the context window, which can be retrieved in later sessions. The framework's Decision Log, Question Queue, and Inbox all function as forms of persistent memory that survive between AI sessions, compensating for the AI's lack of native cross-session memory.

---

## 3. The Context Window Constraint

### 3.1 How Context Windows Work

A context window is the total amount of text — measured in tokens — that a language model can process in a single interaction. One token corresponds to approximately three-quarters of a word in English. Current models support windows ranging from 128,000 to 200,000 tokens, with some models offering up to 1,000,000 tokens in beta.

The context window must accommodate all of the following simultaneously: the system prompt and model instructions, any documents provided by the user, the user's question or instruction, the model's internal reasoning process, and the model's generated response.

### 3.2 Why Bigger Is Not Better

Research consistently shows that model performance degrades as context length increases, even within the advertised window size. Attention is not uniformly distributed across the context. Information near the beginning and end of the window receives stronger attention than information in the middle. The computational cost of attention scales quadratically with the number of tokens, creating a natural tension between context size and reasoning quality.

These findings mean that filling a large context window with everything available is counterproductive. A 200,000-token window filled with 150,000 tokens of project documentation will produce worse results on a specific question than a 200,000-token window loaded with 6,000 tokens of precisely relevant information.

### 3.3 The Practical Budget

The framework establishes a standard working load of approximately 6,000 tokens for document context, leaving over 90% of the context window available for the conversation itself. This budget is allocated as follows:

| Component | Token Budget |
|---|---|
| Anchor Doc | ~650 |
| One Workstream Brief or Deep Dive | ~3,000 |
| Decision Log | ~2,000 |
| User prompt and instructions | ~200–500 |
| **Total document load** | **~6,000** |
| Remaining for AI reasoning and response | ~122,000+ |

This allocation ensures the model has deep, focused context for the current task while retaining the full capacity of the window for complex reasoning and extended output.

---

## 4. Document Architecture

The framework defines seven document types, each with a specific role, hard size constraint, and clear rules about when and how it should be loaded into an AI session. The documents form a hierarchical structure with explicit cross-references between layers.

### 4.1 The Anchor Doc

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

### 4.2 Workstream Briefs

**Role:** The primary working document for each major component of the idea. One brief per workstream, stored as a separate file.

**Size Limit:** 4 pages maximum (~3,000 tokens)

**Rationale:** The workstream brief is the document you load alongside the Anchor Doc when working on a specific area. By keeping each brief in its own file and within the token budget, you can load exactly one brief per session and still have the vast majority of the context window available for deep work.

**Required Contents:**

- **Header Block:** Workstream name, parent idea reference, one-line goal statement.
- **Scope:** What is included in this workstream. Be specific enough that there is no ambiguity about what belongs here.
- **Boundaries:** What is explicitly excluded and which other workstream owns it. This is the enforcement mechanism for MECE decomposition.
- **Dependencies:** What this workstream requires from other workstreams (inputs) and what it provides to other workstreams (outputs). Reference by workstream name only.
- **Key Decisions:** Significant decisions already made that constrain this workstream's direction. Reference Decision Log entries by ID where applicable.
- **Open Questions:** Unresolved items that need investigation or decision.
- **Current Status:** A brief summary of where this workstream stands — not started, in progress, or complete, with one to two sentences of elaboration.

**Critical Rule:** A workstream brief must not contain substantive content that belongs to another workstream. When a topic arises that crosses workstream boundaries, insert a cross-reference (e.g., "Revenue model details are maintained in Workstream 4: Monetization") and stop. Do not elaborate. The AI will use these cross-references to tell you when it needs a document that isn't currently loaded.

**Splitting Rule:** If a workstream brief exceeds the 4-page limit, this signals that the workstream is too broad and should be decomposed into sub-workstreams, each with its own brief. The size limit is not a formatting constraint — it is a structural signal.

---

### 4.3 Deep Dive Docs

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

### 4.4 The Decision Log

**Role:** A running record of every significant decision made about the idea, with sufficient context to prevent the AI from suggesting previously rejected approaches.

**Size Limit:** 2 pages maximum (~2,000 tokens)

**Rationale:** The Decision Log exists because the AI has no memory of prior conversations. Without it, the AI will repeatedly suggest approaches you have already considered and rejected, propose solutions that violate constraints you have already established, or generate output that contradicts decisions you have already made. The Decision Log is the mechanism that gives the AI awareness of your decision history.

**Required Fields Per Entry:**

- **Decision ID:** A sequential identifier (D-001, D-002, etc.) for cross-referencing from other documents.
- **Decision:** What was decided, in one sentence.
- **Rationale:** Why this decision was made and what alternatives were considered, in one to two sentences.
- **Affected Workstreams:** Which workstreams are impacted by this decision.

**Archival Rule:** When the Decision Log exceeds 2 pages, archive older decisions into a separate Decision Archive file. Retain only recent and currently active decisions in the main log. The archive can be loaded on demand for historical context but should not be part of the standard session load.

---

### 4.5 The Question Queue

**Role:** A prioritized list of open questions, unknowns, and items that need investigation across all workstreams.

**Size Limit:** 1 page maximum (~650 tokens)

**Rationale:** During any working session, questions will arise that belong to a different workstream or require investigation you cannot do immediately. Without a capture mechanism, these items are lost between sessions. The Question Queue provides a lightweight, persistent store for these threads so they can be picked up in the appropriate context later.

**Required Fields Per Entry:**

- **Question ID:** A sequential identifier (Q-001, Q-002, etc.).
- **Question:** The open question, stated concisely.
- **Workstream:** Which workstream this question belongs to.
- **Priority:** Now (blocking current work), Next (needed soon), or Later (important but not urgent).

**Triage Discipline:** During the weekly reconciliation session, review all entries. Promote resolved questions into the Decision Log if a decision was made. Remove questions that are no longer relevant. Reassign priorities as the project evolves.

---

### 4.6 The Inbox

**Role:** A zero-friction capture point for new ideas, tangential thoughts, and items that arise while working on something else.

**Size Limit:** None (append-only, reviewed periodically)

**Rationale:** The Inbox solves a different problem than the Question Queue. The Question Queue captures open questions within the current project. The Inbox captures anything — new project ideas, "what if" thoughts, research leads, feature inspirations, tangential observations — that occurs while you are focused on something else. The critical requirement is that appending an entry takes no more than thirty seconds and requires no categorization, prioritization, or elaboration. Any friction in the capture process means ideas will be lost.

**Required Fields Per Entry:**

- **Content:** The idea, observation, or thought in one to two sentences. Capture only — no elaboration.

**Triage Discipline:** During the weekly reconciliation session, review all inbox entries. For each entry, take one of three actions: promote to the Question Queue of a specific workstream if it is an open question about an existing project; create a new Anchor Doc if the idea deserves its own project; or discard if the thought no longer seems valuable.

The Inbox applies David Allen's GTD (Getting Things Done) inbox principle: the mind releases an idea once it trusts it has been captured in a reliable external system, allowing you to maintain focus on the current task without the cognitive overhead of holding unrelated thoughts.

---

### 4.7 The Index

**Role:** A one-page master navigation map of all documents in the system.

**Size Limit:** 1 page maximum (~650 tokens)

**Rationale:** As the document set grows, you need a way to quickly identify which documents to load for any given question. The Index provides this at a glance, preventing the common failure of loading too many documents (bloating the context) or too few (creating information gaps).

**Required Fields Per Entry:**

- **Document Name:** Including type designation (Brief, Deep Dive, etc.).
- **Status:** Draft, Active, Stable, or Archived.
- **Summary:** One-line description of what the document contains.

**Additional Content:**

- **Dependency Map:** A brief notation of which workstreams depend on each other, enabling you to identify which documents to load for cross-cutting questions.

---

## 5. Document Contract Headers

### 5.1 The Problem Headers Solve

When an AI encounters a document, it has no way to know what that document *is* unless the document tells it. A list of raw ideas in an inbox looks structurally identical to a list of confirmed requirements. A draft exploration looks identical to a finalized specification. Without explicit classification, the AI will treat all text with equal authority — which means unvetted shower thoughts can be acted upon as committed decisions, and open questions can be interpreted as settled facts.

This is not a hypothetical risk. Research into context poisoning has documented that when incorrect or unvalidated information enters the context window, the AI will reference it repeatedly in subsequent responses, compounding the error. DeepMind observed this phenomenon in agent systems where false information in a goals document caused cascading nonsense in downstream outputs.

The solution is a standardized header block at the top of every document that functions as a contract between the human and the AI. The header declares what the document is, what authority its contents carry, and how the AI should treat it.

### 5.2 Industry Precedent

The practice of embedding structured metadata at the top of files intended for AI consumption has become an industry standard across multiple platforms and toolchains.

**YAML Frontmatter.** Anthropic's Agent Skills system, GitHub Copilot's custom agents, and the cross-platform AGENTS.md specification all use YAML frontmatter — a block of structured key-value pairs enclosed between triple-dash delimiters (`---`) at the top of a Markdown file. The frontmatter carries machine-readable metadata (name, description, permissions, version), while the Markdown body below carries the human-readable content. This two-part structure — metadata header followed by content — has become the de facto standard for AI-consumed documents in 2025.

**Progressive Disclosure.** Anthropic's Skills architecture uses a three-tier loading strategy: at session start, the AI reads only the name and description from each available document (approximately 100 tokens of metadata). Only when a document becomes relevant does the AI load the full body. This validates the principle that a small, well-structured header can carry enough information for the AI to make correct decisions about how to handle the document without reading its full contents.

**Three-Tier Boundaries.** GitHub's analysis of over 2,500 agent configuration repositories found that the most effective agent files use a three-tier boundary system: "always do," "ask first," and "never do." This pattern translates directly to document authority levels — some documents contain directives the AI should always follow, others contain information it should reference but verify, and others contain raw material it should never act upon without human approval.

**XML Semantic Tags.** Anthropic's prompt engineering guidance recommends wrapping distinct content types in labeled tags (such as `<instructions>`, `<context>`, `<examples>`) so the model can parse the role of each section. The document contract header applies this same principle at the file level — the header is a semantic label for the entire document.

### 5.3 The Standard Header Format

Every document in the Context Architecture Framework uses a YAML frontmatter header that declares three essential properties: what the document is, what authority it carries, and how the AI should handle its contents.

```yaml
---
type: [document type]
authority: [authority level]
status: [document status]
parent: [parent document reference]
handling: [explicit AI handling instruction]
---
```

**Field Definitions:**

**type** — The document's role in the framework hierarchy. One of: `anchor`, `workstream-brief`, `deep-dive`, `decision-log`, `question-queue`, `inbox`, or `index`.

**authority** — How the AI should weight the contents. Three levels:

- **directive** — Contents represent committed decisions and established constraints. The AI should treat these as ground truth and never contradict or work around them without explicit human instruction. Used for: Anchor Doc, Decision Log.
- **working** — Contents represent the current best understanding of a topic and are actively being developed. The AI should use these as context for its work but may suggest modifications, identify gaps, or propose alternatives. Used for: Workstream Briefs, Deep Dive Docs.
- **raw** — Contents are unvetted, unvalidated, and unevaluated. The AI must not treat any item as a decision, requirement, or constraint. Items exist only for future triage. The AI may help organize or evaluate raw items when explicitly asked, but must never act on them autonomously. Used for: Inbox, Question Queue.

**status** — The document's lifecycle state. One of: `draft` (under initial construction), `active` (current and being worked on), `stable` (complete and not expected to change frequently), or `archived` (retained for reference, no longer current).

**parent** — A reference to the document's parent in the hierarchy. For the Anchor Doc, this is the project name. For Workstream Briefs, this is the Anchor Doc. For Deep Dives, this is the parent Workstream Brief. This field enables the AI to understand where the document sits in the structure even when loaded in isolation.

**handling** — A plain-language instruction that tells the AI exactly how to treat the document's contents. This is the most critical field for preventing misinterpretation. It is written as a direct instruction to the AI.

**Note on dates:** The framework intentionally omits date fields from frontmatter. When documents are stored in a Git repository, modification history is tracked automatically by version control. Manually maintained dates add maintenance overhead without providing information that Git does not already capture. If a document is shared outside of Git (for example, pasted directly into a chat session), the authority and handling fields provide the information the AI actually needs to treat the content correctly — a date alone does not prevent misinterpretation.

### 5.4 Standard Headers by Document Type

**Anchor Doc:**
```yaml
---
type: anchor
authority: directive
status: active
parent: [project name]
handling: >
  This is the master reference for the entire project.
  Treat all contents as established ground truth.
  Do not contradict or expand beyond the scope defined here.
  If your task touches a workstream not currently loaded,
  flag it rather than speculating.
---
```

**Workstream Brief:**
```yaml
---
type: workstream-brief
authority: working
status: active
parent: anchor-doc
handling: >
  This is an active working document for a single workstream.
  Use its contents as context for your work.
  You may suggest modifications or identify gaps.
  Do not incorporate details from other workstreams
  unless they are explicitly loaded in this session.
---
```

**Deep Dive Doc:**
```yaml
---
type: deep-dive
authority: working
status: active
parent: workstream-brief-[name]
handling: >
  This is a detailed exploration of a specific topic.
  Use its contents as context for your work.
  You may suggest modifications or identify gaps.
  This document's scope is narrow — do not generalize
  its contents to the broader workstream without checking
  the parent brief.
---
```

**Decision Log:**
```yaml
---
type: decision-log
authority: directive
status: active
parent: anchor-doc
handling: >
  Every entry in this document is a committed decision.
  Do not suggest alternatives to recorded decisions
  unless explicitly asked to revisit one.
  Do not propose approaches that contradict these decisions.
  If you see a conflict between a decision here and content
  in another document, the decision log takes precedence.
---
```

**Question Queue:**
```yaml
---
type: question-queue
authority: raw
status: active
parent: anchor-doc
handling: >
  These are open, unresolved questions.
  Nothing in this document has been decided.
  Do not treat any question as a settled requirement.
  You may help investigate or analyze questions
  when asked, but do not assume answers.
---
```

**Inbox:**
```yaml
---
type: inbox
authority: raw
status: active
parent: anchor-doc
handling: >
  CAUTION: This is a raw capture file.
  Nothing here has been evaluated, validated, or approved.
  Do not implement, act on, or treat any entry as a
  decision, requirement, or directive.
  You may help organize or evaluate entries only when
  the user explicitly asks you to triage the inbox.
---
```

**Index:**
```yaml
---
type: index
authority: raw
status: active
parent: anchor-doc
handling: >
  This is a navigation aid only.
  It contains no substantive project content.
  Use it to understand what documents exist and their
  current status. Do not infer project details from
  document titles or summaries listed here.
---
```

### 5.5 Why YAML Frontmatter

The framework uses YAML frontmatter for four reasons.

First, it is the established convention. Anthropic's SKILL.md files, GitHub Copilot's agent definitions, OpenAI Codex's AGENTS.md files, VS Code's .instructions.md files, and the cross-platform AGENTS.md specification all use YAML frontmatter as their metadata format. Using the same format means that AI models are extensively trained to parse and respect it.

Second, it separates metadata from content. The triple-dash delimiters (`---`) create a clear visual and structural boundary between "instructions about this document" and "the document itself." This prevents the AI from conflating handling instructions with substantive content.

Third, it is human-readable. Unlike JSON or XML, YAML uses indentation and plain-language key names that are easy for the solo operator to read, write, and maintain without tooling.

Fourth, it supports the progressive disclosure pattern. The frontmatter can be scanned quickly (under 100 tokens in most cases) to determine whether the full document needs to be loaded, enabling efficient context management.

### 5.6 The Handling Field as a Circuit Breaker

The `handling` field deserves special emphasis because it is the primary defense against the most dangerous failure mode in AI collaboration: the AI treating unvetted content as actionable.

In agentic coding tools, this problem is addressed through permission boundaries — agents are explicitly told what files they can and cannot modify. In conversational AI, there is no equivalent permission system. The handling field fills this gap by embedding the permission boundary directly in the document itself.

The handling instruction is written as a direct imperative to the AI, not as a description for humans. It uses the second person ("Do not," "You may," "Treat these as") because this is the format that language models are most reliably trained to follow. Research from Anthropic's skill authoring best practices confirms that stronger directive language ("MUST," "Do not") produces more consistent compliance than passive descriptions ("these are typically," "this usually contains").

---

## 6. Repository Configuration with AGENTS.md

### 6.1 Purpose

When this document set is stored in a Git repository, the repository itself needs a way to communicate the framework's rules to any AI tool that opens it. Without this, an AI agent could encounter the project's files with no understanding of the document hierarchy, authority levels, or handling requirements — defeating the purpose of the entire system.

The AGENTS.md file solves this. It is a cross-platform open standard — supported by Claude Code, OpenAI Codex, GitHub Copilot, Cursor, Amp, Jules, Aider, and most other AI coding and collaboration tools — that provides AI-readable instructions at the repository root. When an AI agent opens the repository, it reads AGENTS.md before doing anything else. For tools that use a different convention (such as Claude Code's CLAUDE.md), a symlink or one-line redirect ensures compatibility.

### 6.2 Placement

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

### 6.3 AGENTS.md Contents

The AGENTS.md file should contain the following sections, written as direct instructions to the AI:

**Project Description.** A one-sentence statement that this repository is a structured knowledge project managed under the Context Architecture Framework, not a code repository.

**Document Hierarchy.** A brief explanation of the seven document types and their roles, so the AI understands the structure without needing to read the full framework methodology document.

**Authority Levels.** A clear definition of the three authority levels (`directive`, `working`, `raw`) and how the AI should treat content at each level. This is the most critical section — it is the repository-level defense against context poisoning.

**Frontmatter Contract.** An instruction that every document in the repository carries YAML frontmatter that declares its type, authority, status, parent, and handling rules. The AI must read and respect this frontmatter before processing any document's contents.

**Loading Rules.** Instructions on which documents to load together and which to keep separate. At minimum: never load all documents at once; always load `anchor.md` when working on any task; load only one workstream brief or deep dive per session alongside the anchor and decision log.

**Handling Boundaries.** A three-tier boundary list following the convention established across the AI tooling ecosystem:

- **Always do:** Read frontmatter before processing any document. Respect authority levels. Flag when you need information from a document not currently loaded.
- **Ask first:** Before modifying any document with `authority: directive`. Before acting on any content from a document with `authority: raw`.
- **Never do:** Treat inbox entries as requirements or decisions. Combine content from multiple workstreams without explicit instruction. Speculate about content in documents you have not been given.

### 6.4 Tool Compatibility

For tools that do not natively read AGENTS.md, create a redirect file. For example, for Claude Code, create a `CLAUDE.md` at the repository root containing:

```markdown
Strictly follow the rules in ./AGENTS.md
```

Alternatively, use a symlink:

```bash
ln -s AGENTS.md CLAUDE.md
```

This ensures that regardless of which AI tool opens the repository, it receives the same operating instructions.

---

## 7. Context Loading Strategy

Not all documents should be loaded in every session. The framework defines specific loading patterns based on the type of work being performed.

### 7.1 Loading Decision Tree

**Starting a broad exploration or brainstorming session:**
Load the Anchor Doc only. Ask the AI to reason about the idea at the highest level. This keeps the context clean and avoids biasing the conversation with implementation details.

**Working on a specific workstream:**
Load the Anchor Doc, the relevant Workstream Brief, and the Decision Log. This is the standard working configuration, consuming approximately 6,000 tokens and leaving the vast majority of the context window free.

**Going deep on a specific topic:**
Load the Anchor Doc, the relevant Deep Dive Doc, and the Decision Log. The Workstream Brief is not needed because the Deep Dive's header block provides the necessary structural context.

**Answering a cross-cutting question that spans multiple workstreams:**
Load the Anchor Doc, the specific briefs for the affected workstreams, and the Decision Log. Use the Index to identify exactly which documents are relevant. Do not load all documents — load only those that are directly involved.

**Reviewing overall progress and coherence:**
Load the Anchor Doc, the Index, and the Question Queue. Ask the AI to identify gaps, contradictions, stale items, or missing connections based on the document summaries.

### 7.2 The Loading Principle

Every loading decision should follow a single principle: load the minimum set of documents that gives the AI complete information for the current task. "Complete" means the AI does not need to guess or infer anything that exists in an unloaded document. "Minimum" means nothing is loaded that is not directly relevant.

If you are unsure whether a document is needed, err on the side of not loading it and instead instruct the AI to flag any questions that require information it does not have.

---

## 8. Workflow

The framework follows a six-phase workflow. Each phase builds on the previous one, and the phases are designed to be executed in separate AI sessions to maintain clean context.

### Phase 1: Capture

**Objective:** Transform raw, unstructured thinking into a clean Anchor Doc.

**Process:** Begin with whatever you have — messy notes, voice transcripts, scattered thoughts, a stream-of-consciousness brain dump. Paste the raw material into a single AI session and work with the AI to distill it into a 500-word Anchor Doc. This is the only phase where you load a large volume of unstructured text into the context. The goal is to exit this phase with a tight, structured summary and a preliminary list of 3–7 workstreams.

**Output:** Anchor Doc (draft).

### Phase 2: Decompose

**Objective:** Validate and refine the workstream structure using MECE principles.

**Process:** Load the draft Anchor Doc and work with the AI to challenge the decomposition. Test each workstream for overlap (are any two workstreams covering the same territory?), test the full set for completeness (is anything missing?), and test each workstream for appropriate scope (is any single workstream trying to do too much?). Adjust the workstream list and update the Anchor Doc.

**Output:** Anchor Doc (final), initial Index.

### Phase 3: Elaborate

**Objective:** Create a Workstream Brief for each workstream.

**Process:** For each workstream, start a fresh AI session. Load the Anchor Doc and build the brief through structured conversation. Do not work on multiple workstreams in the same session. Context pollution between workstreams — where the AI starts blending details from one area into another — is one of the most common sources of drift and hallucination.

**Output:** One Workstream Brief per workstream, updated Index.

### Phase 4: Deepen

**Objective:** Create Deep Dive Docs for topics flagged during elaboration as needing more detail.

**Process:** For each topic requiring a Deep Dive, start a fresh AI session. Load the Anchor Doc and work on the specific topic. Not every workstream will require Deep Dives immediately — apply progressive elaboration and only deepen where depth is currently needed.

**Output:** Deep Dive Docs as needed, updated Index.

### Phase 5: Build

**Objective:** Execute on the idea — write code, create designs, draft content, build systems.

**Process:** For each working session, load the standard context package: Anchor Doc + the relevant Brief or Deep Dive + the Decision Log. Work with the AI on the specific task. At the end of each session, extract any decisions made, questions raised, and document updates needed. Update the Decision Log, Question Queue, and any modified documents before the next session.

**Output:** Work product, updated Decision Log and Question Queue.

### Phase 6: Reconcile

**Objective:** Maintain coherence across the entire document set.

**Frequency:** Weekly, or whenever you sense that documents may have drifted out of sync.

**Process:** Load the Anchor Doc, the Index, and the Question Queue. Review for: workstreams that have grown beyond their defined scope, open questions that should have been resolved, gaps in coverage where the Anchor Doc promises something no workstream owns, stale information that no longer reflects the current state of the idea, and inbox items that need triage. Update documents as needed.

**Output:** Updated Anchor Doc, Index, Question Queue, and triaged Inbox.

---

## 9. Document Size Limits

These limits are non-negotiable constraints derived from the mechanics of how language models process context. Exceeding them degrades AI performance and increases the risk of hallucination.

| Document Type | Maximum Length | Approximate Token Budget | Rationale |
|---|---|---|---|
| Anchor Doc | 1 page / 500 words | ~650 tokens | Must fit alongside any other document with room to spare |
| Workstream Brief | 4 pages / 2,500 words | ~3,000 tokens | Must fit alongside Anchor Doc + Decision Log + prompt |
| Deep Dive Doc | 4 pages / 2,500 words | ~3,000 tokens | Same budget as a Brief; loaded in its place |
| Decision Log | 2 pages / 1,500 words | ~2,000 tokens | Must fit alongside Anchor Doc + one Brief |
| Question Queue | 1 page / 500 words | ~650 tokens | Lightweight reference, not a working document |
| Inbox | No limit | N/A | Append-only; never loaded into AI context as-is |
| Index | 1 page / 500 words | ~650 tokens | Navigation only; no substantive content |

**The Splitting Rule:** When any document exceeds its size limit, this is a signal that the content needs further decomposition — not that the limit should be increased. A Workstream Brief that exceeds 4 pages indicates the workstream is too broad and should be split into sub-workstreams. A Deep Dive Doc that exceeds 4 pages indicates the topic should be divided into multiple Deep Dives. A Decision Log that exceeds 2 pages indicates older decisions should be archived.

---

## 10. Anti-Patterns

The following failure modes are the most commonly observed when working with AI on complex ideas. Each one leads to degraded output quality, hallucination, or loss of coherence.

**Loading everything at once.** Pasting the entire idea — or even multiple workstream briefs — into a single session overwhelms the context window and degrades the AI's ability to focus on the specific task. Load the minimum required context for the task at hand.

**Working on multiple workstreams in one session.** When the AI holds details from multiple workstreams simultaneously, it will begin blending them — applying decisions from one area to another, mixing terminology, or creating false dependencies. Maintain one workstream per session.

**Allowing the AI to elaborate beyond loaded context.** When the AI encounters a gap in the information it has been given, it will fill the gap with plausible-sounding content rather than flagging the gap. Always instruct the AI to identify missing context rather than speculating.

**Neglecting document updates after sessions.** Every productive AI session generates decisions, raises questions, and may change the state of documents. If these changes are not captured immediately, subsequent sessions will operate on stale information, compounding drift across the document set.

**Omitting the Anchor Doc.** The AI has no memory between sessions. Omitting the Anchor Doc means the AI is operating without knowledge of the idea's full scope, boundaries, and structure. This is the single most common cause of the AI producing output that is technically sound but strategically wrong.

**Exceeding document size limits.** The limits exist because of how attention mechanisms work in transformer architectures. A document that exceeds its budget does not simply "take up more space" — it actively degrades the AI's ability to attend to all the information present. Breaking the limits introduces the very failure mode the framework is designed to prevent.

**Trusting AI references to information not provided.** If the AI produces output that references specific details from a document you did not load, those details are fabricated. The AI does not have access to your other documents unless you explicitly provide them. Verify any claims against your actual document set.

**Skipping the weekly reconciliation.** Without regular reconciliation, documents drift. Scope boundaries blur. Decisions made in one workstream fail to propagate to dependent workstreams. The Question Queue accumulates stale entries. The reconciliation session is the mechanism that keeps the entire system coherent.

**Loading documents without contract headers.** A document without a frontmatter header provides the AI with no signal about the authority level or handling requirements of its contents. The AI will default to treating all text as equally authoritative, which means raw inbox captures can be acted upon as requirements and open questions can be treated as settled decisions. Every document in the system must carry its contract header before being loaded into an AI session.

---

## 11. System Overview

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
Anchor Doc (~650) + Workstream Brief (~3,000) + Decision Log (~2,000) = ~6,000 tokens

This leaves approximately 122,000 tokens (in a 128K window) or 194,000 tokens (in a 200K window) available for the conversation, reasoning, and response generation.

---

## 12. Guiding Principles

1. **Context is a finite resource.** Treat every token loaded into the context window as having a cost. The cost is not financial — it is attentional. Every irrelevant token dilutes the AI's focus on the tokens that matter.

2. **The smallest effective context produces the best results.** Do not load more than the task requires. The AI's performance on a focused question improves when it has focused context, not comprehensive context.

3. **Document size limits are structural signals.** When a document exceeds its limit, the content needs decomposition — not compression. The limit tells you the idea has reached a level of complexity that requires a finer-grained breakdown.

4. **The AI does not know what it does not have.** Without explicit instruction, the AI will fill information gaps with plausible fabrications rather than flagging them. Structure your documents so the AI can identify its own knowledge boundaries, and instruct it to flag gaps rather than filling them.

5. **Every session starts from zero.** The AI has no memory of prior conversations. The Anchor Doc, Decision Log, and relevant brief must be reloaded every time. There are no shortcuts to re-establishing context.

6. **Capture is cheap; retrieval is expensive.** Recording a decision, question, or idea in the appropriate document takes seconds. Reconstructing that information after it has been lost takes orders of magnitude more effort — and the reconstruction may be wrong.

7. **Reconciliation prevents decay.** Without regular review, the document set will drift out of alignment with the actual state of the idea. The weekly reconciliation session is not optional overhead — it is the mechanism that keeps the system trustworthy.

8. **One workstream per session.** Context pollution between workstreams is one of the primary drivers of hallucination and drift. Maintaining focus in each session is not a productivity technique — it is a quality control measure.
