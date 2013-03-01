<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xsi xd"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Feb 27, 2012</xd:p>
            <xd:p><xd:b>Author:</xd:b> Terry Catapano</xd:p>
            <xd:p>Convert EAD2002 instance to EAD X</xd:p>
            <xd:p>To do: Add parameter to control inclusion of comments in output.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <xsl:variable name="instance-ns-stripped">
        <xsl:apply-templates select="/" mode="strip-ns"/>
    </xsl:variable>

    <xsl:template match="/" name="start">
        <xsl:for-each select="$instance-ns-stripped">
            <xsl:apply-templates/>
        </xsl:for-each>
        
    </xsl:template>

    <!-- ############################################### -->
    <!-- IDENTITY TEMPLATE                               -->
    <!-- ############################################### -->

    <!-- add namespace to all elements -->
    <xsl:template match="element()">
        <xsl:element name="{local-name()}" namespace="http://saa-sdt.example.org/ead/revised">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <!-- copy the attributes -->
    <xsl:template match="attribute()|text()|comment()|processing-instruction()">
        <xsl:copy/>
    </xsl:template>

    <!-- need to add in the new xmlns, starting with the root ead element -->
    <xsl:template match="ead">
        <ead xmlns="http://saa-sdt.example.org/ead/revised">
            <xsl:apply-templates select="@*|node()"/> 
        </ead>
    </xsl:template>

    <!-- ############################################### -->
    <!-- DEPRECATED ELEMENTS                             -->
    <!-- ############################################### -->

<!-- Follow up re: list of deprecated elements MR 2012-10-10 -->
    <xsl:template match="dsc | abbr | expan | descgrp | frontmatter | runner">
        <xsl:comment>
            <xsl:call-template name="removedElement"/>
        </xsl:comment>
        <xsl:message>
            <xsl:call-template name="removedElement"/>
        </xsl:message>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- orphan elements -->
    <xsl:template match="descgrp/head">
        <xsl:comment>
            <xsl:call-template name="removedElement"/>
        </xsl:comment>
        <xsl:message>
            <xsl:call-template name="removedElement"/>
        </xsl:message>
    </xsl:template>
    
    <!-- dsc orphan elements -->
    <xsl:template match="dsc/head | dsc/address | dsc/blockquote | dsc/chronlist
        | dsc/list | dsc/note | dsc/p | dsc/table | dsc/thead">
        <xsl:comment>
            <xsl:call-template name="dscOrphanElements"/>
        </xsl:comment>
        <xsl:message>
            <xsl:call-template name="dscOrphanElements"/>
        </xsl:message>
        <xsl:comment>
            <xsl:apply-templates/>
        </xsl:comment>
    </xsl:template>

    <!-- ############################################### -->
    <!-- REVISED CONTENT MODELS                          -->
    <!-- ############################################### -->

    <!-- m.refs from container -->
    <xsl:template
        match="container/ref | container/extref | container/linkgrp | container/bibref | container/title | container/archref">
        <xsl:comment>
            <xsl:call-template name="removedElement"/>
        </xsl:comment>
        <xsl:message>
            <xsl:call-template name="removedElement"/>
        </xsl:message>
    </xsl:template>

<xsl:template match="eadheader">
    <xsl:comment>
        <xsl:text>eadheader now control: </xsl:text>
        <xsl:text>Inserting minimal control element</xsl:text>
    </xsl:comment>
    <xsl:message>
        <xsl:text>eadheader now control: </xsl:text>
        <xsl:text>Inserting minimal control element</xsl:text>
    </xsl:message>
    <control xmlns="http://saa-sdt.example.org/ead/revised">
        <eadid>xxx</eadid>
        <titleproper>xxx</titleproper>
        <maintenanceAgency>
            <agencyName>xxxx</agencyName>
        </maintenanceAgency>
        <maintenanceStatus>derived</maintenanceStatus>
        <descriptionMaintenanceHistory>
            <maintenanceEvent>
                <eventType>xxx</eventType>
                <eventDateTime>xxx</eventDateTime>
                <agentType>xxx</agentType>
                <agent>xxx</agent>
            </maintenanceEvent>
        </descriptionMaintenanceHistory>
        <instanceMaintenanceHistory>
            <maintenanceEvent>
                <eventType>derived</eventType>
                <eventDateTime><xsl:value-of select="current-dateTime()"/></eventDateTime>
                <agentType>human</agentType>
                <agent>Terry Catapano</agent>
            </maintenanceEvent>
        </instanceMaintenanceHistory>
        <languageDeclaration>
            <language languageCode="eng">xxx</language>
            <script scriptCode="Latn">xxx</script>
        </languageDeclaration>
        <publicationStatus>xxx</publicationStatus>
    </control>
