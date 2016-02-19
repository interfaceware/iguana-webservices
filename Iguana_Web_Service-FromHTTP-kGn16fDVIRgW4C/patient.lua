local Patient = {}

Patient.formatNode = function(PatientNode, Format)
   if Format == 'xml' then 
      -- If XML format as a string.
      return PatientNode:S() 
   else
      -- If JSON just return the node
      return PatientNode
   end
end


Patient.createNode = function(Format)
   local Patient
   if Format == 'xml' then 
      -- Create an blank XML template
      Patient = xml.parse{data="<Patient Id='' FirstName='' LastName='' Gender=''/>"}.Patient
   else
      -- Create a blank JSON table
      Patient = {}
   end
   return Patient
end

return Patient