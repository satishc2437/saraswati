# Dev Container Setup Checklist ✅

Use this checklist to verify your Saraswati development environment is properly configured.

## Prerequisites

Before opening the Dev Container, ensure:

- [ ] Docker Desktop is installed and running
- [ ] VS Code is installed (latest version recommended)
- [ ] "Dev Containers" extension is installed in VS Code
- [ ] Git is configured with your credentials
- [ ] Repository is cloned to `q:\repos\saraswati` (or your preferred location)

## Initial Setup

### Step 1: Verify Files Exist

Navigate to the repository and check that these files exist:

```bash
cd q:\repos\saraswati
```

#### Configuration Files
- [ ] `.devcontainer/devcontainer.json`
- [ ] `.devcontainer/Dockerfile`
- [ ] `.devcontainer/post-create.sh`
- [ ] `.devcontainer/README.md`

#### Documentation Files
- [ ] `README.md`
- [ ] `QUICK_START.md`
- [ ] `DEVELOPMENT.md`
- [ ] `SPEC_KIT_GUIDE.md`
- [ ] `SETUP_COMPLETE.md`
- [ ] `PROJECT_STRUCTURE.md`

#### Spec Directories
- [ ] `specs/architecture/`
- [ ] `specs/features/`
- [ ] `specs/infrastructure/`
- [ ] `specs/templates/spec-template.md`
- [ ] `specs/README.md`

#### VS Code Configuration
- [ ] `.vscode/extensions.json`
- [ ] `.vscode/settings.json`
- [ ] `saraswati.code-workspace`

### Step 2: Open in VS Code

- [ ] Open VS Code
- [ ] Open the `saraswati` folder
- [ ] See prompt to "Reopen in Container" (or use F1 to access command)

### Step 3: Start Dev Container

- [ ] Click "Reopen in Container" or use Command Palette
- [ ] Wait for container to build (5-10 minutes first time)
- [ ] See "Starting Dev Container" progress indicator
- [ ] Wait for post-create script to complete

## Post-Container Verification

Once the container starts, verify everything is working:

### Terminal Commands

Open the integrated terminal in VS Code and run:

#### Check Python
```bash
python --version
```
- [ ] Returns: `Python 3.14.x` or higher

#### Check uv
```bash
uv --version
```
- [ ] Returns: `uv x.x.x` (version number)

#### Check Node.js
```bash
node --version
```
- [ ] Returns: `v20.x.x` or higher (LTS version)

#### Check npm
```bash
npm --version
```
- [ ] Returns: `10.x.x` or higher

#### Check TypeScript
```bash
tsc --version
```
- [ ] Returns: `Version 5.x.x` or higher

#### Check Git
```bash
git --version
```
- [ ] Returns: `git version x.x.x`

### VS Code Extensions

Check that these extensions are installed:

- [ ] Python (ms-python.python)
- [ ] Pylance (ms-python.vscode-pylance)
- [ ] Python Debugger (ms-python.debugpy)
- [ ] Ruff (charliermarsh.ruff)
- [ ] UV Toolkit (the0807.uv-toolkit)
- [ ] ESLint (dbaeumer.vscode-eslint)
- [ ] Prettier (esbenp.prettier-vscode)
- [ ] Tailwind CSS IntelliSense (bradlc.vscode-tailwindcss)
- [ ] GitHub Copilot (GitHub.copilot)
- [ ] GitHub Copilot Chat (GitHub.copilot-chat)
- [ ] Docker (ms-azuretools.vscode-docker)

To check: Go to Extensions panel (Ctrl+Shift+X) and search for each.

### Port Forwarding

The following ports should be available:

- [ ] Port 3000 (React Frontend)
- [ ] Port 5173 (Vite Dev Server)
- [ ] Port 8000 (Python Backend)

View in: Ports panel (usually at bottom of VS Code)

## Functionality Tests

### Test 1: Python Environment

```bash
# Create a test Python script
echo 'print("Hello from Python!")' > test.py
python test.py
rm test.py
```
- [ ] Output: `Hello from Python!`

### Test 2: uv Package Manager

```bash
# Try uv help
uv --help
```
- [ ] Shows uv command help

### Test 3: Node.js Environment

```bash
# Create a test JavaScript file
echo 'console.log("Hello from Node!");' > test.js
node test.js
rm test.js
```
- [ ] Output: `Hello from Node!`

### Test 4: TypeScript Compiler

```bash
# Create a test TypeScript file
echo 'const message: string = "Hello from TypeScript!"; console.log(message);' > test.ts
tsc test.ts
node test.js
rm test.ts test.js
```
- [ ] Output: `Hello from TypeScript!`

