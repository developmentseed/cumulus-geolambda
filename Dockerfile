FROM cumuluss/cumulus-ecs-task-python:0.0.1

RUN \
    apt-get -y update; \
    apt-get install -y wget tar gcc zlib-devel gcc-c++ libgeos curl-devel zip libjpeg-devel rsync git ssh cmake; \
    apt-get clean all;

ENV \
  BUILD=/build \
  PREFIX=/usr/local \
  GDAL_CONFIG=/usr/local/bin/gdal-config \
  LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64

# versions of packages
ENV \
  PROJ4_VERSION=4.9.2 \
  HDF4_VERSION=4.2.12 \
  SZIP_VERSION=2.1.1 \
  HDF5_VERSION=1.10.1 \
  OPENJPEG_VERSION=2.3.0 \
  GDAL_VERSION=2.2.2

RUN \
  pip install numpy; \
  pip3 install numpy;

RUN git clone https://github.com/developmentseed/geolambda
RUN cp geolambda/bin/* /usr/local/bin/
RUN cp geolambda/etc/* /usr/local/etc/
RUN rm -rf geolambda

WORKDIR /build

# proj4
RUN \
    wget https://github.com/OSGeo/proj.4/archive/$PROJ4_VERSION.tar.gz && \
    tar -zvxf $PROJ4_VERSION.tar.gz && \
    cd proj.4-$PROJ4_VERSION && \
    ./configure --prefix=$PREFIX && \
    make && make install && cd .. && \
    rm -rf proj.4-$PROJ4_VERSION $PROJ4_VERSION.tar.gz
