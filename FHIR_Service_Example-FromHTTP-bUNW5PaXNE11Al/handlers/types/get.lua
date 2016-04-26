local handleGetRequest = function(R)
   local dbConn = RISConnection()
   if dbConn.query then
      local tWhere = {}
      if R.location:find('@') then
         -- Return specific resource
         -- External reesource ID if includes alpha
         if R.location:split('@')[2]:find('%a') then
            table.insert(tWhere, "fhir.fhirid_external = '" .. R.location:split('@')[2] .. "'")         
         else
            table.insert(tWhere, 'fhir.fhirid = ' .. R.location:split('@')[2])
         end
         
         -- Get the rows from the database
         local tPatientList = getPatientDataList(dbConn, tWhere)
         if #tPatientList > 0 then
            -- map the patient list to xml so I can reuse the mapping function from the client channel
            local xPatientList = xml.parse(tPatientList[1]:toXML())
            -- map the patient details into the fhir resource
            local xPatient, sPatientID, sFhirID = MapPatient(xPatientList.Row)
            
            local sResponse = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xPatient:fhirDropEmpty():S()
            iguana.logInfo('Query response: \r\n' .. sResponse) 
            -- return resource
            net.http.respond{entity_type='text/xml', body=sResponse}
         else
            -- no matches
            local xOutcome = fhirCreate('OperationOutcome')
            xOutcome.issue.severity.value = 'error'
            xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
            xOutcome.issue.type.code.value = 'Patient resource not-found'
            xOutcome.issue.details.value = 'Resource not found'
            
            local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
            
            iguana.logWarning('Resource not found \r\n' .. sResponse) 
            
            net.http.respond{code=404,body=sOutcome,entity_type='text/xml'}
         end
      else
         -- search database
         if R.params.count then
            sReturnLimit = R.params.count
         end
         -- set the selected rows by the page number
         if not R.params.page then
            table.insert(tWhere, 'ROWNUM <= ' .. sReturnLimit)
         else
            nPage = tonumber(R.params.page)
            table.insert(tWhere, 'ROWNUM >= ' .. (nPage-1) * sReturnLimit + 1 .. ' AND ROWNUM <= ' .. nPage * sReturnLimit )
         end
         
         if R.location == '/patient/search' then
            -- build the where conditions for the sql query
            for sKey, sValue in pairs(R.params) do
               -- only equivelance supported
               if sKey == '_format' then
               elseif sKey == '_id' and sValue:find('%a') then
                  table.insert(tWhere, "fhir.fhirid_external = '" .. sValue .. "'") 
               elseif sKey == '_id' then
                  table.insert(tWhere, "fhir.fhirid = " .. sValue) 
               elseif sKey == 'family' then
                  table.insert(tWhere, "lower(reg.lastname) like '%" .. sValue:lower() .. "%'") 
               elseif sKey == 'given' then
                  table.insert(tWhere, "lower(reg.firstname) like '%" .. sValue:lower() .. "%'") 
               elseif sKey == 'name' then
                  table.insert(tWhere, "lower(reg.firstname || reg.lastname) like '%" .. sValue:lower() .. "%'") 
               elseif sKey == 'gender' then
                  local sSearch = 'Unknown'
                  if sValue:upper() == 'M' then
                     sSearch = 'Male'
                  elseif sValue:upper() == 'F' then
                     sSearch = 'Female'
                  end
                  table.insert(tWhere, "lower(reg.sex) =  '" .. sSearch:lower() .. "'") 
               elseif sKey == 'birthdate' then
                  table.insert(tWhere, "reg.dob = to_date('" .. sValue:sub(1,10) .. "', 'yyyy-mm-dd')") 
               elseif sKey == 'address' then
                  table.insert(tWhere, [[lower(reg.street || reg.street2 || reg.city || reg.zip || reg.state
                     || reg.country) like '%]] .. sValue:lower() .. "%'") 
               elseif sKey == 'identifier' then
                  -- include Australian specific identifiers
                  table.insert(tWhere, "(reg.patientid = '" .. sValue .. [['
                     or addreg.medicarenumber = ']] .. sValue .. [['
                     or addreg.dvanumber = ']] .. sValue .. [['
                     or addreg.safetynet = ']] .. sValue .. [['
                     or addreg.pensionnumber = ']] .. sValue .. [['
                     or addreg.HCCnumber = ']] .. sValue .. "')") 
               end
            end
         end
         -- query the database
         local tPatientList = getPatientDataList(dbConn, tWhere)
         
         -- create the bundle
         local xResponse = fhirCreate('Atom')
         -- insert the patient resources into bundle
         mapPatientResponse(tPatientList, xResponse, R)
         -- remove any xml nodes that are empty
         xResponse:fhirDropEmpty()
         
         local sResponse = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xResponse:S()
         iguana.logInfo('Query response: \r\n' .. sResponse) 
         -- send the response
         net.http.respond{entity_type='application/xml', body=sResponse}
         
      end
      dbConn:close()
   else
      iguana.logInfo('Database connection failure.' )
      
      local xOutcome = fhirCreate('OperationOutcome')
      xOutcome.issue.severity.value = 'error'
      xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
      xOutcome.issue.type.code.value = 'Proccessing'
      xOutcome.issue.details.value = 'Data could not be written to database'
      local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
      net.http.respond{code = 500, body=sOutcome,entity_type='text/xml'}
   end
end

return handleGetRequest