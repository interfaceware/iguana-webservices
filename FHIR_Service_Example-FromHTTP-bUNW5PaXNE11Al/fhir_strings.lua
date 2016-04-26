_fhirStrings = {}
_fhirStrings.datatypes = {}
local _d = _fhirStrings.datatypes

_d.resource = [[
<type value=""/><!-- 0..1 Resource Type -->
<reference value=""/><!-- 0..1 Relative, internal or absolute URL reference -->
<display value=""/><!-- 0..1 Text alternative for the resource -->
]]

_d.extension = [[
<url value=""/><!-- 1..1 identifies the meaning of the extension -->
<isModifier value=""/><!-- 0..1 If extension modifies other elements/extensions -->
<!--<value[x]/>use fhirInsert[x](name,type) to add expension elements-->
]]

_d.period = [[
<start value=""/><!-- 0..1 The start of the period -->
<end value=""/><!-- 0..1 The end of the period, if not ongoing -->
]]

_d.coding = [[
<system value=""/><!-- 0..1 Identity of the terminology system -->
<version value=""/><!-- 0..1 Version of the system - if relevant -->
<code value=""/><!-- 0..1 Symbol in syntax defined by the system -->
<display value=""/><!-- 0..1 Representation defined by the system -->
<primary value=""/><!-- 0..1 If this code was chosen directly by the user -->
<valueSet><!-- 0..1 Resource(ValueSet) Set this coding was chosen from -->]]
.. _d.resource .. [[</valueSet>
]]

_d.quantity = [[
<value value=""/><!-- 0..1 Numerical value (with implicit precision) -->
<comparator value=""/><!-- 0..1 < | <;= | >= | > - how to understand the value -->
<units value=""/><!-- 0..1 Unit representation -->
<system value=""/><!-- 0..1 System that defines coded unit form -->
<code value=""/><!-- 0..1 Coded form of the unit -->
]]

_d.age = _fhirStrings.datatypes.quantity
_d.distance = _fhirStrings.datatypes.quantity
_d.duration = _fhirStrings.datatypes.quantity
_d.count = _fhirStrings.datatypes.quantity
_d.money = _fhirStrings.datatypes.quantity

_d.address = [[
<use value=""/><!-- 0..1 The use of this address -->
<text value=""/><!-- 0..1 Text representation of the address -->
<line value=""/><!-- 0..* Street name, number, direction & P.O. Box etc -->
<city value=""/><!-- 0..1 Name of city, town etc. -->
<state value=""/><!-- 0..1 Sub-unit of country (abreviations ok) -->
<zip value=""/><!-- 0..1 Postal code for area -->
<country value=""/><!-- 0..1 Country (can be ISO 3166 3 letter code) -->
<period><!-- 0..1 Period Time period when address was/is in use -->]]
.. _d.period .. [[</period>
]]

_d.attachment = [[
<contentType value=""/><!-- 1..1 Mime type of the content, with charset etc. -->
<language value=""/><!-- 0..1 Human language of the content (BCP-47) -->
<data value=""/><!-- 0..1 Data inline, base64ed -->
<url value=""/><!-- 0..1 Uri where the data can be found -->
<size value=""/><!-- 0..1 Number of bytes of content (if url provided) -->
<hash value=""/><!-- 0..1 Hash of the data (sha-1, base64ed ) -->
<title value=""/><!-- 0..1 Label to display in place of the data -->
]]

_d.codeableConcept = [[
<coding><!-- 0..* Coding Code defined by a terminology system -->]]
.. _d.coding .. [[</coding>
<text value=""/><!-- 0..1 Plain text representation of the concept -->
]]

_d.contact = [[
<system value=""/><!-- 0..1 Telecommunications form for contact -->
<value value=""/><!-- 0..1 The actual contact details -->
<use value=""/><!-- 0..1 How to use this address -->
<period><!-- 0..1 Period Time period when the contact was/is in use -->]]
.. _d.period .. [[</period>
]]

