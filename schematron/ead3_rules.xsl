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
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
   <xsl:variable xmlns="http://purl.oclc.org/dsdl/schematron"
                 name="language-code-lookups"
                 as="element()*">
        <file key="iso639-1">http://id.loc.gov/vocabulary/iso639-1.rdf</file>
        <file key="iso639-2">http://id.loc.gov/vocabulary/iso639-2.rdf</file>
        <!-- unavailable as of 2015-04-07; where can we find a current list in XML, RDF, or JSON format ? -->
      <!--       <file key="iso639-3">http://anonscm.debian.org/gitweb/?p=iso-codes/pkg-iso-codes.git;a=blob_plain;f=iso_639_3/iso_639_3.xml</file> -->
    </xsl:variable>
   <xsl:param name="active-language-code-key"
              select="(/ead:ead/ead:control/@langencoding[.=$language-code-lookups/@key],'iso639-2')[1]"/>
   <xsl:param name="language-code-lookup"
              select="document($language-code-lookups[@key = $active-language-code-key])//madsrdf:code/normalize-space(.)"/>

   <!--PATTERN codes-->


	  <!--RULE -->
   <xsl:template match="*[exists(@langcode | @lang)]" priority="1005" mode="M5">
      <xsl:variable name="code" select="@lang | @langcode"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="every $l in (@lang | @langcode) satisfies normalize-space($l) = $language-code-lookup"/>
         <xsl:otherwise>
            <xsl:message> The <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> element's lang or langcode attribute should contain a value from the <xsl:text/>
               <xsl:value-of select="$active-language-code-key"/>
               <xsl:text/> codelist.  (every $l in (@lang | @langcode) satisfies normalize-space($l) = $language-code-lookup)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>
   <xsl:variable name="countrycodes" select="document('iso_3166.xml')"/>

	  <!--RULE -->
   <xsl:template match="@countrycode" priority="1003" mode="M5">
      <xsl:variable name="code" select="normalize-space(.)"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$countrycodes//iso_3166_entry/@alpha_2_code = $code "/>
         <xsl:otherwise>
            <xsl:message> The <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> attribute should contain a code from the ISO 3166-1 codelist.
             ($countrycodes//iso_3166_entry/@alpha_2_code = $code)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>
   <xsl:variable name="scriptcodes" select="document('iso_15924.xml')"/>

	  <!--RULE -->
   <xsl:template match="@scriptcode | @script" priority="1001" mode="M5">
      <xsl:variable name="code" select="normalize-space(.)"/>

		    <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$scriptcodes//iso_15924_entry/@alpha_4_code = $code "/>
         <xsl:otherwise>
            <xsl:message> The <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>
                attribute should contain a code from the iso_15924 codelist.  ($scriptcodes//iso_15924_entry/@alpha_4_code = $code)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@repositorycode][preceding::ead:control/@repositoryencoding = 'iso15511']"
                 priority="1000"
                 mode="M5">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@repositorycode, '(([A-Z]{2})|([a-zA-Z]{1})|([a-zA-Z]{3,4}))(-[a-zA-Z0-9:/\-]{1,11})')"/>
         <xsl:otherwise>
            <xsl:message>
                If the repositoryencoding is set to iso15511, the <xsl:text/>repositorycode<xsl:text/> attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must be formatted as a iso15511 code.
             (matches(@repositorycode, '(([A-Z]{2})|([a-zA-Z]{1})|([a-zA-Z]{3,4}))(-[a-zA-Z0-9:/\-]{1,11})'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*" mode="M5"/>
   </xsl:template>

   <!--PATTERN co-occurrence-constraints-->


	  <!--RULE -->
   <xsl:template match="*[@level = 'otherlevel']" priority="1004" mode="M6">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@otherlevel)"/>
         <xsl:otherwise>
            <xsl:message> If the value of a <xsl:text/>level<xsl:text/> attribute is "otherlevel', then the <xsl:text/>otherlevel<xsl:text/> attribute must be used.
             (normalize-space(@otherlevel))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@physdescstructuredtype = 'otherphysdescstructuredtype']"
                 priority="1003"
                 mode="M6">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@otherphysdescstructuredtype)"/>
         <xsl:otherwise>
            <xsl:message> If the value of a <xsl:text/>physdescstructuredtype<xsl:text/> attribute is "otherphysdescstructuredtype', then the <xsl:text/>otherphysdescstructuredtype<xsl:text/> attribute must be used.
             (normalize-space(@otherphysdescstructuredtype))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@daotype = 'otherdaotype']" priority="1002" mode="M6">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@otherdaotype)"/>
         <xsl:otherwise>
            <xsl:message> If the value of a <xsl:text/>daotype<xsl:text/> attribute is "otherdaotype', then the <xsl:text/>otherdaotype<xsl:text/> attribute must be used.
             (normalize-space(@otherdaotype))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@dsctype = 'otherdsctype']" priority="1001" mode="M6">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@otherdsctype)"/>
         <xsl:otherwise>
            <xsl:message> If the value of a <xsl:text/>dsctype<xsl:text/> attribute is "otherdsctype', then the <xsl:text/>otherdsctype<xsl:text/> attribute must be used.
             (normalize-space(@otherdsctype))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="*[@otherrelation = 'otherrelationtype']"
                 priority="1000"
                 mode="M6">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="normalize-space(@otherrelationtype)"/>
         <xsl:otherwise>
            <xsl:message> If the value of a <xsl:text/>otherrelation<xsl:text/> attribute is "otherrelationtype', then the <xsl:text/>otherrelationtype<xsl:text/> attribute must be used.
             (normalize-space(@otherrelationtype))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>

   <!--PATTERN dates-->


	  <!--RULE -->
   <xsl:template match="ead:unitdate[@normal] | ead:date[@normal]"
                 priority="1003"
                 mode="M7">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@normal, '(\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)(/\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)?')"/>
         <xsl:otherwise>
            <xsl:message>
                The <xsl:text/>normal<xsl:text/> attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must be a iso8601 date.
             (matches(@normal, '(\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)(/\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)?'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="ead:datesingle/@standarddate" priority="1002" mode="M7">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(., '(\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)(/\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)?')"/>
         <xsl:otherwise>
            <xsl:message>
                The <xsl:text/>standarddate<xsl:text/> attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must be a iso8601 date.
             (matches(., '(\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)(/\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)?'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="ead:datesingle/@notbefore" priority="1001" mode="M7">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(., '(\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)(/\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)?')"/>
         <xsl:otherwise>
            <xsl:message>
                The <xsl:text/>notbefore<xsl:text/> attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must be a iso8601 date.
             (matches(., '(\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)(/\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)?'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
   <xsl:template match="ead:datesingle/@notafter" priority="1000" mode="M7">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(., '(\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)(/\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)?')"/>
         <xsl:otherwise>
            <xsl:message>
                The <xsl:text/>notafter<xsl:text/> attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must be a iso8601 date.
             (matches(., '(\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)(/\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)?'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*" mode="M7"/>
   </xsl:template>
</xsl:stylesheet>
