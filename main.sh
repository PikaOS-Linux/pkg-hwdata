# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports
# Clone Upstream
git  https://github.com/vcrhonek/hwdata
sed -i 's#/usr/bin/env\ python#/usr/bin/env\ python3#' ./*
cp -rvf ./debian ./hwdata/
cd ./hwdata

# Get build deps
apt-get build-dep ./ -y

# Build binaries
echo -ne 'y'  | debuild -us -uc
