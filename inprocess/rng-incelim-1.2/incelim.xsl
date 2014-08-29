<?xml version="1.0"?>
<!-- $Id: incelim.xsl,v 1.4 2004/01/18 16:34:04 dvd Exp $ -->

<!-- XSLT glue for incelim; 
  - xsltproc compiled against libxml 20604, libxslt 10102 and libexslt 802
    and earlier versions cannot be used with this stylesheets due to bugs
    in implementation of exsl:node-set();
  
  - SAXON 6.5.[23] and jd.xslt 1.5.5 are slow, a patch for SAXON 6.5.3 that
    makes it fast is included in the distribution (saxon-6.5.3.diff).
  -->


<xsl:transform
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl"
	xmlns:rng="http://relaxng.org/ns/structure/1.0"
	xmlns="http://relaxng.org/ns/structure/1.0"
	version="1.0">
	
  <xsl:import href="inc.xsl"/>
  <xsl:import href="elim.xsl"/>
  <xsl:import href="strip.xsl"/>
  <xsl:import href="clean.xsl"/>

  <xsl:param name="rinses">1</xsl:param>
  <xsl:param name="debug">0</xsl:param>

  <xsl:template match="/">
    <xsl:if test="$debug=1">
	<xsl:message>including</xsl:message>
    </xsl:if>
    <xsl:variable name="inc">
	<xsl:apply-templates mode="inc"/>
    </xsl:variable>

    <xsl:if test="$debug=1">
	<xsl:message>splicing</xsl:message>
    </xsl:if>
    <xsl:variable name="elim">
	<xsl:apply-templates select="exsl:node-set($inc)" mode="elim"/>
    </xsl:variable>

    <xsl:call-template name="rinse">
	<xsl:with-param name="rng" select="$elim"/>
	<xsl:with-param name="rinses" select="$rinses"/>
    </xsl:call-template>

  </xsl:template>

  <xsl:template name="rinse">
    <xsl:param name="rng"/>
    <xsl:param name="rinses"/>
	
    <xsl:choose>
      <xsl:when test="$rinses != 0">
	<xsl:variable name="strip">
	  <xsl:if test="$debug=1">
	    <xsl:message>stripping</xsl:message>
	  </xsl:if>
	  <xsl:apply-templates select="exsl:node-set($rng)" mode="strip"/>
	</xsl:variable>
	<xsl:call-template name="rinse">
	  <xsl:with-param name="rng">
	    <xsl:if test="$debug=1">
	      <xsl:message>cleaning</xsl:message>
	    </xsl:if>
	    <xsl:apply-templates select="exsl:node-set($strip)" mode="clean"/>	
	  </xsl:with-param>
	  <xsl:with-param name="rinses" select="$rinses - 1"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy-of select="$rng"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:transform>
