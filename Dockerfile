FROM ubuntu:18.04
WORKDIR /map-repo/
COPY ./fortress/pk3/ /tmp
RUN apt-get update \
      && apt-get install -y zip \
      && for file in /tmp/*; do zip -r /map-repo/$(basename ${file}).pk3 ${file}/*; done \
      && rm -rf /tmp/*
