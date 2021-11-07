### IMAGE
FROM ubuntu:20.04

### VOLUME
VOLUME ["/input", "/output"]

### ENV
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ Asia/Tokyo

### apt-get
RUN apt-get  update   -y \
  && apt-get install  -y tzdata build-essential libtiff-dev libgeotiff-dev \
      libboost-all-dev libssl-dev \
      wget gcc g++ libc6-dev-i386 git

### cmake
RUN cd /usr/local/src/ \
  && wget https://github.com/Kitware/CMake/releases/download/v3.21.4/cmake-3.21.4.tar.gz \
  && tar zxf cmake-3.21.4.tar.gz \
  && cd cmake-3.21.4/ \
  && ./bootstrap \
  && make -j4 \
  && make install

### TBB
RUN cd /usr/local/src/ \
  && git clone https://github.com/wjakob/tbb.git \
  && cd tbb/build \
  && cmake .. \
  && make \
  && make install \
  && ldconfig

### LAS
RUN cd /usr/local/src/ \
  && git clone https://github.com/m-schuetz/LAStools.git \
  && cd LAStools/LASzip \
  && mkdir build \
  && cd build \
  && cmake \
    -DCMAKE_BUILD_TYPE=Release .. \
  && make \
  && make install \
  && ldconfig

### PotreeConverter21
RUN cd /usr/local/src/ \
  && wget https://github.com/potree/PotreeConverter/archive/refs/tags/2.1.tar.gz \
  && tar zxf 2.1.tar.gz \
  && cd PotreeConverter-2.1 \
  && mkdir build \
  && cd build \
  && cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DLASZIP_INCLUDE_DIRS=/usr/local/src/LAStools/LASzip/dll \
    -DLASZIP_LIBRARY=/usr/local/src/LAStools/LASzip/build/src/liblaszip.so .. \
  && make \
  && chmod +x ./PotreeConverter \
  && ln -s /usr/local/src/PotreeConverter-2.1/build /opt/PotreeConverter

### PORT
EXPOSE 1234

