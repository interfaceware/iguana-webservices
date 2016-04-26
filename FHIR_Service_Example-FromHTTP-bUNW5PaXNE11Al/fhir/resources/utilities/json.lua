local Datatypes = require 'fhir.complex_datatypes'

local JsonUtilities = {}


----------------------------------------------------
----------------------------------------------------
----- Resource Definition JSON Parsing Helpers -----
----------------------------------------------------
----------------------------------------------------

JsonUtilities.storeNewNode = function(NodeName, StructreElement, FhirObject)
   local Datatype = StructreElement.type[1].code
   
   if Datatype == "DomainResource" or  Datatype == "BackboneElement" then
      -- Datatype of node is either the main resouce node, or a parent node
      trace("Parent node")
      FhirObject[NodeName] = {}
   elseif Datatypes.json[Datatype] ~= nil then
      -- Datatype of node is a complex datatype
      trace("Complex Datatype")
      FhirObject[NodeName] = json.parse{ data=Datatypes.json[Datatype] }
   else
      -- Datatype of node is a primitive datatype. Set as default null.
      trace("Primitive datatype")
      FhirObject[NodeName] = json.NULL
   end
end

-- Will ensure all elements in the path up to and including the target element exist.
JsonUtilities.storeElementinFhirObject = function(Element, FhirObject)
   trace(FhirObject)
   local ElementPath = Element.path
   local PathParts   = ElementPath:split(".")
   local CurrentNode = FhirObject
   trace(CurrentNode)
   
   -- FHIR resource structures should define parent elements before child elements,
   -- so we can assume the parent path elements have already been created.
   for PathIndex=1, #PathParts do
      local CurrentNodeName = PathParts[PathIndex]
      local isLastElementInPath = PathIndex == #PathParts
      if isLastElementInPath then
          trace("Storing new element '" .. CurrentNodeName .. "' in FHIR object...")
          JsonUtilities.storeNewNode(CurrentNodeName, Element, CurrentNode)
          trace(CurrentNode)
      else
         CurrentNode = CurrentNode[CurrentNodeName]
         if CurrentNode == nil then
            error("Ran into a parent path node that hasn't been created! Shouldn't happen!")
         end
      end
   end
end


JsonUtilities.getResourceElements = function(ResourceStructure)
   if ResourceStructure.snapshot.element ~= nil then
      return ResourceStructure.snapshot.element
   elseif ResourceStructure.snapshot.differential ~= nil then
      return ResourceStructure.snapshot.differential
   else
      error "Can't find element definitions in given resource"
   end
end



---------------------------------------------------
---------------------------------------------------
------------- JSON FHIR Object Helpers -----------
---------------------------------------------------
---------------------------------------------------

local function shouldBeRemoved(JsonNode)
   if JsonUtilities.isEmpty(JsonNode) or (JsonUtilities.hasOnlyOne(JsonNode) and JsonNode["resourceType"] ~= nil) then
      -- No children, 
      -- or only child is a constant defining an empty child resource type 
      return true
   end
   return false
end

JsonUtilities.removeEmptyNodes = function(FhirJSON)
   for Key, Value in pairs(FhirJSON) do
      trace(Key, Value)
      if type(Value) == "table" then
         if shouldBeRemoved(Value) then FhirJSON[Key] = nil end 
         if FhirJSON[Key] ~= nil then
            JsonUtilities.removeEmptyNodes(Value)
            if shouldBeRemoved(Value) then FhirJSON[Key] = nil end
         end
      elseif Value == json.NULL then
         FhirJSON[Key] = nil
      end
   end
end



---------------------------------------------------
---------------------------------------------------
------------- General JSON Helpers ---------------
---------------------------------------------------
---------------------------------------------------

JsonUtilities.mapSize = function(Map)
   local Size = 0
   for k,v in pairs(Map) do
     Size = Size + 1
   end
   return Size
end

JsonUtilities.isEmpty = function(Map)
   local Size = 0
   for k,v in pairs(Map) do
     return false
   end
   return true
end

JsonUtilities.hasOnlyOne = function(Map)
   local Size = 0
   for k,v in pairs(Map) do
     Size = Size + 1
     if Size == 2 then 
         return false
     end
   end
   return Size == 1
end

return JsonUtilities