FROM ubuntu:19.10

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y \
       aria2 \
       libaio1 \
       binutils \
       file \
       libx32stdc++6 \
       numactl \
       libpam0g:i386 \
       language-pack-ja tzdata \
    && update-locale LANG=ja_JP.UTF-8 \
    && rm -rf /var/lib/apt/lists/* \
    && echo "${TZ}" > /etc/timezone \
    && rm -f /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && groupadd --gid 501 db2grp1 \
    && useradd --gid db2grp1 --uid 501 --shell /bin/bash -m db2inst1 \
    && groupadd --gid 601 db2fenc1 \
    && useradd --gid db2fenc1 --uid 601 --shell /bin/bash -m db2fenc1
ADD v11.1_linuxx64_expc.tar.gz /tmp
COPY db2expcJP.rsp /tmp/expc
ENV LANG=ja_JP.utf8
RUN /tmp/expc/db2setup -r /tmp/expc/db2expcJP.rsp && rm -rf /tmp/*
EXPOSE 50000
