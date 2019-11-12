#!/bin/bash

[[ -z "${KEYBASE_USERNAME}" ]] || (run_keybase && keybase oneshot)

[[ -d "/data" ]] || git clone ${CONFIG_REPO} /data
source /synapse/env/bin/activate
python -m synapse.app.homeserver "$@"
