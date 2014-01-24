<?xml version="1.0" encoding="UTF-8"?>
<!-- 
	
Creative Commons Legal Code
CC0 1.0 Universal

    CREATIVE COMMONS CORPORATION IS NOT A LAW FIRM AND DOES NOT PROVIDE LEGAL SERVICES. DISTRIBUTION OF THIS DOCUMENT DOES NOT CREATE AN ATTORNEY-CLIENT RELATIONSHIP. CREATIVE COMMONS PROVIDES THIS INFORMATION ON AN "AS-IS" BASIS. CREATIVE COMMONS MAKES NO WARRANTIES REGARDING THE USE OF THIS DOCUMENT OR THE INFORMATION OR WORKS PROVIDED HEREUNDER, AND DISCLAIMS LIABILITY FOR DAMAGES RESULTING FROM THE USE OF THIS DOCUMENT OR THE INFORMATION OR WORKS PROVIDED HEREUNDER. 
    
Statement of Purpose

The laws of most jurisdictions throughout the world automatically confer exclusive Copyright and Related Rights (defined below) upon the creator and subsequent owner(s) (each and all, an "owner") of an original work of authorship and/or a database (each, a "Work").

Certain owners wish to permanently relinquish those rights to a Work for the purpose of contributing to a commons of creative, cultural and scientific works ("Commons") that the public can reliably and without fear of later claims of infringement build upon, modify, incorporate in other works, reuse and redistribute as freely as possible in any form whatsoever and for any purposes, including without limitation commercial purposes. These owners may contribute to the Commons to promote the ideal of a free culture and the further production of creative, cultural and scientific works, or to gain reputation or greater distribution for their Work in part through the use and efforts of others.

For these and/or other purposes and motivations, and without any expectation of additional consideration or compensation, the person associating CC0 with a Work (the "Affirmer"), to the extent that he or she is an owner of Copyright and Related Rights in the Work, voluntarily elects to apply CC0 to the Work and publicly distribute the Work under its terms, with knowledge of his or her Copyright and Related Rights in the Work and the meaning and intended legal effect of CC0 on those rights.

1. Copyright and Related Rights. A Work made available under CC0 may be protected by copyright and related or neighboring rights ("Copyright and Related Rights"). Copyright and Related Rights include, but are not limited to, the following:

    the right to reproduce, adapt, distribute, perform, display, communicate, and translate a Work;
    moral rights retained by the original author(s) and/or performer(s);
    publicity and privacy rights pertaining to a person's image or likeness depicted in a Work;
    rights protecting against unfair competition in regards to a Work, subject to the limitations in paragraph 4(a), below;
    rights protecting the extraction, dissemination, use and reuse of data in a Work;
    database rights (such as those arising under Directive 96/9/EC of the European Parliament and of the Council of 11 March 1996 on the legal protection of databases, and under any national implementation thereof, including any amended or successor version of such directive); and
    other similar, equivalent or corresponding rights throughout the world based on applicable law or treaty, and any national implementations thereof.
    
2. Waiver. To the greatest extent permitted by, but not in contravention of, applicable law, Affirmer hereby overtly, fully, permanently, irrevocably and unconditionally waives, abandons, and surrenders all of Affirmer's Copyright and Related Rights and associated claims and causes of action, whether now known or unknown (including existing as well as future claims and causes of action), in the Work (i) in all territories worldwide, (ii) for the maximum duration provided by applicable law or treaty (including future time extensions), (iii) in any current or future medium and for any number of copies, and (iv) for any purpose whatsoever, including without limitation commercial, advertising or promotional purposes (the "Waiver"). Affirmer makes the Waiver for the benefit of each member of the public at large and to the detriment of Affirmer's heirs and successors, fully intending that such Waiver shall not be subject to revocation, rescission, cancellation, termination, or any other legal or equitable action to disrupt the quiet enjoyment of the Work by the public as contemplated by Affirmer's express Statement of Purpose.

3. Public License Fallback. Should any part of the Waiver for any reason be judged legally invalid or ineffective under applicable law, then the Waiver shall be preserved to the maximum extent permitted taking into account Affirmer's express Statement of Purpose. In addition, to the extent the Waiver is so judged Affirmer hereby grants to each affected person a royalty-free, non transferable, non sublicensable, non exclusive, irrevocable and unconditional license to exercise Affirmer's Copyright and Related Rights in the Work (i) in all territories worldwide, (ii) for the maximum duration provided by applicable law or treaty (including future time extensions), (iii) in any current or future medium and for any number of copies, and (iv) for any purpose whatsoever, including without limitation commercial, advertising or promotional purposes (the "License"). The License shall be deemed effective as of the date CC0 was applied by Affirmer to the Work. Should any part of the License for any reason be judged legally invalid or ineffective under applicable law, such partial invalidity or ineffectiveness shall not invalidate the remainder of the License, and in such case Affirmer hereby affirms that he or she will not (i) exercise any of his or her remaining Copyright and Related Rights in the Work or (ii) assert any associated claims and causes of action with respect to the Work, in either case contrary to Affirmer's express Statement of Purpose.

