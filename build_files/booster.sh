#!/usr/bin/env bash
source /ctx/common

# This seems to be working for generating an initramfs. The only issue seems to be figuring out https://wiki.archlinux.org/title/Microcode#Microcode_in_a_separate_initramfs_file.  

curl -L https://archlinux.org/packages/extra/x86_64/booster/download/ -o /tmp/booster-0.12-1-x86_64.pkg.tar.zst

mkdir -p /tmp/booster

tar --zstd -xvf /tmp/booster-0.12-1-x86_64.pkg.tar.zst -C /tmp/booster 
rsync -a /tmp/booster/usr/ /usr/

cat <<EOF > /etc/booster.yaml
# https://wiki.archlinux.org/title/Booster
extra_files: fido2-assert
EOF

KERNEL=$(ls /usr/lib/modules)

booster build --force "/boot/initramfs-$KERNEL.img" \
  --kernel-version="$KERNEL" \
  --modules-dir="/usr/lib/modules/$KERNEL"