local FhirObjects  = require 'fhir.resources.objects'

-- Functions that will map a FHIR JSON object to a DB table object. 

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
   "address.line[1]",
   "communication",
   "communication.language",
   "communication.language.coding",
	"communication.language.coding[1].code",
   "deceased[x]",
   "contact",
   "contact.name",
   "contact.name.given",
   "contact.name.family",
   "contact.relationship",
   "contact.relationship.coding",
   "contact.relationship.coding[1].code",
   "contact.telecom",
   "contact.telecom.value",
   "contact.address",
   "contact.address.postalCode",
   "contact.address.state",
   "contact.address.city",
   "contact.address.country",
   "contact.address.line[1]",
   "deceased[x]"
}


local function buildDbAddress(FhirAddress)
	-- NOTE : For this example we are only taking
   --        the first line of the address.   
   local AddressString = FhirAddress.line[1] .. " " .. 
                         FhirAddress.city .. ", " .. 
                         FhirAddress.state .. " " ..
                         FhirAddress.country .. " " .. 
                         FhirAddress.postalCode
   return AddressString
end


local function isPathPartAnArray(PathPart)
   if PathPart:sub(#PathPart - 2) == "[1]" then
      -- The node is an array, and at least one entry is required.
      return true, PathPart:sub(1, #PathPart - 3)
   end
   return false, PathPart
end


local function ensureRequiredDataIsPresent(FhirPatient)
   local CurrentNode = FhirPatient
   
   for FieldIndex = 1, #RequiredFhirPatientFields do
      local RequiredValuePath = RequiredFhirPatientFields[FieldIndex]
      local RequiredPathParts = RequiredValuePath:split(".")
      trace(RequiredValuePath, RequiredPathParts)
      
      for Index, CurrentPathPart in pairs(RequiredPathParts) do
         local IsArray, FormattedPathPart = isPathPartAnArray(CurrentPathPart)
         local ChildNode = nil
         
         if IsArray then
            ChildNode = CurrentNode[FormattedPathPart][1]
            if ChildNode == nil or ChildNode == json.NULL then
               error("Array value: \"" .. FormattedPathPart .. "\" is required to create/update a patient resource, and needs at least one entry")
            end
         else
            ChildNode = CurrentNode[FormattedPathPart]
            if ChildNode == nil or ChildNode == json.NULL then
               error("Value: \"" .. RequiredValuePath .. "\" is required to create/update a patient resource.")
            end
         end
         
         trace(ChildNode)
         CurrentNode = ChildNode
      end
      
      CurrentNode = FhirPatient
   end
end


local PatientJson2DB = function(FhirPatient)
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
   
   DbPatient.FirstName = FhirPatient.name.given
   DbPatient.LastName  = FhirPatient.name.family
   DbPatient.Gender    = FhirPatient.gender
   DbPatient.Active    = FhirPatient.active and 1 or 0
   DbPatient.Deceased  = FhirPatient["deceased[x]"] and 1 or 0
   DbPatient.Birthday  = FhirPatient.birthDate
   DbPatient.Phone     = FhirPatient.telecom.value
   DbPatient.Address   = buildDbAddress(FhirPatient.address)
   
   DbPatient.SpokenLanguage = FhirPatient.communication.language.coding[1].code
   DbPatient.ContactAddress = buildDbAddress(FhirPatient.contact.address)
   DbPatient.ContactPhone   = FhirPatient.contact.telecom.value
   DbPatient.ContactName    = FhirPatient.contact.name.given .. " " .. FhirPatient.contact.name.family  
   DbPatient.ContactRelationship = FhirPatient.contact.relationship.coding[1].code
   
   trace(NewDbEntry)
   return Valid, NewDbEntry
end


return PatientJson2DB