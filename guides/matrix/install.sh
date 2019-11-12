#!/bin/bash

mkdir -p /synapse
virtualenv -p python3 /synapse/env
source /synapse/env/bin/activate
pip install --upgrade pip
pip install --upgrade setuptools
pip install matrix-synapse
