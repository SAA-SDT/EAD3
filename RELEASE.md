
## EAD3
### Encoded Archival Description (EAD), Version 3
* Release: 1.10 (release candidate)
* Date: 2017-05

Hosted by the Library of Congress at http://www.loc.gov/ead/.

Developed by the Society of American Archivists' Technical Subcommittee for Encoded Archival Description (TS-EAD) and Schema Development Team, 2010-2015.

TS-EAD members during the revision process included:
* Mike Rush, co-chair, Yale University
* Bill Stockting, co-chair, British Library (UK)
* Kerstin Arnold, Bundesarchiv (Germany)
* Michael Fox, Minnesota Historical Society
* Kris Kiesling, University of Minnesota
* Angelika Menne-Haritz, Bundesarchiv (Germany)
* Kelcy Shepherd, University of Massachusetts and Amherst College
* Claire Sibille, Direction Générale des Patrimonies (France)
* Henny van Schie, Nationaal Archief / Bibliotheek (Netherlands)
* Brad Westbrook, University of California, San Diego, and ArchivesSpace.

Notable ex-officio contributors included

* Jodi Allison-Bunnell, Orbis Cascade Alliance (EAD Roundtable)
* Anila Angjeli, Bibliothèque nationale de France (TS-EAC)
* Hillel Arnold, Rockefeller Archives Center (EAD Roundtable)
* Mark Custer, Yale University (EAD Roundtable)
* Merrilee Proffitt, OCLC Research
* Ruth Kitchin Tillman, Cadence Group (EAD Roundtable)
* Katherine Wisser, Simmons College (TS-EAC)

Schema Development Team members included

* Terry Catapano, chair, Columbia University
* Karin Bredenberg, Riksarkivet of Sweden
* Florence Clavaud, Ecole Nationale des Chartes (France)
* Michele Combs, Syracuse University
* Mark Matienzo, Yale University and DPLA
* Daniel Pitti, University of Virginia
* Salvatore Vassallo, Università degli Studi di Pavia (Italy).
 
Adopted by SAA Council, July 2015.

Lead schema developer: Terry Catapano

EAD3 was possible because of the generous support of the Society of American Archivists, the Gladys Krieble Delmas Foundation, the National Endowment for the Humanities, the Nationaal Archief of the Netherlands, the Beinecke Rare Book and Manuscript Library, the Institute for Advanced Technology in the Humanities at the University of Virginia, and OCLC Research. 

### EAD3 Files
* ead3.dtd
* ead3.rng
* ead3.xsd
* schematron/ead3.sch (+ code list lookup files)
* schematron/ead3_rules.xsl
* undeprecated/ead3_undeprecated.dtd
* undeprecated/ead3_undeprecated.rng
* undeprecated/ead3_undeprecated.xsd

### Notes:

* EAD3 is available as Relax NG Schema, DTD, and W3C Schema. 
* The EAD3 DTD does not support the <objectxmlwrap> element.
* In the EAD3 DTD, attributes with anyURI, token, and string data types are converted to CDATA.
* Deprecated EAD 2002 elements are available in the undprecated versions of EAD3. 
* A Schematron schema (ead3.sch) is available to validate external code lists not maintained within EAD, standard attribute value patterns, attribute or element co-ocurrence not enforcable in the schema,and some encoding practices recommended for future migration.

### New in EAD3 1.10:
* The @localtype attribute has been added to the conventiondeclaration element. (See issue [#507](https://github.com/SAA-SDT/EAD3/issues/507))
* A new element, rightsdeclaration, has been added as an optional, repeatable child of the control section. It's purpose is to provide a standard location to declare rights associated with the the description present in a finding aid. (See issue [#506](https://github.com/SAA-SDT/EAD3/issues/506))
* The date element has been added as an optional child of the part element (see issue #[505](https://github.com/SAA-SDT/EAD3/issues/505))
* A bug fix had been added to allow xmllint and lxml to validate xsd files that include objectxmlwrap. (See issue #[499](https://github.com/SAA-SDT/EAD3/issues/499))
* The @render attribute has been added as an option to the quote element. (See issue #[485](https://github.com/SAA-SDT/EAD3/issues/485))

