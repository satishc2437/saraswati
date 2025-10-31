# Saraswati

## Git Hooks & Code Hygiene

This repository uses [pre-commit](https://pre-commit.com) to enforce consistent formatting and basic hygiene before accepting commits.

Installed hooks:

- end-of-file-fixer: Ensures every file ends with a single newline.
- trailing-whitespace: Strips stray spaces at line ends.
- check-yaml: Validates YAML syntax.
- check-added-large-files: Prevents committing very large blobs accidentally.
- check-merge-conflict: Detects unresolved conflict markers.
- mixed-line-ending (configured to enforce LF): Normalizes line endings.
- check-git-config (local): Verifies that `git user.name` and `git user.email` are set (locally or globally).

### Initial Setup

1. Ensure Python 3.14 is available (a `.venv` should already exist). If recreating:
   ```bash
   uv venv --python 3.14
   source .venv/bin/activate
   ```
2. Install pre-commit:
   ```bash
   pip install pre-commit
   ```
3. Install the git hook scripts:
   ```bash
   pre-commit install
   ```
4. (Optional) Run against the entire codebase to auto-fix issues:
   ```bash
   pre-commit run --all-files
   ```

### Adding or Updating Hooks

Edit the `.pre-commit-config.yaml` file, then run:

```bash
pre-commit autoupdate
pre-commit run --all-files
```

### Common Issues

- Mixed line endings: The `mixed-line-ending` hook will rewrite affected files. Just stage the changes and re-run your commit.
- Missing git identity: Configure it with:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "you@example.com"
  ```
- Hook failing repeatedly: Run with increased verbosity:
  ```bash
  pre-commit run --all-files -v
  ```

### Disabling a Hook Temporarily

You can skip all hooks for a single commit (avoid unless necessary):

```bash
git commit -m "feat: something" --no-verify
```

## Line Ending Normalization

The `.gitattributes` file enforces LF line endings for text and shell scripts. If you are on Windows, ensure your editor respects these settings. Git will normalize line endings on checkout/commit automatically.

A Spec-Driven Development project utilizing [Spec Kit](https://github.com/github/spec-kit) for specification management.

## Overview

Saraswati is built following Spec-Driven Development principles, where specifications guide the development process. This project combines modern Python and TypeScript/React technologies in a well-structured development environment.

## Technology Stack

### Backend

- **Python 3.14** - Latest Python with modern features
- **uv** (Astral) - Fast, modern Python package management

### Frontend

- **TypeScript** - Type-safe JavaScript
- **Node.js LTS** - JavaScript runtime
- **React** - UI library (to be configured)

### Development Environment

- **Dev Container** - Consistent, reproducible development environment
- **Docker** - Container runtime

## Getting Started

### Prerequisites

- Docker Desktop
- VS Code with "Dev Containers" extension

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/satishc2437/saraswati.git
   cd saraswati
   ```

2. Open in VS Code:

   ```bash
   code .
   ```

3. Open in Dev Container:
   - Press `F1` or `Ctrl+Shift+P`
   - Select "Dev Containers: Reopen in Container"
   - Wait for the container to build and initialize

### Development Workflow

The project follows a Spec-Driven Development approach:

1. **Define Specifications** - Use Spec Kit to create and manage specifications
2. **Design Architecture** - Plan system components and interactions
3. **Implement Features** - Develop according to specifications
4. **Review & Test** - Ensure quality and adherence to specs
5. **Iterate** - Refine based on feedback

## Project Structure

```
saraswati/
├── .devcontainer/          # Dev Container configuration
│   ├── devcontainer.json   # Container settings
│   ├── Dockerfile          # Custom image definition
│   ├── post-create.sh      # Setup script
│   └── README.md           # Dev Container documentation
├── .gitignore              # Git ignore rules
├── LICENSE                 # Project license
└── README.md               # This file
```

## Development

### Python Development

Initialize a Python project:

```bash
uv init
uv add <package-name>
uv sync
```

### TypeScript/React Development

Initialize a React project (example with Vite):

```bash
npm create vite@latest frontend -- --template react-ts
cd frontend
npm install
npm run dev
```

## Spec-Driven Development

This project uses [Spec Kit](https://github.com/github/spec-kit) for managing specifications. Key principles:

- **Specifications First** - Define requirements before implementation
- **Living Documentation** - Specs evolve with the project
- **Traceable Changes** - Link code to specifications
- **Collaborative** - Stakeholders review and approve specs

### Using Spec Kit

Refer to the [Spec Kit documentation](https://github.com/github/spec-kit) for detailed usage instructions.

## Contributing

1. Review existing specifications
2. Create or update specs for new features
3. Implement changes following the specs
4. Submit pull requests with clear descriptions
5. Link PRs to related specifications

## Code Standards

### Python

- Follow PEP 8 style guide
- Use type hints
- Write docstrings for functions and classes
- Format code with Ruff

### TypeScript

- Follow TypeScript best practices
- Use strict type checking
- Write meaningful comments
- Use ESLint for linting

## License

See [LICENSE](LICENSE) file for details.

## Team

Project Codename: **Saraswati**
Repository: [satishc2437/saraswati](https://github.com/satishc2437/saraswati)

---

Built with ❤️ using Spec-Driven Development
