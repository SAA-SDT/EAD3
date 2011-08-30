<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:ext="http://example.org/ead-extension/" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 26, 2011</xd:p>
            <xd:p><xd:b>Author:</xd:b> Terry Catapano</xd:p>
            <xd:p>Transformation to strip extension elements from EAD elements</xd:p>
        </xd:desc>
    </xd:doc>
    <!-- action param: controls how elements from external namespaces will be processed
         'comment' = place elements in comments
         'delete'  = remove elements from output
    -->
    <xsl:param name="action"/>
    <!-- Whenever you match any node or any attribute -->
    <xsl:template match="node()|@*">
        <!-- Copy the current node -->
        <xsl:copy>
            <!-- Including any attributes it has and any child nodes -->
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- process elements not in EAD namespace-->
    <xsl:template match="*[namespace-uri() != 'urn:isbn:1-931666-22-9']">
        <xsl:choose>
            <!-- place elements from external namespaces in comments -->
            <xsl:when test="$action = 'comment'">
                <xsl:comment><xsl:apply-templates  select="." mode="encode"/></xsl:comment>
            </xsl:when>
            <!-- remove elements from external namespaces -->
            <xsl:when test="$action = 'delete'"/>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    <!-- templates to output elements in comments
         derived from Stackoverflow
         see: http://stackoverflow.com/questions/3932152/output-element-in-comments/3933103#3933103
     -->
    <xsl:template match="*" mode="encode">
        <xsl:value-of select="concat('&lt;',name())"
            disable-output-escaping="yes"/>
        <xsl:apply-templates select="@*" mode="encode"/>
        <xsl:text>></xsl:text>
        <xsl:apply-templates mode="encode"/>
        <xsl:value-of select="concat('&lt;',name(),'>')"
            disable-output-escaping="yes"/>
    </xsl:template>
    <xsl:template match="*[not(node())]" mode="encode">
        <xsl:value-of select="concat('&lt;',name())"
            disable-output-escaping="yes"/>
        <xsl:apply-templates select="@*" mode="encode"/>
        <xsl:text>/></xsl:text>
    </xsl:template>
    <xsl:template match="@*" mode="encode">
        <xsl:value-of select="concat(' ',name(),'=&quot;',.,'&quot;')"/>
    </xsl:template>
    
</xsl:transform>