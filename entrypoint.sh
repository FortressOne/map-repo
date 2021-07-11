#!/usr/bin/env bash

echo ${AWS_SECRET_ACCESS_KEY}
echo ${AWS_ACCESS_KEY_ID}
echo ${S3_PACKAGE_URI}

if [ ! -z "${AWS_SECRET_ACCESS_KEY}" ] && [ ! -z "${AWS_ACCESS_KEY_ID}" ] && [ ! -z "${S3_PACKAGE_URI}" ]; then
  /usr/local/bin/aws s3 sync /map-repo/package ${S3_PACKAGE_URI}
fi
