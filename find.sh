#!/bin/bash

# Read the file containing reference hashes
while IFS= read -r hash_ref || [ -n "$hash_ref" ]; do
    # Extract the hash from the reference file
    hash_ref=$(echo "$hash_ref" | awk '{print $1}')

    # Search for files in the current directory and calculate the SHA-512 hash of each file
    find . -type f -exec sha512sum {} + | while read -r hash_file file; do
        # Extract the hash of the current file
        hash_file=$(echo "$hash_file" | awk '{print $1}')

        # Compare the hash of the current file with the reference hash
        if [ "$hash_ref" == "$hash_file" ]; then
            echo "Match found:"
            echo "Hash: $hash_file"
            echo "File: $file"
        fi
    done
done < numeros
