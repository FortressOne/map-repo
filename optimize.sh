#!/bin/bash

for image in $(find -name '*.png'); do
	echo "${image}"

	opaque=$(identify -format "%[opaque]" "${image}")

	if [ $opaque = true ]; then
		echo "converting $image to jpg"
		mogrify -format jpg "${image}"
		rm "${image}"
	fi
done