_d.range = [[
<low><!-- 0..1 Quantity Low limit -->]]
.. _d.quantity .. [[</low>
<high><!-- 0..1 Quantity High limit -->]]
.. _d.quantity .. [[</high>
]]

_d.ratio = [[
<numerator><!-- 0..1 Quantity The numerator -->]]
.. _d.quantity .. [[</numerator>
<denominator><!-- 0..1 Quantity The denominator -->]]
.. _d.quantity .. [[</denominator>
]]

_d.sampledData = [[
<origin><!-- 0..1 Quantity Zero value and units -->]]
.. _d.quantity .. [[</origin>
<period value=""/><!-- 0..1 Number of milliseconds between samples -->
<factor value=""/><!-- 0..1 Multiply data by this before adding to origin -->
<lowerLimit value=""/><!-- 0..1 Lower limit of detection -->
<upperLimit value=""/><!-- 0..1 Upper limit of detection -->
<dimensions value=""/><!-- 0..1 Number of sample points at each time point -->
<data value=""/><!-- 0..1 Decimal values with spaces, or "E" | "U" | "L" -->
]]

_d.identifier = [[
<use value=""/><!-- 0..1 The use of this identifier -->
<label value=""/><!-- 0..1 Description of identifier -->
<system value=""/><!-- 0..1 The namespace for the identifier -->
<key value=""/><!-- 0..1 The value that is unique -->
<period><!-- 0..1 Period Time period when id was valid for use -->]]
.. _d.period .. [[</period>
<assigner><!-- 0..1 Resource(Organization) Organization that issued id (may be just text) -->]]
.. _d.resource .. [[</assigner>
]]

_d.humanName = [[
<use value=""/><!-- 0..1 The use of this name -->
<text value=""/><!-- 0..1 Text representation of the full name -->
<family value=""/><!-- 0..* Family name (often called 'Surname') -->
<given value=""/><!-- 0..* Given names (not always 'first'). Includes middle names -->
<prefix value=""/><!-- 0..* Parts that come before the name -->
<suffix value=""/><!-- 0..* Parts that come after the name -->
<period><!-- 0..1 Period Time period when name was/is in use -->]]
.. _d.period .. [[</period>
]]

_fhirStrings.datatypes['repeat'] = [[
<frequency value=""/><!-- 0..1 Event occurs frequency times per duration -->
<when value=""/><!-- 0..1 Event occurs duration from common life event -->
<duration value=""/><!-- 1..1 Repeating or event-related duration -->
<units value=""/><!-- 1..1 The units of time for the duration -->
<count value=""/><!-- 0..1 Number of times to repeat -->
<end value=""/><!-- 0..1 When to stop repeats -->
]]


_d.schedule = [[
<event><!-- 0..* Period When the event occurs -->]]
.. _d.period .. [[</event>
<repeat><!-- 0..1 Only if there is none or one event -->]]
.. _fhirStrings.datatypes['repeat'] .. [[</repeat>
]]

_d.option = [[
<code value=""/><!-- 1..1 Possible code -->
<display value=""/><!-- 0..1 Display for the code -->
]]

_d.choice = [[
<!-- from Element: extension -->
<code value=""/><!-- 0..1 Selected code -->
<option>  <!-- 1..* List of possible code values -->]]
..  _d.option .. [[</option>
<isOrdered value=""/><!-- 0..1 If order of the values has meaning -->
]]

_d.narrative = [[
<status value=""/><!-- 1..1 generated | extensions | additional -->
<div xmlns="http://www.w3.org/1999/xhtml"><!-- Limited xhtml content< --></div>
]]


