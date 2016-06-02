local Mappings      = require 'fhir.mappings.controller'
local FhirObjects   = require 'fhir.resources.objects'
local JSONutilities = require 'fhir.resources.utilities.json'
local XMLutilities = require 'fhir.resources.utilities.xml'

local MappingUtils = {}

MappingUtils.getDbEntryFromFhirObject = function(DataFormat, ResourceName, FhirObject)
   -- Format the mapping type string.
   local MappingType  = DataFormat:lower() .. "2DB"
   trace(MappingType)
     
   -- Get the right mapping function from the Mappings object.
   local MapFHIR2DB = Mappings[MappingType][ResourceName:lower()]
   trace(MapFHIR2DB)
 
   -- Map the FHIR object to the database table entry.
   -- DbEntry will either be the populated DbEntry table or an error message.
   local Success, DbEntry = MapFHIR2DB(FhirObject)
   
   return Success, DbEntry
end


MappingUtils.getFhirFromDbResults = function(DataFormat, ResourceName, DbResult) 
   -- Format the mapping type string.
   local MappingType  = "DB2" .. DataFormat:lower()
   trace(MappingType)
   
   -- Format the resource type. 
   local ResourceType = ResourceName:lower()
   trace(ResourceType)
   
   
   -- Get the right mapping function from the Mappings object.
   local MapDB2FHIR = Mappings[MappingType][ResourceType]
   trace(MapDB2FHIR)
   
   -- Map the DB result to a FHIR object in the given format.
   local FhirResult = MapDB2FHIR(DbResult)
   
   return FhirResult
end


local function putXmlFhirResultsIntoXmlBundle(FhirResult)
   local Bundle = FhirObjects.createXML("Bundle")
   
   -- Need unique id for each bundle..
   Bundle.id.value    = util.guid(128)
   Bundle.type.value  = "searchSet"
   Bundle.total.value = #FhirResult
   
   -- Store each FHIR object result in 
   for ResultIndex = 1, #FhirResult do
      local NewEntry = Bundle:append(xml.ELEMENT, "entry")
      local Resource = NewEntry:append(xml.ELEMENT, "resource")
      Resource:setInner(FhirResult[ResultIndex]:S() )
   end
   
   XMLutilities.removeEmptyNodes(Bundle)
   trace(Bundle)
   return Bundle
end

local function putJsonFhirResultsIntoJsonBundle(FhirResult)
   local Bundle = FhirObjects.createJSON("Bundle")
   
   -- Need unique id for each bundle..
   Bundle["id"]    = util.guid(128)
   Bundle["type"]  = "searchSet"
   Bundle["total"] = #FhirResult
   
   -- Not including link info in this example
   -- (defines urls to access different result 
   --  sets --> first, prev, next, last, self)
   Bundle["link"]  = nil
   
   -- Same with meta, contains info like lastUpdated.
   Bundle["meta"]  = nil  
   
   -- Store each FHIR object result in 
   for ResultIndex = 1, #FhirResult do
      Bundle["entry"][ResultIndex] = {}
      Bundle["entry"][ResultIndex]["resource"] = FhirResult[ResultIndex]
   end
   
   JSONutilities.removeEmptyNodes(Bundle)
   return Bundle
end

MappingUtils.putFhirResultsIntoFhirBundle = function(DataFormat, FhirResult)
   if DataFormat == "json" then
      return putJsonFhirResultsIntoJsonBundle(FhirResult)
   else
      return putXmlFhirResultsIntoXmlBundle(FhirResult)
   end
end

return MappingUtils