local Datatypes = require 'fhir.complex_datatypes'

local XmlUtilities = {}

----------------------------------------------------
----------------------------------------------------
----- Resource Definition XML Parsing Helpers -----
----------------------------------------------------
----------------------------------------------------

XmlUtilities.storeNewNode = function(NodeName, StructreElement, FhirObject)
   local Datatype = StructreElement.type.code.value:S()
   
   if Datatype == "DomainResource" or  Datatype == "BackboneElement" then
      -- Datatype of node is either the main resouce node, or a parent node
      trace("Parent node")
      FhirObject:append(xml.ELEMENT, NodeName)
   elseif Datatypes.xml[Datatype] ~= nil then
      -- Datatype of node is a complex datatype, create the parent node,
      -- then append the complex datatype nodes to it.
      trace("Complex Datatype")
      local ComplexDatatypeNode = FhirObject:append(xml.ELEMENT, NodeName)
      ComplexDatatypeNode:setInner( Datatypes.xml[Datatype] )
   else
      -- Datatype of node is a primitive datatype. 
      -- Set the value attribute as empty string
      trace("Primitive datatype")
      local PrimitiveDatatypeNode = FhirObject:append(xml.ELEMENT, NodeName)
      PrimitiveDatatypeNode:append(xml.ATTRIBUTE, "value")
   end   
end

-- Will ensure all elements in the path up to and including the target element exist.
XmlUtilities.storeElementinFhirObject = function(Element, FhirObject)
   trace(FhirObject)
   trace(Element)
   local ElementPath = Element.path.value:S()
   local PathParts   = ElementPath:split(".")
   local CurrentNode = FhirObject
   trace(CurrentNode)
   
   -- FHIR resource structures should define parent elements before child elements,
   -- so we can assume the parent path elements have already been created.
   for PathIndex=1, #PathParts do
      local CurrentNodeName = PathParts[PathIndex]
      trace(CurrentNodeName)
      local isLastElementInPath = PathIndex == #PathParts
      if isLastElementInPath then
         trace("Storing new element '" .. CurrentNodeName .. "' in FHIR object...")
         XmlUtilities.storeNewNode(CurrentNodeName, Element, CurrentNode)
         trace(CurrentNode)
      else
         trace(CurrentNode)
         CurrentNode = CurrentNode[CurrentNodeName]
         trace(CurrentNode)
         if CurrentNode == nil then
            error("Ran into a parent path node that hasn't been created! Shouldn't happen!")
         end
      end
   end
end

XmlUtilities.getResourceElements = function(ResourceStructure)
	trace(ResourceStructure)
   if ResourceStructure.snapshot ~= nil then
      return ResourceStructure.snapshot
   elseif ResourceStructure.differential ~= nil then
      return ResourceStructure.differential
   else
      error "Can't find element definitions in given resource"
   end
end



---------------------------------------------------
---------------------------------------------------
------------- XML FHIR Object Helpers -----------
---------------------------------------------------
---------------------------------------------------

XmlUtilities.removeEmptyNodes = function(FhirXML)
   for i = FhirXML:childCount(), 1, -1 do
      local CurrentNode = FhirXML[i]
      trace(CurrentNode)
      if CurrentNode:nodeType() == xml.ELEMENT then
         local Removed = false
         if XmlUtilities.isEmpty(CurrentNode) then 
            FhirXML:remove(i) 
            Removed = true
         end 
         if not Removed then
            XmlUtilities.removeEmptyNodes(CurrentNode)
            if XmlUtilities.isEmpty(CurrentNode) then FhirXML:remove(i) end
         end
      end
   end
end



---------------------------------------------------
---------------------------------------------------
------------- General XML Helpers -----------------
---------------------------------------------------
---------------------------------------------------

XmlUtilities.isEmpty = function(XmlNode)
   if XmlNode:nodeType() ~= xml.ELEMENT then 
      trace("Not an element node!")
      return false 
   end
   local NumberOfChildren = XmlNode:childCount()
   local HasValue      = false
   local HasChildNodes = false
   if NumberOfChildren ~= 0 then
      for i=1,NumberOfChildren do
         local CurrentChild = XmlNode[i]
         if CurrentChild:nodeType() == xml.ATTRIBUTE and 
            CurrentChild:nodeName() == "value"       and 
            CurrentChild:nodeValue() ~= ""          then
            trace("Has a value attribute and it isn't empty!")
            HasValue = true
         elseif CurrentChild:nodeType() == xml.ELEMENT then
            trace("Has child nodes!")
            HasChildNodes = true
         end
      end
   end
   trace(HasValue)
   trace(HasChildNodes)
   return not (HasValue or HasChildNodes)
end



return XmlUtilities
