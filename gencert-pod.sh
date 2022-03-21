#!/bin/bash

HEAD='\e[7;36m'
RESET='\e[m'
OUTPUT='\e[32m'
NL='\n'
ERROR='\e[3;31m'
WARN='\e[3;33m'

heading_out() {
    echo -e "${HEAD}$1${RESET}"
}

description_out() {
    echo -e "${OUTPUT}Description : $1 ${RESET}"
}

warning_out() {
    echo -e "${WARN}Warning : $1 ${RESET}"
}

error_out() {
    echo -e "${ERROR}Error : $1 ${RESET}"
    return 1
}

nspeed=1

# ----
heading_out ">> Checking for root access"
sleep $nspeed
if [[ $(id -u) -ne 0 ]]; then
    error_out "You must run this script as root"
    exit 1
else
    description_out ">> Root access granted."
fi
sleep $nspeed
# ----

# ----
heading_out ">> Checking for required executables..."
sleep $nspeed
command -v podman >/dev/null 2>&1 || { error_out ">> Require 'podman' but it's not installed.  Aborting." >&2; exit 1; }
description_out ">> 'podman' found at $(which podman)."
sleep $nspeed
# ----

# ----
heading_out ">> Checking for 'podman' executables..."
sleep $nspeed
podman info || { error_out ">> 'podman' is not running.  Aborting." >&2; exit 1; }
description_out ">> 'podman' is running."
sleep $nspeed
# ----

# ----
heading_out ">> Checking for 'podman' network..."
sleep $nspeed
podman network ls | grep -q "bridge" || { error_out ">> 'podman' network is not available.  Aborting." >&2; exit 1; }
description_out ">> 'podman' network is available."
sleep $nspeed
# ----

# ----
heading_out ">> Removing existing 'gencert' pod..."
sleep $nspeed
rm -rf ./le || true
description_out ">> Removed existing 'gencert' pod."
sleep $nspeed
# ----

# ---
heading_out ">> Creating 'gencert' dirs..."
sleep $nspeed
mkdir -p ./le/data ./le/data
description_out ">> Created 'gencert' dirs."
sleep $nspeed
# ---

podman run -it --rm --name certbot \
--pod my-pod \
-v $(pwd)/le/certs:/etc/letsencrypt:Z \
-v $(pwd)/le/data:/webroot:Z \
certbot/certbot certonly --standalone -v