local WebUtils  = require 'web.utils'
local Responses = require 'web.responses'
local Database  = require 'database'



-- Delete = DELETE https://example.com/path/{resourceType}/{id}
local handleDeleteRequest = function(Request)
   local Params     = Request.get_params
   local DataFormat = WebUtils.getDataFormat(Request)
   
   local Location = Request.location
   local Valid, LocationMap = WebUtils.validateRequestLocation(Location, "DELETE")
   trace(Valid, LocationMap)
   
   if not Valid then
      -- URL found to have invalid parts, send back the appropriate error.
      Responses.sendError(Request, LocationMap["error"], 400)
      return
   end
   
   if LocationMap["ResourceName"] ~= nil and LocationMap["ResourceId"] == nil then
      Responses.sendError(Request,"Bulk deletion of all resource entities not allowed.", 405)
      return
   end
   
   -- Delete the resource entity from the database
   local Success, DbResult = Database.deleteOne(LocationMap["ResourceName"], LocationMap["ResourceId"])
  
   if not Success then
      -- If database delete failed, send back error and error message
      Responses.sendError(Request, "Database error: " .. DbResult["message"], 500)
   else
      -- Otherwise it succeeded and we send back a 204 response to indicate the 
      -- resource wss successfully deleted or didn;'t exist at all.
      -- https://www.hl7.org/fhir/http.html#delete
      Responses.send204(Request)
   end
end


return handleDeleteRequest
   
   