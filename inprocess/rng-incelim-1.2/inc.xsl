<?xml version="1.0"?>
<!-- $Id: inc.xsl,v 1.8 2004/01/16 17:06:26 dvd Exp $ -->

<xsl:transform
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rng="http://relaxng.org/ns/structure/1.0"
	xmlns="http://relaxng.org/ns/structure/1.0"
	version="1.0">

  <xsl:template match="/">
    <xsl:apply-templates mode="inc"/>
  </xsl:template>

  <xsl:template mode="inc" match="rng:externalRef">
    <rng:div><xsl:text>
</xsl:text><xsl:comment>externalRef "<xsl:value-of select="@href"/>"</xsl:comment><xsl:text>
</xsl:text>
      <xsl:apply-templates mode="inc" select="*|@*[name()!='href']|text()|comment()"/>
      <xsl:apply-templates mode="inc" select="document(@href,.)"/>
    </rng:div>
  </xsl:template>

  <xsl:template mode="inc" match="rng:include">
    <rng:div><xsl:text>
</xsl:text><xsl:comment>include "<xsl:value-of select="@href"/>"</xsl:comment><xsl:text>
</xsl:text>	
      <xsl:apply-templates mode="inc" select="*|@*[name()!='href']|text()|comment()"/>
      <rng:include>
        <xsl:for-each select="document(@href,.)/rng:grammar">
          <xsl:apply-templates mode="inc" select="*|@*|text()|comment()"/>
	</xsl:for-each>
      </rng:include>
    </rng:div>
  </xsl:template>

  <xsl:template mode="inc" match="*|@*|text()|comment()">
    <xsl:copy>
  	<xsl:apply-templates mode="inc" select="*|@*|text()|comment()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
