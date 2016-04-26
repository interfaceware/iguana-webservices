local Datatypes = require 'fhir.complex_datatypes'

local JsonUtilities = {}

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
      local isLastPathElement = PathIndex == #PathParts
      if isLastPathElement then
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

return JsonUtilities