#!/usr/bin/env bash

for map_path in fortress/package/*; do
	mkdir -p fortress/maps/
	map=$(basename ${map_path})
	(cd ${map_path} && zip -0 /tmp/temp.zip -x maps/${map}.bsp -r .)
	cat fortress/package/${map}/maps/${map}.bsp /tmp/temp.zip | gzip -9 > fortress/maps/${map}.bsp.gz
	rm /tmp/temp.zip
done
