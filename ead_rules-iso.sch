<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:ns uri="urn:isbn:1-931666-22-9" prefix="ead"/>
    <sch:pattern id="co-occurrence-constraints">
        <sch:rule context="*[@level ='otherlevel']">
            <sch:assert test="string-length(@otherlevel) &gt; 1"> If the value of a
                    <sch:emph>level</sch:emph> attribute is "otherlevel', then the
                    <sch:emph>otherlevel</sch:emph> attribute must be used. </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="enumerated-values">
        <sch:let name="values" value=""/>
    </sch:pattern>
</sch:schema>
