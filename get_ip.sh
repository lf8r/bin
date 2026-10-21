#!/bin/bash

# Comma-separated list of private IP range patterns (glob-style, used as regex prefixes)
IP_RANGES="172.17.*.*,192.168.*.*"

# Convert the glob-style patterns to awk-compatible regex patterns
# e.g. "172.17.*.*" -> "^172\.17\."
build_awk_pattern() {
    local ranges="$1"
    local awk_pat=""
    IFS=',' read -ra range_arr <<< "$ranges"
    for range in "${range_arr[@]}"; do
        # Escape dots and replace * with [0-9]+ for regex matching
        local pat
        pat=$(echo "$range" | sed 's/[.]/[.]/g; s/\[.\]\*/[0-9]*/g')
        [ -n "$awk_pat" ] && awk_pat="${awk_pat}|"
        awk_pat="${awk_pat}${pat}"
    done
    echo "$awk_pat"
}

AWK_PATTERN="$(build_awk_pattern "$IP_RANGES")"

# Use hostname -I to get all IPs for this host, then filter by the private ranges
MATCHED_IP=""
for ip in $(hostname -I); do
    [[ "$ip" == *.1 ]] && continue
    if echo "$ip" | awk -v pat="$AWK_PATTERN" 'BEGIN{n=split(pat,a,"|")} { for(i=1;i<=n;i++) if ($0 ~ a[i]) { found=1 } } END{exit !found}'; then
        MATCHED_IP="$ip"
        break
    fi
done

if [ -n "$MATCHED_IP" ]; then
    echo "$MATCHED_IP"
else
    echo "No IP matching ranges [$IP_RANGES] found." >&2
    exit 1
fi

