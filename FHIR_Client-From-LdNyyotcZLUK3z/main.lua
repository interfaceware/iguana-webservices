-- This is a simple script that will demonstrate 5 different FHIR operation calls to the FHIR server channel.
-- The new patients that will be created (in both json and xml) are located in FhirPatient.lua

-- This script also requires the the "FHIR Server" to be running

-- http://help.interfaceware.com/v6/fhir-client-and-server

local FhirPatients = require "FhirPatient"

local function buildRequestUrlBeginning()
   local WebInfo   = iguana.webInfo()
   local UseHttps  = WebInfo.https_channel_server.use_https
   local Port      = WebInfo.https_channel_server.port
   local Protocol  = false and "https://" or "http://"
   
   local Url = Protocol .. WebInfo.ip .. ":" .. Port .. "/"
   trace(Url)
   return Url
end


function main()
   
   -- Set to true to run the below FHIR server tests and examine the results 
   -- (They will take a few seconds)
   local RunTests = true
   
   if RunTests then
      
      local UrlBeginning = buildRequestUrlBeginning()
      
      -----------------------------------
      --------- Read Operation ----------
      ------------------------------------
      -- Retrieve the same patient in xml format
      local Patient1XmlString, XmlReadCode, XmlReadHeaders  = net.http.get{
         url= UrlBeginning .. "fhir/patient/1", parameters={_format = "xml"},
         live=RunTests}
      trace(Patient1XmlString)
      trace(XmlReadCode)

      -- Perform a get request for patient with id = 1 (default format is json)
      local Patient1JsonString, JsonReadCode, JsonReadHeaders = net.http.get{
         url= UrlBeginning .. "fhir/patient/1", live=RunTests}
      trace(Patient1JsonString)
      trace(JsonReadCode)

      ------------------------------------
      --------- Update Operation ---------
      ------------------------------------
      -- Parse the resultant json, and read the "active" flag.
      local Patient1Json = json.parse{data=Patient1JsonString}
      local IsActive = Patient1Json.active
      trace(IsActive)

      -- Update the patient's active flag to the opposite of what it was before
      Patient1Json.active = not IsActive
      trace(Patient1Json.active)   
      local NewPatient1JsonString = json.serialize{data=Patient1Json}

      -- Perform an update operation using a put request to update the patients 
      -- info on the server using the altered json data.
      local UpdateResult, UpdateCode, UpdateHeaders = net.http.put{
         url= UrlBeginning .. "fhir/patient/1", data=NewPatient1JsonString, 
         live=RunTests}

      --  A response code of 200 means the update was successful
      trace(UpdateCode)
      
      -- Will be an operation result explaining that the 
      -- "Resource entry successfully updated"
      trace(UpdateResult)

      -----------------------------------
      --------- Search Operation --------
      -----------------------------------
      -- Perform a search operation that will retrieve all entries for the patient 
      -- resource (the result is a resource bundle containing all the results)
      local PatientBundleJsonString, SearchCode, SearchHeaders = net.http.get{
         url= UrlBeginning .. "fhir/patient/", 
         live=RunTests}
      
      -- The result is a FHIR resource bundle containing each patient entry found.
      trace(PatientBundleJsonString)
      trace(SearchCode)

      -----------------------------------
      --------- Create Operation --------
      -----------------------------------
      -- Perform a post request and create a new patient using json
      local PostResult, PostCode, PostHeaders = net.http.post{url= UrlBeginning .. 
         "fhir/patient/", body=FhirPatients.json,  
         live=RunTests}

      -- A response code of 201 means the resource was successfully created.
      trace(PostCode)

      -- Response data is an FHIR operation result detailing (if we got a 201 code)
      -- that the "Resource entry successfully created" 
      -- (or error if something went wrong)
      trace(PostResult)

      -- The new resource can be found at the location specified by the 
      -- location header. (if success)
      trace(PostHeaders.Location)

      -----------------------------------
      --------- Delete Operation --------
      -----------------------------------
      -- Perform a delete operation to remove the newly created patient
      local DeleteResult, DeleteCode, DeleteHeaders = net.http.delete{
         url=PostHeaders.Location,  
         live=RunTests}

      --  A response code of 204 means the resource was successfully 
      -- removed or never existed
      trace(DeleteCode)

      --  Will be empty if it was a success
      trace(DeleteResult)
   end
end