# Use the official Ruby image as base (latest stable version)
FROM ruby:3.2

# Set environment variables
ENV LANG=C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=/usr/local/bundle \
    GEM_HOME=/usr/local/bundle \
    PATH=/usr/local/bundle/bin:$PATH

# Install system dependencies
RUN apt-get update && apt-get install -y \
    # Basic utilities
    curl \
    wget \
    gnupg2 \
    apt-transport-https \
    ca-certificates \
    # Build tools
    build-essential \
    git \
    # PostgreSQL client
    postgresql-client \
    libpq-dev \
    # Redis tools
    redis-tools \
    # Image processing
    imagemagick \
    libmagickwand-dev \
    # JavaScript runtime (use what's available in apt)
    nodejs \
    npm \
    # Other useful tools
    vim \
    nano \
    htop \
    tree \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Install ngrok
RUN curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
  | tee /etc/apt/sources.list.d/ngrok.list \
  && apt update \
  && apt install ngrok

# Install global gems
RUN gem update --system && \
    gem install bundler rails

# Create workspace directory
RUN mkdir -p /workspace

# Set working directory
WORKDIR /workspace

EXPOSE 3000

CMD ["bash"]
