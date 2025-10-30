# Project Structure Overview

Visual representation of the Saraswati project structure.

## Directory Tree

```
saraswati/
│
├── 📁 .devcontainer/                    # Dev Container Configuration
│   ├── 📄 devcontainer.json             # Container settings & features
│   ├── 📄 Dockerfile                    # Custom image with Python 3.14 & Node.js
│   ├── 📜 post-create.sh                # Automated setup script
│   └── 📖 README.md                     # Dev Container documentation
│
├── 📁 .github/                          # GitHub Configuration (Existing)
│   ├── 📁 agents/                       # AI Agents
│   │   └── 📄 Seema.agent.md            # Seema agent configuration
│   └── 📁 prompts/                      # Spec Kit Prompts
│       ├── 📄 speckit.analyze.prompt.md
│       ├── 📄 speckit.checklist.prompt.md
│       ├── 📄 speckit.clarify.prompt.md
│       ├── 📄 speckit.constitution.prompt.md
│       ├── 📄 speckit.implement.prompt.md
│       ├── 📄 speckit.plan.prompt.md
│       ├── 📄 speckit.specify.prompt.md
│       └── 📄 speckit.tasks.prompt.md
│
├── 📁 .specify/                         # Spec Kit Setup (Existing)
│   ├── 📁 memory/
│   │   └── 📄 constitution.md           # Project constitution
│   ├── 📁 scripts/                      # Automation scripts
│   │   └── 📁 powershell/
│   │       ├── 📜 check-prerequisites.ps1
│   │       ├── 📜 common.ps1
│   │       ├── 📜 create-new-feature.ps1
│   │       ├── 📜 setup-plan.ps1
│   │       └── 📜 update-agent-context.ps1
│   └── 📁 templates/                    # Spec Kit templates
│       ├── 📄 agent-file-template.md
│       ├── 📄 checklist-template.md
│       ├── 📄 plan-template.md
│       ├── 📄 spec-template.md
│       └── 📄 tasks-template.md
│
├── 📁 .vscode/                          # VS Code Settings
│   ├── 📄 extensions.json               # Recommended extensions
│   └── 📄 settings.json                 # Workspace settings
│
├── 📁 specs/                            # Specifications (NEW)
│   ├── 📁 architecture/                 # System design specs
│   ├── 📁 features/                     # Feature specifications
│   ├── 📁 infrastructure/               # Infrastructure specs
│   ├── 📁 templates/                    # Spec templates
│   │   └── 📄 spec-template.md          # Comprehensive template
│   └── 📖 README.md                     # Specs organization guide
│
├── 📄 .gitignore                        # Git ignore rules (Updated)
├── 📖 DEVELOPMENT.md                    # Development workflow guide (NEW)
├── 📖 QUICK_START.md                    # 5-minute quick start (NEW)
├── 📖 README.md                         # Project overview (NEW)
├── 📖 SETUP_COMPLETE.md                 # Setup summary (NEW)
├── 📖 SPEC_KIT_GUIDE.md                 # Spec Kit usage guide (NEW)
├── 📄 saraswati.code-workspace          # VS Code workspace (NEW)
└── 📄 LICENSE                           # Project license (Existing)
```

## Component Breakdown

### 🐳 Dev Container Setup
The `.devcontainer/` directory contains everything needed for a reproducible development environment:

**Technologies Included:**
- Python 3.14
- Node.js LTS
- TypeScript
- uv (Astral package manager)
- Git

**Features:**
- Automatic environment setup
- Pre-configured VS Code extensions
- Port forwarding (3000, 5173, 8000)
- Persistent .git mounting

### 📋 Specification Management

**Two-Tier Approach:**

1. **`.specify/` (Existing)**
   - Spec Kit tooling and automation
   - PowerShell scripts for workflow
   - Agent configurations (Seema)
   - Generation templates

2. **`specs/` (New)**
   - Organized by category
   - Version-controlled specifications
   - Comprehensive documentation
   - Approved specs storage

### 🛠️ Development Tools

**Python Development:**
```
Tools: uv, Python 3.14, Ruff, Pylance
Workflow: uv init → uv add → uv sync → uv run
```

**TypeScript/React Development:**
```
Tools: Node.js, npm, TypeScript, ESLint, Prettier
Workflow: npm create vite → npm install → npm run dev
```

### 📚 Documentation Hierarchy

1. **QUICK_START.md** → Immediate setup (5 min)
2. **README.md** → Project overview
3. **DEVELOPMENT.md** → Complete workflow
4. **SPEC_KIT_GUIDE.md** → Specification process
5. **SETUP_COMPLETE.md** → Configuration summary

## Workflow Visualization