### Test 5: File System Access

```bash
# List current directory
ls -la
```
- [ ] Can see project files
- [ ] Can navigate directories

### Test 6: Git Operations

```bash
# Check git status
git status
```
- [ ] Shows current branch
- [ ] No errors

## Project Setup Tests

### Test 7: Create Python Project with uv

```bash
mkdir -p test-python && cd test-python
uv init
uv add requests
cd ..
rm -rf test-python
```
- [ ] Project created successfully
- [ ] Package added without errors
- [ ] Files cleaned up

### Test 8: Create React Project with Vite

```bash
npm create vite@latest test-react -- --template react-ts
cd test-react
npm install
cd ..
rm -rf test-react
```
- [ ] Project created successfully
- [ ] Dependencies installed
- [ ] Files cleaned up

## Documentation Accessibility

Verify you can access all documentation:

- [ ] Can open and read `README.md`
- [ ] Can open and read `QUICK_START.md`
- [ ] Can open and read `DEVELOPMENT.md`
- [ ] Can open and read `SPEC_KIT_GUIDE.md`
- [ ] Can open and read `SETUP_COMPLETE.md`
- [ ] Can open and read `PROJECT_STRUCTURE.md`
- [ ] Can open and read `.devcontainer/README.md`
- [ ] Can open and read `specs/README.md`

## Troubleshooting Checklist

If something doesn't work:

### Container Won't Build

- [ ] Docker Desktop is running
- [ ] Sufficient disk space (at least 10GB free)
- [ ] Internet connection is stable
- [ ] Try: Rebuild without cache (F1 → "Rebuild Container")

### Commands Not Found

- [ ] Check if you're in the container (should see "Dev Container" in VS Code)
- [ ] Try: Reopen VS Code window
- [ ] Try: Run post-create script manually: `bash .devcontainer/post-create.sh`

### Permission Issues

- [ ] Verify you're logged into Docker
- [ ] Check Docker has permission to access the drive
- [ ] Try: Restart Docker Desktop

### Extension Issues

- [ ] Wait for all extensions to finish installing
- [ ] Try: Reload VS Code window
- [ ] Try: Reinstall extension

### Port Conflicts

- [ ] Check if ports are already in use
- [ ] Close applications using those ports
- [ ] Try: Use different port numbers in devcontainer.json

## Final Verification

Complete this final checklist:

- [ ] ✅ All prerequisite software installed
- [ ] ✅ Dev Container builds successfully
- [ ] ✅ All tools (Python, Node, uv, etc.) working
- [ ] ✅ VS Code extensions installed and active
- [ ] ✅ Can create Python projects with uv
- [ ] ✅ Can create React projects with npm
- [ ] ✅ Documentation is accessible and readable
- [ ] ✅ Git operations work correctly
- [ ] ✅ Terminal commands execute without errors
- [ ] ✅ Port forwarding is configured

## Success Criteria

Your environment is fully ready when:

✅ **All checklist items are marked complete**
✅ **No error messages in terminal**
✅ **All documentation is readable**
✅ **Can create and run test projects**
✅ **VS Code extensions are active**

## Next Steps After Verification

Once everything is checked:

1. **Read Documentation**
   - [ ] Read `QUICK_START.md` for immediate next steps
   - [ ] Study `DEVELOPMENT.md` for workflow details
   - [ ] Review `SPEC_KIT_GUIDE.md` for spec writing

2. **Start Development**
   - [ ] Create your first specification
   - [ ] Set up your project structure
   - [ ] Begin implementing features

3. **Customize as Needed**
   - [ ] Add any additional VS Code extensions
   - [ ] Install any additional tools
   - [ ] Configure personal settings

## Getting Help

If you encounter issues not covered here:

1. Check the documentation files
2. Review the troubleshooting section
3. Check Docker Desktop logs
4. Review VS Code Dev Container logs
5. Create an issue in the repository

## Maintenance

Periodically verify:

- [ ] Docker Desktop is up to date
- [ ] VS Code is up to date
- [ ] Dev Containers extension is up to date
- [ ] No security updates needed
- [ ] Sufficient disk space available

## Checklist Complete! 🎉

When all items are checked:

**Your Saraswati development environment is fully operational!**

You're ready to:
- Write specifications
- Develop Python backends
- Build React frontends
- Collaborate with your team
- Build amazing software!

---

**Environment Status**: [ ] Not Started | [ ] In Progress | [ ] ✅ Complete

**Last Verified**: _____________________

**Verified By**: _____________________

**Notes**: _____________________
