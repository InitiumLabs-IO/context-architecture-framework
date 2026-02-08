# Contract Headers

YAML frontmatter headers that declare what a document is, what authority it carries, and how the AI should handle it.

The framework defines seven document types — Anchor Doc, Workstream Brief, Deep Dive Doc, Decision Log, Question Queue, Inbox, and Index — each with different authority levels and handling rules. See [Document Types](02-document-types.md) for full descriptions of each type.

---

## The Problem Headers Solve

When an AI encounters a document, it has no way to know what that document _is_ unless the document tells it. A list of raw ideas in an inbox looks structurally identical to a list of confirmed requirements. A draft exploration looks identical to a finalized specification. Without explicit classification, the AI will treat all text with equal authority — which means unvetted shower thoughts can be acted upon as committed decisions, and open questions can be interpreted as settled facts.

This is not a hypothetical risk. Research into context poisoning has documented that when incorrect or unvalidated information enters the context window, the AI will reference it repeatedly in subsequent responses, compounding the error. DeepMind observed this phenomenon in agent systems where false information in a goals document caused cascading nonsense in downstream outputs.

The solution is a standardized header block at the top of every document that functions as a contract between the human and the AI. The header declares what the document is, what authority its contents carry, and how the AI should treat it.

---

## Industry Precedent

The practice of embedding structured metadata at the top of files intended for AI consumption has become an industry standard across multiple platforms and toolchains.

**YAML Frontmatter.** Anthropic's Agent Skills system, GitHub Copilot's custom agents, and the cross-platform AGENTS.md specification all use YAML frontmatter — a block of structured key-value pairs enclosed between triple-dash delimiters (`---`) at the top of a Markdown file. The frontmatter carries machine-readable metadata (name, description, permissions, version), while the Markdown body below carries the human-readable content. This two-part structure — metadata header followed by content — has become the de facto standard for AI-consumed documents in 2025.

**Progressive Disclosure.** Anthropic's Skills architecture uses a three-tier loading strategy: at session start, the AI reads only the name and description from each available document (approximately 100 tokens of metadata). Only when a document becomes relevant does the AI load the full body. This validates the principle that a small, well-structured header can carry enough information for the AI to make correct decisions about how to handle the document without reading its full contents.

**Three-Tier Boundaries.** GitHub's analysis of over 2,500 agent configuration repositories found that the most effective agent files use a three-tier boundary system: "always do," "ask first," and "never do." This pattern translates directly to document authority levels — some documents contain directives the AI should always follow, others contain information it should reference but verify, and others contain raw material it should never act upon without human approval.

**XML Semantic Tags.** Anthropic's prompt engineering guidance recommends wrapping distinct content types in labeled tags (such as `<instructions>`, `<context>`, `<examples>`) so the model can parse the role of each section. The document contract header applies this same principle at the file level — the header is a semantic label for the entire document.

---

## The Standard Header Format

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

**Formatting rule:** Do not use quotes around frontmatter values. YAML does not require quotes for plain strings, and they add visual noise when reading and editing headers. Write all values as unquoted strings.

**Note on dates:** The framework intentionally omits date fields from document frontmatter. When documents are stored in a Git repository, modification history is tracked automatically by version control. Manually maintained dates in headers add maintenance overhead without providing information that Git does not already capture.

**Exception — Question Queue and Inbox entries:** Individual entries within the Question Queue and Inbox include a date field (YYYY-MM-DD) indicating when the entry was captured. This exception exists because Git history is never loaded into AI context. When the AI reads these documents during a working or reconciliation session, dates on individual entries allow it to reason about staleness, urgency, and timeline — for example, flagging a "Now" priority question that has been open for three months, or identifying inbox items that have sat untriaged for weeks. The date is not metadata about the document; it is contextual information about the entry that the AI cannot obtain any other way.

---

## Standard Headers by Document Type

**Anchor Doc:**

