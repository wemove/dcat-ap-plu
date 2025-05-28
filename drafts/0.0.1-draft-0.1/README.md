# Readme

Below you can find instructions regarding the update process and the release process.

## Update Process

TODO: verify that the Windows `bat` scripts work

If a change to the API is to be made, make sure this change is reflected in all related resources, where applicable:

- [ ] OpenAPI specification: [api-plu.yml](api-plu.yml)
- [ ] Documentation: [doc-plu.html](doc-plu.html)
- [ ] SHACL shapefile: [shacl/dcat-ap-plu_shacl-shapes.ttl](shacl/dcat-ap-plu_shacl-shapes.ttl)
- [ ] UML diagram: [DCAT-AP-PLU.JPG](DCAT-AP-PLU.JPG)
  - no manual changes necessary; done via script, see end of paragraph
- [ ] Codelists: [codelists](codelists)
- [ ] Examples: [examples/plu-example-full.xml](examples/plu-example-full.xml), [examples/plu-example-03.xml](examples/plu-example-03.xml)

After making the changes, run [scripts/update.sh](scripts/update.sh) (Linux) or [scripts/update.bat](scripts/update.bat) (Windows), to
* tidy up the HTML documentation
* validate the SHACL shapefile and the examples
* re-create the UML diagram

Finally, update the [changelog](../../CHANGELOG.md).

## Release Process

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
