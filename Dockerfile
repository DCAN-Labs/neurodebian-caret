FROM ubuntu:14.04

# Prevent interactive configuration prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O- http://neuro.debian.net/lists/trusty.us-nh.full | tee /etc/apt/sources.list.d/neurodebian.sources.list \
    && wget -qO - http://neuro.debian.net/_static/neuro.debian.net.asc | apt-key add -

RUN apt-get update && apt-get install -y --no-install-recommends \
    caret \
    && rm -rf /var/lib/apt/lists/*

CMD ["caret"]
