<?xml version="1.0"?>
<!-- $Id: strip.xsl,v 1.1 2004/01/16 21:09:58 dvd Exp $ -->

<xsl:transform
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rng="http://relaxng.org/ns/structure/1.0"
	xmlns="http://relaxng.org/ns/structure/1.0"
	version="1.0">
	
  <xsl:key name="simple"
    match="rng:define[count(rng:text|rng:empty|rng:notAllowed)=count(*)]"
    use="@name"/>

  <xsl:key name="complex"
    match="rng:define[count(rng:text|rng:empty|rng:notAllowed)!=count(*)]"
    use="@name"/>

  <xsl:template match="/">
    <xsl:apply-templates mode="strip"/>
  </xsl:template>

  <xsl:template mode="strip" match="rng:ref">
    <xsl:variable name="simple" select="key('simple',@name)"/>
    <xsl:variable name="complex" select="key('complex',@name)"/>
    <xsl:choose>
      <xsl:when test="count($simple)=1 and not($complex)">
	<xsl:apply-templates mode="strip" select="$simple/*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
	  <xsl:apply-templates mode="strip" select="*|@*|text()|comment()"/>
	</xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template mode="strip" match="*|@*|text()|comment()">
    <xsl:copy>
      <xsl:apply-templates mode="strip" select="*|@*|text()|comment()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
