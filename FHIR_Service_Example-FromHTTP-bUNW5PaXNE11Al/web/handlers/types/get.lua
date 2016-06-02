local WebUtils  = require 'web.utils'
local Responses = require 'web.responses'

local MappingUtils  = require 'fhir.mappings.utilities'
local JSONutilities = require 'fhir.resources.utilities.json'
local Database      = require 'database'



-- Read   = GET https://example.com/path/{resourceType}/{id}
-- Search = GET https://example.com/path/{resourceType}/
--   NOTE : For this example, search only works to retrieve all entries
--         for a resource type. Searching on specific parameters isn't supported.
local handleGetRequest = function(Request)
   trace(Request)
   local Params     = Request.get_params
   local DataFormat = WebUtils.getDataFormat(Request)
   
   local Location = Request.location
   local Valid, LocationMap = WebUtils.validateRequestLocation(Location, "GET")
   trace(Valid, LocationMap)
   
   if not Valid then
      -- URL found to have invalid parts, send back the appropriate error.
      Responses.sendError(Request, LocationMap["error"], 400)
      return
   end
   
   -- Determine the type of GET operation to be performed  
   local LocationMapSize = JSONutilities.mapSize(LocationMap)
   local SearchOperation = LocationMapSize == 1
   local ReadOperation   = LocationMapSize == 2
   
   
   local DbResult = ""
   local Success  = false
  
   if SearchOperation then
      -- No id specified, do search on all resource entities
      Success, DbResult = Database.queryAll(LocationMap["ResourceName"])      
   elseif ReadOperation then
      -- A resource id has been specified, do a search for that specific resource entity
      Success, DbResult = Database.queryOne(LocationMap["ResourceName"], LocationMap["ResourceId"])
      if Success and #DbResult == 0 then
         -- Return 404 for read on unknown resource id
         Responses.sendError(Request, "Cannot find " .. LocationMap["ResourceName"] .. " with id " .. LocationMap["ResourceId"], 404)
         return
      end
   else
      Responses.sendError(Request, "Invalid URL path format", 400)
      return
   end

   -- If database read failed, send back error and error message
   if not Success then
      Responses.sendError(Request, "Database error: " .. DbResult["message"], 500)
      return
   end
   
   -- Build a formatted FHIR object from the database read results
   local FhirResult = MappingUtils.getFhirFromDbResults(DataFormat, LocationMap["ResourceName"], DbResult)
   trace(FhirResult)
   
   local Response = {}
   
   if SearchOperation then
     -- Need to put all search results into a bundle resource as per
     -- https://www.hl7.org/fhir/bundle.html and https://www.hl7.org/fhir/overview-dev.html#1.8.1.10
      Response = MappingUtils.putFhirResultsIntoFhirBundle(DataFormat, FhirResult)
   else
      Response = FhirResult[1]
   end
   
   -- Send success message back to the browser with the result.
   Responses.send200(Request, "read", Response)
end


return handleGetRequest