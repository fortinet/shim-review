#!/bin/bash

rm -fr shim-16.1
if [ ! -f shim-16.1.tar.bz2 ]; then
	curl --location --remote-name https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2
fi
sha256sum --check shim-16.1.sum
tar -jxvpf shim-16.1.tar.bz2
cd shim-16.1

# Add our public certificate
cp ../fortinet-subca2002.der .
# Add our SBAT data
cp ../sbat.csv data/sbat.csv

# Create build directories
mkdir build-x86_64
mkdir build-aarch64

# Build x86_64
make -C build-x86_64 ARCH=x86_64 \
    VENDOR_CERT_FILE=../fortinet-subca2002.der \
    TOPDIR=.. -f ../Makefile
# Build aarch64
make -C build-aarch64 ARCH=aarch64 CROSS_COMPILE=aarch64-linux-gnu- \
    VENDOR_CERT_FILE=../fortinet-subca2002.der \
    TOPDIR=.. -f ../Makefile

cp build-x86_64/shimx64.efi ../
cp build-aarch64/shimaa64.efi ../
cd ..

# Print the SHA256 of the shims.
sha256sum shimx64.efi
sha256sum shimaa64.efi
