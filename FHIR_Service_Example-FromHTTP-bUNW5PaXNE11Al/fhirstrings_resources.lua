-- Taken from --> http://www.healthintersections.com.au/fhir/resourcelist.htm

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