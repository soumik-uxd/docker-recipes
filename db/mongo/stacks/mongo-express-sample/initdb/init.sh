#!/usr/bin/env bash
# This script imports the downloaded sample data into the mongoDB instance

#--------------------------------------------------------------------------------------------------
# Check for auth settings
#--------------------------------------------------------------------------------------------------
if [ "$MONGO_INITDB_ROOT_USERNAME" ] && [ "$MONGO_INITDB_ROOT_PASSWORD" ]; then
    echo "Using password authentication!"
    if [[ -z "$MONGO_INITDB_DATABASE" ]]; then
        MONGO_INITDB_DATABASE=admin
    fi
    echo "Auth database set as: $MONGO_INITDB_DATABASE"
    auth="--authenticationDatabase ${MONGO_INITDB_DATABASE} -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD}"
fi

if [[ -z "${SAMPLE_DATA_DIR:-}" ]]; then
    SAMPLE_DATA_DIR=/tmp/data/sampledata
fi

#--------------------------------------------------------------------------------------------------
# Check if there is data inside sample data
#--------------------------------------------------------------------------------------------------
if [[ ! -d "$SAMPLE_DATA_DIR" ]]; then
    echo "Sample data directory does not exist: $SAMPLE_DATA_DIR"
    echo "Skipping import"
elif [[ -z "$(find "$SAMPLE_DATA_DIR" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
    echo "Sample data directory is empty: $SAMPLE_DATA_DIR"
    echo "Skipping import"
else
    #--------------------------------------------------------------------------------------------------
    # Import the data
    #--------------------------------------------------------------------------------------------------
    for directory in $(ls -1 "$SAMPLE_DATA_DIR"/sampledata/); do
        for file in $(ls -1 "$SAMPLE_DATA_DIR"/sampledata/"$directory"/); do
            coll=$(basename $file .json)

            # Check if the collection already exists
            if [[ "$(mongosh --host localhost --port 27017 --db "$directory" $auth --quiet --eval "db.getCollectionNames().includes('$coll')")" == "true" ]]; then
                echo "Collection $coll already exists in db $directory; skipping import."
            else
                echo "Importing collection $coll for db $directory..."
                mongoimport --drop --host localhost --port 27017 --db "$directory" --collection $coll --file $SAMPLE_DATA_DIR"/sampledata/"$directory/$file $auth
            fi
        done
    done
    echo "Import completed!"
fi
