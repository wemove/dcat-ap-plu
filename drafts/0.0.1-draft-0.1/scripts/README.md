# DCAT-AP.PLU scripts

The below scripts can be run independently of each other, or in one swoop via

* [update.sh](update.sh) (Linux/MacOS)
* [update.bat](update.bat) (Windows)

All scripts assume a Unix-like toolchain (`sh`, `python3`, `tidy`) and a recent
Python (3.12+, for the f-strings used in `diagram/model.py`). On Windows this
is often not the case out of the box. If `update.bat`/the individual `.bat`
scripts fail locally (missing `tidy`, an older bundled Python, ...), run the
same scripts inside Docker instead, which gives you the exact same
environment on every OS - Windows, Linux and macOS all use the same command:

```
docker compose run --rm scripts
```

(run from this `scripts/` folder; requires Docker Desktop on Windows/macOS,
or Docker Engine + the compose plugin on Linux). This builds a small image
([Dockerfile](Dockerfile)) with Python 3.12 and `tidy`, then runs `update.sh`
inside a container with this draft folder mounted in - no local Python/tidy
install needed. To run a single sub-script instead of the full `update.sh`,
override the command, e.g.:

```
docker compose run --rm scripts sh scripts/diagram/create_diagram.sh
```


## Create UML diagram

The diagram is created based on the documentation and the SHACL shape file.

* Prerequisites: python, loaded `requirements.txt`

```
./diagram/create_diagram.sh (Linux/MacOS)
diagram\create_diagram.bat (Windows)
```


## Clean up HTML documentation

* Prerequisites: tidy

```
./tidy/tidy.sh (Linux/MacOS)
tidy\tidy.bat (Windows)
```


## Validate SHACL shapefile and examples

The SHACL shapefile and the XML examples are validated using the EU SHACL Validator REST API: https://www.itb.ec.europa.eu/shacl

* Prerequisites: python

Validate the SHACL file itself:
```
./validate/validate.sh shacl (Linux/MacOS)
validate\validate.bat shacl (Windows)
```

Validate the examples using the SHACL file:
```
./validate/validate.sh examples (Linux/MacOS)
validate\validate.bat examples (Windows)
```
