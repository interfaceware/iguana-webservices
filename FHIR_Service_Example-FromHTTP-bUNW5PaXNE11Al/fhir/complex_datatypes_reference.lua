-- Contains NON-parseable string definitions for FHIR complex datatypes (in both XML and JSON)
-- Contains comments and descriptions about each datatype key, with the values represented as the datatype
-- (primitive or complex) that they are supposed to be.

-- NOTE : You should not use this file in your code. It is purely a reference.

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
  // from Element: extension
  "reference" : "<string>", // C? Relative, internal or absolute URL reference
  "display"   : "<string>"  // Text alternative for the resource
}
]]

-- Adapted from:
-- https://www.hl7.org/fhir/datatypes.html
Datatypes.json.Attachment = [[
{
  // from Element: extension
  "contentType" : "<code>",         // Mime type of the content, with charset etc. 
  "language"    : "<code>",         // Human language of the content (BCP-47) 
  "data"        : "<base64Binary>", // Data inline, base64ed
  "url"         : "<uri>",          // Uri where the data can be found
  "size"        : "<unsignedInt>",  // Number of bytes of content (if url provided)
  "hash"        : "<base64Binary>", // Hash of the data (sha-1, base64ed)
  "title"       : "<string>",       // Label to display in place of the data
  "creation"    : "<dateTime>"      // Date attachment was first created
}
]]

Datatypes.json.Coding = [[
{
  // from Element: extension
  "system"       : "<uri>",    // Identity of the terminology system
  "version"      : "<string>", // Version of the system - if relevant
  "code"         : "<code>",   // Symbol in syntax defined by the system
  "display"      : "<string>", // Representation defined by the system
  "userSelected" : <boolean>   // If this coding was chosen directly by the user
}
]]

Datatypes.json.CodeableConcept = [[
{
  // from Element: extension
  "coding" : [{ Coding }], // Code defined by a terminology system
  "text"   : "<string>"    // Plain text representation of the concept
}
]]

Datatypes.json.Quantity = [[
{
  // from Element: extension
  "value"      : <decimal>,  // Numerical value (with implicit precision)
  "comparator" : "<code>",   // < | <= | >= | > - how to understand the value
  "unit"       : "<string>", // Unit representation
  "system"     : "<uri>",    // C? System that defines coded unit form
  "code"       : "<code>"    // Coded form of the unit
}
]]

Datatypes.json.Range = [[
{
  // from Element: extension
  "low"  : { Quantity(SimpleQuantity) }, // C? Low limit
  "high" : { Quantity(SimpleQuantity) }  // C? High limit
}
]]

Datatypes.json.Ratio = [[
{
  // from Element: extension
  "numerator"   : { Quantity }, // Numerator value
  "denominator" : { Quantity }  // Denominator value
}
]]

Datatypes.json.Period = [[
{
  // from Element: extension
  "start" : "<dateTime>", // C? Starting time with inclusive boundary
  "end"   : "<dateTime>"  // C? End time with inclusive boundary, if not ongoing
}
]]

Datatypes.json.SampledData = [[
{
  // from Element: extension
  "origin"     : { Quantity(SimpleQuantity) }, // R!  Zero value and units
  "period"     : <decimal>,       // R!  Number of milliseconds between samples
  "factor"     : <decimal>,       // Multiply data by this before adding to origin
  "lowerLimit" : <decimal>,       // Lower limit of detection
  "upperLimit" : <decimal>,       // Upper limit of detection
  "dimensions" : "<positiveInt>", // R!  Number of sample points at each time point
  "data"       : "<string>"       // R!  Decimal values with spaces, or "E" | "U" | "L"
}
]]

Datatypes.json.Identifier = [[
{
  // from Element: extension
  "use"      : "<code>",            // usual | official | temp | secondary (If known)
  "type"     : { CodeableConcept }, // Description of identifier
  "system"   : "<uri>",             // The namespace for the identifier
  "value"    : "<string>",          // The value that is unique
  "period"   : { Period },          // Time period when id is/was valid for use
  "assigner" : { Reference(Organization) } // Organization that issued id (may be just text)
}
]]

