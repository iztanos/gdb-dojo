FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBUGINFOD_URLS=

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        g++ \
        gdb \
        make \
        binutils \
        file \
        less \
        vim \
        nano \
        bash \
        curl \
        ca-certificates \
        procps \
        ttyd \
        sudo \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash dojo
RUN printf 'set debuginfod enabled off\n' > /home/dojo/.gdbinit \
    && chown dojo:dojo /home/dojo/.gdbinit

WORKDIR /dojo

COPY docker/dojo-entrypoint.sh /usr/local/bin/dojo-entrypoint.sh
RUN chmod +x /usr/local/bin/dojo-entrypoint.sh

# The exercises are baked in so the published image runs with no clone and no
# bind mount. docker-compose.yml mounts the working copy over this for
# development; both paths work.
COPY --chown=dojo:dojo . /dojo

RUN mkdir -p /home/dojo/.local/share/gdb-dojo \
    && chown -R dojo:dojo /home/dojo/.local

USER dojo

EXPOSE 7681

CMD ["/usr/local/bin/dojo-entrypoint.sh"]
