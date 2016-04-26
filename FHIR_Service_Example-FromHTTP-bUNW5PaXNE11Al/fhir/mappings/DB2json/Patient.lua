local FhirObjects   = require 'fhir.resources.objects'
local JSONutilities = require 'fhir.resources.utilities.json'

-- Functions that will map a DB table object to a FHIR JSON object.

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
   FhirAddress.text       = AddressString
   FhirAddress.city       = Address.city:sub(0, #Address.city -1)
   FhirAddress.country    = Address.country
   FhirAddress.postalCode = Address.postalCode
   FhirAddress.state      = Address.state
   FhirAddress.line[1]    = Address.line
   trace(FhirAddress)
end

local function storeFhirContact(FhirContact, DbPatient)
   trace(DbPatient)
   local FullName  = DbPatient.ContactName
   local NameParts = FullName:S():split(" ")
   FhirContact.name.text   = FullName 
   FhirContact.name.given  = NameParts[1]
   FhirContact.name.family = NameParts[2]
   
   FhirContact.relationship.text = DbPatient.ContactRelationship
   FhirContact.relationship.coding[1].system = "http://hl7.org/fhir/patient-contact-relationship"
   FhirContact.relationship.coding[1].code = DbPatient.ContactRelationship
   
   FhirContact.telecom.system = "phone"
   FhirContact.telecom.value  = DbPatient.ContactPhone
   
   storeFhirAddress(FhirContact.address, DbPatient.ContactAddress:S())
end

local function storeFhirCommunication(FhirCommunication, DbPatient)
	FhirCommunication.language.text             = DbPatient.SpokenLanguage
   FhirCommunication.language.coding[1].code   = DbPatient.SpokenLanguage
   FhirCommunication.language.coding[1].system = "http://tools.ietf.org/html/bcp47"
end


local function storeFhirName(FhirName, DbPatient)
   FhirName.text   = DbPatient.FirstName .. " " .. DbPatient.LastName 
   FhirName.given  = DbPatient.FirstName
   FhirName.family = DbPatient.LastName 
end


local PatientDB2json = function(DBresult)
   trace(DBresult)
   local Patients = {}
   
   for i = 1, #DBresult do
      local FhirPatient = FhirObjects.createJSON("Patient")
      local DbPatient   = DBresult[i]
      
      storeFhirName(FhirPatient.name, DbPatient)
      storeFhirCommunication(FhirPatient.communication, DbPatient)
      storeFhirContact(FhirPatient.contact, DbPatient)
      storeFhirAddress(FhirPatient.address, DbPatient.Address:S())
  
      FhirPatient.telecom.system = "phone"
      FhirPatient.telecom.value  = DbPatient.Phone
      
      FhirPatient.id        = DbPatient.Id
      FhirPatient.gender    = DbPatient.Gender
      FhirPatient.birthDate = DbPatient.Birthday
      
      if DbPatient.Active == 1 then
         FhirPatient.active = true
      else
         FhirPatient.active = false
      end
      
      if DbPatient.Deceased == 1 then
         FhirPatient["deceased[x]"] = true
      else
         FhirPatient["deceased[x]"] = false
      end
      
      JSONutilities.removeEmptyNodes(FhirPatient)
      Patients[i] = FhirPatient
   end
   trace(Patients)
   return Patients
end


return PatientDB2json