Datatypes.json.HumanName = [[
{
  "resourceType" : "HumanName",
  // from Element: extension
  "use"    : "<code>",     // usual | official | temp | nickname | anonymous | old | maiden
  "text"   : "<string>",   // Text representation of the full name
  "family" : ["<string>"], // Family name (often called 'Surname')
  "given"  : ["<string>"], // Given names (not always 'first'). Includes middle names
  "prefix" : ["<string>"], // Parts that come before the name
  "suffix" : ["<string>"], // Parts that come after the name
  "period" : { Period }    // Time period when name was/is in use
}
]]

Datatypes.json.Address = [[
{
  "resourceType" : "Address",
  // from Element: extension
  "use"        : "<code>",    // home | work | temp | old - purpose of this address
  "type"       : "<code>",    // postal | physical | both
  "text"       : "<string>",  // Text representation of the address
  "line"       : ["<string>"],// Street name, number, direction & P.O. Box etc.
  "city"       : "<string>",  // Name of city, town etc.
  "district"   : "<string>",  // District name (aka county)
  "state"      : "<string>",  // Sub-unit of country (abbreviations ok)
  "postalCode" : "<string>",  // Postal code for area
  "country"    : "<string>",  // Country (can be ISO 3166 3 letter code)
  "period"     : { Period }   // Time period when address was/is in use
}
]]

Datatypes.json.ContactPoint = [[
{
  "resourceType" : "ContactPoint",
  // from Element: extension
  "system" : "<code>",        // C? phone | fax | email | pager | other
  "value"  : "<string>",      // The actual contact point details
  "use"    : "<code>",        // home | work | temp | old | mobile - purpose of this contact point
  "rank"   : "<positiveInt>", // Specify preferred order of use (1 = highest)
  "period" : { Period }       // Time period when the contact point was/is in use
}
]]

Datatypes.json.Timing = [[
{
  "resourceType" : "Timing",
  // from Element: extension
  "event"  : ["<dateTime>"], // When the event occurs
  "repeat" : { // When the event is to occur
    // bounds[x]: Length/Range of lengths, or (Start and/or end) limits. One of these 3:
    "boundsQuantity" : { Quantity(Duration) },
    "boundsRange"    : { Range },
    "boundsPeriod"   : { Period },
    "count"          : <integer>, // Number of times to repeat
    "duration"       : <decimal>, // How long when it happens
    "durationMax"    : <decimal>, // How long when it happens (Max)
    "durationUnits"  : "<code>",  // s | min | h | d | wk | mo | a - unit of time (UCUM)
    "frequency"      : <integer>, // Event occurs frequency times per period
    "frequencyMax"   : <integer>, // Event occurs up to frequencyMax times per period
    "period"         : <decimal>, // Event occurs frequency times per period
    "periodMax"      : <decimal>, // Upper limit of period (3-4 hours)
    "periodUnits"    : "<code>",  // s | min | h | d | wk | mo | a - unit of time (UCUM)
    "when"           : "<code>"   // Regular life events the event is tied to
  },
  "code"  : { CodeableConcept } // QD | QOD | Q4H | Q6H | BID | TID | QID | AM | PM +
}
]]

Datatypes.json.Signature = [[ 
{
  // from Element: extension
  "type"         : [{ Coding }],    // R!  Indication of the reason the entity signed the object(s)
  "when"         : "<instant>",     // R!  When the signature was created
  // who[x]: Who signed the signature. One of these 2:
  "whoUri"       : "<uri>",
  "whoReference" : { Reference(Practitioner|RelatedPerson|Patient|Device|Organization) },
  "contentType"  : "<code>",        // R!  The technical format of the signature 
  "blob"         : "<base64Binary>" // R!  The actual signature content (XML DigSig. JWT, picture, etc.)
}
]]

Datatypes.json.Annotation = [[
{
  // from Element: extension
  // author[x]: Individual responsible for the annotation. One of these 2:
  "authorReference" : { Reference(Practitioner|Patient|RelatedPerson) },
  "authorString"    : "<string>",
  "time"            : "<dateTime>", // When the annotation was made
  "text"            : "<string>"   // R!  The annotation  - text content
}
]]


-- Adapted from:
-- https://www.hl7.org/fhir/resource.html#metadata
Datatypes.json.Resource = [[
{
  // from Element: extension
  "versionId"   : "<id>",       // Version specific identifier
  "lastUpdated" : "<instant>",  // When the resource version last changed
  "profile"     : ["<uri>"],    // Profiles this resource claims to conform to
  "security"    : [{ Coding }], // Security Labels applied to this resource
  "tag"         : [{ Coding }]  // Tags applied to this resource
}
]]

