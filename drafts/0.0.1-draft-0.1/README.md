# Readme

Below you can find instructions regarding the update process and the release process.

## Update Procedure

If a change to the API is to be made, make sure this change is reflected in all related resources, where applicable:

- [ ] OpenAPI specification: [api-plu.yml](api-plu.yml)
- [ ] documentation: [doc-plu.html](doc-plu.html)
- [ ] UML diagram: [dcat-ap-plu.eapx](dcat-ap-plu.eapx) and [DCAT-AP-PLU.JPG](DCAT-AP-PLU.JPG)
- [ ] SHACL shapefile: [shacl/dcat-ap-plu_shacl-shapes.ttl](shacl/dcat-ap-plu_shacl-shapes.ttl)
- [ ] [Codelists](codelists)
- [ ] examples: [examples/plu-example-full.xml](examples/plu-example-full.xml), [examples/plu-example-03.xml](examples/plu-example-03.xml), and remaining

If the changes encompass the `SHACL` shapefile or the examples, ensure that the shapefile still correctly validates them all, e.g. using
https://www.itb.ec.europa.eu/shacl/any/upload

Finally, update the [changelog](../../CHANGELOG.md).

## Release Procedure

Run [release.sh](release.sh) and follow the instructions.

Alternatively, you can manually create a release:
- Validate all examples using the `SHACL` shapefile
- Finalize the [changelog](../../CHANGELOG.md)
- Create a new folder in [releases](../../releases), named after your new version number (semver)
- Copy all appropriate files from [drafts/0.0.1-draft-0.1](.) into this new folder
- In the new version folder, update
  - the `latestVersion` property in `doc-plu.html`
  - the `version` property in `api-plu.yml`
  - the version in `README.md`
- Also update the `DCATAPPLU_VERSION` in the [Dockerfile](../../docker/Dockerfile)
- Merge `develop` into `main`
- In `develop`, add a new dummy entry to the changelog and revert the changes to the Dockerfile

Finally, announce the new version via mail and ADO.
