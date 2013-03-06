<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:output method="xml"/>
   <xsl:template match="@althead" mode="reCaSe">
      <xsl:attribute name="altHead">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@altrender" mode="reCaSe">
      <xsl:attribute name="altRender">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@authfilenumber" mode="reCaSe">
      <xsl:attribute name="authFileNumber">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@charoff" mode="reCaSe">
      <xsl:attribute name="charOff">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@colname" mode="reCaSe">
      <xsl:attribute name="colName">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@colnum" mode="reCaSe">
      <xsl:attribute name="colNum">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@colsep" mode="reCaSe">
      <xsl:attribute name="colSep">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@colspec" mode="reCaSe">
      <xsl:attribute name="colSpec">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@colwidth" mode="reCaSe">
      <xsl:attribute name="colWidth">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@containerid" mode="reCaSe">
      <xsl:attribute name="containerId">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@countryencoding" mode="reCaSe">
      <xsl:attribute name="countryEncoding">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@countrycode" mode="reCaSe">
      <xsl:attribute name="countryCode">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@dataencoding" mode="reCaSe">
      <xsl:attribute name="dataEncoding">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@datechar" mode="reCaSe">
      <xsl:attribute name="dateChar">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@encodinganalog" mode="reCaSe">
      <xsl:attribute name="encodingAnalog">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@entityref" mode="reCaSe">
      <xsl:attribute name="entityRef">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@findaidstatus" mode="reCaSe">
      <xsl:attribute name="findAidStatus">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@langcode" mode="reCaSe">
      <xsl:attribute name="langCode">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@langencoding" mode="reCaSe">
      <xsl:attribute name="langEncoding">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@localtype" mode="reCaSe">
      <xsl:attribute name="localType">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@mainagencycode" mode="reCaSe">
      <xsl:attribute name="mainAgencyCode">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@morerows" mode="reCaSe">
      <xsl:attribute name="moreRows">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@nameend" mode="reCaSe">
      <xsl:attribute name="nameEnd">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@namest" mode="reCaSe">
      <xsl:attribute name="namEst">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@otherlevel" mode="reCaSe">
      <xsl:attribute name="otherLevel">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@pgwide" mode="reCaSe">
      <xsl:attribute name="pgWide">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@relatedencoding" mode="reCaSe">
      <xsl:attribute name="relatedEncoding">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@repositorycode" mode="reCaSe">
      <xsl:attribute name="repositoryCode">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@repositoryencoding" mode="reCaSe">
      <xsl:attribute name="repositoryEncoding">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@rowsep" mode="reCaSe">
      <xsl:attribute name="rowSep">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@scriptencoding" mode="reCaSe">
      <xsl:attribute name="scriptEncoding">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@tpattern" mode="reCaSe">
      <xsl:attribute name="tPattern">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@valign" mode="reCaSe">
      <xsl:attribute name="vAlign">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="@xpointer" mode="reCaSe">
      <xsl:attribute name="xPointer">
         <xsl:apply-templates select="."/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template match="*:accessrestrict" mode="reCaSe">
      <xsl:element name="accessRestrict" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:acqinfo" mode="reCaSe">
      <xsl:element name="acqInfo" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:addressline" mode="reCaSe">
      <xsl:element name="addressLine" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:altformavail" mode="reCaSe">
      <xsl:element name="altFormAvail" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:archdesc" mode="reCaSe">
      <xsl:element name="archDesc" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:archref" mode="reCaSe">
      <xsl:element name="archRef" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:bibref" mode="reCaSe">
      <xsl:element name="bibRef" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:bibseries" mode="reCaSe">
      <xsl:element name="bibSeries" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:bioghist" mode="reCaSe">
      <xsl:element name="biogHist" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:blockquote" mode="reCaSe">
      <xsl:element name="blockQuote" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:chronitem" mode="reCaSe">
      <xsl:element name="chronItem" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:chronlist" mode="reCaSe">
      <xsl:element name="chronList" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:controlaccess" mode="reCaSe">
      <xsl:element name="controlAccess" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:corpname" mode="reCaSe">
      <xsl:element name="corpName" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:custodhist" mode="reCaSe">
      <xsl:element name="custodHist" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:daodesc" mode="reCaSe">
      <xsl:element name="daoDesc" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:daogrp" mode="reCaSe">
      <xsl:element name="daoGrp" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:daoloc" mode="reCaSe">
      <xsl:element name="daoLoc" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:defitem" mode="reCaSe">
      <xsl:element name="defItem" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:eventgrp" mode="reCaSe">
      <xsl:element name="eventGrp" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:famname" mode="reCaSe">
      <xsl:element name="geogName" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:fileplan" mode="reCaSe">
      <xsl:element name="filePlan" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:formsavailable" mode="reCaSe">
      <xsl:element name="formsAvailable" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:genreform" mode="reCaSe">
      <xsl:element name="genreForm" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:indexentry" mode="reCaSe">
      <xsl:element name="indexEntry" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:langmaterial" mode="reCaSe">
      <xsl:element name="langMaterial" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:legalstatus" mode="reCaSe">
      <xsl:element name="legalStatus" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:listhead" mode="reCaSe">
      <xsl:element name="listHead" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:materialspec" mode="reCaSe">
      <xsl:element name="materialSpec" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:namegrp" mode="reCaSe">
      <xsl:element name="nameGrp" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:originalsloc" mode="reCaSe">
      <xsl:element name="originalsLoc" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:otherfindaid" mode="reCaSe">
      <xsl:element name="otherFindAid" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:persname" mode="reCaSe">
      <xsl:element name="persName" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:physdesc" mode="reCaSe">
      <xsl:element name="physDesc" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:physfacet" mode="reCaSe">
      <xsl:element name="physFacet" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:physloc" mode="reCaSe">
      <xsl:element name="physLoc" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:phystech" mode="reCaSe">
      <xsl:element name="physTech" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:prefercite" mode="reCaSe">
      <xsl:element name="preferCite" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:processinfo" mode="reCaSe">
      <xsl:element name="processInfo" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:ptrgrp" mode="reCaSe">
      <xsl:element name="ptrGrp" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:relatedmaterial" mode="reCaSe">
      <xsl:element name="relatedMaterial" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:scopecontent" mode="reCaSe">
      <xsl:element name="scopeContent" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:separetedMaterial" mode="reCaSe">
      <xsl:element name="separatedMaterial" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:subarea" mode="reCaSe">
      <xsl:element name="subArea" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:subtitle" mode="reCaSe">
      <xsl:element name="subTitle" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:tbody" mode="reCaSe">
      <xsl:element name="tBody" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:tgroup" mode="reCaSe">
      <xsl:element name="tGroup" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:thead" mode="reCaSe">
      <xsl:element name="tHead" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:titleproper" mode="reCaSe">
      <xsl:element name="titleProper" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:unitdate" mode="reCaSe">
      <xsl:element name="unitDate" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:unitid" mode="reCaSe">
      <xsl:element name="unitId" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:unittitle" mode="reCaSe">
      <xsl:element name="unitTitle" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="*:userestrict" mode="reCaSe">
      <xsl:element name="useRestrict" namespace="urn:isbn:1-931666-22-9">
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:element>
   </xsl:template>
   <!--identity template--><xsl:template match="@*|node()" mode="reCaSe">
      <xsl:copy>
         <xsl:apply-templates select="@*|node()" mode="reCaSe"/>
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>
