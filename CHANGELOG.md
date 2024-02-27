# Changelog

## xxxx-xx-xx - dev

* [Website] Add latest DCAT-AP.PLU online documentation
* [API] Add possible values for `source` parameter
* [Deployment] Update docker base image
* [Spec] Disable section-linting

## 2024-02-07 - 0.1.3

* [Spec] Add new attribute `plu:planName` to `dcat:Dataset`

## 2023-11-20 - 0.1.2

* [API] Add `source` query parameter to `POST`/`PUT`/`DELETE` endpoints for records
* [Deployment] Upgrade lighttpd

## 2023-10-26 - 0.1.1

* [Codelist] Add `authority` codelist
* [Codelist] Add `plu:docType` - `procedureURL`
* [Codelist] Add `plu:docType` - `xplanGML`, `xplanArchive`
* [Codelist] Fix typo in `plu:procedureType` - "unkonwn" -> "unknown"
* [Documentation] Fix HTML
* [API] Add proper license
* [Deployment] Change lighttpd permissions
* [Spec] `dcat:Distribution` > `dct:format` now expects a Literal

## 2023-08-02 - 0.1.0

* Initial release