#!/bin/bash
set -u

do_mount() {
	if osascript -e 'mount volume "smb://sdasgupta@TNAS/public"'; then
		exit 0
	else
		exit 1
	fi
}
MOUNT_DIR="/Volumes/public"
echo "MOUNT_DIR: $MOUNT_DIR"
if [ ! -d "$MOUNT_DIR" ]; then
    do_mount
fi
if [ ! -d "$MOUNT_DIR" ]; then
    exit 1
fi
exit 0