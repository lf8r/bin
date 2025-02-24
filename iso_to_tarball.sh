#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <iso-file>"
    exit 1
fi

ISO_FILE="$1"
TEMP_DIR=$(mktemp -d -p /tmp)

PLATFORM=$(uname)
echo "Platform detected: $PLATFORM"
if [ "$PLATFORM" = "Linux" ]; then
    sudo mount -o loop "$ISO_FILE" "$TEMP_DIR"
fi
if [ "$PLATFORM" = "Darwin" ]; then
    hdiutil attach -mountpoint "$TEMP_DIR" "$ISO_FILE"
fi

echo "ISO mounted to $TEMP_DIR"

DEST_DIR=$(mktemp -d -p /tmp)
rsync -a "$TEMP_DIR/" "$DEST_DIR/"
if [ "$PLATFORM" = "Linux" ]; then
    sudo chown -R $(whoami):$(whoami) "$DEST_DIR"
fi
echo "Contents copied to $DEST_DIR"

if [ "$PLATFORM" = "Linux" ]; then
    sudo umount "$TEMP_DIR" && rmdir "$TEMP_DIR"
fi

if [ "$PLATFORM" = "Darwin" ]; then
    hdiutil detach "$TEMP_DIR"
fi

TAR_GZ_FILE="${ISO_FILE%.iso}.tar.gz"
tar czf "$TAR_GZ_FILE" -C "$DEST_DIR" .
echo "Contents compressed to $TAR_GZ_FILE"
