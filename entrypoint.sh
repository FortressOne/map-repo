#!/usr/bin/env bash

set -eu

package_map () {
	local package_path=$1
	local map=$(basename ${package_path})

	(cd ${package_path} && zip -0 /tmp/temp.zip -x maps/${map}.bsp -r .)

  local bsp=fortress/maps/${map}.bsp

	cat ${package_path}/maps/${map}.bsp /tmp/temp.zip > ${bsp}
	rm /tmp/temp.zip

  if [ ! -z "${AWS_SECRET_ACCESS_KEY}" ] && [ ! -z "${AWS_ACCESS_KEY_ID}" ] && [ ! -z "${AWS_S3_PACKAGE_BUCKET}" ]; then
    /usr/local/bin/aws s3 sync --size-only ${bsp} ${AWS_S3_PACKAGE_BUCKET}
  fi

  rm ${bsp}
}

mkdir -p fortress/maps/

if [ $# -eq 0 ]; then
	for package_path in fortress/package/*; do
		package_map ${package_path}
	done
else
	for package_path in "$@"; do
		package_map ${package_path}
	done
fi
