#!/bin/env sh
cd "$(dirname "$0")"
python3 -m venv venv
. venv/bin/activate
pip install -q -r requirements.txt
python3 validate.py shacl