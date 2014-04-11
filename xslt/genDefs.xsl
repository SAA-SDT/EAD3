<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xpath-default-namespace="http://relaxng.org/ns/structure/1.0" exclude-result-prefixes="xs xd"
    version="2.0">
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Apr 10, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> terry</xd:p>
            <xd:p>Stylesheet to create table of elements with contained attributes and
                elements</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="/">
        <elements>
            <xsl:apply-templates select="//define[starts-with(@name, 'e.')]">
                <xsl:sort select="child::element/@name"/>
            </xsl:apply-templates>
        </elements>
    </xsl:template>

    <xsl:template match="define">
        <!-- for each definition get the child element name -->
        <element>
            <elementName>
                <xsl:value-of select="child::element/@name"/>
            </elementName>
            <attributes>
                <!-- create pipe delimited list of the names of each descendant attribute or ref to an attribute whose first ancestor element is not the current definition's child element -->
                <xsl:for-each
                    select="child::element//attribute[ancestor::element[1] = current()/element] | child::element//ref[starts-with(@name, 'a.')][ancestor::element[1] = current()/element]">
                    <xsl:value-of select="replace(@name, 'a\.', '')"/>
                    <xsl:text>|</xsl:text>
                </xsl:for-each>
                <!-- apply-templates on each define whose name matches the name of a descendant ref which starts with either "am." or "m." whose first ancestor element is not the current define's child element -->
                <xsl:for-each
                    select="child::element//ref[starts-with(@name, 'am.')][ancestor::element[1] = current()/element] | child::element//ref[starts-with(@name, 'm.')][ancestor::element[1] = current()/element]">
                    <xsl:variable name="modelName" select="@name"/>
                    <xsl:message select="$modelName"/>
                    <xsl:apply-templates select="//define[@name = $modelName]" mode="nestedAttr"/>
                </xsl:for-each>
            </attributes>
            <!-- create pipe delimited list of the names of each descendant element or ref to an element whose first ancestor element is not the current definition's child element -->
            <mayContain>
                <xsl:for-each
                    select="child::element//element[ancestor::element[1] = current()/element] | child::element//ref[starts-with(@name, 'e.')][ancestor::element[1] = current()/element]">
                    <xsl:value-of select="replace(@name, 'e\.', '')"/>
                    <xsl:text>|</xsl:text>
                </xsl:for-each>
                <!-- apply-templates on each define whose name matches the name of a descendant ref which starts with "m." whose first ancestor element is not the current define's child element -->
                <xsl:for-each
                    select="child::element//ref[starts-with(@name, 'm.')][ancestor::element[1] = current()/element]">
                    <xsl:variable name="modelName" select="@name"/>
                    <xsl:message select="$modelName"/>
                    <xsl:apply-templates select="//define[@name = $modelName]" mode="nested"/>
                </xsl:for-each>
            </mayContain>
        </element>
    </xsl:template>
 <!-- defines which are ref'd by other defines -->
    <xsl:template match="define" mode="nested">
        <!--  get names of descendant ref to an element or element -->
        <xsl:for-each select="descendant::element | .//ref[starts-with(@name, 'e.')]">
            <xsl:value-of select="replace(@name, 'e\.', '')"/>
            <xsl:text>|</xsl:text>
        </xsl:for-each>
        <!-- apply-templates on each define whose name matches the name of a descendant ref which starts with "m."-->
        <xsl:for-each select=".//ref[starts-with(@name, 'm.')][ancestor::element[1] = current()/element]">
            <xsl:variable name="modelName" select="@name"/>
            <xsl:message select="$modelName"/>
            <xsl:apply-templates select="//define[@name = $modelName]" mode="nested"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="define" mode="nestedAttr">
        <!--  get names of descendant ref to an attribute or attribute -->
        <xsl:for-each select=".//ref[starts-with(@name, 'a.')] | .//attribute">
            <xsl:value-of select="replace(@name, 'a\.', '')"/>
            <xsl:text>|</xsl:text>
        </xsl:for-each>
        <!-- apply-templates on each define whose name matches the name of a descendant ref which starts with "m." or "am/."  -->
        <xsl:for-each select=".//ref[starts-with(@name, 'am.')] | .//ref[starts-with(@name, 'm.')]">
            <xsl:variable name="modelName" select="@name"/>
            <xsl:message select="$modelName"/>
            <xsl:apply-templates select="//define[@name = $modelName]" mode="nestedAttr"/>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
