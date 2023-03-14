#!/usr/bin/env bash

if [ ! -z "${AWS_SECRET_ACCESS_KEY}" ] && [ ! -z "${AWS_ACCESS_KEY_ID}" ] && [ ! -z "${AWS_S3_PACKAGE_BUCKET}" ]; then
  /usr/local/bin/aws s3 sync --size-only /fortress/maps ${AWS_S3_PACKAGE_BUCKET} --delete
fi