_d.contained = ''
Note that some of the datatypes include datatypes already defined.  Creating the respources is now simple as the datatype definitions can be included within the resource. (http://www.healthint…esourcelist.htm). 
 
Here’s the patient resource:
_fhirStrings.resources = {}
_fhirStrings.components = {}
local _r = _fhirStrings.resources
local _c = _fhirStrings.components


_r.resource = [[
<extension><!-- 0..*  Extension   See Extensions  --></extension>
<language value=""/><!-- 0..1 Human language of the content (BCP-47) -->
<text><!-- 1..1 Narrative Text summary of resource content, for human interpretation -->]]
.. _d.narrative .. [[</text>
<contained><!-- 0..*  Resource   Contained Resources  --></contained>
]]
--+++++++++++++++++++++++++++++++++++++
-- Patient resource

_c.patientContact = [[
<relationship><!-- 0..* CodeableConcept The kind of relationship -->]]
.. _d.codeableConcept .. [[</relationship>
<name><!-- 0..1 HumanName A name associated with the person -->]]
.. _d.humanName .. [[</name>
<telecom><!-- 0..* Contact A contact detail for the person -->]]
.. _d.contact .. [[</telecom>
<address><!-- 0..1 Address Address for the contact person -->]]
.. _d.address .. [[</address>
<gender><!-- 0..1 CodeableConcept Gender for administrative purposes -->]]
.. _d.codeableConcept .. [[</gender>
<organization><!-- 0..1 Resource(Organization) Organization that is associated with the contact -->]]
.. _d.resource .. [[</organization>
]]

_r.Patient = [[
<Patient xmlns="http://hl7.org/fhir">
<!-- from Resource: extension, language, text, and contained -->]]
.. _r.resource .. [[
<identifier><!-- 0..* Identifier An identifier for the person as this patient -->]]
.. _d.identifier .. [[</identifier>
<name><!-- 0..* HumanName A name associated with the patient -->]]
.. _d.humanName .. [[</name>
<telecom><!-- 0..* Contact A contact detail for the individual -->]]
.. _d.contact .. [[</telecom>
<gender><!-- 0..1 CodeableConcept Gender for administrative purposes -->]]
.. _d.codeableConcept .. [[</gender>
<birthDate value=""/><!-- 0..1 The date and time of birth for the individual -->
<deceasedBoolean value = ""/><!-- 0..1 boolean Indicates if the individual is deceased or not -->
<deceasedDatetime value = ""/> <!-- 0..1 dateTime Indicates if the individual is deceased or not -->
<address><!-- 0..* Address Addresses for the individual -->]]
.. _d.address .. [[</address>
<maritalStatus><!-- 0..1 CodeableConcept Marital (civil) status of a person -->]]
.. _d.codeableConcept .. [[</maritalStatus>
<multipleBirthBoolean value = ""/><!-- 0..1 boolean Whether patient is part of a multiple birth -->
<multipleBirthInteger value = ""/><!-- 0..1 integer Whether patient is part of a multiple birth -->
<photo><!-- 0..* Attachment Image of the person -->]]
.. _d.attachment .. [[</photo>
<contact> <!-- 0..* A contact party (e.g. guardian, partner, friend) for the patient -->]]
.. _c.patientContact .. [[</contact>
<animal> <!-- 0..1 If this patient is an animal (non-human) -->
<species><!-- 1..1 CodeableConcept E.g. Dog, Cow -->]]
.. _d.codeableConcept .. [[</species>
<breed><!-- 0..1 CodeableConcept E.g. Poodle, Angus -->]]
.. _d.codeableConcept .. [[</breed>
<genderStatus><!-- 0..1 CodeableConcept E.g. Neutered, Intact -->]]
.. _d.codeableConcept .. [[</genderStatus>
</animal>
<communication><!-- 0..* CodeableConcept Languages which may be used to communicate with the patient -->]]
.. _d.codeableConcept .. [[</communication>
<provider><!-- 0..1 Resource(Organization) Organization managing the patient -->]]
.. _d.resource .. [[</provider>
<link><!-- 0..* Resource(Patient) Other patient resources linked to this resource -->]]
.. _d.resource .. [[</link>
<active value=""/><!-- 0..1 Whether this patient's record is in active use -->
</Patient>]]