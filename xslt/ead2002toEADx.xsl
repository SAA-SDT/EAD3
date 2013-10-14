<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xsi xd"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Feb 27, 2012</xd:p>
            <xd:p><xd:b>Author:</xd:b> Terry Catapano</xd:p>
            <xd:p>Convert EAD2002 instance to EAD X</xd:p>
            <xd:p>To do: Add parameter to control inclusion of comments in output.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>

    <!-- user parameter for control/eventType -->
    <!-- eventType enumeration '[created, revised, deleted, cancelled, derived, updated]'.  -->
    <xsl:param name="eventType" select="'derived'"/>

    <!-- user parameter for control/agentType -->
    <!-- enumeration '[human, machine]' -->
    <xsl:param name="agentType" select="'machine'"/>

    <!-- user parameter for control/publicationStatus -->
    <!-- enumeration '[inProcess, approved]' -->
    <xsl:param name="publicationStatus" select="'inProcess'"/>

    <xsl:param name="eadxmlns" select="'urn:isbn:1-931666-22-9'"/>

    <xsl:variable name="instance-ns-stripped">
        <xsl:apply-templates select="/" mode="strip-ns"/>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model"><xsl:text>href="../ead_revised.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text></xsl:processing-instruction>
        <xsl:for-each select="$instance-ns-stripped">
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <!-- ############################################### -->
    <!-- IDENTITY TEMPLATE                               -->
    <!-- ############################################### -->


    <!-- add namespace to all elements -->
    <xsl:template match="element()">
        <xsl:element name="{local-name()}" namespace="{$eadxmlns}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <!-- copy the attributes -->
    <xsl:template match="attribute()|text()|comment()|processing-instruction()">
        <xsl:copy/>
    </xsl:template>

    <!--  need to add in the new xmlns, starting with the root ead element -->
    <!-- xsl:template match="ead">
        <ead namespace="{$eadxmlns}">
            <xsl:apply-templates select="@*|node()"/> 
        </ead>
    </xsl:template -->

    <!-- ############################################### -->
    <!-- DEPRECATED ELEMENTS                             -->
    <!-- ############################################### -->

    <!-- REMOVE COMPLETELY -->
    <xsl:template match="frontmatter | runner | accessrestrict/legalstatus | arcdesc/address | dsc/address">
        <xsl:comment>
            <xsl:call-template name="removedElement"/>
        </xsl:comment>
        <xsl:message>
            <xsl:call-template name="removedElement"/>
        </xsl:message>
    </xsl:template>

    <!-- SKIP -->
    <xsl:template match="descgrp | admininfo | titleproper/date | titleproper/num | 
        accessrestrict/accessrestrict/legalstatus | archref/abstract | subtitle/date | 
        subtitle/num">
        <xsl:comment>
            <xsl:call-template name="removedElement"/>
        </xsl:comment>
        <xsl:message>
            <xsl:call-template name="removedElement"/>
        </xsl:message>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- dsc orphan elements -->

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


    <!-- ############################################### -->
    <!-- EADHEADER to CONTROL                            -->
    <!-- ############################################### -->

    <xsl:template match="eadheader">
        <xsl:comment>
        <xsl:text>eadheader now control: </xsl:text>
        <xsl:text>Inserting minimal control element</xsl:text>
    </xsl:comment>
        <xsl:message>
            <xsl:text>eadheader now control: </xsl:text>
            <xsl:text>Inserting minimal control element</xsl:text>
        </xsl:message>
        <xsl:element name="control" namespace="{$eadxmlns}" xmlns="urn:isbn:1-931666-22-9">
            <recordid>[recordid]</recordid>
            <xsl:apply-templates select="filedesc"/>
            <maintenancestatus>derived</maintenancestatus>
            <maintenanceagency>
                <agencyname>[agency name]</agencyname>
            </maintenanceagency>
            <maintenancehistory>
                <maintenanceevent>
                    <eventtype>derived</eventtype>
                    <eventdatetime>
                        <xsl:value-of select="current-dateTime()"/>
                    </eventdatetime>
                    <agenttype>machine</agenttype>
                    <agent/>
                </maintenanceevent>
            </maintenancehistory>
        </xsl:element>
    </xsl:template>

    <!-- blockquote -->
    <xsl:template match="blockquote">
        <xsl:choose>
            <xsl:when
                test="parent::event | parent::extref | parent::extrefloc | 
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
            <xsl:when test="parent::archdesc | parent::admininfo | parent::descgrp">
                <xsl:call-template name="nowOdd"/>
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
    <!-- CHRONLIST                                       -->
    <!-- ############################################### -->

    <xsl:template match="chronlist">
        <xsl:call-template name="gonna-deal-with-this-later"/>
    </xsl:template>
    <!-- ############################################### -->
    <!-- LIST                                            -->
    <!-- ############################################### -->

    <xsl:template match="list">
        <xsl:call-template name="gonna-deal-with-this-later"/>
    </xsl:template>

    <!-- ############################################### -->
    <!-- TABLE                                           -->
    <!-- ############################################### -->

    <xsl:template match="table">
        <xsl:call-template name="gonna-deal-with-this-later"/>
    </xsl:template>
    
    
    <!-- ############################################### -->
    <!-- NAMES                                           -->
    <!-- ############################################### -->
    
    <xsl:template match="corpname | famname | persname | name">
        <xsl:comment>
            <xsl:text>Added child part element to </xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:comment>
        <xsl:message>
            <xsl:text>Added child part element to </xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:message>
        
        <xsl:element name="{local-name()}"  namespace="{$eadxmlns}" xmlns="urn:isbn:1-931666-22-9">
            <xsl:apply-templates select="@*"/>
            <part><xsl:apply-templates/></part>
        </xsl:element>
    </xsl:template>

    <!-- ############################################### -->
    <!-- RENAMED ELEMENTS                                -->
    <!-- ############################################### -->

    <!-- the archaic add -->
    <xsl:template match="add">
        <xsl:call-template name="nowOdd"/>
    </xsl:template>


    <!-- ############################################### -->
    <!--                  NOTES                          -->
    <!-- ############################################### -->

    <xsl:template match="c/note | arcdesc/note | descgrp/note">
        <xsl:comment>
                    <xsl:text>ELEMENT </xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:text>RENAMED as 'odd'</xsl:text>
                    <xsl:text>&#10;</xsl:text>
                </xsl:comment>
        <xsl:message>
            <xsl:text>ELEMENT </xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>&#160;</xsl:text>
            <xsl:text>RENAMED as 'odd'</xsl:text>
        </xsl:message>
        <xsl:element name="odd" namespace="{$eadxmlns}" xmlns="urn:isbn:1-931666-22-9">
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
    <xsl:template match="@xsi:schemaLocation" mode="strip-ns"
        xpath-default-namespace="http://www.w3.org/2001/XMLSchema-instance"/>
    
    
    <!-- ############################################### -->
    <!-- @TYPE TO @LOCALTYPE                             -->
    <!-- ############################################### -->
    
    <xsl:template match="abstract/@type | accessrestrict/@type | altformavail/@type | 
        phystech/@type | processinfo/@type | titleproper/@type | unitid/@type | 
        userestruct/@type">
        <xsl:attribute name="localtype">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
    
    
    <!-- ############################################### -->
    <!-- LANGUAGE ATTRIBUTES                             -->
    <!-- ############################################### -->
    
    <xsl:template match="abstract/@langcode">
        <xsl:attribute name="lang">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
    
    
    <!-- ############################################### -->
    <!-- ADDRESSLINE                                     -->
    <!-- ############################################### -->
    
    <xsl:template match="address[not(parent::repository) and not(parent::publicationtmt)]">
        <xsl:choose>
            <xsl:when test="not(parent::entry) 
                and not(parent::p) 
                and not(parent::event) 
                and not(parent::item)
                and not(parent::extref)
                and not(parent::extrefloc)
                and not(parent::ref)
                and not(parent::refloc)">
                <xsl:element name="p">
                    <xsl:for-each select="addressline">
                        <xsl:apply-templates/>
                        <xsl:if test="position()!=last()">
                            <xsl:element name="lb"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="addressline">
                    <xsl:apply-templates/>
                    <!-- MR: Not sure if we want to add commas here.  -->
                    <!--<xsl:if test="position()!=last()">
                        <xsl:text>, </xsl:text>
                    </xsl:if>-->
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- ############################################### -->
    <!-- ACCESSRESTRICT + LEGALSTATUS                    -->
    <!-- ############################################### -->
    
    <xsl:template match="accessrestrict">
        <xsl:element name="{local-name()}" namespace="{$eadxmlns}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
        <xsl:for-each select="legalstatus">
            <xsl:element name="{local-name()}" namespace="{$eadxmlns}">
                <xsl:element name="p" namespace="{$eadxmlns}">
                    <xsl:apply-templates select="@*|node()"/>
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="accessrestrict/legalstatus"/>
    
    <!-- ############################################### -->
    <!-- CUSTODHIST + ACQINFO                            -->
    <!-- ############################################### -->
    
    <xsl:template match="custodhist">
        <xsl:element name="{local-name()}" namespace="{$eadxmlns}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
        <xsl:for-each select="acqinfo">
            <xsl:element name="{local-name()}" namespace="{$eadxmlns}">
                <xsl:apply-templates select="@*|node()"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="custodhist/acqinfo"/>
    
    

    <!-- ############################################### -->
    <!-- OTHER TEMPLATES                                 -->
    <!-- ############################################### -->

    <xsl:template name="removedElement">
        <xsl:text>DEPRECATED ELEMENT </xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:text>REMOVED</xsl:text>
    </xsl:template>

    <xsl:template name="nowOdd">
        <xsl:comment>
                    <xsl:text>ELEMENT </xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:text>RENAMED as 'odd'</xsl:text>
                    <xsl:text>&#10;</xsl:text>
                </xsl:comment>
        <xsl:message>
            <xsl:text>ELEMENT </xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>&#160;</xsl:text>
            <xsl:text>RENAMED as 'odd'</xsl:text>
        </xsl:message>
        <xsl:element name="odd" namespace="{$eadxmlns}" xmlns="urn:isbn:1-931666-22-9">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
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

    <xsl:template name="gonna-deal-with-this-later">
        <xsl:comment>
        <xsl:text>NOT GONNA DEAL WITH</xsl:text>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:text>NOW</xsl:text>
        <xsl:text>&#10;</xsl:text>
        </xsl:comment>
    </xsl:template>

</xsl:stylesheet>
