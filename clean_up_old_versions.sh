#!/bin/bash

# The directory path
dir_path="fortress/package"

# Create an associative array
declare -A max_version

# Iterate over directories
for dir in "$dir_path"/*; do
    # Get the directory basename
    basename=$(basename "$dir")

    # Extract the name and version
    name=$(echo "$basename" | sed -r 's/(_b[0-9]+)?$//')
    version=$(echo "$basename" | grep -oP '(?<=_b)[0-9]+' || echo "")

    # If the directory has no "_b" suffix, consider it as a final release and version as max value
    if [[ -z "$version" ]]; then
        version="999999999"
    fi

    # If this directory version is greater than what we have seen before for this name
    if [[ -z "${max_version[$name]}" || "$version" -gt "${max_version[$name]}" ]]; then
        # If there was a previous version, delete it
        if [[ -n "${max_version[$name]}" && "${max_version[$name]}" != "999999999" ]]; then
            if [[ "${max_version[$name]}" == "999999999" ]]; then
                echo "Removing $dir_path/${name}"
                rm -r "$dir_path/${name}"
            else
                echo "Removing $dir_path/${name}_b${max_version[$name]}"
                rm -r "$dir_path/${name}_b${max_version[$name]}"
            fi
        fi
        # Update the max version for this name
        max_version[$name]=$version
    else
        # If this directory version is less than the max version we've seen, delete it
        if [[ "$version" == "999999999" ]]; then
            echo "Removing $dir_path/${name}"
            rm -r "$dir_path/${name}"
        else
            echo "Removing $dir_path/${name}_b${version}"
            rm -r "$dir_path/${name}_b${version}"
        fi
    fi
done
