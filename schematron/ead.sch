<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns uri="http://www.loc.gov/mads/rdf/v1#" prefix="madsrdf"/>
    <ns uri="urn:isbn:1-931666-22-9" prefix="ead"/>
    <pattern id="codes">
        <let name="langcodes" value="document('http://id.loc.gov/vocabulary/iso639-2.rdf')" />
        
        <rule context="@langcode">
            <let name="code" value="normalize-space(.)" />
            <assert test="$langcodes//madsrdf:code[normalize-space(.) =$code ]" >
                The <name/> attribute should contain a code from the iso639-2 codelist.
            </assert>
        </rule>
        
        <let name="countrycodes" value="document('http://www.iso.org/iso/home/standards/country_codes/country_names_and_code_elements_xml')" />        
        <rule context="@countrycode">
            <let name="code" value="normalize-space(.)" />
            <assert test="$countrycodes//ISO_3166-1_Alpha-2_Code_element[normalize-space(.) = $code ]" >
                The <name/> attribute should contain a code from the ISO 3166-1 codelist.
            </assert>
        </rule>
    </pattern>
    <pattern id="co-occurrence-constraints">
        <rule context="*[@level = 'otherlevel']">
            <assert test="normalize-space(@otherlevel)"> If the value of a
                <emph>level</emph> attribute is "otherlevel', then the
                <emph>otherlevel</emph> attribute must be used. </assert>
        </rule>
    </pattern>
</schema>