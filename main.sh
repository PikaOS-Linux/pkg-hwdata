# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports
# Clone Upstream
git clone https://github.com/vcrhonek/hwdata -b v0.370
sed -i 's#/usr/bin/env\ python#/usr/bin/env\ python3#' ./*
cp -rvf ./debian ./hwdata/
cd ./hwdata

# Get build deps
apt-get build-dep ./ -y

# Build package
dh_make --createorig
dpkg-buildpackage

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