```
┌─────────────────────────────────────────────────────────┐
│                   Development Workflow                   │
└─────────────────────────────────────────────────────────┘

1. 💡 Idea / Requirement
        ↓
2. 📝 Create Spec (Use .specify/ tools)
        ↓
3. 👥 Review & Approve (Store in specs/)
        ↓
4. 🏗️ Design Architecture
        ↓
5. 💻 Implement
        ├── Python Backend (uv)
        └── React Frontend (npm)
        ↓
6. 🧪 Test
        ├── Unit Tests
        ├── Integration Tests
        └── E2E Tests
        ↓
7. 📖 Document
        ↓
8. 🔍 Code Review
        ↓
9. ✅ Merge & Deploy
        ↓
10. 🔄 Iterate
```

## Tech Stack Layers

```
┌───────────────────────────────────────────────────┐
│                  User Interface                    │
│              React + TypeScript                    │
└───────────────────────────────────────────────────┘
                        ↕
┌───────────────────────────────────────────────────┐
│                   API Layer                        │
│         RESTful / GraphQL (To be defined)         │
└───────────────────────────────────────────────────┘
                        ↕
┌───────────────────────────────────────────────────┐
│                Business Logic                      │
│           Python 3.14 + FastAPI/Django            │
└───────────────────────────────────────────────────┘
                        ↕
┌───────────────────────────────────────────────────┐
│                  Data Layer                        │
│        Database (PostgreSQL/MongoDB/etc.)         │
└───────────────────────────────────────────────────┘

        All running in Docker Dev Container
```

## File Type Legend

- 📁 Directory
- 📄 Configuration file (JSON, YAML)
- 📜 Script file (Shell, PowerShell)
- 📖 Markdown documentation
- 🐍 Python source file
- ⚛️ React/TypeScript file
- 🐳 Docker configuration

## Environment Flow

```
Local Machine
     ↓
Docker Desktop
     ↓
Dev Container (Ubuntu-based)
     ├── Python 3.14 + uv
     ├── Node.js LTS + npm
     ├── TypeScript
     └── Development tools
     ↓
VS Code (Remote in Container)
     ├── Extensions loaded
     ├── Settings applied
     └── Terminal ready
     ↓
Development Ready! 🚀
```

## Port Mapping

```
Container          Host Machine
─────────────────────────────────
Port 3000    →    localhost:3000    (React App)
Port 5173    →    localhost:5173    (Vite Dev Server)
Port 8000    →    localhost:8000    (Python Backend)
```

## Git Workflow

```
main
 ├── feature/new-feature
 ├── spec/feature-spec
 ├── bugfix/issue-123
 └── docs/update-readme

Each branch:
  - Linked to specs
  - Conventional commits
  - PR with reviews
  - Merge when approved
```

## Development Phases

```
Phase 1: Setup ✅
├── Dev Container configured
├── Documentation created
├── Spec system organized
└── Tools installed

Phase 2: Foundation (Next)
├── Initialize Python project
├── Setup database schema
├── Create API structure
└── Initialize React app

Phase 3: Core Features
├── Implement specs
├── Write tests
├── Build UI
└── Integrate components

Phase 4: Polish & Deploy
├── Performance optimization
├── Security hardening
├── Documentation finalization
└── Deployment setup
```

## Key Directories Purpose

| Directory | Purpose | Key Files |
|-----------|---------|-----------|
| `.devcontainer/` | Development environment | `devcontainer.json`, `Dockerfile` |
| `.github/` | GitHub & CI/CD | Agent configs, workflows |
| `.specify/` | Spec Kit tools | Scripts, templates |
| `.vscode/` | VS Code config | Extensions, settings |
| `specs/` | Specifications | Architecture, feature specs |

## Documentation Map

```
Entry Points:
├── QUICK_START.md ──────→ First-time users
├── README.md ───────────→ Project overview
├── DEVELOPMENT.md ──────→ Detailed workflow
├── SPEC_KIT_GUIDE.md ──→ Writing specs
└── SETUP_COMPLETE.md ──→ Setup reference

Supporting Docs:
├── .devcontainer/README.md ──→ Container details
└── specs/README.md ──────────→ Spec organization
```

## Quick Reference Commands

### Dev Container
```bash
# Start container
F1 → "Reopen in Container"

# Rebuild
F1 → "Rebuild Container"
```

### Python (uv)
```bash
uv init          # New project
uv add <pkg>     # Add package
uv sync          # Sync deps
uv run <cmd>     # Run command
```

### Node.js
```bash
npm install      # Install deps
npm run dev      # Start dev server
npm test         # Run tests
```

### Git
```bash
git checkout -b feature/name
git commit -m "feat: description"
git push origin feature/name
```

---

**This structure provides:**
- 🚀 Fast, reproducible setup
- 📋 Clear specification process
- 🛠️ Complete development toolchain
- 📚 Comprehensive documentation
- 🔄 Efficient workflow

**Ready to build Saraswati!** 🎉
