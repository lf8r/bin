#!/bin/bash
# See https://www.dzombak.com/blog/2024/05/Keeping-a-SMB-share-mounted-on-macOS-version-2.html
set -e

do_mount() {
	if osascript -e 'mount volume "smb://sdasgupta@TNAS/public"'; then
		exit 0
	else
		exit 1
	fi
}
MOUNT_DIR="/Volumes/public"
diskutil unmount "$MOUNT_DIR"
echo "MOUNT_DIR: $MOUNT_DIR"
if [ ! -d "$MOUNT_DIR" ]; then
    do_mount
fi
if [ ! -d "$MOUNT_DIR" ]; then
    exit 1
fi

set -e
[ -f "$MOUNT_DIR"/.liveness.txt ] || exit 1
exit 0