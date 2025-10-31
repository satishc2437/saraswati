# Implementation Plan: Student Study Assistant Web Application

**Branch**: `001-student-study-assistant` | **Date**: 2025-10-31 | **Spec**: [/specs/001-student-study-assistant/spec.md](spec.md)
**Input**: Feature specification from `/specs/001-student-study-assistant/spec.md`

## Summary

Centralized, browser-based study workspace for MBA students enabling: local file referencing (PDF/PPT/DOC/DOCX), web article ingestion, notes & annotations, AI-assisted Q&A, adjustable multi-panel layout, and structured logging foundation. V1 excludes cloud storage integrations, binary uploads, accessibility deep pass, rate limiting, re-index automation, notes export, metrics/tracing.

## Technical Context

**Language/Version**: Python 3.12 (backend), TypeScript (ES2023) + React for frontend
**Primary Dependencies**: (backend) FastAPI, Pydantic, SQLModel (or PostgreSQL ORM) | (frontend) React, React Router, Zustand (state), TanStack Query (data), TailwindCSS (styling) – NEEDS CLARIFICATION: Final styling lib vs. CSS Modules
**Storage**: PostgreSQL for metadata & notes; local browser IndexedDB for ephemeral caching of extracted text chunks; NO binary file storage in V1
**Testing**: pytest (unit, integration), Playwright (frontend integration/E2E), contract tests using schemathesis or direct OpenAPI validation
**Target Platform**: Linux container deployment (Docker), desktop & tablet browsers (Chrome, Firefox, Safari, Edge)
**Project Type**: Web application (frontend + backend)
**Performance Goals**: Reference registration metadata extraction <10s (SC-001); document open <3s (SC-002); AI Q&A <5s (SC-004); logging overhead <5% per action
**Constraints**: p95 retrieval <300ms (constitution); synthesis (multi-doc AI) <2s; memory for indexing <512MB per worker; no blocking I/O in hot paths; Trace logging disabled by default
**Scale/Scope**: Up to 10k users, 500 referenced documents per user, concurrency target: 300 active users simultaneous (burst)

Unresolved / NEEDS CLARIFICATION:

- Styling approach (Tailwind vs. CSS Modules vs. Mantine) → choose minimal friction
- Choice of embedding model (if needed for semantic search) vs. pure keyword index in V1
- AI provider selection (OpenAI vs. Anthropic vs. others) – abstracted behind provider interface

## Constitution Check

Principles touched:

- Student-Centric Value: Core flows align with learning effectiveness → PASS
- Knowledge Organization: Unified index & search across notes/materials → PASS
- Zero Regression Guarantee: Will establish test suites before merging major flows → PASS
- Test Discipline: Plan includes unit, contract, integration, E2E → PASS
- High Performance: Targets defined for p95 retrieval & synthesis → PASS
- Extensibility: Adapter interfaces for logging & AI provider abstraction → PASS

No violations identified. All gates satisfied for Phase 0.

## Project Structure

### Documentation (this feature)

```text
specs/001-student-study-assistant/
├── spec.md
├── plan.md
├── research.md              # Phase 0 output
├── data-model.md            # Phase 1 output
├── quickstart.md            # Phase 1 output
├── contracts/               # Phase 1 output
└── tasks.md                 # Phase 2 (via /speckit.tasks)
```

### Source Code (repository root)

```text
backend/
├── src/
│   ├── api/          # FastAPI routers
│   ├── core/         # config, logging facade, adapters
│   ├── models/       # ORM / Pydantic models
│   ├── services/     # domain logic (indexing, AI, notes)
│   ├── indexing/     # text extraction, parsing
│   └── auth/         # social + test auth provider
└── tests/
    ├── unit/
    ├── integration/
    ├── contract/
    └── performance/

frontend/
├── src/
│   ├── components/   # UI building blocks
│   ├── pages/        # route-level screens
│   ├── layout/       # panel management & resizing
│   ├── hooks/        # custom hooks (state, api)
│   ├── state/        # Zustand stores
│   ├── services/     # API client, AI client
│   └── styles/       # Tailwind config / global styles
└── tests/
    ├── unit/
    ├── integration/
    └── e2e/
```

**Structure Decision**: Dual project (frontend + backend) enabling clear separation of concerns and independent scaling. Logging & AI provider abstractions reside under `backend/src/core/`.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
| --------- | ---------- | ------------------------------------ |
| (none)    | N/A        | N/A                                  |
