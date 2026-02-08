# Reference

Size limits, anti-patterns, and guiding principles for the Context Architecture Framework.

Related pages: [Document Types](02-document-types.md) for full document specifications, [Contract Headers](03-contract-headers.md) for authority levels and handling rules, [Workflow](04-workflow.md) for loading strategy and the six-phase process.

---

## Document Size Limits

These limits are non-negotiable constraints derived from the mechanics of how language models process context. Exceeding them degrades AI performance and increases the risk of hallucination.

| Document Type    | Maximum Length        | Approximate Token Budget | Rationale                                                |
| ---------------- | --------------------- | ------------------------ | -------------------------------------------------------- |
| Anchor Doc       | 1 page / 500 words    | ~650 tokens              | Must fit alongside any other document with room to spare |
| Workstream Brief | 4 pages / 2,500 words | ~3,000 tokens            | Must fit alongside Anchor Doc + Decision Log + prompt    |
| Deep Dive Doc    | 4 pages / 2,500 words | ~3,000 tokens            | Same budget as a Brief; loaded in its place              |
| Decision Log     | 2 pages / 1,500 words | ~2,000 tokens            | Must fit alongside Anchor Doc + one Brief                |
| Question Queue   | 1 page / 500 words    | ~650 tokens              | Lightweight reference, not a working document            |
| Inbox            | No limit              | N/A                      | Append-only; never loaded into AI context as-is          |
| Index            | 1 page / 500 words    | ~650 tokens              | Navigation only; no substantive content                  |

**The Splitting Rule:** When any document exceeds its size limit, this is a signal that the content needs further decomposition — not that the limit should be increased. A Workstream Brief that exceeds 4 pages indicates the workstream is too broad and should be split into sub-workstreams. A Deep Dive Doc that exceeds 4 pages indicates the topic should be divided into multiple Deep Dives. A Decision Log that exceeds 2 pages indicates older decisions should be archived.

---

## Anti-Patterns

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

## Guiding Principles

1. **Context is a finite resource.** Treat every token loaded into the context window as having a cost. The cost is not financial — it is attentional. Every irrelevant token dilutes the AI's focus on the tokens that matter.

2. **The smallest effective context produces the best results.** Do not load more than the task requires. The AI's performance on a focused question improves when it has focused context, not comprehensive context.

3. **Document size limits are structural signals.** When a document exceeds its limit, the content needs decomposition — not compression. The limit tells you the idea has reached a level of complexity that requires a finer-grained breakdown.

4. **The AI does not know what it does not have.** Without explicit instruction, the AI will fill information gaps with plausible fabrications rather than flagging them. Structure your documents so the AI can identify its own knowledge boundaries, and instruct it to flag gaps rather than filling them.

5. **Every session starts from zero.** The AI has no memory of prior conversations. The Anchor Doc, Decision Log, and relevant brief must be reloaded every time. There are no shortcuts to re-establishing context.

6. **Capture is cheap; retrieval is expensive.** Recording a decision, question, or idea in the appropriate document takes seconds. Reconstructing that information after it has been lost takes orders of magnitude more effort — and the reconstruction may be wrong.

7. **Reconciliation prevents decay.** Without regular review, the document set will drift out of alignment with the actual state of the idea. The weekly reconciliation session is not optional overhead — it is the mechanism that keeps the system trustworthy.

8. **One workstream per session.** Context pollution between workstreams is one of the primary drivers of hallucination and drift. Maintaining focus in each session is not a productivity technique — it is a quality control measure.
