local Handlers = {}

Handlers.default = function(Request)
   net.http.respond{body=HTML.default,code=200,entity_type='text/html'}
end

Handlers.getPatient = function(Request)
   local ResourceUrl = "http://www.hl7.org/fhir/patient-example.json"
   local Data = net.http.get{url=ResourceUrl, live=true}
   local Info = json.parse{data=Data}
   
   local R = 'Patient:'..Info.name[2].given[1].." "..Info.name[1].given[1]
        ..Info.text.div
            
   trace(R)
   net.http.respond{body=R}
end

return Handlers