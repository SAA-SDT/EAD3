<sch:schema xmlns:sch="http://www.ascc.net/xml/schematron">
    <sch:ns prefix="ead" uri="urn:isbn:1-931666-22-9"/>
    <sch:pattern name="Restricted elements in c element">
        <sch:rule context="ead:c">
            <sch:report test="ead:accruals | ead:acqinfo | ead:appraisal | ead:bibliography | ead:bioghist | ead:controlaccess | ead:custodhist | ead:descgrp | ead:dsc | ead:fileplan | ead:head | ead:index | ead:note | ead:odd | ead:originalsloc |  ead:phystech | ead:prefercite | ead:processinfo | ead:thead"> ERROR: <sch:name/> has a child element which is not permitted. Allowable elements are did,
                scopecontent, arrangement, accessrestrict, userestrict, altformavail, relatedmaterial, otherfindaid, separatedmaterial, dao, daogrp, and c </sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern name="Model of c element">
        <sch:rule context="ead:c">
            <sch:assert test="count(child::ead:did/ead:container) &lt; 3">Warning: <sch:name/> contains more than 3 container elements</sch:assert>
            <sch:assert test="count(child::ead:did/ead:unittitle) &lt; 2">Warning: <sch:name/> contains more than 1 unittitle element</sch:assert>
        </sch:rule>
        <sch:rule context="ead:container | ead:unittitle">
            <sch:assert test="string-length(./text()) &gt; 0">Warning: <sch:name/> contains no text</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern name="Elements Removed">
        <sch:rule context="ead:chronlist">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:table">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:appraisal">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:fileplan">
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
        <sch:rule context="ead:c01">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:defitem">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:listhead">
            <sch:report test=".">ERROR: <sch:name/> ELEMENT NOT ALLOWED</sch:report>
        </sch:rule>
        <sch:rule context="ead:note">
            <sch:assert test="parent::ead:did"> ERROR <sch:name/> NOT ALLOWED. <sch:name/> is permitted as child of
                ead:did only</sch:assert>
        </sch:rule>
        <sch:rule context="ead:unitdate">
            <sch:assert test="ancestor::ead:did"> ERROR <sch:name/> NOT ALLOWED. <sch:name/> is permitted as descendant of
                ead:did only</sch:assert>
        </sch:rule>
        <sch:rule context="ead:list">
            <sch:assert test="ancestor::ead:arrangement[parent::ead:archdesc]"> ERROR <sch:name/> NOT ALLOWED. <sch:name/> is permitted as descendant of
                archdesc/arrangement only</sch:assert>
        </sch:rule>
        <sch:rule context="ead:head">
            <sch:report test="parent::ead:list"> ERROR <sch:name/> NOT ALLOWED as child of list</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern name="Attribute Values Controlled">
        <sch:rule context="ead:eadheader">
            <sch:assert test="@findaidstatus = 'unedited' or @findaidstatus = 'draft' or @findaidstatus = 'publish' ">ERROR: Allowable values for findaidstatus attribute of <sch:name/> are "unedited", "draft", and
                "publish" only</sch:assert>
        </sch:rule>
        <sch:rule context="*[@repositorycode]">
            <sch:assert test="@repositorycode = 'nnc-rb' or @repositorycode = 'nnc-a' ">ERROR: Allowable values for
                repository attribute of <sch:name/> are "nnc-rb" and "nnc-a" only</sch:assert>
        </sch:rule>
        <sch:rule context="ead:archdesc/ead:did">
            <sch:assert test="ead:unitid/@type = 'clio' or ead:unitid/@type = 'call_num' ">ERROR: Allowable values for
                type attribute of ead/<sch:name/>/unitid are "clio" and "call_num" only</sch:assert>
        </sch:rule>
        <sch:rule context="ead:list">
            <sch:assert test="@type = 'simple' or @type = 'marked'">ERROR: Allowable values for type attribute of <sch:name/> are "simple", and
                "marked" only</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>