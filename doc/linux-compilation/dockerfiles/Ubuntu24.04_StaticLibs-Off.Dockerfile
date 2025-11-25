FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    cmake build-essential \
    libboost-all-dev \
    libbz2-dev \
    libphysfs-dev \
    libogg-dev \
    libvorbis-dev \
    zlib1g-dev \
    libzip-dev \
    libssl-dev \
    libopenal-dev \
    libglew-dev \
    libluajit-5.1-dev \
    mesa-common-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev

COPY src /usr/src/otclientv8/src/
COPY CMakeLists.txt /usr/src/otclientv8/
WORKDIR /usr/src/otclientv8

RUN mkdir build
RUN cd build && cmake -DUSE_STATIC_LIBS=OFF ..
RUN cd build && make -j$(nproc)
