<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:ns uri="urn:isbn:1-931666-22-9" prefix="ead"/>
    <sch:pattern id="co-occurrence-constraints">
        <sch:rule abstract="true" id="level-otherlevel">
            <sch:assert test="(contains(string(@level), 'otherlevel')) and (normalize-space(@otherlevel))"> If the value of a
                    <sch:emph>level</sch:emph> attribute is "otherlevel', then the
                    <sch:emph>otherlevel</sch:emph> attribute must be used. </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="RemovedElements">
        <sch:rule context="ead:chronlist">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:table">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:index">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:frontmatter">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:runner">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:thead">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="c01">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:defitem">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:listhead">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:note">
            <sch:assert test="parent::ead:did"> ERROR <sch:name/> NOT ALLOWED. <sch:name/> is
                permitted as child of ead:did only</sch:assert>
        </sch:rule>
        <sch:rule context="ead:list">
            <sch:assert test="ancestor::ead:arrangement[parent::ead:archdesc]"> ERROR <sch:name/>
                NOT ALLOWED. <sch:name/> is permitted as descendant of archdesc/arrangement
                only</sch:assert>
        </sch:rule>
        <sch:rule context="ead:head">
            <sch:report test="parent::ead:list"> ERROR <sch:name/> NOT ALLOWED as child of
                list</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="otherlevel">
        <sch:rule context="*[@level]">
            <sch:extends rule="level-otherlevel"/>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="No-Mixed-Content">
        <sch:rule context="*">
            <sch:report test="child::* and text()[string-length(normalize-space(.)) != 0]"
                >ERROR: Mixed content is not allowed</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>
