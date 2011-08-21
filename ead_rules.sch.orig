<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://www.ascc.net/xml/schematron">
<<<<<<< HEAD
    <sch:ns prefix="ead" uri="urn:isbn:1-931666-22-9"/>
    <sch:pattern name="Co-Occurrence Constraints">
        <sch:rule context="*[@level ='otherlevel']">
            <sch:assert test="string-length(@otherlevel) &gt; 1"> If the value of a level attribute
                is "otherlevel', then the otherlevel attribute must be used </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern name="Elements Removed">
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
    <sch:pattern name="No Mixed Content">
        <sch:rule context="*">
            <sch:report test="child::ead:* and text()[string-length(normalize-space(.)) != 0]"
                >ERROR: Mixed content is not allowed</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>
=======
 <sch:ns prefix="ead" uri="urn:isbn:1-931666-22-9"/>
 <sch:pattern name="Co-Occurrence Constraints">
     <sch:rule context="*[@level ='otherlevel']">
         <sch:assert test="string-length(@otherlevel) &gt; 1">
          If the value of a level attribute is "otherlevel', then the otherlevel attribute must be used
         </sch:assert>
     </sch:rule>
 </sch:pattern>
    
</sch:schema>
>>>>>>> 6e16cb493001011525a8cae5882e25ef441fcee3
