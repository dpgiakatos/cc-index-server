#!/bin/bash

CRAWL="CC-MAIN-2025-13"

if [ ! -d "collections" ]; then
    mkdir -p "collections/$CRAWL/indexes"
fi

echo "Downloading cc-index.paths.gz..."
wget "https://data.commoncrawl.org/crawl-data/$CRAWL/cc-index.paths.gz"

echo "Extracting cc-index.paths.gz..."
gunzip cc-index.paths.gz

echo "Downloading all files from cc-index.paths..."
while read -r path; do
  wget "https://data.commoncrawl.org/$path" -P "collections/$CRAWL/indexes"
done < cc-index.paths

if [ $? -ne 0 ]; then
    echo "Error installing collections"
    rm -r collections
    exit 1
fi
echo "Collections installed"
