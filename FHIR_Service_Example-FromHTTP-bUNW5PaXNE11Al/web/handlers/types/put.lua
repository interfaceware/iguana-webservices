local WebUtils  = require 'web.utils'
local Responses = require 'web.responses'

local MappingUtils  = require 'fhir.mappings.utilities'
local Database  = require 'database'



-- Update = PUT https://example.com/path/{resourceType}/{id}
local handlePutRequest = function(Request)
   local Params     = Request.get_params
   local DataFormat = WebUtils.getDataFormat(Request)
   
   local Location = Request.location
   local Valid, LocationMap = WebUtils.validateRequestLocation(Location, "PUT")
   trace(Valid, LocationMap)
   
   if not Valid then
      -- URL found to have invalid parts, send back the appropriate error.
      Responses.sendError(Request, LocationMap["error"], 400)
      return
   end
   
   if LocationMap["ResourceName"] ~= nil and LocationMap["ResourceId"] == nil then
      Responses.sendError(Request,"A resource ID is required for update requests.", 400)
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
   
   -- Check if the specified resource exists already
   local AlreadyExisted = false
   Success, DbResult = Database.queryOne(LocationMap["ResourceName"], LocationMap["ResourceId"])
   if not Success then
      Responses.sendError(Request, "Database error: " .. DbResult["message"], 500)
      return
   elseif #DbResult ~= 0 then
      -- Set the AlreadyExisted so we know what type of response to send back
      -- and set the id of the database entry
      AlreadyExisted = true
      DbEntry.patient[1].Id = DbResult[1].Id
   end
   
   -- Create the new resource entity in the database.
   local Success, DbResult = Database.createOrUpdate(DbEntry)
   
   if Success and AlreadyExisted then
      Responses.send200(Request, "update")
      return
   elseif not Success then
      Responses.sendError(Request, "Database error: " .. DbResult["message"], 500)
      return
   end
   
   -- Resource was new and was successfully created, retrieve the id of the inserted entity.
   local Success, DbResult = Database.getLastId(LocationMap["ResourceName"])
   if not Success then
      Responses.sendError(Request, "Database error: " .. DbResult["message"], 500)
      return
   end
   
   -- Return creation success response to the browser
   local LastId = DbResult[1].LastID:S()
   trace(LastId)
   Responses.send201(Request, LastId)
end

return handlePutRequest