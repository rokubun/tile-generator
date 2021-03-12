# TILE-GENERATOR

This repository contains a Docker image for generating a folder with vector tiles
from a geojson.

## Docker enviroment

The project uses tippecanoe and mbutil for generating the pbf files. A custome Dockerfile has been created with those dependencies.
In order to generate the tiles and considering you have the geojson folde rin your current folder, just launch:

```bash
docker run -it -v $PWD:/data rokubun/tile-generator:latest ./generate-tiles.sh /data/output/stations.geojson /data/output/tiles
```

In order to upload the data to AWS use de AWS cli:

```
aws s3 cp output/ s3://jason-coverage-tiles-test/ --recursive
```