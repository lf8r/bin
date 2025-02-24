#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <iso-file>"
    exit 1
fi

ISO_FILE="$1"
TEMP_DIR=$(mktemp -d)

sudo mount -o loop "$ISO_FILE" "$TEMP_DIR"
echo "ISO mounted to $TEMP_DIR"

DEST_DIR=$(mktemp -d)
rsync -a "$TEMP_DIR/" "$DEST_DIR/"
sudo chown -R $(whoami):$(whoami) "$DEST_DIR"
echo "Contents copied to $DEST_DIR"

sudo umount "$TEMP_DIR" && rmdir "$TEMP_DIR"

TAR_GZ_FILE="${ISO_FILE%.iso}.tar.gz"
tar czf "$TAR_GZ_FILE" -C "$DEST_DIR" .
echo "Contents compressed to $TAR_GZ_FILE"
