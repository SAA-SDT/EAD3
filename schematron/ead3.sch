<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2">
    <ns uri="http://www.loc.gov/mads/rdf/v1#" prefix="madsrdf"/>
    <ns uri="http://ead3.archivists.org/schema/" prefix="ead"/>

    <!-- VARIABLES -->

    <!-- VARIABLE $language-code-lookups: list of filenames of target codelist documents -->
    
    <xsl:variable name="language-code-lookups" as="element()*">
        <file key="iso639-1">iso639-1.rdf</file>
        <file key="iso639-2b">iso639-2.rdf</file>
        <file key="iso639-3">iso_639_3.xml</file>
    </xsl:variable>
    
    <!-- VARIABLE $language-code-key: the EAD3 document's /ead:ead/ead:control/@langencoding, with a fall-back of iso639- 2b -->
    
    <let name="active-language-code-key"
        value="(/ead:ead/ead:control/@langencoding[.=$language-code-lookups/@key],'iso639-2b')[1]"/>
    
    <!-- VARIABLE $language-code-lookup: lookup in the external code list based on $active-language-code-key  -->
    
    <let name="language-code-lookup"
        value="document($language-code-lookups[@key = $active-language-code-key])//(madsrdf:code | iso_639_3_entries/iso_639_3_entry/@id)"/>
    
    <!-- VARIABLE iso15511Pattern -->
    
    <let name="iso15511Pattern" value="'(^([A-Z]{2})|([a-zA-Z]{1})|([a-zA-Z]{3,4}))(-[a-zA-Z0-9:/\-]{1,11})$'"/>

    <!-- LANGUAGE CODES -->

    <pattern id="langcodes">

       
        <rule context="*[exists(@langcode | @lang)]">
            <!-- for every @lang or @langcode attribute, test that it is equal to a value in the relevant language code list -->
            <assert
                test="every $l in (@lang | @langcode) satisfies normalize-space($l) = $language-code-lookup"> The <name/> element's lang or langcode attribute should contain a value from the<value-of select="$active-language-code-key"/> codelist. </assert>
        </rule>
    </pattern>

    <!-- COUNTRY CODES -->
    <pattern id="countrycode">
        <let name="countrycodes" value="document('iso_3166.xml')"/>
        <rule context="*[exists(@countrycode)]">
            <let name="code" value="normalize-space(@countrycode)"/>
            <assert test="$countrycodes//iso_3166_entry/@alpha_2_code = $code "> The countrycode attribute should contain a code from the ISO 3166-1 codelist. </assert>
        </rule>
    </pattern>

    <!-- SCRIPT CODES -->
    <pattern id="scriptcode">
        <let name="scriptcodes" value="document('iso_15924.xml')"/>
        <rule context="*[exists(@scriptcode | @script)]">
            <let name="code" value="normalize-space(.)"/>
            <assert
                test="every $s in (@script | @scriptcode) satisfies $scriptcodes//iso_15924_entry/@alpha_4_code = $s "> The script or scriptcode attribute should contain a code from the iso_15924 codelist. </assert>
        </rule>
    </pattern>

    <!-- REPOSITORY CODES -->
    <pattern id="repositorycode">
        <rule context="*[@repositorycode][preceding::ead:control/@repositoryencoding = 'iso15511']">
            <assert
                test="matches(@repositorycode, $iso15511Pattern)">If the repositoryencoding is set to iso15511, the format of the value of the <emph>repositorycode</emph> attribute of <name/> is constrained to that of the International Standard Identifier for Libraries and Related Organizations (ISIL: ISO 15511): a prefix, a dash, and an identifier. </assert>
        </rule>
    </pattern>

    <!-- AGENCY CODES -->
    <pattern id="agencycode">
        <rule context="ead:agencycode">
            <assert
                test="matches(normalize-space(.), $iso15511Pattern)"> The format of <name/> is constrained to that of the International Standard Identifier for Libraries and Related Organizations (ISIL: ISO 15511): a prefix, a dash, and an identifier. </assert>
        </rule>
    </pattern>

    <!-- CO-OCCURRENCE CONSTRAINTS -->

    <pattern id="co-occurrence-constraints">
        <rule context="*[@level = 'otherlevel']">
            <assert test="normalize-space(@otherlevel)"> If the value of a <emph>level</emph> attribute is "otherlevel', then the <emph>otherlevel</emph> attribute must be used.</assert>
        </rule>
        <rule context="*[@physdescstructuredtype = 'otherphysdescstructuredtype']">
            <assert test="normalize-space(@otherphysdescstructuredtype)"> If the value of a <emph>physdescstructuredtype</emph> attribute is "otherphysdescstructuredtype', then the <emph>otherphysdescstructuredtype</emph> attribute must be used. </assert>
        </rule>
        <rule context="*[@daotype = 'otherdaotype']">
            <assert test="normalize-space(@otherdaotype)"> If the value of a <emph>daotype</emph> attribute is "otherdaotype', then the <emph>otherdaotype</emph> attribute must be used.</assert>
        </rule>
        <rule context="*[@dsctype = 'otherdsctype']">
            <assert test="normalize-space(@otherdsctype)"> If the value of a <emph>dsctype</emph> attribute is "otherdsctype', then the <emph>otherdsctype</emph> attribute must be used. </assert>
        </rule>
        <rule context="*[@relationtype = 'otherrelationtype']">
            <assert test="normalize-space(@otherrelationtype)"> If the value of an <emph>otherrelation</emph> attribute is "otherrelationtype', then the <emph>otherrelationtype</emph> attribute must be used. </assert>
        </rule>
        <rule context="*[@listtype = 'unordered']">
            <assert test="normalize-space(@mark)"> If the value of attribute <emph>listtype</emph> is 'unordered', then the <emph>mark</emph> attribute should be used </assert>
        </rule>
        <rule context="*[@listtype = 'ordered']">
            <assert test="normalize-space(@numeration)"> If the value of attribute <emph>listtype</emph> is 'ordered', then the <emph>numeration</emph> attribute should be used </assert>
        </rule>
    </pattern>

    <!-- DATE NORMALIZATION -->
    <pattern id="dates">
        <let name="isoYYYY" value="'\-?(0|1|2)([0-9]{3})'"/>
        <let name="isoMM" value="'\-?(01|02|03|04|05|06|07|08|09|10|11|12)'"/>
        <let name="isoDD" value="'\-?((0[1-9])|((1|2)[0-9])|(3[0-1]))'"/>
        <let name="isoRangePattern"
            value="concat('^', '(\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)(/\-?(0|1|2)([0-9]{3})(((01|02|03|04|05|06|07|08|09|10|11|12)((0[1-9])|((1|2)[0-9])|(3[0-1])))|\-((01|02|03|04|05|06|07|08|09|10|11|12)(\-((0[1-9])|((1|2)[0-9])|(3[0-1])))?))?)?', '$')"/>
        <let name="isoPattern"
            value="concat('^', $isoYYYY, '$','|', '^', $isoYYYY, $isoMM,'$', '|', '^', $isoYYYY, $isoMM, $isoDD,'$')"/>
        <rule context="ead:unitdate[@normal] | ead:date[@normal]">
            <assert test="matches(@normal, $isoRangePattern)">The <emph>normal</emph> attribute of
                <name/> must be a iso8601 date. </assert>
        </rule>
        <rule
            context="ead:datesingle[exists(@notbefore | @notafter | @standarddate)] | ead:todate[exists(@notbefore | @notafter | @standarddate)] | ead:fromdate[exists(@notbefore | @notafter | @standarddate)]">
            <assert
                test="every $d in (@notbefore, @notafter, @standarddate) satisfies matches($d, $isoPattern)"> The <emph>notbefore</emph>, <emph>notafter</emph>, and <emph>standarddate</emph> attributes of <name/> must be a iso8601 date. </assert>
        </rule>
    </pattern>

    <!-- CARDINALITY RESTRICTIONS -->

    <pattern id="cardinality">
        <rule context="ead:dsc">
            <report test="preceding::ead:dsc"> The use of multiple &lt;dsc&gt; elements is discouraged. It may be deprecated in the future and eliminating multiple <name/> elements will facilitate future migration </report>
        </rule>
    </pattern>

    <!-- SUGGESTED VALUES -->
    <pattern>
        <rule context="*[@era]">
            <assert test="@era = 'ce' or . = 'bce'"> Suggested values for the era attribute are 'ce' or 'bce' </assert>
        </rule>
    </pattern>
</schema>
