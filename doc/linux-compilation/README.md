## Linux compilation

Recommended Linux compilation is described in README.md in the main folder of OTCv8 and it uses `vcpkg`.
First compilation with `vcpkg` is much slower on slow PCs as you have to compile all C++ dependencies from sources.

### Compilation without vcpkg

In the [dockerfiles](dockerfiles) folder are `Dockerfiles` with instructions on how to compile OTCv8 on various Linux distributions without `vcpkg`.

Running test builds from the main folder:
```
docker build -f doc/linux-compilation/dockerfiles/Ubuntu24.04_StaticLibs-Off.Dockerfile . --progress=plain
docker build -f doc/linux-compilation/dockerfiles/Ubuntu24.04_StaticLibs-On.Dockerfile . --progress=plain

```

### Ubuntu note

Compilation on Ubuntu does not work with 'static libraries' - which are the default in OTCv8 -,
because Ubuntu `physfs` installed by `apt-get install` does not contain a static library.

Compilation ends with an error:
```
[100%] Linking CXX executable otclient
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libphysfs.a: error adding symbols: archive has no index; run ranlib to add one
collect2: error: ld returned 1 exit status
```

To compile OTCv8 without `vcpkg`, you must pass `-DUSE_STATIC_LIBS=OFF` parameter to `cmake` or download and compile `physfs` from source

Compilation without static libraries on Ubuntu:
```
mkdir build
cd build
cmake -DUSE_STATIC_LIBS=OFF .. 
make -j$(nproc)
```

Compilation with static libraries on Ubuntu:
1. Install `physfs` from source:
```
sudo apt-get install -yq zip wget
mkdir /tmp/physfs && cd /tmp/physfs
wget https://github.com/icculus/physfs/archive/refs/heads/stable-3.0.zip
unzip stable-3.0.zip
cd physfs-stable-3.0
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
sudo mv /usr/local/lib/libphysfs.a /usr/lib/x86_64-linux-gnu/.
```
2. Compile OTCv8:
```
mkdir build
cd build
cmake .. 
make -j$(nproc)
```
