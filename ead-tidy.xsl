<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="xd"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 29, 2011</xd:p>
            <xd:p><xd:b>Author:</xd:b> terry</xd:p>
            <xd:p>Various templates to clean up EAD instances</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:param name="empty-elements">
        <xsl:text></xsl:text>
    </xsl:param>
    <!-- Function definition from FunctX function library, version 1.0
         For more information on the FunctX XSLT library, contact contrib@functx.com.
         see http://www.xsltfunctions.com -->
    <xsl:function name="functx:is-value-in-sequence" as="xs:boolean" >
        <xsl:param name="value" as="xs:anyAtomicType?"/> 
        <xsl:param name="seq" as="xs:anyAtomicType*"/>        
        <xsl:sequence select=" 
            $value = $seq
            "/>       
    </xsl:function>
   <!-- Identity Template -->
    <!-- Whenever you match any node or any attribute -->
    <xsl:template match="node()|@*">
        
        
        <!-- Copy the current node -->
        <xsl:copy>            
            <!-- Including any attributes it has and any child nodes -->
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <!--
    <xsl:template match="ead:lb">
                 <xsl:message select="local-name()"/>
         <xsl:message select="$empty-elements"></xsl:message>
         <xsl:message select="functx:is-value-in-sequence(local-name(), ('lb','ptr','colspec','ptrloc','extptrloc','arc'))"></xsl:message>
    </xsl:template>
    -->
    <!-- strip elements not defined as empty which have no content       -->
     <xsl:template match="*[string-length(normalize-space(.)) = 0][not(child::*)][not(functx:is-value-in-sequence(local-name(), ('lb','ptr','colspec','ptrloc','extptrloc','arc')))]">
         <xsl:message select="local-name()"/>
         <xsl:message select="$empty-elements"></xsl:message>
         <xsl:message select="functx:is-value-in-sequence(local-name(), $empty-elements)"></xsl:message>
     </xsl:template>

    <!-- Strip any elements not in EAD namespace-->
    <xsl:template match="*[namespace-uri() != 'urn:isbn:1-931666-22-9']"/>
    
</xsl:stylesheet>