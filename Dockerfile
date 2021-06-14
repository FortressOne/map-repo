FROM ubuntu:18.04
WORKDIR /map-repo
COPY fortress/package /map-repo/fortress/package
COPY gzip.sh /map-repo
COPY entrypoint.sh /map-repo
RUN apt-get update \
 && apt-get install -y \
    cron \
    curl \
    python3 \
    python3-distutils \
    zip \
 && rm -rf /var/lib/apt/lists/* \
 && curl -O https://bootstrap.pypa.io/get-pip.py \
 && python3 get-pip.py \
 && pip3 install awscli --upgrade \
 && ./gzip.sh
CMD ["/map-repo/entrypoint.sh"]
