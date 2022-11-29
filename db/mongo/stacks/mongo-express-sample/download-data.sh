#!/usr/bin/env bash
# This script downloads the sample data from a repo

SAMPLE_DATA_REPO=https://github.com/neelabalan/mongodb-sample-dataset/archive/refs/heads/main.zip
if [[ -n "$1" ]]; then
    SAMPLE_DATA_DIR=$1
else
    if [[ -z "$SAMPLE_DATA_DIR" ]]; then
        SAMPLE_DATA_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd) # Script directory
    fi
fi
echo "Sample data will be donwloaded to $SAMPLE_DATA_DIR"
#--------------------------------------------------------------------------------------------------
# Download the sample files from the remote repo, extract and then cleanup the zip
#--------------------------------------------------------------------------------------------------
SAMPLE_DATA_PATH="$SAMPLE_DATA_DIR"/sampledata.zip
wget --no-verbose -O "$SAMPLE_DATA_PATH" "$SAMPLE_DATA_REPO"
unzip -q "$SAMPLE_DATA_PATH" 'mongodb-sample-dataset-main/sample_*/*' -d "$SAMPLE_DATA_DIR" 
mv "$SAMPLE_DATA_DIR"/mongodb-sample-dataset-main/ "$SAMPLE_DATA_DIR"/sampledata/
rm -f "$SAMPLE_DATA_PATH"
echo "Sample data has been donwloaded."
