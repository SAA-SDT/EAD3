<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Feb 27, 2012</xd:p>
            <xd:p><xd:b>Author:</xd:b> Terry Catapano</xd:p>
            <xd:p>Convert EAD2002 instance to EAD X</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <xsl:variable name="instance-ns-stripped">
        <xsl:apply-templates select="/" mode="strip-ns"/>
    </xsl:variable>

    <xsl:template match="/" name="start">
        <xsl:message select="$instance-ns-stripped"/>
        <xsl:for-each select="$instance-ns-stripped">
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <!-- ############################################### -->
    <!-- IDENTITY TEMPLATE                               -->
    <!-- ############################################### -->

    <!-- Whenever you match any node or any attribute -->
    <xsl:template match="node()|@*">

        <!-- Copy the current node -->
        <xsl:copy>

            <!-- Including any attributes it has and any child nodes -->
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>


    <!-- ############################################### -->
    <!-- DEPRECATED ELEMENTS                             -->
    <!-- ############################################### -->

    <xsl:template match="did | dsc | abbr | expan | descgrp">
        <xsl:comment>
            <xsl:text>ELEMENT </xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text> REMOVED</xsl:text>
        </xsl:comment>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- orphan heads -->
    <xsl:template match="descgrp/head | dsc/head ">
        <xsl:comment>
            <xsl:text>ELEMENT </xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>&#160;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text> REMOVED</xsl:text>
        </xsl:comment>
    </xsl:template>

    <!-- ############################################### -->
    <!-- REVISED CONTENT MODELS                          -->
    <!-- ############################################### -->

    <!-- m.refs from container -->
    <xsl:template
        match="container/ref | container/extref | container/linkgrp | container/bibref | container/title | container/archref">
        <xsl:comment>
            <xsl:text>ELEMENT </xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text> REMOVED</xsl:text>
        </xsl:comment>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    
    <!-- ############################################### -->
    <!-- RENAMED ELEMENTS                                -->
    <!-- ############################################### -->
    <!-- numbered c's -->
    <xsl:template match="c01 | c02 | c03 | c04 | c05 | c06 | c07 | c08 | c09 | c10 | c11 | c12 ">
        <xsl:comment>
            <xsl:text>ELEMENT </xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>&#160;</xsl:text>
            <xsl:text>RENAMED as 'c'</xsl:text>
        </xsl:comment>
        <xsl:element name="c">
         <xsl:copy-of select="@*"/>            
            <xsl:apply-templates/>
        </xsl:element>
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
    <xsl:template match="@schemaLocation"
        xpath-default-namespace="http://www.w3.org/2001/XMLSchema-instance"/>

</xsl:stylesheet>
