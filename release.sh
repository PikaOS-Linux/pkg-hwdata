# Sign the packages
dpkg-sig --sign builder ./output/hwdata*.deb

# Pull down existing ppa repo db files etc
rsync -azP --exclude '*.deb' ferreo@pika-os.com:/srv/www/pikappa/ ./output/repo

# Remove our existing package from the repo
reprepro -V --basedir ./output/repo/ removefilter kinetic 'Package (% hwdata*)'

# Add the new package to the repo
reprepro -V --basedir ./output/repo/ includedeb kinetic ./output/hwdata*.deb

# Push the updated ppa repo to the server
rsync -azP ./output/repo/ ferreo@pika-os.com:/srv/www/pikappa/
