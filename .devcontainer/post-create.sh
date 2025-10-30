#!/bin/bash

echo "🚀 Running post-create setup for Saraswati project..."

# Ensure uv is in PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Verify installations
echo "📦 Verifying installations..."
echo "Python version: $(python --version)"
echo "Node version: $(node --version)"
echo "npm version: $(npm --version)"
echo "uv version: $(uv --version)"

# Install global npm packages
echo "📦 Installing global npm packages..."
npm install -g typescript tsx @types/node

# Setup Python environment with uv if pyproject.toml exists
if [ -f "pyproject.toml" ]; then
    echo "📦 Setting up Python environment with uv..."
    uv sync
else
    echo "ℹ️ No pyproject.toml found. Skipping Python environment setup."
fi

# Install Node.js dependencies if package.json exists
if [ -f "package.json" ]; then
    echo "📦 Installing Node.js dependencies..."
    npm install
else
    echo "ℹ️ No package.json found. Skipping Node.js dependencies installation."
fi

# Setup git configuration
echo "🔧 Configuring git..."
git config --global core.autocrlf input
git config --global init.defaultBranch main

echo "✅ Post-create setup completed successfully!"
echo ""
echo "🎉 Your Saraswati development environment is ready!"
echo ""
echo "Available tools:"
echo "  - Python 3.14 with uv package manager"
echo "  - Node.js LTS with npm"
echo "  - TypeScript"
echo "  - React (can be installed via npm)"
echo ""
echo "Quick commands:"
echo "  - uv init          : Initialize a new Python project"
echo "  - uv add <package> : Add a Python package"
echo "  - uv sync          : Sync Python dependencies"
echo "  - npm run dev      : Start development server (if configured)"
echo ""
