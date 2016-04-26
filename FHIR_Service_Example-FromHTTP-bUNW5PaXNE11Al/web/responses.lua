local WebUtils = require 'web.utils'

local Responses = {}

local function standardResponseBody(Message)
   if Message == nil then
      error("Must provide a response message!")
   end
   local Response = [[
      {
        "resourceType": "OperationOutcome",
        "text": {
          "status": "generated",
          "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">]] .. Message .. [[</div>"
        }
      }
   ]]
   return Response
end


Responses.send201 = function(Request, NewResourceId)
   -- Resource Created Successfully
   local WebInfo  = iguana.webInfo()
   local Protocol = WebInfo.web_config.use_https and "https://" or "http://"
   local Host     = WebInfo.host
   local Port     = WebInfo.https_channel_server.port
   trace(Protocol, Host, Port)
   
   local Location = Protocol .. Host .. ":" .. Port .. Request.location .. NewResourceId
   trace(Location)
   
   net.http.respond{
      code = 201,
      entity_type = WebUtils.getResponseEntityType(Request),
      headers = {
         "Location:" .. Location,
         "Date:" .. os.ts.gmdate() .. " GMT"
      },
      body = standardResponseBody("Resource entry successfully created")
   }
end


Responses.send200 = function(Request, Operation, Result)
	-- Read/Update Success
   local ResponseBody = ""
   
   if Operation == "read" then
      -- Need to serialize the read result
      local DataFormat = WebUtils.getDataFormat(Request)
      if DataFormat == "xml" then
         ResponseBody = Result:S()
      else
         ResponseBody = json.serialize{data=Result}
      end
   elseif Operation == "update" then
      -- Return the standard success message
         ResponseBody = standardResponseBody("Resource entry successfully updated.")
   else
      error("Operation '" .. Operation .. "' not yet supported to return 200 responses")
   end 
      
   -- TODO : Needs to match the last modified date stored in the response data.
   --        Only put this if the result set going back is empty.
   local LastModified = os.ts.gmdate() .. " GMT"
   
	net.http.respond{
      code = 200,
      entity_type = WebUtils.getResponseEntityType(Request),
      headers = {
         "Last-Modified:" .. LastModified
      },
      body = ResponseBody
   }
end


Responses.send204 = function(Request)
	-- Delete Success
	net.http.respond{
      code = 204,
      entity_type = WebUtils.getResponseEntityType(Request),
      headers = {
         "Date:" .. os.ts.gmdate() .. " GMT"
      },
      body=standardResponseBody("Resource entry successfully deleted (or entry didn't exist).")
   }
end

local function sanitizeErrorString(ErrorString)
   if iguana.isTest() then 
      return ErrorString 
   end
   -- Part of stack trace string inserted into thrown errors
   -- when not running in test. Remove the part we don't want.
   local SanitizedError = ErrorString:gsub("^....*.lua:[0-9]+: ","")
   return SanitizedError
end

-- More comprehensive error responses should be implemented using
-- OperationOutcome error resources to provide additional information. 
-- Follow the guidelines defined at:
-- https://www.hl7.org/fhir/operationoutcome.html
Responses.sendError = function(Request, ErrorString, ErrorCode)
	-- Error
   local SanitizedErrorString = sanitizeErrorString(ErrorString)
   local ResponseBody = standardResponseBody(SanitizedErrorString)
   net.http.respond{
      code = ErrorCode,
      entity_type = WebUtils.getResponseEntityType(Request),
      headers = {
         "Date:" .. os.ts.gmdate() .. " GMT"
      },
      body = ResponseBody
   }
end


return Responses