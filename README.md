
EAD3
============

### EAD3 Schema files

* `ead3.rng`: RelaxNG Schema for EAD3. Compiled version of `inprocess/ead3_driver.rng` and included files, which is the primary maintenance schema from which other versions are derived
* `ead3.dtd`: XML Document Type Definition for EAD3, derived from `inprocess/ead3_dtd.rng` customization to create DTD version
* `ead3.xsd`: W3C XML Schema for EAD3, derived from `ead3.rng` and post-processed by inprocess/deglobalize.xsl
* `schematron/ead.sch`: Schematron schema for ancillary validation of codelist values, date patterns, and co-occurrence constraints

### Rolling revision cycle
* TS-EAS intends to establish a rolling revision cycle for minor revisions of all standards under its purview. The current version of this can be viewed here: https://github.com/SAA-SDT/TS-EAS-subteam-notes/blob/master/rolling-revision-cycle.md
* In this context, EAD team of TS-EAS will follow this process for engaging with new submissions to GitHub: https://github.com/SAA-SDT/TS-EAS-subteam-notes/blob/master/ead-subteam/working-documents/ReviewOfNewGitHubIssues.md
