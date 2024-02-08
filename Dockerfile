FROM ubuntu:22.04
RUN apt-get update && apt-get install -y \
    bzip2 \
    curl \
    gcc \
    gcc-aarch64-linux-gnu \
    make \
    tar

# Download the shim tarball, verify and extract.
RUN mkdir -p /build/shim
WORKDIR /build/shim
ADD shim-15.8.sum .
RUN curl --location --remote-name https://github.com/rhboot/shim/releases/download/15.8/shim-15.8.tar.bz2
RUN sha256sum --check shim-15.8.sum
RUN tar -jxvpf shim-15.8.tar.bz2 && rm shim-15.8.tar.bz2
WORKDIR /build/shim/shim-15.8

# Add our public certificate
ADD fortinet-ca2.der .
# Add our SBAT data
ADD sbat.csv data/sbat.csv

# Create build directories
RUN mkdir build-x86_64
RUN mkdir build-aarch64

# Build x86_64
RUN make -C build-x86_64 ARCH=x86_64 \
    VENDOR_CERT_FILE=../fortinet-ca2.der \
    TOPDIR=.. -f ../Makefile
# Build aarch64
RUN make -C build-aarch64 ARCH=aarch64 CROSS_COMPILE=aarch64-linux-gnu- \
    VENDOR_CERT_FILE=../fortinet-ca2.der \
    TOPDIR=.. -f ../Makefile

# Print the SHA256 of the shims.
RUN sha256sum build-x86_64/shimx64.efi
RUN sha256sum build-aarch64/shimaa64.efi
