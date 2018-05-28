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

RUN \
  wget http://download.osgeo.org/gdal/$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz && \
  tar -xzvf gdal-$GDAL_VERSION.tar.gz && \
  cd gdal-$GDAL_VERSION && \
    ./configure --prefix=$PREFIX \
        --without-python \
        --with-hdf4=no \
        --with-hdf5=no \
        --with-threads \
        --with-gif=no \
        --with-pg=no \
        --with-grass=no \
        --with-libgrass=no \
        --with-cfitsio=no \
        --with-pcraster=no \
        --with-netcdf=no \
        --with-png=no \
        --with-jpeg=no \
        --with-gif=no \
        --with-ogdi=no \
        --with-fme=no \
        --with-jasper=no \
        --with-ecw=no \
        --with-kakadu=no \
        --with-mrsid=no \
        --with-jp2mrsid=no \
        --with-bsb=no \
        --with-grib=no \
        --with-mysql=no \
        --with-ingres=no \
        --with-xerces=no \
        --with-expat=no \
        --with-odbc=no \
        --with-curl=yes \
        --with-sqlite3=no \
        --with-dwgdirect=no \
        --with-idb=no \
        --with-sde=no \
        --with-perl=no \
        --with-php=no \
        --without-mrf \
        --with-hide-internal-symbols=yes \
        CFLAGS="-O2 -Os" CXXFLAGS="-O2 -Os" && \ 
        make; make install; cd swig/python; \
        python setup.py install; \
        python3 setup.py install; \
        cd $BUILD; rm -rf gdal-$GDAL_VERSION*

