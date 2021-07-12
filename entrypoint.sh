#!/usr/bin/env bash

echo ${AWS_SECRET_ACCESS_KEY}
echo ${AWS_ACCESS_KEY_ID}
echo ${AWS_S3_PACKAGE_BUCKET}

if [ ! -z "${AWS_SECRET_ACCESS_KEY}" ] && [ ! -z "${AWS_ACCESS_KEY_ID}" ] && [ ! -z "${AWS_S3_PACKAGE_BUCKET}" ]; then
  /usr/local/bin/aws s3 sync /map-repo/package ${AWS_S3_PACKAGE_BUCKET}
fi
