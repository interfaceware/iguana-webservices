local handlePutRequest = function(R)
   -- update/create a patient resource
   
   -- parse the resource
   local bOK, xPatient = pcall(xml.parse,R.body)
   local sResourceID = R.location:gsub('/patient',''):sub(3)
   
   if not bOK then
      -- error parsing resource
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
         -- no patient resource
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

         -- map the data from the patient resource to tables that match the database tables
         local tReg, tAddReg, sPatientID = mapPatientData(xPat, sPatientID)

         local dbConn = RISConnection()            
         if dbConn.query then
            -- look for existing resource id
            local sQuery = ''
            if sResourceID:find('%a') then
               -- contains alpha so external resource id
               sQuery = [[SELECT patientid 
               FROM fhir_id
               WHERE fhirid_external = ']] .. sResourceID .. "'"               
            else
               sQuery = [[SELECT patientid 
               FROM fhir_id
               WHERE fhirid = ']] .. sResourceID .. "'"                           
            end
            
            local tResult = dbConn:query{sql=sQuery}
            
            if #tResult > 0 and sPatientID ~= tResult[1].PATIENTID:S() then
               -- duplicate patient
               local xOutcome = fhirCreate('OperationOutcome')
               xOutcome.issue.severity.value = 'error'
               xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
               xOutcome.issue.type.code.value = 'Duplicate patient business-rule'
               xOutcome.issue.details.value = 'Patient ID already exists for different resource or resource identifies different patient'
               local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
               net.http.respond{code = 400, body=sOutcome,entity_type='text/xml'}
               iguana.logWarning('Patient ID already exists')
            elseif #tResult > 0 then
               -- patient exists so update
               -- build the sql merge command from each table
               sRegMerge = db.BuildMerge('registration', 'patientid', tReg)
               sAddRegMerge = db.BuildMerge('additionalregistration', 'patientid', tAddReg)
               
               -- begin transacttion and execute the merge commands
               dbConn:begin()
               
               local bOK, sDBResult = db.pexecute(dbConn, sRegMerge)
               
               if bOK then
                  bOK, sDBResult = db.pexecute(dbConn, sAddRegMerge)
               end
               
               if not bOK then
                  -- merge failure
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
                  -- commit data
                  dbConn:commit()
                  iguana.logInfo('Patient created in database')
                  
                  -- now get the data created and build a new patient resource to return
                  tWhere = {"reg.patientid = '" .. sPatientID .. "'"}
                  local tPatientList = getPatientDataList(dbConn, tWhere)
                  
                  if #tPatientList == 0 then
                     -- not found :-(
                     local xOutcome = fhirCreate('OperationOutcome')
                     xOutcome.issue.severity.value = 'error'
                     xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
                     xOutcome.issue.type.code.value = 'Proccessing'
                     xOutcome.issue.details.value = 'Data could not be written to database'
                     local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
                     net.http.respond{code = 500, body=sOutcome,entity_type='text/xml'}
                  else
                     -- convert the result set to xml so I can re-use the mapping from the client
                     local xPatientList = xml.parse(tPatientList[1]:toXML())
                     local xPatient, sPatientID, sFhirID = MapPatient(xPatientList.Row)
                     
                     local sResponse = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xPatient:fhirDropEmpty():S()
                     iguana.logInfo('Update Patient response: \r\n' .. sResponse) 
                     
                     -- return the response
                     local sLocation = R.headers.Host .. '/patient/@' .. sResourceID
                     net.http.respond{code=200, entity_type='text/xml', headers = {'Content-Location: ' .. sLocation}, body=sResponse}
                  end
               end
            elseif sPatientID == '' then
               -- error no identifier supplied
               local xOutcome = fhirCreate('OperationOutcome')
               xOutcome.issue.severity.value = 'error'
               xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
               xOutcome.issue.type.code.value = 'Patient ID required'
               xOutcome.issue.details.value = 'Patient ID with label MR not supplied'
               local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
               net.http.respond{code=422, body=sOutcome, entity_type='text/xml'}
               iguana.logWarning('Patient ID not supplied')
            elseif not tReg.lastname then
               -- error no last name supplied
               local xOutcome = fhirCreate('OperationOutcome')
               xOutcome.issue.severity.value = 'error'
               xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
               xOutcome.issue.type.code.value = 'Family name required'
               xOutcome.issue.details.value = 'Family name not supplied'
               local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
               net.http.respond{code=422, body=sOutcome, entity_type='text/xml'}
               iguana.logWarning('Family name not supplied')
            else
               -- create patient
               -- check of patient already exists
               sQuery = [[SELECT patientid 
               FROM registration
               WHERE patientid = ']] .. sPatientID .. "'"            
               tResult = dbConn:query{sql=sQuery}
               
               if #tResult > 0 then
                  -- duplicate patient
                  local xOutcome = fhirCreate('OperationOutcome')
                  xOutcome.issue.severity.value = 'error'
                  xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
                  xOutcome.issue.type.code.value = 'Duplicate patient business-rule'
                  xOutcome.issue.details.value = 'Patient ID already exists'
                  local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
                  net.http.respond{code = 400, body=sOutcome,entity_type='text/xml'}
                  iguana.logWarning('Patient ID already exists')
               elseif not sResourceID:find('%a') then
                  -- external resources must contain an alpha
                  local xOutcome = fhirCreate('OperationOutcome')
                  xOutcome.issue.severity.value = 'error'
                  xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
                  xOutcome.issue.type.code.value = 'External ID business-rule'
                  xOutcome.issue.details.value = 'External resource IDs must contain at least one alpha character'
                  local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
                  net.http.respond{code = 400, body=sOutcome,entity_type='text/xml'}
                  iguana.logWarning('Invalid external Resource ID')
               else
                  -- build the merges
                  sRegMerge = db.BuildMerge('registration', 'patientid', tReg)
                  sAddRegMerge = db.BuildMerge('additionalregistration', 'patientid', tAddReg)
                  
                  -- begin the transaction and execute
                  dbConn:begin()
                  
                  local bOK, sDBResult = db.pexecute(dbConn, sRegMerge)
                  
                  if bOK then
                     bOK, sDBResult = db.pexecute(dbConn, sAddRegMerge)
                  end
                  
                  if bOK then
                     -- set the external resource id
                     bOK, sDBResult = db.pexecute(dbConn, [[UPDATE fhir_id
                        SET fhirid_external = ']] .. sResourceID .. [['
                        WHERE patientid = ']] .. sPatientID .. "'")
                  end
                  
                  if not bOK then
                     -- error so rollback
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
                     
                     -- get the patient details just created 
                     tWhere = {"reg.patientid = '" .. sPatientID .. "'"}
                     local tPatientList = getPatientDataList(dbConn, tWhere)
                     
                     if #tPatientList == 0 then
                        -- error, something went wrong
                        local xOutcome = fhirCreate('OperationOutcome')
                        xOutcome.issue.severity.value = 'error'
                        xOutcome.issue.type.system.value = 'http://hl7.org/fhir/issue-type'
                        xOutcome.issue.type.code.value = 'Proccessing'
                        xOutcome.issue.details.value = 'Data could not be written to database'
                        local sOutcome = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xOutcome:fhirDropEmpty():S()
                        net.http.respond{code = 500, body=sOutcome,entity_type='text/xml'}
                     else
                        -- convert the result set to xml so I can re-use the mapping from the client
                        local xPatientList = xml.parse(tPatientList[1]:toXML())
                        local xPatient, sPatientID, sFhirID = MapPatient(xPatientList.Row)
                        
                        local sResponse = '<?xml version="1.0" encoding="UTF-8"?>\r\n' .. xPatient:fhirDropEmpty():S()
                        iguana.logInfo('Create Patient response: \r\n' .. sResponse) 
                        
                        -- return the response
                        local sLocation = R.headers.Host .. '/patient/@' .. sResourceID
                        net.http.respond{code=201, entity_type='text/xml', headers = {'Content-Location: ' .. sLocation}, body=sResponse}
                     end
                  end
               end
               dbConn:close()
            end
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

return handlePutRequest