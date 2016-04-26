-- Functions that will map a DB table object to a FHIR XML object.

local FhirObjects   = require 'fhir.resources.objects'
local XMLutilities = require 'fhir.resources.utilities.xml'

local function getAddressMap(AddressString)
   local Address = {}
   local AddressParts = AddressString:split(" ")
   trace(AddressParts)
   Address.line       = AddressParts[1] .. " " .. AddressParts[2] .. " " .. AddressParts[3]
   Address.city       = AddressParts[4]
   Address.state      = AddressParts[5]
   Address.country    = AddressParts[6]
   Address.postalCode = AddressParts[7]
   trace(Address)
   return Address
end

local function storeFhirAddress(FhirAddress, AddressString)
   local Address = getAddressMap(AddressString)
   FhirAddress.text.value       = AddressString
   FhirAddress.city.value       = Address.city:sub(0, #Address.city -1)
   FhirAddress.country.value    = Address.country
   FhirAddress.postalCode.value = Address.postalCode
   FhirAddress.state.value      = Address.state
   FhirAddress.line.value       = Address.line
   trace(FhirAddress)
end

local function storeFhirContact(FhirContact, DbPatient)
   trace(DbPatient)
   local FullName  = DbPatient.ContactName
   local NameParts = FullName:S():split(" ")
   FhirContact.name.text.value   = FullName 
   FhirContact.name.given.value  = NameParts[1]
   FhirContact.name.family.value = NameParts[2]
   
   FhirContact.relationship.text.value          = DbPatient.ContactRelationship
   FhirContact.relationship.coding.system.value = "http://hl7.org/fhir/patient-contact-relationship"
   FhirContact.relationship.coding.code.value   = DbPatient.ContactRelationship
   
   FhirContact.telecom.system.value = "phone"
   -- Need to loop through and make sure we are setting the value on the 
   -- attribute (node name is 'value' as well.)
   for i=1,FhirContact.telecom:childCount() do
      if FhirContact.telecom[i]:nodeName() == "value" and 
         FhirContact.telecom[i]:nodeType() == xml.ELEMENT then 
         FhirContact.telecom[i].value = DbPatient.ContactPhone
      end
   end
   storeFhirAddress(FhirContact.address, DbPatient.ContactAddress:S())
end

local function storeFhirCommunication(FhirCommunication, DbPatient)
	FhirCommunication.language.text.value             = DbPatient.SpokenLanguage
   FhirCommunication.language.coding.code.value   = DbPatient.SpokenLanguage
   FhirCommunication.language.coding.system.value = "http://tools.ietf.org/html/bcp47"
end


local function storeFhirName(FhirName, DbPatient)
   FhirName.text.value   = DbPatient.FirstName .. " " .. DbPatient.LastName 
   FhirName.given.value  = DbPatient.FirstName
   FhirName.family.value = DbPatient.LastName
end


local PatientDB2xml = function(DBresult)
   trace(DBresult)
   local Patients = {}
   
   for i = 1, #DBresult do
      local FhirPatient = FhirObjects.createXML("Patient")
      trace(FhirPatient)

      local DbPatient   = DBresult[i]
      
      storeFhirName(FhirPatient.name, DbPatient)
      storeFhirCommunication(FhirPatient.communication, DbPatient)
      storeFhirContact(FhirPatient.contact, DbPatient)
      storeFhirAddress(FhirPatient.address, DbPatient.Address:S())
  
      FhirPatient.telecom.system.value = "phone"
      FhirPatient.telecom.value.value  = DbPatient.Phone
      
      FhirPatient.id.value        = DbPatient.Id
      FhirPatient.gender.value    = DbPatient.Gender
      FhirPatient.birthDate.value = DbPatient.Birthday
      
      if DbPatient.Active:S() == "1" then
         FhirPatient.active.value = "true"
      else
         FhirPatient.active.value = "false"
      end
      
      if DbPatient.Deceased:S() == "1" then
         FhirPatient["deceased"].value = "true"
      else
         FhirPatient["deceased"].value = "false"
      end
      XMLutilities.removeEmptyNodes(FhirPatient)
      Patients[i] = FhirPatient
   end
   
   trace(Patients)
   return Patients
end


return PatientDB2xml