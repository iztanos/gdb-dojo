FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

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

WORKDIR /dojo

COPY docker/dojo-entrypoint.sh /usr/local/bin/dojo-entrypoint.sh
RUN chmod +x /usr/local/bin/dojo-entrypoint.sh

USER dojo

EXPOSE 7681

CMD ["/usr/local/bin/dojo-entrypoint.sh"]
