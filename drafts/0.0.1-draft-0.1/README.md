# Update procedure

If a change has to be made to the API, make sure this change is reflected in all related resources:

- [ ] OpenAPI spec: [api-plu.yml](api-plu.yml)
- [ ] documentation: [doc-plu.html](doc-plu.html)
- [ ] UML diagram: [dcat-ap-plu.eapx](dcat-ap-plu.eapx) and [DCAT-AP-PLU.JPG](DCAT-AP-PLU.JPG)
- [ ] XML schema: [schema/dcat-ap-plu.xsd](schema/dcat-ap-plu.xsd) (et al.)
- [ ] examples: [examples/plu-example-full.xml](examples/plu-example-full.xml), [examples/plu-example-03.xml](examples/plu-example-03.xml), and remaining

Finally, ensure that the `XSD` still correctly validates all examples:

```
xmllint --noout --schema schema/dcat-ap-plu.xsd examples/plu-example-*.xml 
```