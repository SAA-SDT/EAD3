
incelim -- Relax NG Splicer

Version 1

   Table of Contents

   Package Contents
   Invocation
   Aknowledgements
   Terms and Conditions
   News and updates

   Abstract

   incelim takes a Relax NG grammar in XML syntax, expands all includes
   and externalRefs, and optionally replaces references to text, empty,
   or notAllowed with the patterns. The result is a 'compiled' schema
   convenient for distribution.

   The package includes stylesheets for each of the transformation steps,
   and two kinds of glue: XSLT stylesheet incelim.xsl, which chains the
   transformations using exsl:node-set(), and a shell script, incelim,
   which applies each of the stylesheets to the serialized result of the
   previous one.

Package Contents

   inc.xsl
          literally inserts contents of included files (and
          externalRefs);

   elim.xsl
          removes overriden defines;

   strip.xsl
          splices references to single parameterless patterns
          (text,empty,notAllowed);

   clean.xsl
          filters out empty divs and unreferenced defines;

   incelim.xsl
          XSLT glue to chain the transformations;

   incelim
          (ash or bash) shell script to run each of the transformations
          in order;

   saxon-6.5.3.diff
          performance patch for SAXON 6.5.3;

   readme.txt, readme.dbx
          brief description in plain text and DocBook XML formats;

   license.txt
          the license.

Invocation

   For the XSLT glue, the arguments are the source schema and the
   stylesheet. Parameter rinses specifies the number of times to apply
   strip/clean phase (it should be recursive, but it would be too complex
   for XSLT to stop timely). 1 is the default, more than 3 does not make
   sense in most practical cases.

Note

     * xsltproc compiled against libxml 20604, libxslt 10102 and libexslt
       802 and earlier versions cannot be used with this stylesheets due
       to bugs in implementation of exsl:node-set();
     * SAXON 6.5. and jd.xslt 1.5.5 are slow, a patch for SAXON 6.5.3
       that makes it fast is included in the distribution
       (saxon-6.5.3.diff).

   The shell script takes a list of schema files and puts the result for
   each schema.rng into schema-compiled.rng. Additionally,the following
   command-line options are accepted:

   -nnn
          number of strip/clean passes (default is -1)

   -processor
          XSLT processor to use, default is -saxon, other options are xt,
          jd.xslt, xalan, 4xslt, xsltproc

   Environment variable INCELIM should point to the directory containing
   XSLT scripts, default is /usr/local/lib/incelim. Temporary files are
   created in a directory pointed to by environment variable TMPDIR, /tmp
   by default.

Aknowledgements

   I would like to thank Sebastian Rahtz for the idea, inspiration,
   sample stylesheet using exsl:node-set(), and testing of the program.

Terms and Conditions

   This software is distributed under BSD license. The details are in
   license.txt.

News and updates

   Visit http://davidashen.net/.

