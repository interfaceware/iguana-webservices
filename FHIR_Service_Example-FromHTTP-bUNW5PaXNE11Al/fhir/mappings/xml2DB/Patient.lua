local FhirObjects  = require 'fhir.resources.objects'

-- Functions that will map a FHIR XML object to a DB table object. 

-- NOTE : For this example we are only mapping the sections of the 
--        input FHIR object which are relevant to the current example database schema,
--        all other potential filled in fields are ignored.


local RequiredFhirPatientFields = {
   "name",
   "name.given",
   "name.family", 
   "gender",
   "active",
   "birthDate",
   "telecom",
   "telecom.value",
   "address",
   "address.postalCode",
   "address.state",
   "address.city",
   "address.country",
   "address.line",
   "communication",
   "communication.language",
   "communication.language.coding",
	"communication.language.coding.code",
   "deceased",
   "contact",
   "contact.name",
   "contact.name.given",
   "contact.name.family",
   "contact.relationship",
   "contact.relationship.coding",
   "contact.relationship.coding.code",
   "contact.telecom",
   "contact.telecom.value",
   "contact.address",
   "contact.address.postalCode",
   "contact.address.state",
   "contact.address.city",
   "contact.address.country",
   "contact.address.line",

}


local function buildDbAddress(FhirAddress)
	-- NOTE : For this example we are only taking
   --        the first line of the address.
   local AddressString = FhirAddress.line.value .. " " .. 
                         FhirAddress.city.value .. " " .. 
                         FhirAddress.state.value .. ", " ..
                         FhirAddress.country.value .. " " .. 
                         FhirAddress.postalCode.value
   return AddressString
end


local function ensureRequiredDataIsPresent(FhirPatient)
   local CurrentNode = FhirPatient
   
   for FieldIndex = 1, #RequiredFhirPatientFields do
      local RequiredValuePath = RequiredFhirPatientFields[FieldIndex]
      local RequiredPathParts = RequiredValuePath:split(".")
      trace(RequiredValuePath, RequiredPathParts)
      
      for Index, CurrentPathPart in pairs(RequiredPathParts) do
         trace(Index, CurrentPathPart)
         trace(CurrentNode)
         
         local ChildNode = CurrentNode[CurrentPathPart]
         trace(ChildNode)
         
         if ChildNode == nil then
            error("Value: \"" .. RequiredValuePath .. "\" is required to create/update a patient resource.")
         end

         trace(ChildNode)
         CurrentNode = ChildNode
      end
      CurrentNode = FhirPatient
   end
end


local PatientJson2DB = function(FhirPatient)
   -- Need the parent element to work with
   local FhirPatient = FhirPatient[1]
   trace(FhirPatient)
   
   local Valid, Message = pcall( function()
         ensureRequiredDataIsPresent(FhirPatient) 
   end)
   trace(Valid, Message)
   
   if not Valid then
      return Valid, Message
   end

   local NewDbEntry = db.tables{vmd="FHIR_VMDs/Patient.vmd", name="patient"}
   local DbPatient  = NewDbEntry.patient[1]
   
   DbPatient.FirstName = FhirPatient.name.given.value
   DbPatient.LastName  = FhirPatient.name.family.value
   DbPatient.Gender    = FhirPatient.gender.value
   DbPatient.Active    = FhirPatient.active.value:S() == "true" and 1 or 0
   DbPatient.Deceased  = FhirPatient.deceased.value:S() == "true" and 1 or 0
   DbPatient.Birthday  = FhirPatient.birthDate.value
   DbPatient.Phone     = FhirPatient.telecom.value.value
   DbPatient.Address   = buildDbAddress(FhirPatient.address)   
   
   DbPatient.SpokenLanguage = FhirPatient.communication.language.coding.code.value
   DbPatient.ContactAddress = buildDbAddress(FhirPatient.contact.address)
   DbPatient.ContactPhone   = FhirPatient.contact.telecom.value.value
   DbPatient.ContactName    = FhirPatient.contact.name.given.value .. " " .. FhirPatient.contact.name.family.value  
   DbPatient.ContactRelationship = FhirPatient.contact.relationship.coding.code.value
   
   trace(NewDbEntry)
   return Valid, NewDbEntry
end


return PatientJson2DB