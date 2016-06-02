local WebUtils  = require 'web.utils'
local Responses = require 'web.responses'

local MappingUtils  = require 'fhir.mappings.utilities'
local Database  = require 'database'



local function getDbErrorMessage(DbResult)
   if DbResult["message"] ~= nil then
      return DbResult["message"]
   else
      return DbResult
   end
end


-- Create = POST https://example.com/path/{resourceType}
-- NOTE: This example does not support POST search requests.
--      (i.e. POST  https://example.com/path/[type]/_search{?[parameters] )
local handlePostRequest = function(Request)
   trace(Request)
   local Params      = Request.get_params
   local DataFormat  = WebUtils.getDataFormat(Request)
   
   local Location = Request.location
   local Valid, LocationMap = WebUtils.validateRequestLocation(Location, "POST")
   trace(Valid, LocationMap)
   
   if not Valid then
      -- URL found to have invalid parts, send back the appropriate error.
      Responses.sendError(Request, LocationMap["error"], 400)
      return
   end
   
   if LocationMap["ResourceId"] ~= nil then
      Responses.sendError(Request, "Resource ID path element is not allowed when performing a create operation.", 400)
      return
   end
   
   -- Attempt to parse the request body into a valid format (json/xml).
   -- The actual data will be validated before mapping into a database object.
   local ParseSuccess, FhirObject = pcall(
      function()
         if DataFormat == "xml" then
            return xml.parse{data=Request.body}
         else
            return json.parse{data=Request.body}   
         end
      end
   )
   
   if not ParseSuccess then
      -- Parsing error. FhirObject is an error message.
      Responses.sendError(Request, FhirObject, 400)
      return
   end
   
   -- Get a populated Database entry table from the posted FHIR body content. 
   local Success, DbEntry = MappingUtils.getDbEntryFromFhirObject(DataFormat, LocationMap["ResourceName"], FhirObject)
   
   -- An error signifies the post body was missing a required value. DbEntry is an error message.
   if not Success then
      Responses.sendError(Request, DbEntry, 400)
      return
   end
   
   -- Create the new resource entity in the database.
   local Success, DbResult = Database.createOrUpdate(DbEntry)
  
   if not Success then
      Responses.sendError(Request, "Database error: " .. getDbErrorMessage(DbResult), 500)
      return
   end
 
   -- After successful create, retrieve the id of the inserted entity.
   local Success, DbResult = Database.getLastId(LocationMap["ResourceName"])
   
   if not Success then
      Responses.sendError(Request, "Database error: " .. DbResult["message"], 500)
      return
   end
   
   local LastId = DbResult[1].LastID:S()
   trace(LastId)
   
   -- Return creation success response to the browser
   Responses.send201(Request, LastId)
end


return handlePostRequest