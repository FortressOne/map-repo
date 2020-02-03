#!/usr/bin/env bash

[ "$(which zip)" ] || error "ERROR: The package 'zip' is not installed. Please install it and run the installation again."
zip -r map-repo.zip fortress/
