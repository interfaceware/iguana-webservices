-- Contains parseable string definitions for FHIR complex datatypes (in both XML and JSON)

-- Refer to complex_datatypes_reference.lua for descriptions/comments/primitive type values 
-- of all the below datatypes (in non-parseable format due to comments and primitive datatypes 
-- being set as values, which causes the JSON/XML to be invalid)

-- Main complex datatypes:
-- https://www.hl7.org/fhir/datatypes-definitions.html

-- Additional complex datatypes: 
-- https://www.hl7.org/fhir/resource.html#metadata
-- https://www.hl7.org/fhir/references.html#Reference
-- https://www.hl7.org/fhir/extensibility.html
-- https://www.hl7.org/fhir/narrative.html#Narrative

-- NOTE 1 : Primitive datatypes and Restrictive primitive datatypes are not defined
--          because they are base level elements such as booleans, numbers, and strings
--          that can be directly applied to any JSON key/XML node value. 
--          (unlike the following complex datatypes which are made up of child elements
--           that may themselves have primitive datatype values.)

-- NOTE 2 : In FHIR, all default values should be ignored, so for parseability and validation
--          all primitive types have been assigned a default (unset) value of null. 
--
--          Also if a value is allowed to be an array of datatypes, by default only 1 empty instance 
--          has been added. 

local Datatypes = {}

Datatypes.json  = {}
Datatypes.xml   = {}


------------------------------
------------------------------
--- JSON COMPLEX DATATYPES ---
------------------------------
------------------------------

-- Adapted from:
-- https://www.hl7.org/fhir/references.html#Reference
Datatypes.json.Reference = [[
{
  "reference" : null, 
  "display"   : null 
}
]]

-- Adapted from:
-- https://www.hl7.org/fhir/datatypes.html
Datatypes.json.Attachment = [[
{
  "contentType" : null, 
  "language"    : null, 
  "data"        : null, 
  "url"         : null, 
  "size"        : null, 
  "hash"        : null, 
  "title"       : null, 
  "creation"    : null 
}
]]

Datatypes.json.Coding = [[
{
  "system"       : null,   
  "version"      : null,   
  "code"         : null,   
  "display"      : null,   
  "userSelected" : null 
}
]]

Datatypes.json.CodeableConcept = [[
{
  "coding" : [ ]] .. Datatypes.json.Coding .. [[ ], 
  "text"   : null 
}
]]

Datatypes.json.Quantity = [[
{
  "value"      : null, 
  "comparator" : null, 
  "unit"       : null, 
  "system"     : null, 
  "code"       : null  
}
]]

Datatypes.json.Range = [[
{
  "low"  : ]] .. Datatypes.json.Quantity .. [[, 
  "high" : ]] .. Datatypes.json.Quantity .. [[  
}
]]

Datatypes.json.Ratio = [[
{
  "numerator"   : ]] .. Datatypes.json.Quantity .. [[,
  "denominator" : ]] .. Datatypes.json.Quantity .. [[    
}
]]

Datatypes.json.Period = [[
{
  "start" : ]] .. Datatypes.json.Quantity .. [[, 
  "end"   : ]] .. Datatypes.json.Quantity .. [[  
}
]]

Datatypes.json.SampledData = [[
{
  "origin"     : ]] .. Datatypes.json.Quantity .. [[, 
  "period"     : null, 
  "factor"     : null, 
  "lowerLimit" : null, 
  "upperLimit" : null, 
  "dimensions" : null, 
  "data"       : null 
}
]]

Datatypes.json.Identifier = [[
{
  "use"      : null, 
  "type"     : ]] .. Datatypes.json.CodeableConcept .. [[, 
  "system"   : null, 
  "value"    : null, 
  "period"   : ]] .. Datatypes.json.Period .. [[, 
  "assigner" : ]] .. Datatypes.json.Reference .. [[,
}
]]

Datatypes.json.HumanName = [[
{
  "resourceType" : "HumanName",
  "use"    : null, 
  "text"   : null, 
  "family" : [null], 
  "given"  : [null], 
  "prefix" : [null], 
  "suffix" : [null], 
  "period" : ]] .. Datatypes.json.Period .. [[
}
]]

Datatypes.json.Address = [[
{
  "resourceType" : "Address",
  "use"        : null, 
  "type"       : null, 
  "text"       : null, 
  "line"       : [null], 
  "city"       : null, 
  "district"   : null, 
  "state"      : null, 
  "postalCode" : null, 
  "country"    : null, 
  "period"     : ]] .. Datatypes.json.Period .. [[
}
]]

