#!/usr/bin/env bash

if [ ! -z "${AWS_SECRET_ACCESS_KEY}" ] && [ ! -z "${AWS_ACCESS_KEY_ID}" ] && [ ! -z "${S3_PK3_URI}" ]; then
  /usr/local/bin/aws s3 sync /map-repo/pk3 ${S3_PK3_URI}
fi
