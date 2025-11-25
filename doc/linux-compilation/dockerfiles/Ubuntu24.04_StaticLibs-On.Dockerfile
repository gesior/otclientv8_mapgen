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

RUN apt-get install -yq zip wget && \
    wget https://github.com/icculus/physfs/archive/refs/heads/stable-3.0.zip && \
    unzip stable-3.0.zip && \
    cd physfs-stable-3.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    mv /usr/local/lib/libphysfs.a /usr/lib/x86_64-linux-gnu/.

COPY src /usr/src/otclientv8/src/
COPY CMakeLists.txt /usr/src/otclientv8/
WORKDIR /usr/src/otclientv8

RUN mkdir build
RUN cd build && cmake ..
RUN cd build && make -j$(nproc)