Datatypes.json.ContactPoint = [[
{
  "resourceType" : "ContactPoint",
  "system" : null, 
  "value"  : null, 
  "use"    : null, 
  "rank"   : null, 
  "period" : ]] .. Datatypes.json.Period .. [[
}
]]

Datatypes.json.Timing = [[
{
  "resourceType" : "Timing",
  "event"  : [null], 
  "repeat" : {   
    "boundsQuantity": ]] .. Datatypes.json.Quantity .. [[,
    "boundsRange"   : ]] .. Datatypes.json.Range .. [[,
    "boundsPeriod"  : ]] .. Datatypes.json.Period .. [[,
    "count"         : null, 
    "duration"      : null, 
    "durationMax"   : null, 
    "durationUnits" : null, 
    "frequency"     : null, 
    "frequencyMax"  : null, 
    "period"        : null, 
    "periodMax"     : null, 
    "periodUnits"   : null, 
    "when"          : null 
  },
  "code"   : ]] .. Datatypes.json.CodeableConcept .. [[
}
]]

Datatypes.json.Signature = [[ 
{
  
  "type"         : ]] .. Datatypes.json.Coding .. [[,
  "when"         : null, 
  "whoUri"       : null, 
  "whoReference" : ]] .. Datatypes.json.Reference .. [[, 
  "contentType"  : null, 
  "blob"         : null  
}
]]

Datatypes.json.Annotation = [[
{
  "authorReference" : ]] .. Datatypes.json.Reference .. [[,
  "authorString"    : null, 
  "time"            : null, 
  "text"            : null 
}
]]



-- Adapted from:
-- https://www.hl7.org/fhir/resource.html#metadata
Datatypes.json.Resource = [[
{
  "versionId"   : null, 
  "lastUpdated" : null, 
  "profile"     : [null], 
  "security"    : [ ]] .. Datatypes.json.Coding .. [[ ], 
  "tag"         : [ ]] .. Datatypes.json.Coding .. [[ ]
}
]]

-- Adapted from:
-- https://www.hl7.org/fhir/extensibility.html
Datatypes.json.Extension = [[
{
  "url" : null, 
  "valueInteger"         : null,    
  "valueDecimal"         : null,    
  "valueDateTime"        : null,    
  "valueDate"            : null,    
  "valueInstant"         : null,    
  "valueString"          : null,    
  "valueUri"             : null,    
  "valueBoolean"         : null, 
  "valueCode"            : null,    
  "valueBase64Binary"    : null,    
  "valueCoding"          : ]] .. Datatypes.json.Coding .. [[,
  "valueCodeableConcept" : ]] .. Datatypes.json.CodeableConcept .. [[,
  "valueAttachment"      : ]] .. Datatypes.json.Attachment .. [[,
  "valueIdentifier"      : ]] .. Datatypes.json.Identifier .. [[,
  "valueQuantity"        : ]] .. Datatypes.json.Quantity .. [[,
  "valueRange"           : ]] .. Datatypes.json.Range .. [[,
  "valuePeriod"          : ]] .. Datatypes.json.Period .. [[,
  "valueRatio"           : ]] .. Datatypes.json.Ratio .. [[,
  "valueHumanName"       : ]] .. Datatypes.json.HumanName .. [[,
  "valueAddress"         : ]] .. Datatypes.json.Address .. [[,
  "valueContactPoint"    : ]] .. Datatypes.json.ContactPoint .. [[,
  "valueSchedule"        : ]] .. Datatypes.json.Timing .. [[,
  "valueReference"       : ]] .. Datatypes.json.Reference .. [[
}
]]

-- Adapted from:
-- https://www.hl7.org/fhir/narrative.html#Narrative
Datatypes.json.Narrative = [[
{
  "status" : null, 
  "div"    : null 
}
]]





------------------------------
------------------------------
--- XML COMPLEX DATATYPES ---
------------------------------
------------------------------

-- Adapted from:
-- https://www.hl7.org/fhir/references.html#Reference
Datatypes.xml.Reference = [[
   <reference value=""/>
   <display value=""/>
]]

-- Adapted from:
-- https://www.hl7.org/fhir/datatypes.html
Datatypes.xml.Attachment = [[
   <contentType value=""/>
   <language value=""/>
   <data value=""/>
   <url value=""/>
   <size value=""/>
   <hash value=""/>
   <title value=""/>
   <creation value=""/>
]]

Datatypes.xml.Coding = [[
   <system value=""/>
   <version value=""/>
   <code value=""/>
   <display value=""/>
   <userSelected value=""/>
]]

