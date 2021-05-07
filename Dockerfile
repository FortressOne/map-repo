FROM ubuntu:18.04
WORKDIR /map-repo/
COPY ./fortress/pk3/ /tmp
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
 && mkdir /map-repo/pk3/ \
 && for file in /tmp/*; do zip -r /map-repo/pk3/$(basename ${file}).pk3 ${file}/*; done \
 && rm -rf /tmp/*
CMD ["/map-repo/entrypoint.sh"]
