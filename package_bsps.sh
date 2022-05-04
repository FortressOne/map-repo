#!/usr/bin/env bash
set -eu

package_map () {
	local package_path=$1
	local map=$(basename ${package_path})

	(cd ${package_path} && zip -0 /tmp/temp.zip -x maps/${map}.bsp -r .)
	cat ${package_path}/maps/${map}.bsp /tmp/temp.zip > fortress/maps/${map}.bsp
	rm /tmp/temp.zip
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