-- Adapted from:
-- https://www.hl7.org/fhir/extensibility.html
Datatypes.json.Extension = [[
{
  // from Element: extension
  "url" : "<uri>", // R!  identifies the meaning of the extension
  // value[x]: Value of extension. One of these 23:
  "valueInteger"         : "<integer>",
  "valueDecimal"         : "<decimal>",
  "valueDateTime"        : "<dateTime>",
  "valueDate"            : "<date>",
  "valueInstant"         : "<instant>",
  "valueString"          : "<string>",
  "valueUri"             : "<uri>",
  "valueBoolean"         : <boolean>,
  "valueCode"            : "<code>",
  "valueBase64Binary"    : "<base64Binary>",
  "valueCoding"          : { Coding },
  "valueCodeableConcept" : { CodeableConcept },
  "valueAttachment"      : { Attachment },
  "valueIdentifier"      : { Identifier },
  "valueQuantity"        : { Quantity },
  "valueRange"           : { Range },
  "valuePeriod"          : { Period },
  "valueRatio"           : { Ratio },
  "valueHumanName"       : { HumanName },
  "valueAddress"         : { Address },
  "valueContactPoint"    : { ContactPoint },
  "valueSchedule"        : { Schedule },
  "valueReference"       : { Reference }
}
]]

-- Adapted from:
-- https://www.hl7.org/fhir/narrative.html#Narrative
Datatypes.json.Narrative = [[
{
  // from Element: extension
  "status" : "<code>",         // R!  generated | extensions | additional | empty 
  "div"    : "(Escaped XHTML)" // R!  Limited xhtml content 
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
<[name] xmlns="http://hl7.org/fhir"> doco
   <!-- from Element: extension -->
   <reference value="[string]"/> <!-- ?? 0..1 Relative, internal or absolute URL reference -->
   <display value="[string]"/>   <!-- 0..1 Text alternative for the resource -->
</[name]>
]]

-- Adapted from:
-- https://www.hl7.org/fhir/datatypes.html
Datatypes.xml.Attachment = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <contentType value="[code]"/>   <!-- 0..1 Mime type of the content, with charset etc.  -->
   <language value="[code]"/>      <!-- 0..1 Human language of the content (BCP-47)  -->
   <data value="[base64Binary]"/>  <!-- 0..1 Data inline, base64ed -->
   <url value="[uri]"/>            <!-- 0..1 Uri where the data can be found -->
   <size value="[unsignedInt]"/>   <!-- 0..1 Number of bytes of content (if url provided) -->
   <hash value="[base64Binary]"/>  <!-- 0..1 Hash of the data (sha-1, base64ed) -->
   <title value="[string]"/>       <!-- 0..1 Label to display in place of the data -->
   <creation value="[dateTime]"/>  <!-- 0..1 Date attachment was first created -->
</[name]>
]]

Datatypes.xml.Coding = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <system value="[uri]"/>            <!-- 0..1 Identity of the terminology system -->
   <version value="[string]"/>        <!-- 0..1 Version of the system - if relevant -->
   <code value="[code]"/>             <!-- 0..1 Symbol in syntax defined by the system -->
   <display value="[string]"/>        <!-- 0..1 Representation defined by the system -->
   <userSelected value="[boolean]"/>  <!-- 0..1 If this coding was chosen directly by the user -->
</[name]>
]]

Datatypes.xml.CodeableConcept = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <coding></coding>         <!-- 0..* Coding Code defined by a terminology system -->
   <text value="[string]"/>  <!-- 0..1 Plain text representation of the concept -->
</[name]>
]]

Datatypes.xml.Quantity = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <value value="[decimal]"/>    <!-- 0..1 Numerical value (with implicit precision) -->
   <comparator value="[code]"/>  <!-- 0..1 < | <= | >= | > - how to understand the value -->
   <unit value="[string]"/>      <!-- 0..1 Unit representation -->
   <system value="[uri]"/>       <!-- ?? 0..1 System that defines coded unit form -->
   <code value="[code]"/>        <!-- 0..1 Coded form of the unit -->
</[name]>
]]

Datatypes.xml.Range = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <low></low>    <!-- ?? 0..1 Quantity(SimpleQuantity) Low limit -->
   <high></high>  <!-- ?? 0..1 Quantity(SimpleQuantity) High limit -->
