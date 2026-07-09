FROM ubuntu:14.04

# Prevent interactive configuration prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# -----------------------------------------------------------------------------
# Step 1: Update repository URLs for legacy Ubuntu
# Since 14.04 is at end-of-life, we must point 'apt' to the old-releases server.
# -----------------------------------------------------------------------------
RUN sed -i -e 's/archive.ubuntu.com/old-releases.ubuntu.com/g' \
           -e 's/security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# -----------------------------------------------------------------------------
# Step 2: Install prerequisite tools needed to add external repositories
# -----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# Step 3: Add the NeuroDebian repository and its GPG security key
# Note that we are now pulling the 'trusty' list instead of 'xenial'.
# -----------------------------------------------------------------------------
RUN wget -O- http://neuro.debian.net/lists/trusty.us-nh.full | tee /etc/apt/sources.list.d/neurodebian.sources.list \
    && wget -qO - http://neuro.debian.net/_static/neuro.debian.net.asc | apt-key add -

# -----------------------------------------------------------------------------
# Step 4: Install the Caret software and clean up the package cache
# -----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    caret \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# Step 5: Set the default command
# -----------------------------------------------------------------------------
CMD ["caret"]
