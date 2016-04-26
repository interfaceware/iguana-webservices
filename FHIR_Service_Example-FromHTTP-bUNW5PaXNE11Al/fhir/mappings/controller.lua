local Mappings = {}

Mappings.json2DB = {}
Mappings.DB2json = {}
Mappings.xml2DB  = {}
Mappings.DB2xml  = {}

-- JSON Mappings : FHIR JSON -> LUA DB TABLE and LUA DB TABLE -> FHIR JSON
Mappings.json2DB.patient = require 'fhir.mappings.json2DB.Patient'
Mappings.DB2json.patient = require 'fhir.mappings.DB2json.Patient'

-- XML Mappings : FHIR XML -> LUA DB TABLE and LUA DB TABLE -> FHIR XML
Mappings.xml2DB.patient = require 'fhir.mappings.xml2DB.Patient'
Mappings.DB2xml.patient = require 'fhir.mappings.DB2xml.Patient'

return Mappings