</[name]>
]]

Datatypes.xml.Ratio = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <numerator></numerator>      <!-- 0..1 Quantity Numerator value --> 
   <denominator></denominator>  <!-- 0..1 Quantity Denominator value -->
</[name]>
]]

Datatypes.xml.Period = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <start value="[dateTime]"/>  <!-- ?? 0..1 Starting time with inclusive boundary -->
   <end value="[dateTime]"/>    <!-- ?? 0..1 End time with inclusive boundary, if not ongoing -->
</[name]>
]]

Datatypes.xml.SampledData = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <origin></origin>                   <!-- 1..1 Quantity(SimpleQuantity) Zero value and units -->
   <period value="[decimal]"/>         <!-- 1..1 Number of milliseconds between samples -->
   <factor value="[decimal]"/>         <!-- 0..1 Multiply data by this before adding to origin -->
   <lowerLimit value="[decimal]"/>     <!-- 0..1 Lower limit of detection -->
   <upperLimit value="[decimal]"/>     <!-- 0..1 Upper limit of detection -->
   <dimensions value="[positiveInt]"/> <!-- 1..1 Number of sample points at each time point -->
   <data value="[string]"/>            <!-- 1..1 Decimal values with spaces, or "E" | "U" | "L" -->
</[name]>
]]

Datatypes.xml.Identifier = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <use value="[code]"/>      <!-- 0..1 usual | official | temp | secondary (If known) -->
   <type></type>              <!-- 0..1 CodeableConcept Description of identifier -->
   <system value="[uri]"/>    <!-- 0..1 The namespace for the identifier -->
   <value value="[string]"/>  <!-- 0..1 The value that is unique -->
   <period></period>          <!-- 0..1 Period Time period when id is/was valid for use -->
   <assigner></assigner>      <!-- 0..1 Reference(Organization) Organization that issued id (may be just text) -->
</[name]>
]]

Datatypes.xml.HumanName = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <use value="[code]"/>       <!-- 0..1 usual | official | temp | nickname | anonymous | old | maiden -->
   <text value="[string]"/>    <!-- 0..1 Text representation of the full name -->
   <family value="[string]"/>  <!-- 0..* Family name (often called 'Surname') -->
   <given value="[string]"/>   <!-- 0..* Given names (not always 'first'). Includes middle names -->
   <prefix value="[string]"/>  <!-- 0..* Parts that come before the name -->
   <suffix value="[string]"/>  <!-- 0..* Parts that come after the name -->
   <period></period>           <!-- 0..1 Period Time period when name was/is in use -->
</[name]>
]]

Datatypes.xml.Address = [[
<[name] xmlns="http://hl7.org/fhir">
   <!-- from Element: extension -->
   <use value="[code]"/>           <!-- 0..1 home | work | temp | old - purpose of this address -->
   <type value="[code]"/>          <!-- 0..1 postal | physical | both -->                         
   <text value="[string]"/>        <!-- 0..1 Text representation of the address -->             
   <line value="[string]"/>        <!-- 0..* Street name, number, direction & P.O. Box etc. --> 
   <city value="[string]"/>        <!-- 0..1 Name of city, town etc. -->                        
   <district value="[string]"/>    <!-- 0..1 District name (aka county) -->                 
   <state value="[string]"/>       <!-- 0..1 Sub-unit of country (abbreviations ok) -->        
   <postalCode value="[string]"/>  <!-- 0..1 Postal code for area -->                     
   <country value="[string]"/>     <!-- 0..1 Country (can be ISO 3166 3 letter code) -->     
   <period></period>               <!-- 0..1 Period Time period when address was/is in use -->       
</[name]>
]]

Datatypes.xml.ContactPoint = [[
   <[name] xmlns="http://hl7.org/fhir">
      <!-- from Element: extension -->
      <system value="[code]"/>       <!-- ?? 0..1 phone | fax | email | pager | other -->
      <value value="[string]"/>      <!-- 0..1 The actual contact point details -->
      <use value="[code]"/>          <!-- 0..1 home | work | temp | old | mobile - purpose of this contact point -->
      <rank value="[positiveInt]"/>  <!-- 0..1 Specify preferred order of use (1 = highest) -->
      <period></period>              <!-- 0..1 Period Time period when the contact point was/is in use -->
   </[name]>
]]

