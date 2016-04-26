local handlePostRequest = function(R)
   -- create the patient resource
   -- parse the resource
   local bOK, xPatient = pcall(xml.parse,R.body)

   if not bOK then
      -- parse failed
      local xOutcome = fhirCreate('OperationOutcome')
      xOutcome.issue.severity.value = 'error'
      xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
      xOutcome.issue.type.code.value = 'XML Structure'
      xOutcome.issue.details.value = 'Unable to parse XML'
      local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()

      net.http.respond{code = 400, body=sOutcome,entity_type='text/xml'} 
      iguana.logWarning('Unable to parse XML /r/n' .. R.body)      
   else
      if not xPatient.Patient then
         -- patient resource not found
         local xOutcome = fhirCreate('OperationOutcome')
         xOutcome.issue.severity.value = 'error'
         xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
         xOutcome.issue.type.code.value = 'Patient resource not-found'
         xOutcome.issue.details.value = 'Patient details missing'
         local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
         net.http.respond{code = 400, body=sOutcome,entity_type='text/xml'}
         iguana.logWarning('Patient details missing')         
      else
         local xPat = xPatient.Patient
         -- map the data from the resource to tables that match the database
         local tReg, tAddReg, sPatientID = mapPatientData(xPat, sPatientID)

         if sPatientID == '' then
            -- no patient id 
            local xOutcome = fhirCreate('OperationOutcome')
            xOutcome.issue.severity.value = 'error'
            xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
            xOutcome.issue.type.code.value = 'Patient ID required'
            xOutcome.issue.details.value = 'Patient ID with label MR not supplied'
            local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()

            net.http.respond{code=422, body=sOutcome, entity_type='text/xml'}
            iguana.logWarning('Patient ID not supplied')
         elseif not tReg.lastname then
            -- no last name
            local xOutcome = fhirCreate('OperationOutcome')
            xOutcome.issue.severity.value = 'error'
            xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
            xOutcome.issue.type.code.value = 'Family name required'
            xOutcome.issue.details.value = 'Family name not supplied'
            local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()

            net.http.respond{code=422, body=sOutcome, entity_type='text/xml'}
            iguana.logWarning('Family name not supplied')
         else
            -- check if patient exists
            local dbConn = RISConnection()            
            if dbConn.query then
               local sQuery = [[SELECT patientid 
               FROM registration
               WHERE patientid = ']] .. sPatientID .. "'"            
               local tResult = dbConn:query{sql=sQuery}
               
               if bOK and #tResult > 0 then
                  -- patient already exists
                  local xOutcome = fhirCreate('OperationOutcome')
                  xOutcome.issue.severity.value = 'error'
                  xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
                  xOutcome.issue.type.code.value = 'Duplicate patient business-rule'
                  xOutcome.issue.details.value = 'Patient ID already exists'
                  local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
                  net.http.respond{code = 400, body=sOutcome,entity_type='text/xml'}
                  iguana.logWarning('Patient ID already exists')
               else
                  -- build merge commands
                  sRegMerge = db.BuildMerge('registration', 'patientid', tReg)
                  sAddRegMerge = db.BuildMerge('additionalregistration', 'patientid', tAddReg)
                  
                  -- begin transaction and execure merge commands
                  dbConn:begin()
                  
                  local bOK, sDBResult = db.pexecute(dbConn, sRegMerge)
                  
                  if bOK then
                     bOK, sDBResult = db.pexecute(dbConn, sAddRegMerge)
                  end
                  
                  
                  if not bOK then
                     -- db error
                     dbConn:rollback()
                     iguana.logInfo('Database failure: /r/n' .. sDBResult)
                     
                     local xOutcome = fhirCreate('OperationOutcome')
                     xOutcome.issue.severity.value = 'error'
                     xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
                     xOutcome.issue.type.code.value = 'Proccessing'
                     xOutcome.issue.details.value = 'Data could not be written to database'
                     local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
                     net.http.respond{code = 500, body=sOutcome,entity_type='text/xml'}
                  else
                     -- commit the data
                     dbConn:commit()
                     iguana.logInfo('Patient created in database')
                     
                     -- get the patient created
                     tWhere = {"reg.patientid = '" .. sPatientID .. "'"}
                     local tPatientList = getPatientDataList(dbConn, tWhere)
                     
                     if #tPatientList == 0 then
                        -- not found, something went wrong
                        local xOutcome = fhirCreate('OperationOutcome')
                        xOutcome.issue.severity.value = 'error'
                        xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
                        xOutcome.issue.type.code.value = 'Proccessing'
                        xOutcome.issue.details.value = 'Data could not be written to database'
                        local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
                        net.http.respond{code = 500, body=sOutcome,entity_type='text/xml'}
                     else
                        -- convert result set to xml so I can re-use the mapping from the client
                        local xPatientList = xml.parse(tPatientList[1]:toXML())
                        local xPatient, sPatientID, sFhirID = MapPatient(xPatientList.Row)
                        
                        local sResponse = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xPatient:fhirDropEmpty():S()
                        iguana.logInfo('Create Patient response: \r\n' .. sResponse) 
                        
                        -- get the resource id for the new patient record
                        sQuery = [[SELECT * 
                        FROM fhir_id
                        WHERE patientid = ']] .. sPatientID .. "'"            
                        tResult = dbConn:query{sql=sQuery}
                        sFhirID = tResult[1].FHIRID:S()
                        
                        -- return the respoonse
                        local sLocation = R.headers.Host .. '/patient/@' .. sFhirID
                        net.http.respond{code=201, entity_type='text/xml', headers = {'Content-Location: ' .. sLocation}, body=sResponse}
                     end
                  end
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
      end
   end
end

return handlePostRequest