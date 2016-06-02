local Resources = require 'fhir.resources.definitions.controller'

local WebUtils = {}

-- All responses conform to the 
WebUtils.Responses = {}


WebUtils.getDataFormat = function(Request)
   trace(Request)
   if Request.get_params._format == "json" or Request.get_params._format == "xml" or
      Request.post_params._format == "json"or Request.post_params._format == "xml" then
      return Request.get_params._format
   else
      -- JSON defualt
      return "json"
   end
end


WebUtils.getResponseEntityType = function(Request)
   local DataFormat = WebUtils.getDataFormat(Request)
   if DataFormat == "xml" then
      return "text/xml+fhir"
   else
      return "text/json+fhir"
   end
end


WebUtils.isValidResourceId = function(id)
   local NotNull = id ~= nil
   
   -- Lua will convert value to number automatically.
   -- Will throw error if it can't convert it.
   local IsNumber, Result = pcall(function () 
         local Result = id + 1
         return Result
   end)
   
   return NotNull and IsNumber
end


local function getLocationParts(Location)
   -- Get all the parts by splitting on the "/" seperator
   local LocationParts = Location:split('/')
   -- Remove all empty parts.
   for i=1, #LocationParts do 
      if LocationParts[i] == "" then
         table.remove(LocationParts, i)
      end
   end
   --return the valid parts of the location url.
   return LocationParts
end


WebUtils.validateRequestLocation = function(Location, RequestType)
   local Success       = true
   local LocationMap   = {}
   local LocationParts = getLocationParts(Location)
   
   if LocationParts[1] ~= "fhir" then
      LocationMap["error"] = "The first part of the path must be 'fhir' to correctly access resources."
      Success = false
   end
   if LocationParts[2] ~= nil then
      -- Check to make sure the resource name is a valid one we have mappings for.
      if Resources[ LocationParts[2]:capitalize() ] ~= nil then
         LocationMap["ResourceName"] = LocationParts[2]:lower()
      else
         LocationMap["error"] = "The requested resource is not available."
         Success = false
      end
   else
      -- LocationMap["error"] = "A resource type must be provided!"
      -- Success = false
   end
  
   if LocationParts[3] ~= nil then
      -- If a resource id was provided (and is allowed with the RequestType) then it needs to be a number
      if WebUtils.isValidResourceId( LocationParts[3] ) and RequestType ~= "POST" then
         LocationMap["ResourceId"] = LocationParts[3]
      elseif RequestType == "POST" then
         LocationMap["error"] = "Resource ID's are forbidden with POST create resource requests."
         Success = false
      else
         LocationMap["error"] = "The requested resource id must be a valid numeric value."
         Success = false
      end
   end
	return Success, LocationMap
end

return WebUtils