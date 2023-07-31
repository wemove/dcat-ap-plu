# Update procedure

If a change has to be made to the API, make sure this change is reflected in all related resources:

- [ ] OpenAPI specification: [api-plu.yml](api-plu.yml)
- [ ] documentation: [doc-plu.html](doc-plu.html)
- [ ] UML diagram: [dcat-ap-plu.eapx](dcat-ap-plu.eapx) and [DCAT-AP-PLU.JPG](DCAT-AP-PLU.JPG)
- [ ] SHACL shapefile: [shacl/dcat-ap-plu_shacl-shapes.ttl](shacl/dcat-ap-plu_shacl-shapes.ttl)
- [ ] examples: [examples/plu-example-full.xml](examples/plu-example-full.xml), [examples/plu-example-03.xml](examples/plu-example-03.xml), and remaining

Finally, ensure that the `SHACL` shapefile still correctly validates all examples, e.g. using
https://www.itb.ec.europa.eu/shacl/any/upload