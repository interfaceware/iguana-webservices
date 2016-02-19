-- This script sets Iguana up as a web service for patient name requests.
-- For each incoming request, Iguana will call the 'main' function. 

Webpage  = require 'webpage'  -- Contains our default webpage html string.
Database = require 'database' -- Contains the database connectivity code.
Patient  = require 'patient'  -- Contains helper functions for building/formatting patient nodes.

function main(Data)
   -- Parse each incoming request with net.http.parseRequest
   local Request = net.http.parseRequest{data=Data}
   -- Get 'LastName' parameter from request
   if Request.params.LastName then
      -- Send LastName to getPatients function to check database and build result
      local Result, MimeType = getPatients(Request.params.LastName, Request.params.Format)
      -- Return the results with net.http.respond
      net.http.respond{body=Result, entity_type=MimeType}      
      return
   end
	-- If no LastName specified, return the webpage with net.http.respond
   net.http.respond{body=Webpage.text}
end

function getPatients(LastName, Format)   
   -- Search the database connected to in database.lua for the Patients with the requested LastName
   -- NOTE: Database:quote handles quotes in SQL statement for you
   local QueryResult = Database:query('SELECT * FROM Patient WHERE LastName = '..Database:quote(LastName))
   -- Build the result as either XML or JSON using the retrieved QueryResult
   local Result = buildResult(QueryResult, Format)
   -- Format the result for returning to the browser
   return formatResult(Result, Format)
end

function buildResult(QueryResult, Format)
   local Result = {}
   -- Loops through results from the database query
   for i = 1, #QueryResult do 
      -- Create a blank node in either xml or json format
      local PatientNode = Patient.createNode(Format)
      -- Loops each result to get each field and insert result into 'Patient' table
      PatientNode.Id        = QueryResult[i].Id
      PatientNode.FirstName = QueryResult[i].FirstName
      PatientNode.LastName  = QueryResult[i].LastName
      PatientNode.Gender    = QueryResult[i].Gender
      trace(Patient)
      -- Store the current patient node
      Result[i] = Patient.formatNode(PatientNode, Format)
   end
   return Result
end

function formatResult(Result, Format)
   -- If XML, then concatenate results with table.concat
   if Format == 'xml' then
      local Output = "<AllPatients>".. table.concat(Result) .."</AllPatients>"
      return Output, 'text/xml'
   else
      -- if NOT XML then Serialize 'Result' with json.serialize
      return json.serialize{data=Result}, 'text/plain'
   end
end
