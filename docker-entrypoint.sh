#!/bin/bash

set -eu

SERVER_USERNAME=${SERVER_USERNAME:?set SERVER_USERNAME}
SERVER_HOSTNAME=${SERVER_HOSTNAME:?set SERVER_HOSTNAME}
SERVER_PORT=${SERVER_PORT:?set SERVER_PORT}
PRIVATE_KEY_PATH=${PRIVATE_KEY_PATH:?set PRIVATE_KEY_PATH}
LOCAL_FORWARDING_PORTS=${LOCAL_FORWARDING_PORTS:-}
REMOTE_FORWARDING_PORTS=${REMOTE_FORWARDING_PORTS:-}

# TODO: prevent command/option injection
LOCAL_FORWARDING_PORTS=$(echo "${LOCAL_FORWARDING_PORTS}" | tr -d ' ' | tr ',' '\n')
LOCAL_FORWARDING_OPTIONS=
for mapping in ${LOCAL_FORWARDING_PORTS}; do
  echo "local mapping: ${mapping}"
  LOCAL_FORWARDING_OPTIONS="${LOCAL_FORWARDING_OPTIONS} -L ${mapping}"
done

REMOTE_FORWARDING_PORTS=$(echo "${REMOTE_FORWARDING_PORTS}" | tr -d ' ' | tr ',' '\n')
REMOTE_FORWARDING_OPTIONS=
for mapping in ${REMOTE_FORWARDING_PORTS}; do
  echo "remote mapping: ${mapping}"
  REMOTE_FORWARDING_OPTIONS="${REMOTE_FORWARDING_OPTIONS} -R ${mapping}"
done

echo ${LOCAL_FORWARDING_OPTIONS}

ssh -v -N "${SERVER_HOSTNAME}" \
    -l "${SERVER_USERNAME}" \
    -p "${SERVER_PORT}" \
    -i "${PRIVATE_KEY_PATH}" \
    -o ServerAliveInterval=30 \
    -o TCPKeepAlive=yes \
    -o ExitOnForwardFailure=yes \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/known_hosts/known_hosts ${LOCAL_FORWARDING_OPTIONS} ${REMOTE_FORWARDING_OPTIONS}
