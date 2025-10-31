# Research & Decisions: Student Study Assistant (Phase 0)

## Overview

This document captures resolution of open technical questions and rationale behind selected approaches for V1.

## Decisions

### 1. Styling Approach

- **Decision**: TailwindCSS + minimal custom utility extensions.
- **Rationale**: Rapid layout prototyping, responsive design ease, consistent spacing/typography system. Reduces CSS handcrafting overhead.
- **Alternatives Considered**:
  - CSS Modules: Greater isolation but slower iteration; more boilerplate.
  - Mantine/Component Library: Faster ready-made components but risk of visual rigidity and unused bundle weight.

### 2. Embeddings vs. Keyword Index (V1)

- **Decision**: V1 uses keyword/phrase inverted index (e.g., Postgres full-text search) only.
- **Rationale**: Simplicity, avoids embedding latency & storage complexity, adequate for early user scale (<500 docs per user). Defers vector search until semantic gaps identified.
- **Alternatives Considered**:
  - Local embedding model: Higher resource usage; complexity for refresh.
  - Hosted vector DB (Pinecone/Qdrant): Operational overhead not justified pre-validation.

### 3. AI Provider Abstraction

- **Decision**: Abstract provider interface with initial implementation targeting OpenAI (gpt-4 class) behind environment-configured key.
- **Rationale**: Mature ecosystem, predictable latency; abstraction preserves switch option to Anthropic/others.
- **Alternatives Considered**:
  - Direct hard-coded OpenAI calls: Faster initial dev but increases coupling.
  - Multiple providers in V1: Added complexity without user benefit.

### 4. Logging Implementation Details

- **Decision**: Structured JSON line logger with facade methods: log_error, log_warn, log_info, log_trace; asynchronous buffer using queue + single writer.
- **Rationale**: Meets non-blocking requirement; easy to ship to multiple sinks.
- **Alternatives Considered**: Direct print/console (no structure), sync file writes (blocking), full observability stack (premature).

### 5. Document Text Extraction Strategy

- **Decision**: Use server-side parsing libraries (PDF text extraction, PPT slide text, DOC/DOCX heading extraction) at reference-time; store extracted plain text + structural markers (page/slide/headings) NOT raw binary.
- **Rationale**: Minimizes storage footprint; supports search & AI context.
- **Alternatives Considered**: Client-side parsing (inconsistent across browsers), storing binary for potential re-processing (increases storage complexity).

### 6. Correlation ID Scheme

- **Decision**: Generate UUIDv4 per incoming request; propagate as header `X-Correlation-ID`; attach to AI sub-requests and extraction tasks.
- **Rationale**: Standard practice simplifies tracing and error diagnostics.
- **Alternatives Considered**: Incremental sequence IDs (not globally unique), hash-of-session+timestamp (collision risk).

### 7. Redaction Policy

- **Decision**: Redact user home directory path segments; keep file name + extension; mask potential email addresses inside logs.
- **Rationale**: Protect privacy while retaining context.
- **Alternatives Considered**: Full path removal (loses debugging context), hashing entire path (less human-friendly).

### 8. Deferred Items (Post-V1)

- Accessibility baseline (keyboard focus order, screen reader labels)
- LLM rate limiting (token usage tracking & per-user quotas)
- Automated re-index detection for moved/changed local files
- Notes export / backup function
- Metrics / tracing adapters

## Summary of Removed NEEDS CLARIFICATION

All previously marked uncertainties have explicit decisions or deferrals documented above.

## Next Steps

Proceed to Phase 1: data-model and API contract design using these decisions.
