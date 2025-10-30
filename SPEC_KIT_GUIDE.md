# Spec Kit Integration Guide

This guide explains how to use [Spec Kit](https://github.com/github/spec-kit) in the Saraswati project.

## What is Spec Kit?

Spec Kit is a framework for writing and managing product specifications. It provides:
- Structured specification format
- Version control for specs
- Links between specs and implementation
- Review and approval workflows

## Installation

Spec Kit will be available in the dev container. To install or update:

```bash
# Using uv (Python)
uv add spec-kit

# Or using npm if there's a Node version
npm install -g @github/spec-kit
```

## Specification Structure

A typical spec document includes:

### 1. Frontmatter (Metadata)

```yaml
---
title: Feature Name
author: Your Name
created: 2025-10-30
status: draft  # draft, review, approved, implemented
reviewers:
  - reviewer1
  - reviewer2
---
```

### 2. Overview

Brief description of what the spec covers:

```markdown
## Overview

This specification defines [feature/component] for [purpose].
```

### 3. Problem Statement

```markdown
## Problem Statement

Describe the problem or opportunity this addresses.

### Current State
- What exists today
- Pain points
- Limitations

### Desired State
- What we want to achieve
- Expected outcomes
- Success criteria
```

### 4. Requirements

```markdown
## Requirements

### Functional Requirements
1. The system MUST...
2. The system SHOULD...
3. The system MAY...

### Non-Functional Requirements
1. Performance: ...
2. Security: ...
3. Scalability: ...
```

### 5. Proposed Solution

```markdown
## Proposed Solution

### Architecture
Describe the technical architecture.

### Components
Detail each component:

#### Component A
- Purpose
- Interface
- Dependencies

#### Component B
- Purpose
- Interface
- Dependencies

### Data Models
Define data structures.

### APIs
Document API endpoints.

### UI/UX (if applicable)
Describe user interface and flows.
```

### 6. Implementation Plan

```markdown
## Implementation Plan

### Phase 1: Foundation
- Task 1
- Task 2

### Phase 2: Core Features
- Task 3
- Task 4

### Phase 3: Polish
- Task 5
- Task 6

### Timeline
Estimated dates and milestones.
```

### 7. Testing Strategy

```markdown
## Testing Strategy

### Unit Tests
What to test at the unit level.

### Integration Tests
How components work together.

### End-to-End Tests
User workflows to validate.

### Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3
```

### 8. Risks and Mitigations

```markdown
## Risks and Mitigations

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| Risk 1 | High | Medium | Strategy 1 |
| Risk 2 | Medium | Low | Strategy 2 |
```

### 9. Alternatives Considered

```markdown
## Alternatives Considered

### Alternative 1
Description and why it was not chosen.

### Alternative 2
Description and why it was not chosen.
```

### 10. References

```markdown
## References

- [Related Spec](link)
- [External Documentation](link)
- [Research](link)
```

## Spec Workflow

### Creating a New Spec

1. **Create the spec file:**
   ```bash
   mkdir -p specs
   touch specs/SPEC-001-feature-name.md
   ```

2. **Write the specification:**
   - Use the template structure above
   - Be clear and specific
   - Include diagrams if helpful

3. **Create a PR:**
   ```bash
   git checkout -b spec/feature-name
   git add specs/SPEC-001-feature-name.md
   git commit -m "spec: add specification for feature name"
   git push origin spec/feature-name
   ```

4. **Request review:**
   - Tag relevant reviewers
   - Address feedback
   - Iterate until approved

### Updating an Existing Spec

When implementation reveals needed changes:

1. Update the spec document
2. Increment version or add changelog
3. Get re-approval if changes are significant
4. Link the PR to original spec

### Linking Implementation to Specs

In your code:

```python
# Python example
def important_function():
    """
    Implements the feature defined in SPEC-001-feature-name.
    
    See: specs/SPEC-001-feature-name.md#section-name
    """
    pass
```

```typescript
// TypeScript example
/**
 * Implements the feature defined in SPEC-001-feature-name
 * 
 * @see specs/SPEC-001-feature-name.md#section-name
 */
function importantFunction() {
  // implementation
}
```

In commit messages:

```
feat(auth): implement user authentication

Implements SPEC-001-authentication.md

- Add login endpoint
- Add JWT token generation
- Add middleware for auth checking
```

In PRs:

```markdown
## Description
This PR implements the authentication feature as defined in SPEC-001.

## Related Spec
- [SPEC-001: User Authentication](../specs/SPEC-001-authentication.md)

## Acceptance Criteria
- [x] Users can log in with email/password
- [x] JWT tokens are generated
- [x] Protected routes check authentication
- [ ] Password reset flow (separate PR)
```

## Directory Structure

Organize specs logically:

```
specs/
├── README.md                   # Index of all specs
├── templates/
│   └── spec-template.md       # Template for new specs
├── architecture/
│   ├── SPEC-001-system-architecture.md
│   └── SPEC-002-data-models.md
├── features/
│   ├── SPEC-010-authentication.md
│   ├── SPEC-011-user-profile.md
│   └── SPEC-012-payments.md
└── infrastructure/
    ├── SPEC-020-deployment.md
    └── SPEC-021-monitoring.md
```

## Best Practices

1. **Write specs before code**
   - Clarifies thinking
   - Gets early feedback
   - Prevents rework

2. **Keep specs updated**
   - Reflect implementation reality
   - Document deviations
   - Note lessons learned

3. **Be specific**
   - Use precise language
   - Include examples
   - Define edge cases

4. **Get reviews**
   - Multiple perspectives improve quality
   - Catch issues early
   - Build team alignment

5. **Link everything**
   - Specs to issues
   - Issues to PRs
   - Code to specs

6. **Version control**
   - Track changes over time
   - Maintain history
   - Enable rollback if needed

## Example Spec

See the template below for a complete example:

```markdown
---
title: User Authentication System
author: Engineering Team
created: 2025-10-30
status: approved
version: 1.0
reviewers:
  - tech-lead
  - security-team
---

# User Authentication System

## Overview

This specification defines the user authentication system for Saraswati, 
enabling secure user login and session management.

## Problem Statement

### Current State
- No user authentication exists
- Cannot identify users
- No access control

### Desired State
- Secure user authentication
- Session management
- Role-based access control

## Requirements

### Functional Requirements
1. Users MUST be able to register with email/password
2. Users MUST be able to log in with credentials
3. System MUST generate JWT tokens for authenticated sessions
4. System MUST validate tokens on protected endpoints
5. Users SHOULD be able to reset passwords

### Non-Functional Requirements
1. Passwords MUST be hashed with bcrypt (cost factor 12)
2. JWT tokens MUST expire after 24 hours
3. API response time MUST be < 200ms for auth endpoints
4. System MUST comply with OWASP security guidelines

## Proposed Solution

### Architecture

```
Client → API Gateway → Auth Service → Database
                     ↓
                  JWT Token
```

### Components

#### Auth Service (Python)
- Handles registration, login, token generation
- Uses FastAPI framework
- Connects to PostgreSQL database

#### Token Validator Middleware
- Validates JWT tokens
- Extracts user information
- Enforces access control

### Data Models

```python
class User:
    id: UUID
    email: str
    password_hash: str
    created_at: datetime
    last_login: datetime
```

### APIs

#### POST /auth/register
```json
{
  "email": "user@example.com",
  "password": "SecureP@ss123"
}
```

#### POST /auth/login
```json
{
  "email": "user@example.com",
  "password": "SecureP@ss123"
}
```

Response:
```json
{
  "token": "eyJhbGc...",
  "expires_in": 86400
}
```

## Implementation Plan

### Phase 1: Core Auth (Week 1)
- Database schema
- User registration
- Password hashing

### Phase 2: Token Management (Week 1)
- JWT token generation
- Token validation
- Middleware integration

### Phase 3: Additional Features (Week 2)
- Password reset
- Email verification
- Rate limiting

## Testing Strategy

### Unit Tests
- Password hashing functions
- Token generation/validation
- User model validation

### Integration Tests
- Registration flow
- Login flow
- Protected endpoint access

### Acceptance Criteria
- [x] Users can register
- [x] Users can log in
- [x] Tokens are validated
- [ ] Password reset works
- [ ] Email verification works

## Risks and Mitigations

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| Password breach | High | Low | Use bcrypt with high cost |
| Token theft | High | Medium | Short expiry, HTTPS only |
| Rate limit bypass | Medium | Medium | Implement sliding window |

## Alternatives Considered

### Alternative 1: Session Cookies
- Simpler implementation
- Not chosen: Doesn't work well with API architecture

### Alternative 2: OAuth2 Only
- Better for third-party auth
- Not chosen: Adds complexity for basic auth

## References

- [JWT Best Practices](https://example.com)
- [OWASP Authentication Cheat Sheet](https://example.com)
- [FastAPI Security](https://fastapi.tiangolo.com/tutorial/security/)
```

## Summary

Spec Kit helps maintain clear, versioned specifications that guide development. By following this guide, you ensure that:

1. All work is backed by approved specs
2. Implementations match requirements
3. Changes are tracked and documented
4. Team alignment is maintained

For more information, visit the [Spec Kit repository](https://github.com/github/spec-kit).
