FROM ubuntu:18.04
COPY fortress/package /fortress/package
COPY package_bsps.sh /package_bsps.sh
COPY entrypoint.sh /entrypoint.sh
RUN apt-get update \
 && apt-get install -y \
    cron \
    curl \
    python3 \
    python3-distutils \
    zip \
 && rm -rf /var/lib/apt/lists/* \
 && curl -O https://bootstrap.pypa.io/pip/3.6/get-pip.py \
 && python3 get-pip.py \
 && pip3 install awscli --upgrade \
 && ./package_bsps.sh
CMD ["/entrypoint.sh"]
