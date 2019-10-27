<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:s="http://ead3.archivists.org/schema/"
    exclude-result-prefixes="xs s" version="2.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- identity template: copy attribute or node and apply-templates-->
    <xsl:template match="@* |node()">
        <xsl:copy>
            <xsl:apply-templates select="@* |node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- make any <element> not named "ead" a complexType -->
    
    <!-- c12 is defined in RNG as:  
        
     <element name="c12">
      <ref name="m.c.base"/>
    </element>
    
    and that is correctly converted by TRANG to
    
      <xs:element name="c12" type="schema:m.c.base"/>
      
     However, the deglobalize transformation process (do we really need it?) does not expect c12 to be an empty element with a type attribute only... 
      so, we need to take that into account.
    
    so, before the fix, we wind up with this:
    <xs:complexType name="c12"/>
    
    which means that you can create a c12 element, but it does not have any valid children.
    
    so, that should be:
   <xs:complexType name="c12">
    <xs:complexContent>
      <xs:extension base="m.c.base"/>
    </xs:complexContent>
  </xs:complexType>
    
    since c12 is the only incoming xs:element with a @type, we'll process those slightly differenlty here.
    -->
    <xsl:template match="xs:element[@name != 'ead'][parent::xs:schema]">
        <xs:complexType name="{@name}">
            <xsl:if test='xs:complexType[@mixed = "true"]'>
                <xsl:attribute name="mixed">true</xsl:attribute>
            </xsl:if>
            <!-- new, to fix the issue of the c12 bug -->
            <xsl:apply-templates select="@type[starts-with(., 'schema:')]" mode="convert-type-to-extension-element"/>
            <xsl:apply-templates select="xs:complexType/*"/>
        </xs:complexType>
    </xsl:template>
    <xsl:template match="xs:element[@ref != 'ead']">
        <xs:element name="{substring-after(@ref, ':')}" type="{substring-after(@ref, ':')}">
            <xsl:apply-templates select='@*[not(name(.) = "ref")] | *'/>
        </xs:element>
    </xsl:template>
    <!--    <xsl:template match="xs:extension">
        <xsl:element name="xs:extension">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="xs:attributeGroup">
        <xsl:element name="xs:extension">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
-->
    <xsl:template match="@*[starts-with(., 'schema')]">
        <xsl:attribute name="{name()}"><xsl:value-of select="substring-after(., ':')"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="@*[starts-with(., 'u:')]">
        <xsl:attribute name="{name()}"><xsl:value-of select="substring-after(., ':')"/></xsl:attribute>
    </xsl:template>
    <!--    
    <xsl:template match="xs:element[starts-with(@ref, 'schema:m.')]">
        <xs:group>
            <xsl:apply-templates select="@* | node()"/>
        </xs:group>
    </xsl:template> 
   -->
    
    <!-- new, to fix the issue of the c12 bug -->
    <xsl:template match="@type" mode="convert-type-to-extension-element">
        <xs:extension base="{substring-after(., ':')}" />
    </xsl:template>
    
</xsl:stylesheet>
