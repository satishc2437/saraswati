# Quick Start Guide

Get up and running with the Saraswati project in minutes.

## Prerequisites

Before you begin, ensure you have:

- ✅ **Docker Desktop** installed and running
- ✅ **VS Code** with the "Dev Containers" extension
- ✅ **Git** configured with your credentials

## 5-Minute Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/satishc2437/saraswati.git
cd saraswati
```

### Step 2: Open in VS Code

```bash
code .
```

### Step 3: Start Dev Container

In VS Code:
1. Press `F1` (or `Ctrl+Shift+P`)
2. Type and select: **"Dev Containers: Reopen in Container"**
3. Wait 5-10 minutes for the initial build (first time only)

That's it! Your development environment is ready. ✨

## What's Included?

After the container builds, you'll have:

- 🐍 **Python 3.14** with `uv` package manager
- 📦 **Node.js LTS** with npm
- 📘 **TypeScript** compiler
- ⚛️ **React** (ready to install)
- 🛠️ All necessary VS Code extensions

## Verify Installation

Open the integrated terminal in VS Code and run:

```bash
# Check Python
python --version
# Expected: Python 3.14.x

# Check uv
uv --version
# Expected: uv x.x.x

# Check Node.js
node --version
# Expected: v20.x.x (LTS)

# Check TypeScript
tsc --version
# Expected: Version 5.x.x
```

## Next Steps

### Option A: Python Project

Create a new Python project with uv:

```bash
# Initialize project
uv init my-python-app
cd my-python-app

# Add dependencies
uv add fastapi uvicorn

# Run your app
uv run python main.py
```

### Option B: React + TypeScript Project

Create a new React app with Vite:

```bash
# Create React app
npm create vite@latest my-react-app -- --template react-ts
cd my-react-app

# Install dependencies
npm install

# Start development server
npm run dev
```

### Option C: Full-Stack Project

Combine both:

```
saraswati/
├── backend/          # Python FastAPI
│   ├── pyproject.toml
│   └── main.py
├── frontend/         # React TypeScript
│   ├── package.json
│   └── src/
└── specs/           # Specifications
```

## Understanding Spec-Driven Development

Before writing code, familiarize yourself with our workflow:

1. 📖 **Read**: [SPEC_KIT_GUIDE.md](SPEC_KIT_GUIDE.md)
2. 📝 **Write**: Create a spec using the template in `specs/templates/`
3. 👥 **Review**: Get stakeholder approval
4. 💻 **Implement**: Build according to the spec
5. ✅ **Verify**: Ensure implementation matches requirements

## Essential Commands

### Python (with uv)

```bash
uv init              # Initialize new project
uv add <package>     # Add a package
uv add --dev <pkg>   # Add dev dependency
uv sync              # Install all dependencies
uv run <command>     # Run command in environment
uv pip list          # List installed packages
```

### Node.js / TypeScript

```bash
npm install          # Install dependencies
npm install <pkg>    # Add a package
npm run dev          # Start dev server
npm run build        # Build for production
npm test             # Run tests
tsc                  # Compile TypeScript
```

### Git Workflow

```bash
# Create a feature branch
git checkout -b feature/my-feature

# Create a spec branch
git checkout -b spec/my-spec

# Commit with conventional commits
git commit -m "feat(api): add user endpoint"
git commit -m "docs(spec): add authentication spec"

# Push and create PR
git push origin feature/my-feature
```

## Common Tasks

### Create a Specification

```bash
# Copy the template
cp specs/templates/spec-template.md specs/features/SPEC-010-my-feature.md

# Edit the spec
code specs/features/SPEC-010-my-feature.md

# Create PR for review
git checkout -b spec/my-feature
git add specs/features/SPEC-010-my-feature.md
git commit -m "spec: add my-feature specification"
git push origin spec/my-feature
```

### Start Python Backend

```bash
# Create backend directory
mkdir backend
cd backend

# Initialize with uv
uv init

# Add FastAPI
uv add fastapi uvicorn

# Create main.py
cat > main.py << 'EOF'
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from Saraswati!"}
EOF

# Run the server
uv run uvicorn main:app --reload --port 8000
```

Visit: http://localhost:8000

### Start React Frontend

```bash
# Create frontend with Vite
npm create vite@latest frontend -- --template react-ts

# Navigate and install
cd frontend
npm install

# Start dev server
npm run dev
```

Visit: http://localhost:5173

## Troubleshooting

### Container won't build

```bash
# Rebuild without cache
# In VS Code: F1 → "Dev Containers: Rebuild Container"
```

### Python environment issues

```bash
# Recreate virtual environment
rm -rf .venv
uv sync
```

### Node modules issues

```bash
# Clear and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Port already in use

```bash
# Find process using port (example: 3000)
# On Windows:
netstat -ano | findstr :3000
# Kill the process ID shown

# On Linux/Mac:
lsof -ti:3000 | xargs kill
```

## Documentation

- 📚 [README.md](README.md) - Project overview
- 🛠️ [DEVELOPMENT.md](DEVELOPMENT.md) - Detailed development guide
- 📋 [SPEC_KIT_GUIDE.md](SPEC_KIT_GUIDE.md) - Specification writing guide
- 🐳 [.devcontainer/README.md](.devcontainer/README.md) - Dev Container details

## Getting Help

1. Check the documentation files above
2. Review existing specs in `specs/` directory
3. Look at the issue tracker
4. Ask in team channels

## Tips for Success

✨ **Always start with a spec** - Don't write code without an approved specification

🧪 **Test as you go** - Write tests alongside your implementation

📝 **Document your work** - Update docs when you change code

🔍 **Review carefully** - Both for your code and others'

🤝 **Collaborate** - Ask questions, share knowledge, help teammates

---

**Ready to build?** Start by reading [DEVELOPMENT.md](DEVELOPMENT.md) for the full development workflow!
