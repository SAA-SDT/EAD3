<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 26, 2011</xd:p>
            <xd:p><xd:b>Author:</xd:b> Terry Catapano</xd:p>
            <xd:p>Transformation to strip extension elements from EAD elements</xd:p>
        </xd:desc>
    </xd:doc>
    <!-- Whenever you match any node or any attribute -->
    <xsl:template match="node()|@*">
        <!-- Copy the current node -->
        <xsl:copy>            
            <!-- Including any attributes it has and any child nodes -->
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- Strip any elements not in EAD namespace-->
    <xsl:template match="*[namespace-uri() != 'urn:isbn:1-931666-22-9']"/>
</xsl:transform>