<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- identity template: copy attribute or node and apply-templates-->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>  
    </xsl:template>
    <!-- make any <element> not named "ead" a complexType -->
    <xsl:template match="xs:element[@name != 'ead']">
       <xs:complexType name="{@name}">
           <xsl:apply-templates select="child::xs:complexType/*"/>
       </xs:complexType>
    </xsl:template>
</xsl:stylesheet>