4. Limitations and Disclaimers.

    No trademark or patent rights held by Affirmer are waived, abandoned, surrendered, licensed or otherwise affected by this document.
    Affirmer offers the Work as-is and makes no representations or warranties of any kind concerning the Work, express, implied, statutory or otherwise, including without limitation warranties of title, merchantability, fitness for a particular purpose, non infringement, or the absence of latent or other defects, accuracy, or the present or absence of errors, whether or not discoverable, all to the greatest extent permissible under applicable law.
    Affirmer disclaims responsibility for clearing rights of other persons that may apply to the Work or any use thereof, including without limitation any person's Copyright and Related Rights in the Work. Further, Affirmer disclaims responsibility for obtaining any necessary consents, permissions or other rights required for any use of the Work.
    Affirmer understands and acknowledges that Creative Commons is not a party to this document and has no duty or obligation with respect to this CC0 or use of the Work.
    
    
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xsi xd"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://ead3.archivists.org/schema/"
    version="2.0">
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

    <xsl:param name="eadxmlns" select="'http://ead3.archivists.org/schema/'"/>

    <xsl:variable name="instance-ns-stripped">
        <xsl:apply-templates select="/" mode="strip-ns"/>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model">
            <xsl:text>href="../ead_revised.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
        </xsl:processing-instruction>
        <xsl:processing-instruction name="oxygen">
            <xsl:text>RNGSchema="../ead_revised.rng" type="xml"</xsl:text>
        </xsl:processing-instruction>
        <!--<xsl:copy-of select="$instance-ns-stripped"/>
        -->
        <!--<xsl:apply-templates select="/" mode="strip-ns"/>
        -->
        <xsl:for-each select="$instance-ns-stripped">
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <!-- ############################################### -->
    <!-- IDENTITY TEMPLATE                               -->
    <!-- ############################################### -->


    <xsl:template match="element()">
        <xsl:element name="{local-name()}" namespace="http://ead3.archivists.org/schema/">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <!-- copy the attributes -->
    <xsl:template match="attribute()|text()|comment()|processing-instruction()">
        <xsl:copy/>
    </xsl:template>

    <!--  need to add in the new xmlns, starting with the root ead element -->
    <!-- xsl:template match="ead">
        <ead>
            <xsl:apply-templates select="@*|node()"/> 
        </ead>
    </xsl:template -->

    <!-- ############################################### -->
    <!-- DEPRECATED ELEMENTS                             -->
    <!-- ############################################### -->

    <!-- REMOVE COMPLETELY -->
    <xsl:template
        match="frontmatter | runner | accessrestrict/legalstatus | arcdesc/address | dsc/address | @linktype">
        <xsl:comment>
            <xsl:call-template name="removedElement"/>
        </xsl:comment>
        <xsl:message>
            <xsl:call-template name="removedElement"/>
        </xsl:message>
    </xsl:template>

    <!-- SKIP -->
    <xsl:template
        match="descgrp | admininfo | titleproper/date | titleproper/num | 
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

    <xsl:template
        match="descgrp/address | descgrp/blockquote | descgp/descgrp | descgrp/head | descgrp/index | descgrp/list | descgrp/p | descgrp/table">
        <xsl:comment>
            <xsl:call-template name="removedElement"/>
        </xsl:comment>
        <xsl:message>
            <xsl:call-template name="removedElement"/>
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


    <!-- ############################################### -->
    <!-- type attributes                            -->
    <!-- ############################################### -->

    <xsl:template match="dsc/@type | list/@type">
        <xsl:attribute name="{parent::*/local-name()}type" select="string(.)"/>
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
        <control>
            <recordid>[recordid]</recordid>
            <xsl:apply-templates select="filedesc"/>
            <maintenancestatus value="derived"/>
            <maintenanceagency>
                <agencyname>[agency name]</agencyname>
            </maintenanceagency>
            <maintenancehistory>
                <maintenanceevent>
                    <eventtype value="derived"/>
                    <eventdatetime>
                        <xsl:value-of select="current-dateTime()"/>
                    </eventdatetime>
                    <agenttype value="machine"/>
                    <agent/>
                </maintenanceevent>
            </maintenancehistory>
        </control>
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
<!--
    <xsl:template match="list">
        <list>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="*"/>
        </list>
    </xsl:template>
