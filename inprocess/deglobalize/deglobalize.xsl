<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:s="http://ead3.archivists.org/schema/"
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
    <xsl:template match="xs:element[@name != 'ead'][parent::xs:schema]">
        <xsl:element name='xs:complexType'>
            <xsl:attribute name='name'>
                <xsl:value-of select='@name'/>
            </xsl:attribute>
            <xsl:if test='xs:complexType[@mixed="true"]'>
                <xsl:attribute name='mixed'>true</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select='xs:complexType/*'/>
            
        </xsl:element>
    </xsl:template>
    <xsl:template match="xs:element[@ref != 'ead']">
        <xsl:element name='xs:element'>           
        <xsl:attribute name='name'>
            <xsl:value-of select="substring-after(@ref, ':')"/> <!-- <xsl:value-of select='substring-after(string(@ref), "s:")'/> -->
        </xsl:attribute>
        <xsl:attribute name='type'>
            <xsl:value-of select="substring-after(@ref, ':')"/>
        </xsl:attribute>
            <xsl:apply-templates select='@*[not(name(.)="ref")] | *'/>
        </xsl:element>

    </xsl:template>

    <xsl:template match="@*[starts-with(., 'schema')]">
        <xsl:attribute name="{name()}"><xsl:value-of select="substring-after(., ':')"/></xsl:attribute>
    </xsl:template>
    <!--    
    <xsl:template match="xs:element[starts-with(@ref, 'schema:m.')]">
        <xs:group>
            <xsl:apply-templates select="@* | node()"/>
        </xs:group>
    </xsl:template>
    
   -->
</xsl:stylesheet>