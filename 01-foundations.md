# Foundations

The theory and constraints behind the Context Architecture Framework.

---

## Purpose and Scope

The Context Architecture Framework is a structured methodology for breaking down large, complex ideas into modular documents optimized for collaboration with AI language models. It is designed for solo operators — entrepreneurs, indie developers, researchers, and creators — who use conversational AI assistants as their primary thinking and execution partners.

The framework addresses a specific failure mode: as an idea grows in complexity, it eventually exceeds the AI's ability to hold everything in working memory at once. When the AI operates on incomplete information, it compensates by generating plausible-sounding output that may contradict prior decisions, ignore established constraints, or fabricate details. This is not a reasoning failure. It is a context failure.

The framework treats AI context as a finite, engineerable resource. Every document is designed to fit within strict size limits, carry enough internal structure to be independently understandable, and include explicit markers that tell the AI what information it does and does not have access to. The result is a system where the AI always operates with complete information for the task at hand, rather than partial information about the entire idea.

---

## Theoretical Foundations

The framework draws on established methodologies from consulting, project management, software engineering, and the emerging discipline of context engineering.

### Context Engineering

Context engineering, formalized as a discipline in mid-2025, is the practice of curating and managing the information provided to a language model during inference. The term was popularized by Andrej Karpathy, who described it as "the delicate art and science of filling the context window with just the right information for the next step." The mental model is that the language model functions as a processor (CPU), the context window serves as working memory (RAM), and the human operator acts as the operating system — deciding what data to load, when to load it, and when to discard it.

Anthropic's Applied AI team further established that context must be treated as a resource with diminishing marginal returns. As the volume of tokens in the context window increases, the model's ability to accurately recall and reason over that information degrades — a phenomenon known as context rot. Research has demonstrated that models effectively utilize only 10–20% of very long contexts, and that material positioned in the middle of a large document receives less attention than material at the beginning or end (the "lost in the middle" effect).

The practical implication is that the optimal context is not the largest context, but the smallest set of high-signal information that enables the model to accomplish the current task.

### MECE Decomposition

The MECE principle — Mutually Exclusive, Collectively Exhaustive — originates from McKinsey & Company and Barbara Minto's Pyramid Principle. It requires that any decomposition of a problem satisfy two properties: no element overlaps with another (mutually exclusive), and all elements together cover the full scope of the problem (collectively exhaustive).

This principle governs how the framework decomposes ideas into workstreams. Each workstream must own a distinct, non-overlapping territory. Together, all workstreams must account for the complete idea. When the AI works on one workstream, it should never need to reason about another workstream's content, because the boundaries are clearly drawn.

### Progressive Elaboration

Borrowed from project management (PMBOK), progressive elaboration is the practice of developing plans in increasing levels of detail as more information becomes available. The framework applies this principle by starting with a high-level summary and only deepening detail where and when it is needed. Not every workstream requires the same depth at the same time.

### Architecture Decision Records

The Decision Log within the framework is modeled on Architecture Decision Records (ADRs), a pattern from software engineering originally proposed by Michael Nygard. ADRs capture not just what was decided, but why it was decided and what alternatives were considered. This prevents the same ground from being relitigated and provides essential context for future work.

### Structured Note-Taking and Agentic Memory

Anthropic's engineering team identified structured note-taking as a key technique for long-horizon AI work. The pattern involves the agent periodically writing notes to persistent storage outside the context window, which can be retrieved in later sessions. The framework's Decision Log, Question Queue, and Inbox all function as forms of persistent memory that survive between AI sessions, compensating for the AI's lack of native cross-session memory.

---

## The Context Window Constraint

### How Context Windows Work

A context window is the total amount of text — measured in tokens — that a language model can process in a single interaction. One token corresponds to approximately three-quarters of a word in English. Current models support windows ranging from 128,000 to 200,000 tokens, with some models offering up to 1,000,000 tokens in beta.

The context window must accommodate all of the following simultaneously: the system prompt and model instructions, any documents provided by the user, the user's question or instruction, the model's internal reasoning process, and the model's generated response.

### Why Bigger Is Not Better

Research consistently shows that model performance degrades as context length increases, even within the advertised window size. Attention is not uniformly distributed across the context. Information near the beginning and end of the window receives stronger attention than information in the middle. The computational cost of attention scales quadratically with the number of tokens, creating a natural tension between context size and reasoning quality.

These findings mean that filling a large context window with everything available is counterproductive. A 200,000-token window filled with 150,000 tokens of project documentation will produce worse results on a specific question than a 200,000-token window loaded with 6,000 tokens of precisely relevant information.

### The Practical Budget

The framework establishes a standard working load of approximately 6,000 tokens for document context, leaving over 90% of the context window available for the conversation itself. For the full token budget breakdown by document type, see [Document Types](02-document-types.md).

This allocation ensures the model has deep, focused context for the current task while retaining the full capacity of the window for complex reasoning and extended output.
