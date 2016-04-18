-- This example shows how easy it is to call a FHIR webservice API without
-- a lot of fuss in Iguana.

-- If you have more extensive needs with FHIR then do reach out to us. 
-- We have more elaborate examples of handling FHIR.

HTML = require 'html'

-- We put the handler functions into the 'handlers.lua' module.
local Handlers = require 'handlers'
local HandlerMap = {
   ["/fhir_example/"] = Handlers.default,
   ["/fhir_example/patient/example"] = Handlers.getPatient
}

function main(Data)
   -- Parse a web request from the user of this webservice
   local Request = net.http.parseRequest{data=Data}
   
   -- Make sure it's a GET request
   if Request.method ~= 'GET' then
      net.http.respond{body=HTML.invalidRequest,code=400}
      return
   end
   -- We get the location to look up in our handler map.
   -- The handler map, maps URL paths to functions in our
   -- script.
   local Location = Request.location
   trace(Location)
   
   if HandlerMap[Location] then
      -- Call Handler function for that URL.
      local HandlerFunction = HandlerMap[Location]
      HandlerFunction(Request)
   else 
      -- return error - unknown path
      net.http.respond{body=HTML.invalidRequest,code=400}
   end
end

