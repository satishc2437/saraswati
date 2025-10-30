# Use official Python 3.14 image as base
FROM mcr.microsoft.com/devcontainers/python:3.14

# Install Node.js LTS (will be handled by devcontainer features, but adding base setup)
# Additional system dependencies
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    build-essential \
    curl \
    git \
    ca-certificates \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install uv (Python package manager from Astral)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Add uv to PATH for all users
ENV PATH="/root/.cargo/bin:${PATH}"

# Create a non-root user (vscode user is created by base image)
# Ensure vscode user has access to uv
RUN if [ -f /root/.cargo/bin/uv ]; then \
    cp /root/.cargo/bin/uv /usr/local/bin/uv && \
    chmod +x /usr/local/bin/uv; \
    fi

# Set working directory
WORKDIR /workspaces/saraswati

# Switch to vscode user
USER vscode

# Install uv for vscode user as well
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Add uv to PATH for vscode user
ENV PATH="/home/vscode/.cargo/bin:${PATH}"