</xsl:template>
    
    <!-- blockquote -->
    <xsl:template match="blockquote">
        <xsl:choose>
            <xsl:when test="parent::event | parent::extref | parent::extrefloc | 
                parent::item | parent::p | parent::ref | parent::refloc">
                <xsl:element name="quote">
                    <xsl:apply-templates select="p" mode="skipP"/>
                    <xsl:for-each select="address | chronlist | list | note | table">
                        <xsl:comment>
                            <xsl:call-template name="blockquoteOrphanElements"/>
                        </xsl:comment>
                        <xsl:comment>
                            <xsl:apply-templates/>
                        </xsl:comment>
                    </xsl:for-each>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="blockquote">
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>

    
    


    <!-- ############################################### -->
    <!-- RENAMED ELEMENTS                                -->
    <!-- ############################################### -->
    <!-- fileplan -->
    <xsl:template match="fileplan">
        <xsl:choose>
            <xsl:when test="ancestor::fileplan">
                <xsl:comment>
                    <xsl:text>ELEMENT </xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:text>RENAMED as 'div'</xsl:text>
                </xsl:comment>
                <xsl:message>
                    <xsl:text>ELEMENT </xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:text>RENAMED as 'div'</xsl:text>
                </xsl:message>
                <xsl:element name="div">
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:comment>
                    <xsl:text>ELEMENT </xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:text>RENAMED as 'odd'</xsl:text>
                </xsl:comment>
                <xsl:message>
                    <xsl:text>ELEMENT </xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:text>RENAMED as 'odd'</xsl:text>
                </xsl:message>
                <xsl:element name="odd">
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>


    </xsl:template>
    

    <!-- ############################################### -->
    <!-- NAMESPACE STRIPPING ELEMENTS                    -->
    <!-- ############################################### -->
    <xsl:template match="*" mode="strip-ns">
        <xsl:element name="{local-name()}" inherit-namespaces="no">
            <xsl:apply-templates select="@* | node()" mode="strip-ns"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="@*|text()|comment()|processing-instruction()" mode="strip-ns">
        <xsl:copy inherit-namespaces="no" copy-namespaces="no">
            <xsl:apply-templates select="@*|node()" mode="strip-ns"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="@xsi:schemaLocation" mode="strip-ns"
        xpath-default-namespace="http://www.w3.org/2001/XMLSchema-instance"/>

    <!-- ############################################### -->
    <!-- RECURSIVE ELEMENTS REPLACED BY DIV              -->
    <!-- ############################################### -->



    <!-- ############################################### -->
    <!-- OTHER TEMPLATES                                 -->
    <!-- ############################################### -->

    <xsl:template name="removedElement">
        <xsl:text>DEPRECATED ELEMENT </xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:text>REMOVED</xsl:text>
    </xsl:template>
    
    <xsl:template name="dscOrphanElements">
        <xsl:text>DSC CHILD ELEMENT </xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:text>ORPHANED BY DEPRECATION OF DSC. MIGRATION PATH PENDING</xsl:text>
    </xsl:template>
    
    <xsl:template name="blockquoteOrphanElements">
        <xsl:text>INLINE BLOCKQUOTE CHILD ELEMENT </xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:text>ORPHANED BY CONVERSION OF INLINE BLOCKQUOTE TO QUOTE. MIGRATION PATH PENDING</xsl:text>
    </xsl:template>
</xsl:stylesheet>
