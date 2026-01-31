FROM node:20-bullseye

# Install additional system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-client \
    git \
    curl \
    build-essential \
    python3 \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Set simple sudo password for node user
RUN echo "node:123" | chpasswd && usermod -aG sudo node

# Create workspace directory
WORKDIR /workspace

# Set NODE_ENV
ENV NODE_ENV=development

# Expose ports
EXPOSE 3000 5432

# Keep container running
CMD ["/bin/bash"]
