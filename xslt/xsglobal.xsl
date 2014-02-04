<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:xs="http://www.w3.org/2001/XMLSchema" 
xmlns:s="http://http://www.taxonx.org/schema/v1"
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


	<xsl:template match="xs:schema/xs:element[not(@name='ead')]">
	
	
	<xsl:element name="xs:complexType">
		<xsl:attribute name='name'>
			<xsl:value-of select='@name'/>
		</xsl:attribute>
		<xsl:if test='xs:complexType[@mixed="true"]'>
			<xsl:attribute name='mixed'>true</xsl:attribute>
		</xsl:if>
		<xsl:apply-templates select='xs:complexType/*'/>
		
	</xsl:element> <!-- end:  -->
</xsl:template>


<xsl:template match='xs:element[@ref]'>
	<xsl:element name='xs:element'>
		<xsl:attribute name='name'>
<!--			<xsl:value-of select='@ref'/> -->
	    <xsl:value-of select='substring-after(string(@ref), ":")'/>
		</xsl:attribute>
		<xsl:attribute name='type'>
			<xsl:value-of select='@ref'/>
		</xsl:attribute>
	 <!-- end: xs:element -->
		<xsl:apply-templates select='@*[not(name(.)="ref")] | *'/>
	</xsl:element>
</xsl:template>


	</xsl:stylesheet>