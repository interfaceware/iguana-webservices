-- This controller builds a map of all resource definitions location in the 
-- fhir/resources/types folder. 

-- All resource keys in this object should be title case.

local FhirDefinitions = {}

FhirDefinitions.Patient = require 'fhir.resources.definitions.types.Patient'
FhirDefinitions.Bundle  = require 'fhir.resources.definitions.types.Bundle'

return FhirDefinitions