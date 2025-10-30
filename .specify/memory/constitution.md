<!--
Sync Impact Report
Version change: (new) → 1.0.0
Modified principles: (initial set)
Added sections: Core Principles; Technical Constraints & Performance Standards; Delivery Workflow & Quality Gates; Governance
Removed sections: None
Templates requiring updates:
	.specify/templates/plan-template.md ✅
	.specify/templates/spec-template.md ✅
	.specify/templates/tasks-template.md ✅
	.specify/templates/checklist-template.md ✅
Deferred TODOs: None
-->

# Saraswati : Teaching Assistant Platform Constitution
<!-- Initial ratification -->

## Core Principles

### I. Student-Centric Value Delivery
All decisions MUST prioritize measurable learning impact for students: clarity, retention, and reduced cognitive load. Features MUST map to concrete student workflows: understanding lecture content, organizing notes, practicing, and self‑assessment. Any proposed capability without a direct student value statement SHALL be rejected or deferred. UX copy MUST favor plain academic language over implementation jargon.

### II. Knowledge Organization & Unified Context
The platform MUST provide a single, queryable knowledge space aggregating lecture notes, teacher resources, personal annotations, and generated summaries. Content ingestion MUST preserve source attribution. Data structures MUST enable incremental enrichment (summaries, flashcards, concept graphs) without rewriting originals. No feature may fragment knowledge into silos that are not searchable via the unified interface.

### III. Zero Regression Guarantee (Non‑Negotiable)
No merge is permitted if any existing test fails. Existing tests MAY only be modified when (a) documented false positives or flaky behavior is proven OR (b) an intentional, approved behavior change is ratified with an added test capturing the new contract. Rollbacks MUST occur within one business day if a post‑merge regression is identified. CI MUST block on red; skipping tests is forbidden. Performance regressions (p95 latency or memory > defined thresholds) count as failures.

### IV. Test Discipline & Guardrails
All new logic MUST be covered by at least one of: unit test (function-level), contract test (API / CLI boundary), or integration test (student workflow simulation). Fast unit/contract layers MUST be green (<60s total) to enable rapid iteration. Red‑Green‑Refactor is the mandated flow: write failing test → implement → refactor with coverage intact. Mutation or property-based tests SHOULD be added for core parsing, summarization, and retrieval algorithms to reduce silent drift.

### V. High Performance & Resource Efficiency
The system MUST target low-latency study interactions: p95 response < 300ms for retrieval-based answers (excluding first‑time heavy model warmups) and < 2s for complex multi-document synthesis. Memory usage for background indexing MUST stay within configured budgets. Performance budgets MUST be enforced via automated benchmarks; exceeding budget is a release blocker. Implementations MUST prefer algorithmic clarity and data locality over premature micro‑optimizations; however, obvious N^2 or unbounded structures in hot paths are prohibited.

### VI. Evolutionary Improvement & Extensibility
Architectural decisions MUST allow progressive enhancement: plug-in summarizers, new practice modes, or alternative storage engines can be added without rewrites of existing modules. Public interfaces MUST be versioned; breaking changes REQUIRE a migration note plus deprecation window ≥ one minor release. Refactors MUST retain observable behavior unless accompanied by explicit version bumps and tests.

## Technical Constraints & Performance Standards

1. Language: Python (current stable 3.x selected in runtime environment) is the primary runtime.
2. Code/Test Separation: `src/` (or domain packages) for implementation; `tests/` mirrored structure for validation. No production logic inside test helpers.
3. Determinism: Core parsing, indexing, and retrieval functions MUST produce consistent outputs for identical inputs (seeded randomness only when essential).
4. Observability: Structured logging (JSON lines or key=value) at boundaries; request correlation IDs for multi-step queries; metrics for latency, cache efficiency, index freshness, summarization token usage.
5. Performance Budgets (initial): retrieval p95 <300ms; synthesis p95 <2s; background index build throughput ≥ 5 docs/sec on baseline hardware (TODO refine with empirical baselines after first prototype release).
6. Security & Privacy: Student data (notes, assessments) MUST never be logged in raw form; redact or hash sensitive fields.
7. Dependency Policy: Prefer well‑maintained libraries with explicit version pins; transitive heavy dependencies MUST justify benefit vs footprint.

## Delivery Workflow & Quality Gates

1. Plan → Spec → Tasks → Implementation → Review → Merge → Benchmark → Release.
2. Every feature plan MUST include a Constitution Check section referencing which principles it touches and any requested exceptions (rare and time‑boxed).
3. Mandatory CI Gates:
	- Lint & static analysis: PASS required.
	- Unit & contract tests: 100% pass.
	- Integration workflow tests: PASS for impacted features.
	- Performance sentinel: no >5% regression vs last stable baseline in protected metrics.
4. Review Requirements: At least one reviewer validates principle alignment; performance-sensitive code requires evidence (profiling snippet or benchmark result) attached to PR.
5. Release Tagging: Semantic versioning MAJOR.MINOR.PATCH. Hotfixes only allowed for critical runtime breakages or data corruption prevention.
6. Documentation & Onboarding: Each new feature MUST update quickstart or usage docs and add at least one example query / workflow.

## Governance
<!-- Example: Constitution supersedes all other practices; Amendments require documentation, approval, migration plan -->

Authority: This constitution supersedes conflicting informal practices. All contributors are custodians of principles; enforcement is collective.

Amendments: Proposed via PR labeled `constitution-change` containing: rationale, impacted principles, version bump justification, migration/communication notes, and updated Sync Impact Report block. Approval requires ≥2 maintainer approvals (or 1 if project has only one active maintainer) and zero outstanding review objections after 48 hours.

Versioning Policy (Constitution):
 - MAJOR: Removal or fundamental redefinition of a principle; governance process overhaul.
 - MINOR: Addition of a new principle, new mandatory gate, or substantial expansion of a section.
 - PATCH: Clarifications, wording consistency, metrics refinements not changing enforcement intent.

Compliance Review: Quarterly (or before each MINOR release) a formal audit enumerates: test coverage gaps in critical modules, performance drift, deprecated APIs, and open TODO performance metrics. Findings MUST be tracked as tasks with explicit owners.

Exception Handling: Temporary waivers (e.g., performance budget breach) REQUIRE: documented reason, approved expiration date, mitigation tasks filed. Waivers auto-expire and cannot be renewed without fresh justification.

Incident Response: Regressions discovered post‑merge trigger: immediate issue creation, optional rollback within 1 business day, root cause summary within 3 days, preventive action tasks added.

**Version**: 1.0.0 | **Ratified**: 2025-10-30 | **Last Amended**: 2025-10-30
