# Reproducible toolchain for the scripts in this folder (update.sh and the
# sub-scripts it calls: tidy/tidy.sh, diagram/create_diagram.sh,
# validation/validate_shacl.sh, validation/validate_examples.sh).
#
# The scripts themselves are unchanged and still create their own venv and
# install requirements.txt at run time - this image just guarantees the same
# Python and `tidy` versions on every machine (Windows, Linux, macOS), so
# Windows contributors get the same results as Linux/macOS contributors.
#
# Same command on every OS (from this scripts/ folder), via compose.yaml:
#   docker compose run --rm scripts

FROM python:3.12-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends tidy ca-certificates \
    && rm -rf /var/lib/apt/lists/*
