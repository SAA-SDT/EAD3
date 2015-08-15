
EAD3
============

###EAD3 Schema files

* `ead3.rng`: RelaxNG Schema for EAD3. Compiled version of `inprocess/ead3_driver.rng` and included files, which is the primary maintenance schema from which other versions are derived
* `ead3.dtd`: XML Document Type Definition for EAD3, derived from `inprocess/ead3_dtd.rng` customization to create DTD version
* `ead3.xsd`: W3C XML Schema for EAD3, derived from `ead3.rng` and post-processed by inprocess/deglobalize.xsl
* `schematron/ead.sch`: Schematron schema for ancillary validation of codelist values, date patterns, and co-occurrence constraints

