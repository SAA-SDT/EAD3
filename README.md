<<<<<<< HEAD

EAD-Revision
============

###EAD3 Schema files

* `ead3.rng`: RelaxNG Schema for EAD3. Compiled version of `inprocess/ead3_driver.rng` and included files, which is the primary maintenance schema from which other versions are derived
* `ead3.dtd`: XML Document Type Definition for EAD3, derived from `inprocess/ead3_dtd.rng` customization to create DTD version
* `ead3.xsd`: W3C XML Schema for EAD3, derived from `ead3.rng` and post-processed by inprocess/deglobalize.xsl

=======
EAD-Revision
============

* ead_revised.rng: RelaxNG version of EAD3 (Gamma) schema. This is the master version of the schema

* ead_revised.xsd: W3C XML Schema version of EAD3 (Gamma) schema. This file was derived from the ead_revised.rng. 

* ead_revised_norelations.rng: RelaxNG version of EAD3 (Gamma) schema without  <relations> element

* ead_revised_norelations.xsd: W3C XML Schema version of EAD3 (Gamma) schema without  <relations> element

* schematron/ead.sch: Schematron schema with rules for checking of codelist values, and use of "otherlevel" attribute.

* doc/ : Contains automatically generated documentation for ead_revised.xsd 
>>>>>>> master
