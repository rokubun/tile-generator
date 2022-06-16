#!/bin/bash

#TODO download stations
STATIONS_GEOJSON=$1
TILES_FOLDER=$2
STATIONS_MBTILES="stations.mbtiles"

usage()  
{  
    echo "Usage: $0 GEOJSON_FILE OUTPUT_FOLDER"  
    exit 1
} 

check_tippecanoe(){
    which tippecanoe
    if [ $? -eq 1  ]; then
        echo "Missing tippecanoe (https://github.com/mapbox/tippecanoe)"
        exit 1
    fi
}

check_mbutil(){
    which  mb-util
    if [ $? -eq 1  ]; then
        echo "Missing MBUtil (https://github.com/mapbox/mbutil)"
        exit 1
    fi
}

check_mbutil
check_tippecanoe

if [ $# -ne 2 ]; then
    echo "Missing arguments"
    usage 
fi

# generate mbtiles (lvl zoom [1-9], base zoom 1, no tile compressed)
if [ -f "$STATIONS_GEOJSON" ]; then
    tippecanoe --no-tile-compression -z9 -Z1 -f -B1 --quiet -o $STATIONS_MBTILES $STATIONS_GEOJSON
else
    echo "file $STATIONS_GEOJSON does not exist." 
    exit 1
fi
#Export an mbtiles file to a directory of files
if [ -f "$STATIONS_MBTILES" ]; then    
    mb-util --image_format=pbf --silent $STATIONS_MBTILES $TILES_FOLDER
    echo "YOU SHOULD UPLOAD TILES FOLDER TO S3 BUCKET (jason-coverage-tiles)"      
else
    echo "file $STATIONS_MBTILES does not exist."
    exit 0
fi