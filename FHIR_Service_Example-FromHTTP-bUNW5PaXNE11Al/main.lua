-- This channel is an example web service that allows for health care information to be accessed 
-- and manipulated using a FHIR based API. 
-- It supports a basic set of FHIR operations like read, search, update, delete, and create. 
-- These operations support both XML and JSON data formats.

-- The "FHIR Client" channel is designed to work with this FHIR Server channel
-- (though you can also use/create another channel to use this FHIR Server channel)

-- http://help.interfaceware.com/v6/fhir-client-and-server

local Handlers  = require 'web.handlers.controller'
local WebUtils  = require 'web.utils'
local Database  = require 'database'

-- See http://help.interfaceware.com/v6/fhir-server
-- This example currently supports the following FHIR operations:
--      Create = POST https://example.com/path/{resourceType}
--      Read   = GET https://example.com/path/{resourceType}/{id}
--      Update = PUT https://example.com/path/{resourceType}/{id}
--      Delete = DELETE https://example.com/path/{resourceType}/{id}
--      Search = GET https://example.com/path/{resourceType}?search parameters... [No search parameters supported yet, returns everything]

-- However, there are more operations that are defined under the standard:
--      History = GET https://example.com/path/{resourceType}/{id}/_history
--      Transaction = POST https://example.com/path/ (POST a tranasction bundle to the system)
--      Operation = GET https://example.com/path/{resourceType}/{id}/${opname}

-- An example request to get a patient resource record with id = 2 with 
-- Iguana running on localhost and https port 6544 would be as follows: 
-- http://localhost:6544/fhir/patient/2

-- For more information: https://www.hl7.org/fhir/overview-dev.html

function main(Data)
   local Request = net.http.parseRequest{data=Data}
   local RequestType = Request.method
   trace(RequestType)
   
   if iguana.isTest() then
      -- Check each time it exists, in case we delete it during testing.
      -- Will just copy over the default one and start fresh.
      Database.ensureWorkingDatabaseExists()
   end
   
   
   if RequestType == 'GET' then
      Handlers.handleGet(Request)
      
   elseif RequestType == 'POST' then
      Handlers.handlePost(Request)
      
   elseif RequestType == 'PUT' then
      Handlers.handlePut(Request)
      
   elseif RequestType == 'DELETE' then
      Handlers.handleDelete(Request)
   else
      WebUtils.sendError(Request, "Request type " .. RequestType .. " is invalid", 405)
      iguana.logWarning(RequestType .. ' not supported')
   end
end
