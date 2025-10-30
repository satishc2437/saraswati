# Saraswati Dev Container

This development container provides a fully configured environment for the Saraswati project with all necessary tools and dependencies.

## What's Included

### Languages & Runtimes
- **Python 3.14** - Latest Python version
- **Node.js LTS** - Long-term support version with npm
- **TypeScript** - Superset of JavaScript with static typing

### Package Managers
- **uv** (from Astral) - Fast Python package manager and installer
- **npm** - Node package manager

### Development Tools
- Git with sensible defaults
- VS Code extensions for Python, TypeScript, React, and more
- ESLint for JavaScript/TypeScript linting
- Ruff for Python linting and formatting
- Docker tools

### Pre-configured Ports
- **3000** - Frontend (React)
- **5173** - Vite Dev Server
- **8000** - Backend (Python)

## Getting Started

### Prerequisites
- Docker Desktop installed and running
- VS Code with the "Dev Containers" extension

### Opening the Project

1. Open VS Code
2. Open the command palette (F1 or Ctrl+Shift+P)
3. Select "Dev Containers: Reopen in Container"
4. Wait for the container to build and the post-create script to complete

The first build may take several minutes as it downloads the base image and installs all dependencies.

## Using the Dev Container

### Python Development

The container includes `uv` for managing Python dependencies:

```bash
# Initialize a new Python project
uv init

# Add a Python package
uv add <package-name>

# Add a dev dependency
uv add --dev <package-name>

# Sync dependencies from pyproject.toml
uv sync

# Run a Python script
uv run python script.py
```

### Node.js/TypeScript/React Development

```bash
# Install dependencies
npm install

# Add a package
npm install <package-name>

# Run development server (if configured)
npm run dev

# Build for production
npm run build
```

### Available Commands

All standard development commands are available:
- `python` - Python 3.14 interpreter
- `uv` - Python package manager
- `node` - Node.js runtime
- `npm` - Node package manager
- `tsc` - TypeScript compiler
- `git` - Version control

## Customization

### Adding VS Code Extensions

Edit `.devcontainer/devcontainer.json` and add extension IDs to the `customizations.vscode.extensions` array.

### Adding System Dependencies

Edit `.devcontainer/Dockerfile` to install additional system packages using `apt-get`.

### Port Forwarding

Additional ports can be configured in the `forwardPorts` section of `devcontainer.json`.

## Troubleshooting

### Container won't build
- Ensure Docker Desktop is running
- Try rebuilding without cache: Command Palette → "Dev Containers: Rebuild Container"

### uv command not found
- Reopen the container or run the post-create script manually: `bash .devcontainer/post-create.sh`

### Permission issues
- The container runs as the `vscode` user with appropriate permissions
- If you encounter permission issues, check file ownership

## Notes

- The container mounts your local `.git` folder to preserve git history and credentials
- Environment variables and secrets should be configured through VS Code's devcontainer settings
- The post-create script runs automatically when the container is first created
