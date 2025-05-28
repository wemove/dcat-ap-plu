# DCAT-AP.PLU scripts

## Create UML diagram

The diagram is created based on documentation and SHACL shape file.
* Prerequisite: python

```
./diagram/create_diagram.sh (Linux/MacOS)
diagram\create_diagram.bat (Windows)
```

## Clean up HTML documentation


* Prerequisite: tidy

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