Datatypes.xml.Timing = [[
   <[name] xmlns="http://hl7.org/fhir">
      <!-- from Element: extension -->
      <event value="[dateTime]"/>           <!-- 0..* When the event occurs -->
      <repeat>                              <!-- 0..1 When the event is to occur -->
         <bounds[x]></bounds[x]>                <!-- 0..1 Quantity(Duration)|Range|Period Length/Range of lengths, or (Start and/or end) limits -->
         <count value="[integer]"/>             <!-- 0..1 Number of times to repeat -->
         <duration value="[decimal]"/>          <!-- 0..1 How long when it happens -->
         <durationMax value="[decimal]"/>       <!-- 0..1 How long when it happens (Max) -->
         <durationUnits value="[code]"/>        <!-- 0..1 s | min | h | d | wk | mo | a - unit of time (UCUM) -->
         <frequency value="[integer]"/>         <!-- 0..1 Event occurs frequency times per period -->
         <frequencyMax value="[integer]"/>      <!-- 0..1 Event occurs up to frequencyMax times per period -->
         <period value="[decimal]"/>            <!-- 0..1 Event occurs frequency times per period -->
         <periodMax value="[decimal]"/>         <!-- 0..1 Upper limit of period (3-4 hours) -->
         <periodUnits value="[code]"/>          <!-- 0..1 s | min | h | d | wk | mo | a - unit of time (UCUM) -->
         <when value="[code]"/>                 <!-- 0..1 Regular life events the event is tied to -->
      </repeat>
      <code></code>                         <!-- 0..1 CodeableConcept QD | QOD | Q4H | Q6H | BID | TID | QID | AM | PM + -->
   </[name]>
]]

Datatypes.xml.Signature = [[
   <[name] xmlns="http://hl7.org/fhir">
      <!-- from Element: extension -->
      <type></type>                   <!-- 1..* Coding Indication of the reason the entity signed the object(s) -->
      <when value="[instant]"/>       <!-- 1..1 When the signature was created -->
      <who[x]></who[x]>               <!-- 1..1 uri|Reference(Practitioner|RelatedPerson|Patient|Device|Organization) Who signed the signature -->
      <contentType value="[code]"/>   <!-- 1..1 The technical format of the signature  -->
      <blob value="[base64Binary]"/>  <!-- 1..1 The actual signature content (XML DigSig. JWT, picture, etc.) -->
   </[name]>
]]

Datatypes.xml.Annotation = [[
   <[name] xmlns="http://hl7.org/fhir">
      <!-- from Element: extension -->
      <author[x]></author[x]>     <!-- 0..1 Reference(Practitioner|Patient|RelatedPerson)|string Individual responsible for the annotation -->
      <time value="[dateTime]"/>  <!-- 0..1 When the annotation was made -->
      <text value="[string]"/>    <!-- 1..1 The annotation  - text content -->
   </[name]>
]]


-- Adapted from:
-- https://www.hl7.org/fhir/resource.html#metadata
Datatypes.xml.Resource = [[
   <meta xmlns="http://hl7.org/fhir">
      <!-- from Element: extension -->
      <versionId value="[id]"/>         <!-- 0..1 Version specific identifier -->
      <lastUpdated value="[instant]"/>  <!-- 0..1 When the resource version last changed -->
      <profile value="[uri]"/>          <!-- 0..* Profiles this resource claims to conform to -->
      <security></security>             <!-- 0..* Coding Security Labels applied to this resource -->
      <tag></tag>                       <!-- 0..* Coding Tags applied to this resource -->
   </meta>
]]

-- Adapted from:
-- https://www.hl7.org/fhir/extensibility.html
Datatypes.xml.Extension = [[
   <extension|modifierExtension xmlns="http://hl7.org/fhir" url="identifies the meaning of the extension (uri)">
       <!-- from Element: extension -->
       <value[x]></value[x]>  <!-- 0..1 * Value of extension -->
   </extension|modifierExtension>
]]

-- Adapted from:
-- https://www.hl7.org/fhir/narrative.html#Narrative
Datatypes.xml.Narrative = [[
   <[name] xmlns="http://hl7.org/fhir">
      <!-- from Element: extension -->
      <status value="[code]"/>                          <!-- 1..1 generated | extensions | additional | empty -->
      <div xmlns="http://www.w3.org/1999/xhtml"> </div> <!-- Limited xhtml content< --> 
   </[name]>
]]




return Datatypes
