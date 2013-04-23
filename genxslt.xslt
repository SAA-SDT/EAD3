<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xsi xd"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:gen="dummy"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"    version="2.0">

  <!-- saxon elementNames.xml genxslt.xslt > reCaSe.xsl -->

  <xsl:output encoding="UTF-8" indent="yes" method="xml"/>

  <xsl:namespace-alias stylesheet-prefix="gen" result-prefix="xsl"/>

  <xsl:param name="eadxmlns" select="'urn:isbn:1-931666-22-9'"/>

  <xsl:template match="/">
    <gen:stylesheet version="2.0">
      <gen:output method="xml"/>
      <xsl:apply-templates select="elementNames/attributeName | elementNames/elementName"/>
    <xsl:comment>identity template</xsl:comment>
    <gen:template match="@*|node()" mode="reCaSe">
      <gen:copy>
        <gen:apply-templates select="@*|node()" mode="reCaSe"/>
      </gen:copy>
    </gen:template>
    </gen:stylesheet>
  </xsl:template>

  <xsl:template match="elementName">
    <gen:template match="*:{@oldName}" mode="reCaSe">
      <gen:element name="{@newName}" namespace="{$eadxmlns}">
          <gen:apply-templates select="@*|node()" mode="reCaSe"/>
      </gen:element>
    </gen:template>
  </xsl:template>

  <xsl:template match="attributeName">
    <gen:template match="@{@oldName}" mode="reCaSe">
      <gen:attribute name="{@newName}">
          <gen:apply-templates select="."/>
      </gen:attribute>
    </gen:template>
  </xsl:template>

</xsl:stylesheet>
