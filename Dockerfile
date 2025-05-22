FROM ubuntu:noble

# Install essential packages
RUN apt-get update && \
    apt-get install -y curl unzip build-essential git sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user with sudo access
RUN useradd -m -s /bin/bash -G sudo user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user

# Switch to the user
USER user
WORKDIR /home/user

# Install Node.js via fnm for the user
RUN curl -fsSL https://fnm.vercel.app/install | bash && \
    echo 'eval "$(fnm env --use-on-cd)"' >> /home/user/.bashrc && \
    . /home/user/.bashrc && \
    fnm install 22 && \
    fnm default 22 && \
    npm install -g @anthropic-ai/claude-code

CMD ["bash"]
