FROM python:3.9

RUN apt-get update && \
    apt-get install -y build-essential libsqlite3-dev libz-dev git && \
    git clone https://github.com/mapbox/tippecanoe.git && \
    (cd tippecanoe && make -j && make install) && \
    git clone git://github.com/mapbox/mbutil.git && \
    (cd mbutil && python3 setup.py install )

WORKDIR /coverage-map
COPY generate-tiles.sh .

CMD "./generate-tiles.sh"