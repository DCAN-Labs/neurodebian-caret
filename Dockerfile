# -----------------------------------------------------------------------------
# Base Image: Ubuntu 16.04 (Xenial)
# Chosen for maximum compatibility with Caret 5.65 dependencies.
# -----------------------------------------------------------------------------
FROM ubuntu:16.04

# Prevent interactive configuration prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# -----------------------------------------------------------------------------
# Step 1: Install prerequisite tools needed to add external repositories
# -----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# Step 2: Add the NeuroDebian repository and its GPG security key
# This repository securely hosts the final 5.65 version of Caret.
# -----------------------------------------------------------------------------
RUN wget -O- http://neuro.debian.net/lists/xenial.us-nh.full | tee /etc/apt/sources.list.d/neurodebian.sources.list \
    && wget -qO - http://neuro.debian.net/_static/neuro.debian.net.asc | apt-key add -

# -----------------------------------------------------------------------------
# Step 3: Install the Caret software and clean up the package cache
# -----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    caret \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# Step 4: Set the default command
# 'caret' launches the GUI, while 'caret_command' accesses the CLI toolkit
# -----------------------------------------------------------------------------
CMD ["caret"]