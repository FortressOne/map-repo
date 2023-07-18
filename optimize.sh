#!/bin/bash

for image in $(find -name '*.tga'); do
	echo "converting $image to png"
	mogrify -format png "${image}"
	rm "${image}"
done

for image in $(find -name '*.png'); do
	opaque=$(identify -format "%[opaque]" "${image}")

	if [ $opaque = true ]; then
		echo "converting $image to jpg"
		mogrify -format jpg "${image}"
		rm "${image}"
	fi
done
