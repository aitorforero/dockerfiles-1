FROM sbs20/scanservjs

RUN apt-get update && \
    apt-get -y --no-install-recommends install libsane-hpaio && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
