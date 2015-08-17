<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:madsrdf="http://www.loc.gov/mads/rdf/v1#"
   xmlns:ead="http://ead3.archivists.org/schema/" version="2.0">
   <!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. The name or details of 
    this mode may change during 1Q 2007.-->


   <!--PHASES-->


   <!--PROLOG-->

   <axsl:output method="text"/>

   <!--KEYS-->


   <!--DEFAULT RULES-->


   <!--MODE: SCHEMATRON-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->

   <axsl:template match="*" mode="schematron-get-full-path">
      <axsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <axsl:text>/</axsl:text>
      <axsl:choose>
         <axsl:when test="namespace-uri()=''">
            <axsl:value-of select="name()"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:text>*:</axsl:text>
            <axsl:value-of select="local-name()"/>
            <axsl:text>[namespace-uri()='</axsl:text>
            <axsl:value-of select="namespace-uri()"/>
            <axsl:text>']</axsl:text>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:variable name="preceding"
         select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <axsl:text>[</axsl:text>
      <axsl:value-of select="1+ $preceding"/>
      <axsl:text>]</axsl:text>
   </axsl:template>
   <axsl:template match="@*" mode="schematron-get-full-path">
      <axsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <axsl:text>/</axsl:text>
      <axsl:choose>
         <axsl:when test="namespace-uri()=''">@schema</axsl:when>
         <axsl:otherwise>
            <axsl:text>@*[local-name()='</axsl:text>
            <axsl:value-of select="local-name()"/>
            <axsl:text>' and namespace-uri()='</axsl:text>
            <axsl:value-of select="namespace-uri()"/>
            <axsl:text>']</axsl:text>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
   <!--This mode can be used to generate prefixed XPath for humans-->

   <axsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <axsl:for-each select="ancestor-or-self::*">
         <axsl:text>/</axsl:text>
         <axsl:value-of select="name(.)"/>
         <axsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <axsl:text>[</axsl:text>
            <axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <axsl:text>]</axsl:text>
         </axsl:if>
      </axsl:for-each>
      <axsl:if test="not(self::*)">
         <axsl:text/>/@<axsl:value-of select="name(.)"/>
      </axsl:if>
   </axsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->

   <axsl:template match="/" mode="generate-id-from-path"/>
   <axsl:template match="text()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </axsl:template>
   <axsl:template match="comment()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </axsl:template>
   <axsl:template match="processing-instruction()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of
         select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"
      />
   </axsl:template>
   <axsl:template match="@*" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.@', name())"/>
   </axsl:template>
   <axsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:text>.</axsl:text>
      <axsl:choose>
         <axsl:when test="count(. | ../namespace::*) = count(../namespace::*)">
            <axsl:value-of select="concat('.namespace::-',1+count(namespace::*),'-')"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:value-of
               select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"
            />
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

   <!--MODE: GENERATE-ID-2 -->

   <axsl:template match="/" mode="generate-id-2">U</axsl:template>
   <axsl:template match="*" mode="generate-id-2" priority="2">
      <axsl:text>U</axsl:text>
      <axsl:number level="multiple" count="*"/>
   </axsl:template>
   <axsl:template match="node()" mode="generate-id-2">
      <axsl:text>U.</axsl:text>
      <axsl:number level="multiple" count="*"/>
      <axsl:text>n</axsl:text>
      <axsl:number count="node()"/>
   </axsl:template>
   <axsl:template match="@*" mode="generate-id-2">
      <axsl:text>U.</axsl:text>
      <axsl:number level="multiple" count="*"/>
      <axsl:text>_</axsl:text>
      <axsl:value-of select="string-length(local-name(.))"/>
      <axsl:text>_</axsl:text>
      <axsl:value-of select="translate(name(),':','.')"/>
   </axsl:template>
   <!--Strip characters-->
   <axsl:template match="text()" priority="-1"/>

   <!--SCHEMA METADATA-->

   <axsl:template match="/">
      <axsl:apply-templates select="/" mode="M6"/>
      <axsl:apply-templates select="/" mode="M7"/>
      <axsl:apply-templates select="/" mode="M8"/>
      <axsl:apply-templates select="/" mode="M9"/>
      <axsl:apply-templates select="/" mode="M10"/>
      <axsl:apply-templates select="/" mode="M11"/>
      <axsl:apply-templates select="/" mode="M12"/>
      <axsl:apply-templates select="/" mode="M13"/>
      <axsl:apply-templates select="/" mode="M14"/>
   </axsl:template>

   <!--SCHEMATRON PATTERNS-->

   <xsl:variable xmlns="http://purl.oclc.org/dsdl/schematron" name="language-code-lookups"
      as="element()*">


      <file key="iso639-1">iso639-1.rdf</file>


      <file key="iso639-2b">iso639-2.rdf</file>


      <file key="iso639-3">iso_639_3.xml</file>


   </xsl:variable>
   <axsl:variable name="active-language-code-key"
      select="(/ead:ead/ead:control/@langencoding[.=$language-code-lookups/@key],'iso639-2b')[1]"/>
   <axsl:variable name="language-code-lookup"
      select="document($language-code-lookups[@key = $active-language-code-key])//(madsrdf:code | iso_639_3_entries/iso_639_3_entry/@id)"/>
   <axsl:variable name="iso15511Pattern"
      select="'(^([A-Z]{2})|([a-zA-Z]{1})|([a-zA-Z]{3,4}))(-[a-zA-Z0-9:/\-]{1,11})$'"/>

   <!--PATTERN langcodes-->


   <!--RULE -->

   <axsl:template match="*[exists(@langcode | @lang)]" priority="101" mode="M6">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when
            test="every $l in (@lang | @langcode) satisfies normalize-space($l) = $language-code-lookup"/>
         <axsl:otherwise>
            <axsl:message> The <axsl:text/>
               <axsl:value-of select="name(.)"/>
               <axsl:text/> element's lang or langcode attribute should contain a value from the<axsl:text/>
               <axsl:value-of select="$active-language-code-key"/>
               <axsl:text/> codelist. <axsl:text> (</axsl:text>every $l in (@lang | @langcode)
               satisfies normalize-space($l) = $language-code-lookup<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M6"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M6"/>
   <axsl:template match="@*|node()" priority="-2" mode="M6">
      <axsl:choose>
         <!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M6"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M6"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

   <!--PATTERN countrycode-->

   <axsl:variable name="countrycodes" select="document('iso_3166.xml')"/>

   <!--RULE -->

   <axsl:template match="*[exists(@countrycode)]" priority="101" mode="M7">
      <axsl:variable name="code" select="normalize-space(@countrycode)"/>

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="$countrycodes//iso_3166_entry/@alpha_2_code = $code "/>
         <axsl:otherwise>
            <axsl:message> The countrycode attribute should contain a code from the ISO 3166-1
               codelist. <axsl:text> (</axsl:text>$countrycodes//iso_3166_entry/@alpha_2_code =
                  $code<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M7"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M7"/>
   <axsl:template match="@*|node()" priority="-2" mode="M7">
      <axsl:choose>
         <!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M7"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M7"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

   <!--PATTERN scriptcode-->

   <axsl:variable name="scriptcodes" select="document('iso_15924.xml')"/>

   <!--RULE -->

   <axsl:template match="*[exists(@scriptcode | @script)]" priority="101" mode="M8">
      <axsl:variable name="code" select="normalize-space(.)"/>

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when
            test="every $s in (@script | @scriptcode) satisfies $scriptcodes//iso_15924_entry/@alpha_4_code = $s "/>
         <axsl:otherwise>
            <axsl:message> The script or scriptcode attribute should contain a code from the
               iso_15924 codelist. <axsl:text> (</axsl:text>every $s in (@script | @scriptcode)
               satisfies $scriptcodes//iso_15924_entry/@alpha_4_code = $s<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M8"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M8"/>
   <axsl:template match="@*|node()" priority="-2" mode="M8">
      <axsl:choose>
         <!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M8"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M8"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

   <!--PATTERN repositorycode-->


   <!--RULE -->

   <axsl:template
      match="*[@repositorycode][preceding::ead:control/@repositoryencoding = 'iso15511']"
      priority="101" mode="M9">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="matches(@repositorycode, $iso15511Pattern)"/>
         <axsl:otherwise>
            <axsl:message>If the repositoryencoding is set to iso15511, the format of the value of
               the <axsl:text/>repositorycode<axsl:text/> attribute of <axsl:text/>
               <axsl:value-of select="name(.)"/>
               <axsl:text/> is constrained to that of the International Standard Identifier for
               Libraries and Related Organizations (ISIL: ISO 15511): a prefix, a dash, and an
               identifier. <axsl:text> (</axsl:text>matches(@repositorycode,
                  $iso15511Pattern)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M9"/>
   <axsl:template match="@*|node()" priority="-2" mode="M9">
      <axsl:choose>
         <!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M9"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M9"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

   <!--PATTERN agencycode-->


   <!--RULE -->

   <axsl:template match="ead:agencycode" priority="101" mode="M10">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="matches(normalize-space(.), $iso15511Pattern)"/>
         <axsl:otherwise>
            <axsl:message> The format of <axsl:text/>
               <axsl:value-of select="name(.)"/>
               <axsl:text/> is constrained to that of the International Standard Identifier for
               Libraries and Related Organizations (ISIL: ISO 15511): a prefix, a dash, and an
               identifier. <axsl:text> (</axsl:text>matches(normalize-space(.),
                  $iso15511Pattern)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M10"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M10"/>
   <axsl:template match="@*|node()" priority="-2" mode="M10">
      <axsl:choose>
         <!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M10"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M10"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

   <!--PATTERN co-occurrence-constraints-->


   <!--RULE -->

   <axsl:template match="*[@level = 'otherlevel']" priority="107" mode="M11">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="normalize-space(@otherlevel)"/>
         <axsl:otherwise>
            <axsl:message> If the value of a <axsl:text/>level<axsl:text/> attribute is
               "otherlevel', then the <axsl:text/>otherlevel<axsl:text/> attribute must be
                  used.<axsl:text> (</axsl:text>normalize-space(@otherlevel)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/>
   </axsl:template>

   <!--RULE -->

   <axsl:template match="*[@physdescstructuredtype = 'otherphysdescstructuredtype']" priority="106"
      mode="M11">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="normalize-space(@otherphysdescstructuredtype)"/>
         <axsl:otherwise>
            <axsl:message> If the value of a <axsl:text/>physdescstructuredtype<axsl:text/>
               attribute is "otherphysdescstructuredtype', then the
               <axsl:text/>otherphysdescstructuredtype<axsl:text/> attribute must be used.
                  <axsl:text>
                  (</axsl:text>normalize-space(@otherphysdescstructuredtype)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/>
   </axsl:template>

   <!--RULE -->

   <axsl:template match="*[@daotype = 'otherdaotype']" priority="105" mode="M11">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="normalize-space(@otherdaotype)"/>
         <axsl:otherwise>
            <axsl:message> If the value of a <axsl:text/>daotype<axsl:text/> attribute is
               "otherdaotype', then the <axsl:text/>otherdaotype<axsl:text/> attribute must be
                  used.<axsl:text>
                  (</axsl:text>normalize-space(@otherdaotype)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/>
   </axsl:template>

   <!--RULE -->

   <axsl:template match="*[@dsctype = 'otherdsctype']" priority="104" mode="M11">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="normalize-space(@otherdsctype)"/>
         <axsl:otherwise>
            <axsl:message> If the value of a <axsl:text/>dsctype<axsl:text/> attribute is
               "otherdsctype', then the <axsl:text/>otherdsctype<axsl:text/> attribute must be used.
                  <axsl:text> (</axsl:text>normalize-space(@otherdsctype)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/>
   </axsl:template>

   <!--RULE -->

   <axsl:template match="*[@relationtype = 'otherrelationtype']" priority="103" mode="M11">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="normalize-space(@otherrelationtype)"/>
         <axsl:otherwise>
            <axsl:message> If the value of an <axsl:text/>otherrelation<axsl:text/> attribute is
               "otherrelationtype', then the <axsl:text/>otherrelationtype<axsl:text/> attribute
               must be used. <axsl:text>
                  (</axsl:text>normalize-space(@otherrelationtype)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/>
   </axsl:template>

   <!--RULE -->

   <axsl:template match="*[@listtype = 'unordered']" priority="102" mode="M11">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="normalize-space(@mark)"/>
         <axsl:otherwise>
            <axsl:message> If the value of attribute <axsl:text/>listtype<axsl:text/> is
               'unordered', then the <axsl:text/>mark<axsl:text/> attribute should be used
                  <axsl:text> (</axsl:text>normalize-space(@mark)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/>
   </axsl:template>

   <!--RULE -->

   <axsl:template match="*[@listtype = 'ordered']" priority="101" mode="M11">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="normalize-space(@numeration)"/>
         <axsl:otherwise>
            <axsl:message> If the value of attribute <axsl:text/>listtype<axsl:text/> is 'ordered',
               then the <axsl:text/>numeration<axsl:text/> attribute should be used <axsl:text>
                  (</axsl:text>normalize-space(@numeration)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M11"/>
   <axsl:template match="@*|node()" priority="-2" mode="M11">
      <axsl:choose>
         <!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M11"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M11"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

   <!--PATTERN dates-->

   <axsl:variable name="isoYYYY" select="'\-?(0|1|2)([0-9]{3})'"/>
   <axsl:variable name="isoMM" select="'\-?(01|02|03|04|05|06|07|08|09|10|11|12)'"/>
   <axsl:variable name="isoDD" select="'\-?((0[1-9])|((1|2)[0-9])|(3[0-1]))'"/>
   <axsl:variable name="isoRangePattern"
      select="concat('^', '(\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)(/\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)?', '$')"/>
   <axsl:variable name="isoPattern"
      select="concat('^', $isoYYYY, '$','|', '^', $isoYYYY, $isoMM,'$', '|', '^', $isoYYYY, $isoMM, $isoDD,'$')"/>

   <!--RULE -->

   <axsl:template match="ead:unitdate[@normal] | ead:date[@normal]" priority="102" mode="M12">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="matches(@normal, $isoRangePattern)"/>
         <axsl:otherwise>
            <axsl:message>The <axsl:text/>normal<axsl:text/> attribute of <axsl:text/>
               <axsl:value-of select="name(.)"/>
               <axsl:text/> must be a iso8601 date. <axsl:text> (</axsl:text>matches(@normal,
                  $isoRangePattern)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M12"/>
   </axsl:template>

   <!--RULE -->

   <axsl:template
      match="ead:datesingle[exists(@notbefore | @notafter | @standarddate)] | ead:todate[exists(@notbefore | @notafter | @standarddate)] | ead:fromdate[exists(@notbefore | @notafter | @standarddate)]"
      priority="101" mode="M12">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when
            test="every $d in (@notbefore, @notafter, @standarddate) satisfies matches($d, $isoPattern)"/>
         <axsl:otherwise>
            <axsl:message> The <axsl:text/>notbefore<axsl:text/>, <axsl:text/>notafter<axsl:text/>,
               and <axsl:text/>standarddate<axsl:text/> attributes of <axsl:text/>
               <axsl:value-of select="name(.)"/>
               <axsl:text/> must be a iso8601 date. <axsl:text> (</axsl:text>every $d in
               (@notbefore, @notafter, @standarddate) satisfies matches($d,
                  $isoPattern)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M12"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M12"/>
   <axsl:template match="@*|node()" priority="-2" mode="M12">
      <axsl:choose>
         <!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M12"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M12"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

   <!--PATTERN cardinality-->


   <!--RULE -->

   <axsl:template match="ead:dsc" priority="101" mode="M13">

      <!--REPORT -->

      <axsl:if test="preceding::ead:dsc">
         <axsl:message> The use of multiple &lt;dsc&gt; elements is discouraged. It may be
            deprecated in the future and eliminating multiple <axsl:text/>
            <axsl:value-of select="name(.)"/>
            <axsl:text/> elements will facilitate future migration <axsl:text>
               (</axsl:text>preceding::ead:dsc<axsl:text>)</axsl:text>
            <axsl:text> [</axsl:text>report<axsl:text>]</axsl:text>
         </axsl:message>
      </axsl:if>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M13"/>
   <axsl:template match="@*|node()" priority="-2" mode="M13">
      <axsl:choose>
         <!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M13"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M13"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

   <!--PATTERN -->


   <!--RULE -->

   <axsl:template match="*[@era]" priority="101" mode="M14">

      <!--ASSERT -->

      <axsl:choose>
         <axsl:when test="@era = 'ce' or . = 'bce'"/>
         <axsl:otherwise>
            <axsl:message> Suggested values for the era attribute are 'ce' or 'bce' <axsl:text>
                  (</axsl:text>@era = 'ce' or . = 'bce'<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M14"/>
   <axsl:template match="@*|node()" priority="-2" mode="M14">
      <axsl:choose>
         <!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M14"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M14"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>
</axsl:stylesheet>
