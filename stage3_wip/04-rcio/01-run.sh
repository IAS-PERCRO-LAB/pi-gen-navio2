#!/bin/bash -e

install -v -m 600 files/export_symbols.patch "${ROOTFS_DIR}"

on_chroot << EOF
echo "======================="
echo "Existing linux headers:"
ls /lib/modules
echo "-----------------------"
echo "Using: 6.1.0-rpi7-rpi-v8"
echo "======================="

rm -rf sources/rcio-dkms
mkdir -p sources
cd sources
git clone https://github.com/IAS-PERCRO-LAB/rcio-dkms.git
cd rcio-dkms
git apply /export_symbols.patch && rm /export_symbols.patch # TO BE REMOVED
make KVERSION='6.1.0-rpi7-rpi-v8'
dkms install .
EOF
