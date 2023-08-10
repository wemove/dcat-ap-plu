# Readme

Below you can find instructions regarding the update process and the release process.

## Update Procedure

If a change to the API is made, make sure this change is reflected in all related resources, where applicable:

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

- Validate all examples using the `SHACL` shapefile
- Create a new folder in [releases](releases), named after your new version number (semver)
- Copy all appropriate files from [drafts](drafts) into this new folder
- In the new version folder, change the following line in `doc-plu.html` (replace `${YOUR_NEW_VERSION}` as appropriate):
    ```
    latestVersion: "https://github.com/wemove/dcat-ap-plu/tree/main/releases/${YOUR_NEW_VERSION}
    ```
- Amend the [changelog](../../CHANGELOG.md)
- Update the `DCATAPPLU_VERSION` in the [Dockerfile](../../docker/Dockerfile)
- Merge `develop` into `main`
- Announce new version via mail, ADO