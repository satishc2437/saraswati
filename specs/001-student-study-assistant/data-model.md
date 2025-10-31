# Data Model: Student Study Assistant (Phase 1)

## Overview

Logical data structures for V1 focusing on metadata, extracted text, notes, annotations, collections, AI conversations, and logging correlation.

## Entities

### 1. Student

| Field             | Type                                    | Constraints        | Notes                    |
| ----------------- | --------------------------------------- | ------------------ | ------------------------ |
| id                | UUID                                    | PK                 | Immutable                |
| display_name      | string                                  | 2-100 chars        | Shown in UI              |
| email             | string                                  | valid email unique | Auth mapping             |
| auth_provider     | enum(GOOGLE, FACEBOOK, MICROSOFT, TEST) | required           | TEST for dev automation  |
| created_at        | timestamp UTC                           | required           | Set on creation          |
| layout_prefs      | json                                    | optional           | Panel sizes/mode         |
| redaction_enabled | boolean                                 | default false      | Logging redaction toggle |

### 2. StudyMaterial

| Field           | Type                                         | Constraints               | Notes                                              |
| --------------- | -------------------------------------------- | ------------------------- | -------------------------------------------------- |
| id              | UUID                                         | PK                        |                                                    |
| owner_id        | UUID                                         | FK Student.id             | index                                              |
| title           | string                                       | 1-200 chars               | Derived or user provided                           |
| type            | enum(PDF, PPT, DOC, DOCX, WEB_ARTICLE, NOTE) | required                  |                                                    |
| reference_type  | enum(LocalReference, WebArticle, Note)       | required                  |                                                    |
| local_path_hash | string                                       | optional                  | Hash of path for mismatch detection (not raw path) |
| size_bytes      | int                                          | >=0                       | From metadata                                      |
| last_indexed_at | timestamp UTC                                | optional                  | null until extraction done                         |
| tags            | string[]                                     | each 1-40 chars           | case-insensitive uniqueness per material           |
| collection_id   | UUID                                         | FK Collection.id nullable |                                                    |
| heading_outline | json                                         | optional                  | headings / slide titles                            |
| extracted_text  | text                                         | optional                  | searchable body                                    |
| created_at      | timestamp UTC                                | required                  |                                                    |
| updated_at      | timestamp UTC                                | required                  |                                                    |
| stale           | boolean                                      | default false             | True if reference broken                           |

### 3. Note (Specialization of StudyMaterial)

Included as type NOTE. Additional fields:
| Field | Type | Constraints | Notes |
|-------|------|------------|-------|
| parent_material_id | UUID | FK StudyMaterial.id nullable | If note linked to doc |
| content_rich | json | required | Rich text structure |

### 4. Annotation

| Field       | Type          | Constraints         | Notes                                      |
| ----------- | ------------- | ------------------- | ------------------------------------------ |
| id          | UUID          | PK                  |                                            |
| material_id | UUID          | FK StudyMaterial.id | index                                      |
| owner_id    | UUID          | FK Student.id       | index                                      |
| location    | json          | required            | {page: int?, slide: int?, anchor: string?} |
| text        | string        | 1-1000 chars        | annotation body                            |
| created_at  | timestamp UTC | required            |                                            |
| updated_at  | timestamp UTC | required            |                                            |

### 5. Collection

| Field       | Type          | Constraints               | Notes              |
| ----------- | ------------- | ------------------------- | ------------------ |
| id          | UUID          | PK                        |                    |
| owner_id    | UUID          | FK Student.id             | index              |
| name        | string        | 1-80 chars                | unique per owner   |
| description | string        | 0-300 chars               | optional           |
| parent_id   | UUID          | FK Collection.id nullable | nested collections |
| created_at  | timestamp UTC | required                  |                    |

### 6. AIConversation

| Field                | Type          | Constraints   | Notes          |
| -------------------- | ------------- | ------------- | -------------- |
| id                   | UUID          | PK            |                |
| owner_id             | UUID          | FK Student.id | index          |
| started_at           | timestamp UTC | required      |                |
| last_activity_at     | timestamp UTC | required      |                |
| correlation_id       | UUID          | required      | links to logs  |
| context_material_ids | UUID[]        | optional      | materials used |

### 7. AIMessage

| Field           | Type              | Constraints          | Notes                           |
| --------------- | ----------------- | -------------------- | ------------------------------- |
| id              | UUID              | PK                   |                                 |
| conversation_id | UUID              | FK AIConversation.id | index                           |
| sender          | enum(STUDENT, AI) | required             |                                 |
| content         | text              | required             | full message                    |
| references      | json              | optional             | list of {material_id, location} |
| created_at      | timestamp UTC     | required             |                                 |
| token_usage     | int               | >=0 optional         | future telemetry                |

### 8. LogEntry (Stored selectively - Error/Warning only)

| Field          | Type                 | Constraints  | Notes                         |
| -------------- | -------------------- | ------------ | ----------------------------- |
| id             | UUID                 | PK           |                               |
| timestamp      | timestamp UTC        | required     |                               |
| level          | enum(ERROR, WARNING) | required     | Info/Trace not persisted      |
| message        | string               | 1-1024 chars | truncated earlier if >4KB     |
| category       | string               | 1-100 chars  | module name                   |
| correlation_id | UUID                 | optional     |                               |
| context        | json                 | optional     | key-value metadata (redacted) |

## Relationships

- Student 1..\* StudyMaterial
- Student 1..\* Collection; Collection self-referential parent
- StudyMaterial 0..\* Annotation
- StudyMaterial 0..\* Note (as specialization) (Note.parent_material_id)
- Student 1.._ AIConversation; AIConversation 1.._ AIMessage

## Indexing & Search

- Inverted index over StudyMaterial.extracted_text + Note.content_rich text blocks.
- Tag and title B-tree indexes for fast filtering.
- Stale materials excluded from default search unless explicitly requested.

## Validation Rules

- Title required unless extracted; fallback: original filename (without extension) truncated 100 chars.
- Tags deduplicated case-insensitive per material (max 20 tags per material).
- Annotation location must include at least one of (page, slide, anchor).
- Collection nesting depth max 5 to prevent runaway hierarchies.
- AIConversation auto-closes (no new messages) after 12 hours inactivity (maintenance job) – sets last_activity_at; archived state tracked externally.

## State Transitions

### StudyMaterial

States: ACTIVE → STALE (reference broken) → ACTIVE (after re-link) → ARCHIVED (future post-V1)

### AIConversation

States: ACTIVE → INACTIVE (timeout) → ARCHIVED (future)

## Integrity & Consistency

- Foreign key constraints enforced for all relationships.
- On Student deletion (future administrative action), cascade archive (not delete) – Post-V1 policy.
- LogEntry retention policy: 30 days rolling for persisted warnings/errors.

## Open Questions (Deferred)

- Automated detection of local file changes (re-index triggers)
- Export format for notes (portable archive spec)
- Metrics schema for future performance telemetry

## Justification

Model prioritizes minimal persistence (no binaries) while enabling search, AI context, and robust logging correlation.