```yaml
---
type: anchor
authority: directive
status: active
parent: [project name]
handling: This is the master reference for the entire project. Treat all contents as established ground truth. Do not contradict or expand beyond the scope defined here. If your task touches a workstream not currently loaded, flag it rather than speculating.
---
```

**Workstream Brief:**

```yaml
---
type: workstream-brief
authority: working
status: active
parent: anchor-doc
handling: This is an active working document for a single workstream. Use its contents as context for your work. You may suggest modifications or identify gaps. Do not incorporate details from other workstreams unless they are explicitly loaded in this session.
---
```

**Deep Dive Doc:**

```yaml
---
type: deep-dive
authority: working
status: active
parent: workstream-brief-[name]
handling: This is a detailed exploration of a specific topic. Use its contents as context for your work. You may suggest modifications or identify gaps. This document's scope is narrow — do not generalize its contents to the broader workstream without checking the parent brief.
---
```

**Decision Log:**

```yaml
---
type: decision-log
authority: directive
status: active
parent: anchor-doc
handling: Every entry in this document is a committed decision. Do not suggest alternatives to recorded decisions unless explicitly asked to revisit one. Do not propose approaches that contradict these decisions. If you see a conflict between a decision here and content in another document, the decision log takes precedence.
---
```

**Question Queue:**

```yaml
---
type: question-queue
authority: raw
status: active
parent: anchor-doc
handling: These are open, unresolved questions. Nothing in this document has been decided. Do not treat any question as a settled requirement. You may help investigate or analyze questions when asked, but do not assume answers. Each entry includes an Added date — use this to flag stale questions (e.g., high-priority items open for weeks) during reconciliation.
---
```

**Inbox:**

```yaml
---
type: inbox
authority: raw
status: active
parent: anchor-doc
handling: CAUTION — This is a raw capture file. Nothing here has been evaluated, validated, or approved. Do not implement, act on, or treat any entry as a decision, requirement, or directive. You may help organize or evaluate entries only when the user explicitly asks you to triage the inbox. Each entry is prefixed with a capture date — use this to flag aging items during triage.
---
```

**Index:**

```yaml
---
type: index
authority: raw
status: active
parent: anchor-doc
handling: This is a navigation aid only. It contains no substantive project content. Use it to understand what documents exist and their current status. Do not infer project details from document titles or summaries listed here.
---
```

---

## Why YAML Frontmatter

The framework uses YAML frontmatter for four reasons.

First, it is the established convention. Anthropic's SKILL.md files, GitHub Copilot's agent definitions, OpenAI Codex's AGENTS.md files, VS Code's .instructions.md files, and the cross-platform AGENTS.md specification all use YAML frontmatter as their metadata format. Using the same format means that AI models are extensively trained to parse and respect it.

Second, it separates metadata from content. The triple-dash delimiters (`---`) create a clear visual and structural boundary between "instructions about this document" and "the document itself." This prevents the AI from conflating handling instructions with substantive content.

Third, it is human-readable. Unlike JSON or XML, YAML uses indentation and plain-language key names that are easy for the solo operator to read, write, and maintain without tooling.

Fourth, it supports the progressive disclosure pattern. The frontmatter can be scanned quickly (under 100 tokens in most cases) to determine whether the full document needs to be loaded, enabling efficient context management.

---

## The Handling Field as a Circuit Breaker

The `handling` field deserves special emphasis because it is the primary defense against the most dangerous failure mode in AI collaboration: the AI treating unvetted content as actionable.

In agentic coding tools, this problem is addressed through permission boundaries — agents are explicitly told what files they can and cannot modify. In conversational AI, there is no equivalent permission system. The handling field fills this gap by embedding the permission boundary directly in the document itself.

The handling instruction is written as a direct imperative to the AI, not as a description for humans. It uses the second person ("Do not," "You may," "Treat these as") because this is the format that language models are most reliably trained to follow. Research from Anthropic's skill authoring best practices confirms that stronger directive language ("MUST," "Do not") produces more consistent compliance than passive descriptions ("these are typically," "this usually contains").
