<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://www.ascc.net/xml/schematron">
 <sch:ns prefix="ead" uri="urn:isbn:1-931666-22-9"/>
 <sch:pattern name="Co-Occurrence Constraints">
     <sch:rule context="*[@level ='otherlevel']">
         <sch:assert test="string-length(@otherlevel) &gt; 1">
          If the value of a level attribute is "otherlevel', then the otherlevel attribute must be used
         </sch:assert>
     </sch:rule>
 </sch:pattern>
    
</sch:schema>