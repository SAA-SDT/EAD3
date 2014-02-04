<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://relaxng.org/ns/structure/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
        
        
        <xsl:template match="node() | @*">
            <xsl:copy>
                <xsl:apply-templates select="node() | @*"/>
            </xsl:copy>
        </xsl:template>
        
    <xsl:template match="define[string(@name) = 'e.relations'] | ref[string(@name) = 'e.relations']"/>
        
        
        
    </xsl:stylesheet>