-->
    <!-- ############################################### -->
    <!-- TABLE                                           -->
    <!-- ############################################### -->

    <xsl:template match="table">
        <xsl:call-template name="gonna-deal-with-this-later"/>
    </xsl:template>

    <!-- ############################################### -->
    <!-- DID ELEMENTS                                    -->
    <!-- ############################################### -->
    <!-- origination:
     when child *name is present:   
        create origination for each *name element
        put all text in a comment
      otherwise:
      put all text in <name>/<part>
-->

    <xsl:template match="origination">
        <xsl:for-each select="corpname | name | persname | famname">
            <origination>
                <xsl:apply-templates select="self::*"/>
                <xsl:comment>
                    <xsl:value-of select="parent::origination//text()"/>
                </xsl:comment>
            </origination>
        </xsl:for-each>
        <xsl:if test="empty(corpname | name | persname | famname)">
            <origination>
                <xsl:copy-of select="@*"/>
                <name>
                    <part>
                        <xsl:apply-templates/>
                    </part>
                </name>
            </origination>
            <!--    <descriptivenote>
                <xsl:value-of separator=" " select="node() except (corpname | name | persname | famname)"/>
            </descriptivenote>
         -->
        </xsl:if>
    </xsl:template>


    <xsl:template match="repository">
        <repository>
            <xsl:apply-templates select="corpname | name | persname | famname | address"/>
            <xsl:if test="empty(corpname | name | persname | famname | address)">

                <name>
                    <part>
                        <xsl:value-of select=".//text()"/>
                    </part>
                </name>

            </xsl:if>
            <xsl:comment>
                <xsl:value-of select=".//text()"/>
            </xsl:comment>
        </repository>
    </xsl:template>
    
    <xsl:template match="physdesc[child::node() except (extent) ]">
        <physdesc>
         <xsl:apply-templates/>
        </physdesc>
    </xsl:template>
    
    <xsl:template match="physdesc[child::extent]">
        <physdescstructured physdescstructuredtype="spaceoccupied" coverage="whole">
            <quantity><xsl:apply-templates select="extent/text()"/></quantity>
            <unittype></unittype>
        </physdescstructured>
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

        <xsl:element name="{local-name()}" namespace="{$eadxmlns}">
            <xsl:apply-templates select="@*"/>
            <part>
                <xsl:apply-templates/>
            </part>
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

    <xsl:template match="c/note | archdesc/note | descgrp/note">
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

    <xsl:template match="did/note">
        <xsl:comment>
            <xsl:text>ELEMENT </xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>&#160;</xsl:text>
            <xsl:text>RENAMED as 'didnote'</xsl:text>
            <xsl:text>&#10;</xsl:text>
        </xsl:comment>
        <xsl:message>
            <xsl:text>ELEMENT </xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>&#160;</xsl:text>
            <xsl:text>RENAMED as 'didnote'</xsl:text>
        </xsl:message>
        <didnote>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="p" mode="skipP"/>
        </didnote>
    </xsl:template>

    <!-- ############################################### -->
    <!-- NAMESPACE STRIPPING ELEMENTS                    -->
    <!-- ############################################### -->
    <xsl:template match="*" mode="strip-ns">
        <xsl:element name="{local-name()}" namespace="" inherit-namespaces="no">
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

    <xsl:template
        match="abstract/@type | accessrestrict/@type | altformavail/@type | 
        phystech/@type | processinfo/@type | titleproper/@type | unitid/@type | 
        userestruct/@type | odd/@type">
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
    <!--
    <xsl:template match="address[not(parent::repository) and not(parent::publicationtmt)]">
        <xsl:choose>
            <xsl:when
                test="not(parent::entry) 
                and not(parent::p) 
                and not(parent::event) 
                and not(parent::item)
                and not(parent::extref)
                and not(parent::extrefloc)
                and not(parent::ref)
                and not(parent::refloc)
                and not (parent::descgrp)">
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
                    <xsl:apply-templates/> -->
    <!-- MR: Not sure if we want to add commas here.  -->
    <!--<xsl:if test="position()!=last()">
                        <xsl:text>, </xsl:text>
                    </xsl:if>-->
    <!--               </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
-->
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
            <xsl:copy-of select="@* except @type"/>
            <xsl:attribute name="localtype" select="@type"/>
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
