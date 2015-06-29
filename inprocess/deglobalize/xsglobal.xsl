<?xml version="1.0" encoding="utf-8"?>


<xsl:stylesheet 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:xs="http://www.w3.org/2001/XMLSchema" 
xmlns:s="http://ead3.archivists.org/schema/"
version="1.0">

<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" encoding="utf-8"/>
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template 
  match="*|@*|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates
     select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match='comment()'/>


	<xsl:template match='xs:schema/xs:element[not(@name="ead" or
																 @name="archdesc" or
																 @name="c" or
																 @name="c01" or
																 @name="c02" or
																 @name="c03" or
																 @name="c04" or
																 @name="c05" or
																 @name="c06" or
																 @name="c07" or
																 @name="c08" or
																 @name="c09" or
																 @name="c10" or
																 @name="c11" or
																 @name="c12")]'>
	<xsl:element name='xs:complexType'>
		<xsl:attribute name='name'>
			<xsl:value-of select='@name'/>
		</xsl:attribute>
		<xsl:if test='xs:complexType[@mixed="true"]'>
			<xsl:attribute name='mixed'>true</xsl:attribute>
		</xsl:if>
		<xsl:apply-templates select='xs:complexType/*'/>
		
	</xsl:element> <!-- end:  -->
</xsl:template>


<xsl:template match='xs:element[not(@ref="s:archdesc" or
																 @ref="s:c" or
																 @ref="s:c01" or
																 @ref="s:c02" or
																 @ref="s:c03" or
																 @ref="s:c04" or
																 @ref="s:c05" or
																 @ref="s:c06" or
																 @ref="s:c07" or
																 @ref="s:c08" or
																 @ref="s:c09" or
																 @ref="s:c10" or
																 @ref="s:c11" or
																 @ref="s:c12")]'>
	<xsl:element name='xs:element'>
		<xsl:attribute name='name'>
			<xsl:value-of select='@ref'/> <!-- <xsl:value-of select='substring-after(string(@ref), "s:")'/> -->
		</xsl:attribute>
		<xsl:attribute name='type'>
			<xsl:value-of select='@ref'/>
		</xsl:attribute>
	 <!-- end: xs:element -->
		<xsl:apply-templates select='@*[not(name(.)="ref")] | *'/>
	</xsl:element>
</xsl:template>
	</xsl:stylesheet>