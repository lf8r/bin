#!/bin/bash

# Set your Wi‑Fi network prefix (first three octets)
WIFI_PREFIX="192.168.68"

get_ip_from_interface() {
    local iface="$1"
    ip addr show dev "$iface" 2>/dev/null | \
        awk -F'[ /]+' "/inet / && !/127.0.0.1/ { ip=\$3; gsub(/\/.*/,\"\",ip); print ip; exit }"
}

# 1. Try wired: first non‑loopback, non‑wifi‑like interface that has an IP
WIRED_IP="$(ip -4 addr show | \
    awk -F'[ :]' '
        /state UP/ { up=1 }
        up && /enp|eno|eth|ens/ && !/lo|wlp|wl/ { iface=$2; up=0; print iface; exit }
    ' | while read IFACE; do
        get_ip_from_interface "$IFACE"
        [ -n "$(get_ip_from_interface "$IFACE")" ] && exit 0
    done)"

if [ -n "$WIRED_IP" ]; then
    echo "$WIRED_IP"
else
    # 2. Fallback: first IP matching Wi‑Fi network prefix
    ip addr show | \
        awk -F'[ /]+' "/inet / && /${WIFI_PREFIX}/ { ip=\$3; gsub(/\/.*/,\"\",ip); print ip; exit }"
fi

