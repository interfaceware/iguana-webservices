-- Create FHIR objects based off the resource definitions defined in fhir/resources/definitions
-- Calling the createJSON or createXML functions with the resource type string as a parameter 
-- will return an empty resource object.

local Definitions   = require 'fhir.resources.definitions.controller'

local JSONutilities = require 'fhir.resources.utilities.json'
local XMLutilities  = require 'fhir.resources.utilities.xml'

local FhirObjectCreators = {}

FhirObjectCreators.createJSON = function(ResourceType)
   -- Parse the resource structure definition string
   local ResourceJson = Definitions[ResourceType:capitalize()].json
   local ResourceStructure = json.parse{data=ResourceJson}

   -- Create an empty json object that will hold our FHIR object 
   local FhirObject = json.createObject()
   
	-- Retrieve the elements in the resource structure definition.
   -- They exist in either 'element' or 'differential'
   local Elements = JSONutilities.getResourceElements(ResourceStructure)
   
   -- Loop through all the elements defined for this resource in the definition,
   -- store each one in the FHIR object using the proper datatype. 
   for ElementIndex=1, #Elements do
      local CurrentElement = Elements[ElementIndex]
      trace(CurrentElement)
      JSONutilities.storeElementinFhirObject(CurrentElement, FhirObject)
      trace(FhirObject)
   end
   
    -- Set the Resource type of the FHIR object
	local ResourceType = ResourceStructure.name
   FhirObject[ResourceType].resourceType = ResourceType
   trace(FhirObject)
   
   -- Extract the main resource node from the wrapper object to finish
   local Result = FhirObject[ResourceType]
   trace(Result)
   
   return Result
end


FhirObjectCreators.createXML = function(ResourceType)
   local ResourceXml = Definitions[ResourceType:capitalize()].xml
   trace(ResourceXml)
   local ResourceStructure = xml.parse{data=ResourceXml}
   ResourceStructure = ResourceStructure.StructureDefinition
   
   -- Retrieve the elements in the resource structure definition.
   -- They exist in either 'element' or 'differential'
   local Elements = XMLutilities.getResourceElements(ResourceStructure)
   
   -- Create an empty xml document. 
   -- The main xml node is a wrapper for the fhir resource nodes.
   local FhirObject = xml.parse{data="<xml></xml>"}
   
   for ElementIndex=1, #Elements do
      local CurrentElement = Elements[ElementIndex]
      trace(CurrentElement)
      XMLutilities.storeElementinFhirObject(CurrentElement, FhirObject[1])
      trace(FhirObject)
   end
   
   -- Extract the main fhir resource node from our wrapper.
   FhirObject = FhirObject.xml[1]
   trace(FhirObject)
   return FhirObject
end

return FhirObjectCreators
   
   

   
   
 
      
      
  