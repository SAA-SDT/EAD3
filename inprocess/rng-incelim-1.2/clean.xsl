<?xml version="1.0"?>
<!-- $Id: clean.xsl,v 1.5 2004/01/16 17:06:26 dvd Exp $ -->

<xsl:transform
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rng="http://relaxng.org/ns/structure/1.0"
	xmlns="http://relaxng.org/ns/structure/1.0"
	version="1.0">
	
  <xsl:key name="refs" match="rng:ref" use="@name"/>

  <xsl:template match="/">
    <xsl:apply-templates mode="clean"/>
  </xsl:template>

  <xsl:template mode="clean" match="rng:text|rng:empty|rng:notAllowed">
    <xsl:if test="not(following-sibling::*[name()=name(current())])">
      <xsl:copy/>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="clean" match="rng:div">
    <xsl:if test=".//*[not(name()='rng:div')]">
      <xsl:copy>
        <xsl:apply-templates mode="clean" select="*|@*|text()|comment()"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="clean" match="rng:define">
    <xsl:if test="key('refs',@name)">
      <xsl:copy>
        <xsl:apply-templates mode="clean" select="*|@*|text()|comment()"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="clean" match="*|@*|text()|comment()">
    <xsl:copy>
      <xsl:apply-templates mode="clean" select="*|@*|text()|comment()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
