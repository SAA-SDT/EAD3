## EAD3
### Encoded Archival Description (EAD), Version 3
* Release: 1.1.1
* Date: 2019-10-28

Hosted by the Library of Congress at http://www.loc.gov/ead/.

EAD3 1.0.0 was developed by the Society of American Archivists' Technical Subcommittee for Encoded Archival Description (TS-EAD) and Schema Development Team, 2010-2015. The standard was adopted in July 2015 by SAA Council.

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

Lead schema developer: Terry Catapano

Members of the TS-EAS Schema Subteam during the release of EAD3 1.1.1:
* Kerstin Arnold, Archives Portal Europe
* Karin Bredenberg, Riksarkivet of Sweden
* Mark Custer, chair, Yale University
* Alexander Duryee, New York Public Library
* Jessica Purkis, Archives of American Art

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
* The EAD3 DTD does not support the `<objectxmlwrap>` element.
* In the EAD3 DTD, attributes with anyURI, token, and string data types are converted to CDATA.
* Deprecated EAD 2002 elements are available in the undeprecated versions of EAD3.
* A Schematron schema (ead3.sch) is available to validate external code lists not maintained within EAD, standard attribute value patterns, attribute or element co-occurrence not enforceable in the schema,and some encoding practices recommended for future migration.

### New in EAD3 1.1.1:
1. The foreign element is now available as a child of the ref element. (See issue #[522](https://github.com/SAA-SDT/EAD3/issues/522))
2. Fixed a bug in the XSD schemas that resulted in empty-only c12 elements being valid. (See issue #[523](https://github.com/SAA-SDT/EAD3/issues/523))

### New in EAD3 1.1.0:
1. The @render attribute can now be used with the quote element. (See issue #[485](https://github.com/SAA-SDT/EAD3/issues/485))
2. The objectxmlwrap element can now be validated properly in the XSD schemas. (See issue #[499](https://github.com/SAA-SDT/EAD3/issues/499)) (bug fix)
3. Manually fixed a bug that was causing the descgrp element not to validate correctly in the undeprecated DTD. (See issue #[503](https://github.com/SAA-SDT/EAD3/issues/503)) (bug fix)
4. The date element is now a valid child of the part element. (See issue #[505](https://github.com/SAA-SDT/EAD3/issues/505))
5. rightsdeclaration, a new element, has been added to the control section. (See issue #[506](https://github.com/SAA-SDT/EAD3/issues/506)) (new element)
6. The @localtype attribute can now be used with the conventiondeclaration element. (See issue #[507](https://github.com/SAA-SDT/EAD3/issues/507))  
7. The datatype associated with the @containerid attribute has been relaxed to xsd:string (in EAD3 version 1.0, the datatype for this attribute was restricted to xsd:NMTOKEN). (See issue #[512](https://github.com/SAA-SDT/EAD3/issues/512))
