local PatientDefinition = require 'fhir.resources.definitions.Patient'
local JSONutilities     = require 'fhir.resources.objects.utilities.json_utilities'
local XMLutilities      = require 'fhir.resources.objects.utilities.xml_utilities'

local PatientObject = {}

PatientObject.createJSON = function()
   -- Parse the resource structure definition string
   local ResourceStructure = json.parse{data=PatientDefinition.json}

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

PatientObject.createXML = function()
   local XmlDefinition = xml.parse(PatientDefinition.xml)
end

return PatientObject
   
   

   
   
 
      
      
  