Datatypes.xml.CodeableConcept = [[
   <coding> ]] .. Datatypes.xml.Coding .. [[ </coding>
   <text value=""/>
]]

Datatypes.xml.Quantity = [[
   <value value=""/>
   <comparator value=""/>
   <unit value=""/>
   <system value=""/>
   <code value=""/>
]]

Datatypes.xml.Range = [[
   <low> ]] .. Datatypes.xml.Quantity .. [[  </low>
   <high> ]] .. Datatypes.xml.Quantity .. [[ </high>
]]

Datatypes.xml.Ratio = [[
   <numerator> ]] .. Datatypes.xml.Quantity .. [[ </numerator>
   <denominator> ]] .. Datatypes.xml.Quantity .. [[ </denominator>
]]

Datatypes.xml.Period = [[
   <start value=""/>
   <end value=""/>
]]

Datatypes.xml.SampledData = [[
   <origin> ]] .. Datatypes.xml.Quantity .. [[ </origin>
   <period value=""/>
   <factor value=""/>
   <lowerLimit value=""/>
   <upperLimit value=""/>
   <dimensions value=""/>
   <data value="" -->
]]

Datatypes.xml.Identifier = [[
   <use value=""/>
   <type> ]] .. Datatypes.xml.CodeableConcept .. [[ </type>
   <system value=""/>
   <value value=""/>
   <period> ]] .. Datatypes.xml.Period .. [[ </period>
   <assigner> ]] .. Datatypes.xml.Reference .. [[ </assigner>
]]

Datatypes.xml.HumanName = [[
   <use value=""/>
   <text value=""/>
   <family value=""/>
   <given value=""/>
   <prefix value=""/>
   <suffix value=""/>
   <period> ]] .. Datatypes.xml.Period .. [[ </period>
]]

Datatypes.xml.Address = [[
   <use value=""/>
   <type value=""/>
   <text value=""/>
   <line value=""/>
   <city value=""/>
   <district value=""/>
   <state value=""/>
   <postalCode value=""/>
   <country value=""/>
   <period> ]] .. Datatypes.xml.Period .. [[ </period>
]]

Datatypes.xml.ContactPoint = [[
   <system value=""/>
   <value value=""/>
   <use value=""/>
   <rank value=""/>
   <period> ]] .. Datatypes.xml.Period .. [[ </period>
]]

Datatypes.xml.Timing = [[
   <event value=""/>
   <repeat>
    <!-- bounds can also be a Range, Period Length/Range of lengths, or Start and/or end -->
      <bounds> ]] .. Datatypes.xml.Quantity .. [[ </bounds>
      <count value=""/>
      <duration value=""/>
      <durationMax value=""/>
      <durationUnits value=""/>
      <frequency value=""/>
      <frequencyMax value=""/>
      <period value=""/>
      <periodMax value=""/>
      <periodUnits value=""/>
      <when value=""/>
   </repeat>
   <code> ]] .. Datatypes.xml.CodeableConcept .. [[ </code>
]]

Datatypes.xml.Signature = [[
   <type> ]] .. Datatypes.xml.Coding .. [[ </type>
   <when value=""/>
   <who> ]] .. Datatypes.xml.Reference .. [[ </who>
   <contentType value=""/>
   <blob value=""/>
]]

Datatypes.xml.Annotation = [[
   <author> ]] .. Datatypes.xml.Reference .. [[ </author>
   <time value=""/>
   <text value=""/>
]]


-- Adapted from:
-- https://www.hl7.org/fhir/resource.html#metadata
Datatypes.xml.Resource = [[
   <meta xmlns="http://hl7.org/fhir">
      <versionId value=""/>
      <lastUpdated value=""/>
      <profile value=""/>
      <security> ]] .. Datatypes.xml.Coding .. [[ </security>
      <tag> ]] .. Datatypes.xml.Coding .. [[ </tag>
   </meta>
]]

-- Adapted from:
-- https://www.hl7.org/fhir/extensibility.html
Datatypes.xml.Extension = [[
   <extension xmlns="http://hl7.org/fhir" url="identifies the meaning of the extension (uri)">
       <!-- Can be any data type (simple or complex) -->
       <value></value>
   </extension>
]]

-- Adapted from:
-- https://www.hl7.org/fhir/narrative.html#Narrative
Datatypes.xml.Narrative = [[
   <status value=""/>
   <div xmlns="http://www.w3.org/1999/xhtml"></div>
]]






return Datatypes