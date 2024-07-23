#! /bin/bash

VERSION="0.384"

set -e

export DEBIAN_FRONTEND="noninteractive"
export DEB_BUILD_MAINT_OPTIONS="optimize=+lto -march=x86-64-v3 -O3 -flto -fuse-linker-plugin -falign-functions=32"
export DEB_CFLAGS_MAINT_APPEND="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -falign-functions=32"
export DEB_CPPFLAGS_MAINT_APPEND="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -falign-functions=32"
export DEB_CXXFLAGS_MAINT_APPEND="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -falign-functions=32"
export DEB_LDFLAGS_MAINT_APPEND="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -falign-functions=32"
export DEB_BUILD_OPTIONS="nocheck notest terse"
export DPKG_GENSYMBOLS_CHECK_LEVEL=0

# Clone Upstream
git clone https://github.com/vcrhonek/hwdata -b v"$VERSION"
sed -i 's#/usr/bin/env\ python#/usr/bin/env\ python3#' ./*
cp -rvf ./debian ./hwdata/
cd ./hwdata

# Get build deps
apt-get build-dep ./ -y

# Build package
LOGNAME=root dh_make --createorig -y -l -p hwdata_"$VERSION" || echo "dh-make didn't go clean"
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
