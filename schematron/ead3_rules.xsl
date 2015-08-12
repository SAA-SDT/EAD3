<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:madsrdf="http://www.loc.gov/mads/rdf/v1#"
                xmlns:ead="http://ead3.archivists.org/schema/"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
   <xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>

   <!--PHASES-->


   <!--PROLOG-->
   <xsl:output method="text"/>

   <!--XSD TYPES FOR XSLT2-->


   <!--KEYS AND FUNCTIONS-->


   <!--DEFAULT RULES-->


   <!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
   <!--This mode can be used to generate prefixed XPath for humans-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
   <!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
   <xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
   <xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters-->
   <xsl:template match="text()" priority="-1"/>

   <!--SCHEMA SETUP-->
   <xsl:template match="/">
      <xsl:apply-templates select="/" mode="M5"/>
      <xsl:apply-templates select="/" mode="M6"/>
      <xsl:apply-templates select="/" mode="M7"/>
      <xsl:apply-templates select="/" mode="M8"/>
      <xsl:apply-templates select="/" mode="M9"/>
      <xsl:apply-templates select="/" mode="M10"/>
      <xsl:apply-templates select="/" mode="M11"/>
      <xsl:apply-templates select="/" mode="M12"/>
      <xsl:apply-templates select="/" mode="M13"/>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
   <xsl:variable xmlns="http://purl.oclc.org/dsdl/schematron"
                 name="language-code-lookups"
                 as="element()*">
        <file key="iso639-1">iso639-1.rdf</file>
        <file key="iso639-2b">iso639-2.rdf</file>
      <!--        <file key="iso639-3">iso_639_3.xml</file> -->
    </xsl:variable>
   <xsl:param name="active-language-code-key"
              select="(/ead:ead/ead:control/@langencoding[.=$language-code-lookups/@key],'iso639-2b')[1]"/>
   <xsl:param name="language-code-lookup"
              select="document($language-code-lookups[@key = $active-language-code-key])//madsrdf:code/normalize-space(.)"/>

   <!--PATTERN langcodes-->


	  <!--RULE -->
   <xsl:template match="*[exists(@langcode | @lang)]" priority="1000" mode="M5">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $l in (@lang | @langcode) satisfies normalize-space($l) = $language-code-lookup"/>
         <xsl:otherwise>
            <xsl:message> The <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> element's lang or langcode attribute should contain a value from the<xsl:text/>
               <xsl:value-of select="$active-language-code-key"/>
               <xsl:text/> codelist.  (every $l in (@lang | @langcode) satisfies normalize-space($l) = $language-code-lookup)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>

   <!--PATTERN countrycode-->
   <xsl:variable name="countrycodes" select="document('iso_3166.xml')"/>

	  <!--RULE -->
   <xsl:template match="*[exists(@countrycode)]" priority="1000" mode="M6">
      <xsl:variable name="code" select="normalize-space(@countrycode)"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$countrycodes//iso_3166_entry/@alpha_2_code = $code "/>
         <xsl:otherwise>
            <xsl:message> The countrycode attribute should contain a code from the ISO 3166-1 codelist.  ($countrycodes//iso_3166_entry/@alpha_2_code = $code)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>

   <!--PATTERN scriptcode-->
   <xsl:variable name="scriptcodes" select="document('iso_15924.xml')"/>

	  <!--RULE -->
   <xsl:template match="*[exists(@scriptcode | @script)]" priority="1000" mode="M7">
      <xsl:variable name="code" select="normalize-space(.)"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $l in (@script | @scriptcode) satisfies $scriptcodes//iso_15924_entry/@alpha_4_code = $l "/>
         <xsl:otherwise>
            <xsl:message> The script or scriptcode attribute should contain a code from the iso_15924 codelist.  (every $l in (@script | @scriptcode) satisfies $scriptcodes//iso_15924_entry/@alpha_4_code = $l)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>

   <!--PATTERN repositorycode-->


	  <!--RULE -->
   <xsl:template match="*[@repositorycode][preceding::ead:control/@repositoryencoding = 'iso15511']"
                 priority="1000"
                 mode="M8">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@repositorycode, '(^([A-Z]{2})|([a-zA-Z]{1})|([a-zA-Z]{3,4}))(-[a-zA-Z0-9:/\-]{1,11})$')"/>
         <xsl:otherwise>
            <xsl:message> If the repositoryencoding is set to iso15511, the <xsl:text/>repositorycode<xsl:text/> attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must be formatted as an iso15511 code.  (matches(@repositorycode, '(^([A-Z]{2})|([a-zA-Z]{1})|([a-zA-Z]{3,4}))(-[a-zA-Z0-9:/\-]{1,11})$'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*" mode="M8"/>
   </xsl:template>

   <!--PATTERN agencycode-->


	  <!--RULE -->
   <xsl:template match="ead:agencycode" priority="1000" mode="M9">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(normalize-space(.), '(^([A-Z]{2})|([a-zA-Z]{1})|([a-zA-Z]{3,4}))(-[a-zA-Z0-9:/\-]{1,11}$)')"/>
         <xsl:otherwise>
            <xsl:message>
                The format of the agencycode attribute is constrained to that of the International Standard Identifier for Libraries and Related Organizations (ISIL: ISO 15511): a prefix, a dash, and an identifier.
             (matches(normalize-space(.), '(^([A-Z]{2})|([a-zA-Z]{1})|([a-zA-Z]{3,4}))(-[a-zA-Z0-9:/\-]{1,11}$)'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>

   <!--PATTERN co-occurrence-constraints-->


	  <!--RULE -->
   <xsl:template match="*[@level = 'otherlevel']" priority="1006" mode="M10">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@otherlevel)"/>
         <xsl:otherwise>
            <xsl:message> If the value of a <xsl:text/>level<xsl:text/> attribute is "otherlevel', then the <xsl:text/>otherlevel<xsl:text/> attribute must be used. (normalize-space(@otherlevel))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@physdescstructuredtype = 'otherphysdescstructuredtype']"
                 priority="1005"
                 mode="M10">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@otherphysdescstructuredtype)"/>
         <xsl:otherwise>
            <xsl:message> If the value of a <xsl:text/>physdescstructuredtype<xsl:text/> attribute is "otherphysdescstructuredtype', then the <xsl:text/>otherphysdescstructuredtype<xsl:text/> attribute must be used.  (normalize-space(@otherphysdescstructuredtype))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@daotype = 'otherdaotype']" priority="1004" mode="M10">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@otherdaotype)"/>
         <xsl:otherwise>
            <xsl:message> If the value of a <xsl:text/>daotype<xsl:text/> attribute is "otherdaotype', then the <xsl:text/>otherdaotype<xsl:text/> attribute must be used.  (normalize-space(@otherdaotype))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@dsctype = 'otherdsctype']" priority="1003" mode="M10">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@otherdsctype)"/>
         <xsl:otherwise>
            <xsl:message> If the value of a <xsl:text/>dsctype<xsl:text/> attribute is "otherdsctype', then the <xsl:text/>otherdsctype<xsl:text/> attribute must be used.  (normalize-space(@otherdsctype))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@relationtype = 'otherrelationtype']"
                 priority="1002"
                 mode="M10">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@otherrelationtype)"/>
         <xsl:otherwise>
            <xsl:message> If the value of an <xsl:text/>otherrelation<xsl:text/> attribute is "otherrelationtype', then the <xsl:text/>otherrelationtype<xsl:text/> attribute must be used.  (normalize-space(@otherrelationtype))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@listtype = 'unordered']" priority="1001" mode="M10">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@mark)"/>
         <xsl:otherwise>
            <xsl:message> If the value of attribute <xsl:text/>listtype<xsl:text/> is 'unordered', then the <xsl:text/>mark<xsl:text/> attribute should be used  (normalize-space(@mark))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@listtype = 'ordered']" priority="1000" mode="M10">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@numeration)"/>
         <xsl:otherwise>
            <xsl:message> If the value of attribute <xsl:text/>listtype<xsl:text/> is 'ordered', then the <xsl:text/>numeration<xsl:text/> attribute should be used  (normalize-space(@numeration))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>

   <!--PATTERN dates-->
   <xsl:variable name="isoYYYY" select="'\-?(0|1|2)([0-9]{3})'"/>
   <xsl:variable name="isoMM" select="'\-?(01|02|03|04|05|06|07|08|09|10|11|12)'"/>
   <xsl:variable name="isoDD" select="'\-?((0[1-9])|((1|2)[0-9])|(3[0-1]))'"/>
   <xsl:variable name="isoPattern"
                 select="concat('^', $isoYYYY, '$','|', '^', $isoYYYY, $isoMM, '$', '|', '^', $isoYYYY, $isoMM, $isoDD,  '$')"/>

	  <!--RULE -->
   <xsl:template match="ead:unitdate[@normal] | ead:date[@normal]"
                 priority="1001"
                 mode="M11">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@normal, $isoPattern)"/>
         <xsl:otherwise>
            <xsl:message>The <xsl:text/>normal<xsl:text/> attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must be a iso8601 date.  (matches(@normal, $isoPattern))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="ead:datesingle[exists(@notbefore | @notafter | @standarddate)] | ead:todate[exists(@notbefore | @notafter | @standarddate)] | ead:fromdate[exists(@notbefore | @notafter | @standarddate)]"
                 priority="1000"
                 mode="M11">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $d in (@notbefore, @notafter, @standarddate) satisfies matches($d, $isoPattern)"/>
         <xsl:otherwise>
            <xsl:message> The <xsl:text/>notbefore<xsl:text/>, <xsl:text/>notafter<xsl:text/>, and <xsl:text/>standarddate<xsl:text/> attributes of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must be a iso8601 date.  (every $d in (@notbefore, @notafter, @standarddate) satisfies matches($d, $isoPattern))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>

   <!--PATTERN cardinality-->


	  <!--RULE -->
   <xsl:template match="ead:dsc" priority="1000" mode="M12">

		<!--REPORT -->
      <xsl:if test="preceding::ead:dsc">
         <xsl:message>
             The use of multiple &lt;dsc&gt; elements is discouraged. It may be deprecated in the future and eliminating multiple &lt;dsc&gt; elements will facilitate future migration
             (preceding::ead:dsc)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>

   <!--PATTERN -->


	  <!--RULE -->
   <xsl:template match="*[@era]" priority="1000" mode="M13">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@era = 'ce' or . = 'bce'"/>
         <xsl:otherwise>
            <xsl:message>
                Suggested values for the era attribute are 'ce' or 'bce'
             (@era = 'ce' or . = 'bce')</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
</xsl:stylesheet>
