# Development Guide

This guide outlines the development workflow and best practices for the Saraswati project.

## Spec-Driven Development Workflow

### 1. Understand Spec Kit

Before starting development, familiarize yourself with [Spec Kit](https://github.com/github/spec-kit):

- Read the [Spec Kit documentation](https://github.com/github/spec-kit/blob/main/README.md)
- Understand how to create and manage specifications
- Learn the spec file format and structure

### 2. Define Specifications

For any new feature or change:

1. **Create a Specification Document**
   - Use Spec Kit's format
   - Define the problem/opportunity
   - Outline the proposed solution
   - Include acceptance criteria
   - Document technical requirements

2. **Get Stakeholder Review**
   - Share the spec with relevant stakeholders
   - Gather feedback and iterate
   - Get approval before implementation

3. **Track the Spec**
   - Use GitHub Issues to track specs
   - Link specs to implementation work items

### 3. Design Phase

Once specs are approved:

1. **System Design**
   - Define architecture components
   - Create sequence diagrams if needed
   - Plan data models and APIs
   - Consider security and performance

2. **UI/UX Design (if applicable)**
   - Create wireframes in Figma
   - Define user flows
   - Ensure accessibility standards
   - Get design approval

### 4. Implementation

Follow these guidelines during development:

#### Python Development

```bash
# Create a new Python module
uv init

# Add dependencies
uv add <package-name>

# Add dev dependencies (testing, linting, etc.)
uv add --dev pytest ruff black

# Sync environment
uv sync

# Run tests
uv run pytest
```

**Best Practices:**
- Follow PEP 8 style guide
- Use type hints for all functions
- Write docstrings (Google style recommended)
- Keep functions small and focused
- Write unit tests for all new code
- Use Ruff for linting and formatting

#### TypeScript/React Development

```bash
# Install dependencies
npm install

# Add a package
npm install <package-name>

# Run development server
npm run dev

# Run tests
npm test

# Build for production
npm run build
```

**Best Practices:**
- Use TypeScript strict mode
- Define proper types/interfaces
- Use React hooks properly
- Write component tests
- Follow React best practices
- Use ESLint and Prettier

### 5. Code Review

Before submitting a PR:

1. **Self Review**
   - Check code follows standards
   - Ensure tests pass
   - Verify documentation is updated
   - Run linters and formatters

2. **Create Pull Request**
   - Write clear PR description
   - Link to related spec/issue
   - Include screenshots if UI changes
   - Request appropriate reviewers

3. **Address Feedback**
   - Respond to review comments
   - Make requested changes
   - Re-request review after updates

### 6. Testing

#### Python Testing

```python
# Example test structure
import pytest

def test_feature():
    """Test description following the spec."""
    # Arrange
    setup = create_test_data()
    
    # Act
    result = function_under_test(setup)
    
    # Assert
    assert result == expected_value
```

#### TypeScript/React Testing

```typescript
// Example test with React Testing Library
import { render, screen } from '@testing-library/react';

test('renders component correctly', () => {
  render(<Component />);
  expect(screen.getByText('Expected Text')).toBeInTheDocument();
});
```

### 7. Documentation

Keep documentation up to date:

- **Code Comments**: Explain complex logic
- **README Files**: Update as features are added
- **API Documentation**: Document all endpoints
- **Spec Updates**: Reflect implementation changes

## Dev Container Usage

### Starting the Environment

```bash
# In VS Code
1. Open Command Palette (F1 or Ctrl+Shift+P)
2. Select "Dev Containers: Reopen in Container"
3. Wait for initialization
```

### Useful Commands in Container

```bash
# Check Python version
python --version

# Check uv version
uv --version

# Check Node version
node --version

# Check TypeScript compiler
tsc --version

# List Python packages
uv pip list

# List Node packages
npm list
```

## Git Workflow

### Branch Strategy

```bash
# Create feature branch
git checkout -b feature/your-feature-name

# Create bugfix branch
git checkout -b bugfix/issue-description

# Create spec branch (for spec documents)
git checkout -b spec/feature-name
```

### Commit Messages

Follow conventional commits:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding/updating tests
- `chore`: Maintenance tasks
- `spec`: Specification changes

Examples:
```
feat(auth): add user authentication module

fix(api): correct response status code for validation errors

docs(readme): update installation instructions

spec(payments): define payment processing requirements
```

### Git Identity in Dev Container

Because development occurs inside a Dev Container, your host machine's global git configuration (name/email) does not automatically apply. We use a forwarding approach plus a setup script:

1. The container mounts the host `.gitconfig` at `/home/vscode/.host.gitconfig` (if it exists).
2. On creation, `.devcontainer/setup-git-identity.sh` copies `user.name` and `user.email` into the container if they are unset.
3. A commit message template is installed at `.git-commit-template.txt` and configured via `git config commit.template` for consistent messages.

#### Setting Identity Manually

Global (single identity for all repos in container):
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Per-repository (multiple personas):
```bash
git config user.name "Project Persona"
git config user.email "persona@example.com"
```

Enforce explicit config (prevents accidental fallback):
```bash
git config --global user.useConfigOnly true
```

#### Verifying
```bash
git config --list --show-origin | grep -E 'user.name|user.email'
```

#### Commit Template Guidance
The template encourages concise imperative titles (<=50 chars), wrapped body lines (<=72 chars), and optional footers (`BREAKING CHANGE:` / issue references / `Co-authored-by:` entries).

#### Optional Commit Signing
To enable commit signing later:
```bash
git config --global commit.gpgsign true
git config --global gpg.format ssh
git config --global user.signingkey <your-ssh-key-id>
```
Ensure the SSH key is added to your GitHub account with signing enabled.

#### Troubleshooting
If VS Code Source Control reports missing identity despite configuration:
- Re-run: `bash .devcontainer/setup-git-identity.sh`
- Confirm permissions on `/home/vscode/.gitconfig`
- Check for `user.useConfigOnly` blocking fallback values

If host identity should never be copied (privacy concerns), remove the mount from `devcontainer.json`.


## Troubleshooting

### Common Issues

**Python environment issues:**
```bash
# Recreate virtual environment
rm -rf .venv
uv sync
```

**Node modules issues:**
```bash
# Clear and reinstall
rm -rf node_modules package-lock.json
npm install
```

**Dev Container issues:**
```bash
# Rebuild container without cache
# In VS Code: Command Palette → "Dev Containers: Rebuild Container"
```

## Resources

- [Spec Kit Documentation](https://github.com/github/spec-kit)
- [uv Documentation](https://docs.astral.sh/uv/)
- [Python PEP 8 Style Guide](https://peps.python.org/pep-0008/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [React Documentation](https://react.dev/)
- [Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)

## Getting Help

- Review existing specifications and code
- Check this development guide
- Ask in team channels
- Create an issue for bugs or questions

---

**Remember:** Specifications drive development. Always start with a clear spec, get it reviewed, and then implement. This ensures we build the right thing, the right way.
