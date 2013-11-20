<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:madsrdf="http://www.loc.gov/mads/rdf/v1#" xmlns:ead="urn:isbn:1-931666-22-9" version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
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
      <axsl:variable name="preceding" select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
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
      <axsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
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
            <axsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
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
   </axsl:template><!--Strip characters-->
   <axsl:template match="text()" priority="-1"/>

<!--SCHEMA METADATA-->

   <axsl:template match="/">
      <axsl:apply-templates select="/" mode="M2"/>
      <axsl:apply-templates select="/" mode="M3"/>
   </axsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN codes-->

   <axsl:variable name="langcodes" select="document('http://id.loc.gov/vocabulary/iso639-2.rdf')"/>

	<!--RULE -->

   <axsl:template match="@langcode | @lang" priority="105" mode="M2">
      <axsl:variable name="code" select="normalize-space(.)"/>

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="$langcodes//madsrdf:code/normalize-space(.) = $code"/>
         <axsl:otherwise>
            <axsl:message>The <axsl:text/>
               <axsl:value-of select="name(.)"/>
               <axsl:text/> attribute should contain a code from the iso639-2 codelist. <axsl:text> (</axsl:text>$langcodes//madsrdf:code/normalize-space(.) = $code<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M2"/>
   </axsl:template>
   <axsl:variable name="countrycodes" select="document('http://www.iso.org/iso/home/standards/country_codes/country_names_and_code_elements_xml')"/>

	<!--RULE -->

   <axsl:template match="@countrycode" priority="103" mode="M2">
      <axsl:variable name="code" select="normalize-space(.)"/>

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="$countrycodes//ISO_3166-1_Alpha-2_Code_element/normalize-space(.) = $code"/>
         <axsl:otherwise>
            <axsl:message>The <axsl:text/>
               <axsl:value-of select="name(.)"/>
               <axsl:text/> attribute should contain a code from the ISO 3166-1 codelist. <axsl:text> (</axsl:text>$countrycodes//ISO_3166-1_Alpha-2_Code_element/normalize-space(.) = $code<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M2"/>
   </axsl:template>
   <axsl:variable name="scriptcodes" select="document('http://anonscm.debian.org/gitweb/?p=iso-codes/iso-codes.git;a=blob_plain;f=iso_15924/iso_15924.xml;hb=HEAD')"/>

	<!--RULE -->

   <axsl:template match="@scriptcode | @script" priority="101" mode="M2">
      <axsl:variable name="code" select="normalize-space(.)"/>

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="$scriptcodes//iso_15924_entry/@alpha_4_code = $code "/>
         <axsl:otherwise>
            <axsl:message>The <axsl:text/>
               <axsl:value-of select="name(.)"/>
               <axsl:text/> attribute should contain a code from the iso_15924 codelist. <axsl:text> (</axsl:text>$scriptcodes//iso_15924_entry/@alpha_4_code = $code<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M2"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M2"/>
   <axsl:template match="@*|node()" priority="-2" mode="M2">
      <axsl:choose><!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M2"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M2"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

<!--PATTERN co-occurrence-constraints-->


	<!--RULE -->

   <axsl:template match="*[@level = 'otherlevel']" priority="101" mode="M3">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="normalize-space(@otherlevel)"/>
         <axsl:otherwise>
            <axsl:message> If the value of a <axsl:text/>level<axsl:text/> attribute is "otherlevel', then the <axsl:text/>otherlevel<axsl:text/> attribute must be used. <axsl:text> (</axsl:text>normalize-space(@otherlevel)<axsl:text>)</axsl:text>
               <axsl:text> [</axsl:text>assert<axsl:text>]</axsl:text>
            </axsl:message>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M3"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M3"/>
   <axsl:template match="@*|node()" priority="-2" mode="M3">
      <axsl:choose><!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
         <axsl:when test="not(@*)">
            <axsl:apply-templates select="node()" mode="M3"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:apply-templates select="@*|node()" mode="M3"/>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>
</axsl:stylesheet>