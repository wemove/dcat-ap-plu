# Changelog

## xxxx-xx-xx - dev

...

## 2025-06-03 - 0.2.3

* [Spec] Add new attribute `dcat:byteSize` to `dcat:Distribution`
* [Spec] Add new attribute `plu:objectiveInPreparation` to `dcat:Dataset`
* [Codelist] Add `objectiveInPreparation` codelist
* [Deployment] Update docker base image, always use lighttpd latest
* [Documentation] Cleanup documentation, automate diagram, refactoring

## 2025-02-12 - 0.2.2

* [Codelist] Extend `plu:planState` to describe values `planned`, `completelyReversed`, `discontinued`
* [Codelist] Extend `plu:procedureState` to describe values `completelyCanceled`, `discontinued`
* [Spec] Add new attribute `plu:procedureImportDate` to `dcat:Dataset`
* [Deployment] Update docker base image

## 2024-06-26 - 0.2.1

* [Documentation] Fix type links
* [Documentation] Fix ADMS namespace
* [Documentation] Move DCAT-AP.EIA files to own repository: https://github.com/wemove/dcat-ap-eia
* [Deployment] Update docker base image

## 2024-04-29 - 0.2.0

* [Codelist] Extend `plu:docType` to describe values from https://www.xrepository.de/details/urn:xoev-de:xplanverfahren:codeliste:verfahrensunterlagentyp
* [Website] Fix links to DCAT-AP.PLU documentation
* [Deployment] Set draft version for development
* [Spec] Replace `plu:procedureStartDate` (type `xsd:dateTime`) with `plu:procedurePeriod` (type `dct:PeriodOfTime`)
* [Spec] Add new attribute `dct:title` to `plu:ProcessStep`
* [API] Remove `source` query parameter from `POST`/`PUT`/`DELETE` endpoints for records
* [Deployment] Update docker base image, lighttpd

## 2024-02-28 - 0.1.4

* [Website] Add latest DCAT-AP.PLU online documentation
* [API] Add possible values for `source` parameter
* [Deployment] Update docker base image

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