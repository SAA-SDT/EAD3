<?xml version="1.0"?>
<!-- $Id: elim.xsl,v 1.8 2004/01/16 17:06:26 dvd Exp $ -->

<xsl:transform
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rng="http://relaxng.org/ns/structure/1.0"
	xmlns="http://relaxng.org/ns/structure/1.0"
	exclude-result-prefixes="rng"
	version="1.0">

  <xsl:template match="/">
    <xsl:apply-templates mode="elim"/>
  </xsl:template>

  <xsl:template mode="elim" match="rng:include">
    <rng:div>
      <xsl:apply-templates mode="elim" select="*|@*|text()|comment()"/>
    </rng:div>
  </xsl:template>

  <xsl:template mode="elim" match="rng:define">
    <xsl:call-template name="cp-unless-ovr">
      <xsl:with-param name="incelim" select="ancestor::rng:include[1]"/>
      <xsl:with-param name="define" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="cp-unless-ovr">
    <xsl:param name="incelim"/>
    <xsl:param name="define"/>
    <xsl:choose>
      <xsl:when test="$incelim
          and generate-id($define/ancestor::rng:grammar[1])
	    = generate-id($incelim/ancestor::rng:grammar[1])">

 	<xsl:if test="not(
           $incelim/preceding-sibling::*/descendant-or-self::rng:define[
	     @name=$define/@name
	     and generate-id(ancestor::rng:grammar[1])
	       = generate-id($incelim/ancestor::rng:grammar[1])])">
	  <xsl:call-template name="cp-unless-ovr">
	    <xsl:with-param name="incelim"
	      select="$incelim/ancestor::rng:include[1]"/>
	    <xsl:with-param name="define" select="$define"/>
	  </xsl:call-template>
	</xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <rng:define>
	  <xsl:for-each select="$define">
	    <xsl:apply-templates mode="elim" select="*|@*|text()|comment()"/>
	  </xsl:for-each>
	</rng:define>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template mode="elim" match="*|@*|text()|comment()">
    <xsl:copy>
  	<xsl:apply-templates mode="elim" select="*|@*|text()|comment()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
