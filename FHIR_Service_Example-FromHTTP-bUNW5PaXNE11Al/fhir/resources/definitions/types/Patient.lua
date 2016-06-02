-- Taken directly from:
-- https://www.hl7.org/fhir/patient.profile.json

local Patient = {}

Patient.json =
[[
{
  "resourceType": "StructureDefinition",
  "id": "Patient",
  "meta": {
    "lastUpdated": "2015-10-24T07:41:03.495+11:00"
  },
  "text": {
    "status": "generated",
    "div": "<div>!-- Snipped for Brevity --></div>"
  },
  "extension": [
    {
      "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm",
      "valueInteger": 3
    }
  ],
  "url": "http://hl7.org/fhir/StructureDefinition/Patient",
  "name": "Patient",
  "status": "draft",
  "publisher": "Health Level Seven International (Patient Administration)",
  "contact": [
    {
      "telecom": [
        {
          "system": "other",
          "value": "http://hl7.org/fhir"
        }
      ]
    },
    {
      "telecom": [
        {
          "system": "other",
          "value": "http://www.hl7.org/Special/committees/pafm/index.cfm"
        }
      ]
    }
  ],
  "date": "2015-10-24T07:41:03+11:00",
  "description": "Base StructureDefinition for Patient Resource",
  "requirements": "Tracking patient is the center of the healthcare process.",
  "fhirVersion": "1.0.2",
  "mapping": [
    {
      "identity": "cda",
      "uri": "http://hl7.org/v3/cda",
      "name": "CDA (R2)"
    },
    {
      "identity": "rim",
      "uri": "http://hl7.org/v3",
      "name": "RIM"
    },
    {
      "identity": "w5",
      "uri": "http://hl7.org/fhir/w5",
      "name": "W5 Mapping"
    },
    {
      "identity": "v2",
      "uri": "http://hl7.org/v2",
      "name": "HL7 v2"
    },
    {
      "identity": "loinc",
      "uri": "http://loinc.org",
      "name": "LOINC"
    }
  ],
  "kind": "resource",
  "abstract": false,
  "base": "http://hl7.org/fhir/StructureDefinition/DomainResource",
  "snapshot": {
    "element": [
      {
        "path": "Patient",
        "short": "Information about an individual or animal receiving health care services",
        "definition": "Demographics and other administrative information about an individual or animal receiving care or other health-related services.",
        "alias": [
          "SubjectOfCare Client Resident"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "DomainResource"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "ClinicalDocument.recordTarget.patientRole"
          },
          {
            "identity": "rim",
            "map": "Patient[classCode=PAT]"
          },
          {
            "identity": "w5",
            "map": "administrative.individual"
          }
        ]
      },
      {
        "path": "Patient.id",
        "short": "Logical id of this artifact",
        "definition": "The logical id of the resource, as used in the URL for the resource. Once assigned, this value never changes.",
        "comments": "The only time that a resource does not have an id is when it is being submitted to the server using a create operation. Bundles always have an id, though it is usually a generated UUID.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "id"
          }
        ],
        "isSummary": true
      },
      {
        "path": "Patient.meta",
        "short": "Metadata about the resource",
        "definition": "The metadata about the resource. This is content that is maintained by the infrastructure. Changes to the content may not always be associated with version changes to the resource.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "Meta"
          }
        ],
        "isSummary": true
      },
      {
        "path": "Patient.implicitRules",
        "short": "A set of rules under which this content was created",
        "definition": "A reference to a set of rules that were followed when the resource was constructed, and which must be understood when processing the content.",
        "comments": "Asserting this rule set restricts the content to be only understood by a limited set of trading partners. This inherently limits the usefulness of the data in the long term. However, the existing health eco-system is highly fractured, and not yet ready to define, collect, and exchange data in a generally computable sense. Wherever possible, implementers and/or specification writers should avoid using this element as much as possible.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "uri"
          }
        ],
        "isModifier": true,
        "isSummary": true
      },
      {
        "path": "Patient.language",
        "short": "Language of the resource content",
        "definition": "The base language in which the resource is written.",
        "comments": "Language is provided to support indexing and accessibility (typically, services such as text to speech use the language tag). The html language tag in the narrative applies  to the narrative. The language tag on the resource may be used to specify the language of other presentations generated from the data in the resource  Not all the content has to be in the base language. The Resource.language should not be assumed to apply to the narrative automatically. If a language is specified, it should it also be specified on the div element in the html (see rules in HTML5 for information about the relationship between xml:lang and the html lang attribute).",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "code"
          }
        ],
        "binding": {
          "strength": "required",
          "description": "A human language.",
          "valueSetUri": "http://tools.ietf.org/html/bcp47"
        }
      },
      {
        "path": "Patient.text",
        "short": "Text summary of the resource, for human interpretation",
        "definition": "A human-readable narrative that contains a summary of the resource, and may be used to represent the content of the resource to a human. The narrative need not encode all the structured data, but is required to contain sufficient detail to make it \"clinically safe\" for a human to just read the narrative. Resource definitions may define what content should be represented in the narrative to ensure clinical safety.",
        "comments": "Contained resources do not have narrative. Resources that are not contained SHOULD have a narrative.",
        "alias": [
          "narrative",
          "html",
          "xhtml",
          "display"
        ],
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "Narrative"
          }
        ],
        "condition": [
          "dom-1"
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "Act.text?"
          }
        ]
      },
      {
        "path": "Patient.contained",
        "short": "Contained, inline Resources",
        "definition": "These resources do not have an independent existence apart from the resource that contains them - they cannot be identified independently, and nor can they have their own independent transaction scope.",
        "comments": "This should never be done when the content can be identified properly, as once identification is lost, it is extremely difficult (and context dependent) to restore it again.",
        "alias": [
          "inline resources",
          "anonymous resources",
          "contained resources"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Resource"
          }
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "N/A"
          }
        ]
      },
      {
        "path": "Patient.extension",
        "short": "Additional Content defined by implementations",
        "definition": "May be used to represent additional information that is not part of the basic definition of the resource. In order to make the use of extensions safe and manageable, there is a strict set of governance  applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.",
        "comments": "There can be no stigma associated with the use of extensions by any application, project, or standard - regardless of the institution or jurisdiction that uses or defines the extensions.  The use of extensions is what allows the FHIR specification to retain a core level of simplicity for everyone.",
        "alias": [
          "extensions",
          "user content"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Extension"
          }
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "N/A"
          }
        ]
      },
      {
        "path": "Patient.modifierExtension",
        "short": "Extensions that cannot be ignored",
        "definition": "May be used to represent additional information that is not part of the basic definition of the resource, and that modifies the understanding of the element that contains it. Usually modifier elements provide negation or qualification. In order to make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions.",
        "comments": "There can be no stigma associated with the use of extensions by any application, project, or standard - regardless of the institution or jurisdiction that uses or defines the extensions.  The use of extensions is what allows the FHIR specification to retain a core level of simplicity for everyone.",
        "alias": [
          "extensions",
          "user content"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Extension"
          }
        ],
        "isModifier": true,
        "mapping": [
          {
            "identity": "rim",
            "map": "N/A"
          }
        ]
      },
      {
        "path": "Patient.identifier",
        "short": "An identifier for this patient",
        "definition": "An identifier for this patient.",
        "requirements": "Patients are almost always assigned specific numerical identifiers.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Identifier"
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": ".id"
          },
          {
            "identity": "v2",
            "map": "PID-3"
          },
          {
            "identity": "rim",
            "map": "id"
          },
          {
            "identity": "w5",
            "map": "id"
          }
        ]
      },
      {
        "path": "Patient.active",
        "short": "Whether this patient's record is in active use",
        "definition": "Whether this patient record is in active use.",
        "comments": "Default is true. If a record is inactive, and linked to an active record, then future patient/record updates should occur on the other patient.",
        "requirements": "Need to be able to mark a patient record as not to be used because it was created in error.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "boolean"
          }
        ],
        "defaultValueBoolean": true,
        "isModifier": true,
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "statusCode"
          },
          {
            "identity": "w5",
            "map": "status"
          }
        ]
      },
      {
        "path": "Patient.name",
        "short": "A name associated with the patient",
        "definition": "A name associated with the individual.",
        "comments": "A patient may have multiple names with different uses or applicable periods. For animals, the name is a \"HumanName\" in the sense that is assigned and used by humans and has the same patterns.",
        "requirements": "Need to be able to track the patient by multiple names. Examples are your official name and a partner name.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "HumanName"
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": ".patient.name"
          },
          {
            "identity": "v2",
            "map": "PID-5, PID-9"
          },
          {
            "identity": "rim",
            "map": "name"
          }
        ]
      },
      {
        "path": "Patient.telecom",
        "short": "A contact detail for the individual",
        "definition": "A contact detail (e.g. a telephone number or an email address) by which the individual may be contacted.",
        "comments": "A Patient may have multiple ways to be contacted with different uses or applicable periods.  May need to have options for contacting the person urgently and also to help with identification. The address may not go directly to the individual, but may reach another party that is able to proxy for the patient (i.e. home phone, or pet owner's phone).",
        "requirements": "People have (primary) ways to contact them in some way such as phone, email.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "ContactPoint"
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": ".telecom"
          },
          {
            "identity": "v2",
            "map": "PID-13, PID-14, PID-40"
          },
          {
            "identity": "rim",
            "map": "telecom"
          }
        ]
      },
      {
        "path": "Patient.gender",
        "short": "male | female | other | unknown",
        "definition": "Administrative Gender - the gender that the patient is considered to have for administration and record keeping purposes.",
        "comments": "The gender may not match the biological sex as determined by genetics, or the individual's preferred identification. Note that for both humans and particularly animals, there are other legitimate possibilities than M and F, though the vast majority of systems and contexts only support M and F.  Systems providing decision support or enforcing business rules should ideally do this on the basis of Observations dealing with the specific gender aspect of interest (anatomical, chromosonal, social, etc.)  However, because these observations are infrequently recorded, defaulting to the administrative gender is common practice.  Where such defaulting occurs, rule enforcement should allow for the variation between administrative and biological, chromosonal and other gender aspects.  For example, an alert about a hysterectomy on a male should be handled as a warning or overrideable error, not a \"hard\" error.",
        "requirements": "Needed for identification of the individual, in combination with (at least) name and birth date. Gender of individual drives many clinical processes.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "code"
          }
        ],
        "isSummary": true,
        "binding": {
          "strength": "required",
          "description": "The gender of a person used for administrative purposes.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/administrative-gender"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": ".patient.administrativeGenderCode"
          },
          {
            "identity": "v2",
            "map": "PID-8"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/administrativeGender"
          }
        ]
      },
      {
        "path": "Patient.birthDate",
        "short": "The date of birth for the individual",
        "definition": "The date of birth for the individual.",
        "comments": "At least an estimated year should be provided as a guess if the real DOB is unknown  There is a standard extension \"patient-birthTime\" available that should be used where Time is required (such as in maternaty/infant care systems).",
        "requirements": "Age of the individual drives many clinical processes.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "date"
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "loinc",
            "map": "21112-8"
          },
          {
            "identity": "cda",
            "map": ".patient.birthTime"
          },
          {
            "identity": "v2",
            "map": "PID-7"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/birthTime"
          }
        ]
      },
      {
        "path": "Patient.deceased[x]",
        "short": "Indicates if the individual is deceased or not",
        "definition": "Indicates if the individual is deceased or not.",
        "comments": "If there's no value in the instance it means there is no statement on whether or not the individual is deceased. Most systems will interpret the absence of a value as a sign of the person being alive.",
        "requirements": "The fact that a patient is deceased influences the clinical process. Also, in human communication and relation management it is necessary to know whether the person is alive.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "boolean"
          },
          {
            "code": "dateTime"
          }
        ],
        "isModifier": true,
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PID-30  (bool) and PID-29 (datetime)"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/deceasedInd, player[classCode=PSN|ANM and determinerCode=INSTANCE]/deceasedTime"
          }
        ]
      },
      {
        "path": "Patient.address",
        "short": "Addresses for the individual",
        "definition": "Addresses for the individual.",
        "comments": "Patient may have multiple addresses with different uses or applicable periods.",
        "requirements": "May need to keep track of patient addresses for contacting, billing or reporting requirements and also to help with identification.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Address"
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": ".addr"
          },
          {
            "identity": "v2",
            "map": "PID-11"
          },
          {
            "identity": "rim",
            "map": "addr"
          }
        ]
      },
      {
        "path": "Patient.maritalStatus",
        "short": "Marital (civil) status of a patient",
        "definition": "This field contains a patient's most recent marital (civil) status.",
        "requirements": "Most, if not all systems capture it.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "binding": {
          "strength": "required",
          "description": "The domestic partnership status of a person.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/marital-status"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": ".patient.maritalStatusCode"
          },
          {
            "identity": "v2",
            "map": "PID-16"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN]/maritalStatusCode"
          }
        ]
      },
      {
        "path": "Patient.multipleBirth[x]",
        "short": "Whether patient is part of a multiple birth",
        "definition": "Indicates whether the patient is part of a multiple or indicates the actual birth order.",
        "requirements": "For disambiguation of multiple-birth children, especially relevant where the care provider doesn't meet the patient, such as labs.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "boolean"
          },
          {
            "code": "integer"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PID-24 (bool), PID-25 (integer)"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/multipleBirthInd,  player[classCode=PSN|ANM and determinerCode=INSTANCE]/multipleBirthOrderNumber"
          }
        ]
      },
      {
        "path": "Patient.photo",
        "short": "Image of the patient",
        "definition": "Image of the patient.",
        "requirements": "Many EHR systems have the capability to capture an image of the patient. Fits with newer social media usage too.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Attachment"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "OBX-5 - needs a profile"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/desc"
          }
        ]
      },
      {
        "extension": [
          {
            "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-explicit-type-name",
            "valueString": "Contact"
          }
        ],
        "path": "Patient.contact",
        "short": "A contact party (e.g. guardian, partner, friend) for the patient",
        "definition": "A contact party (e.g. guardian, partner, friend) for the patient.",
        "comments": "Contact covers all kinds of contact parties: family members, business contacts, guardians, caregivers. Not applicable to register pedigree and family ties beyond use of having contact.",
        "requirements": "Need to track people you can contact about the patient.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "BackboneElement"
          }
        ],
        "constraint": [
          {
            "key": "pat-1",
            "severity": "error",
            "human": "SHALL at least contain a contact's details or a reference to an organization",
            "xpath": "f:name or f:telecom or f:address or f:organization"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/scopedRole[classCode=CON]"
          }
        ]
      },
      {
        "path": "Patient.contact.id",
        "representation": [
          "xmlAttr"
        ],
        "short": "xml:id (or equivalent in JSON)",
        "definition": "unique id for the element within a resource (for internal references).",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "id"
          }
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "n/a"
          }
        ]
      },
      {
        "path": "Patient.contact.extension",
        "short": "Additional Content defined by implementations",
        "definition": "May be used to represent additional information that is not part of the basic definition of the element. In order to make the use of extensions safe and manageable, there is a strict set of governance  applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.",
        "comments": "There can be no stigma associated with the use of extensions by any application, project, or standard - regardless of the institution or jurisdiction that uses or defines the extensions.  The use of extensions is what allows the FHIR specification to retain a core level of simplicity for everyone.",
        "alias": [
          "extensions",
          "user content"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Extension"
          }
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "n/a"
          }
        ]
      },
      {
        "path": "Patient.contact.modifierExtension",
        "short": "Extensions that cannot be ignored",
        "definition": "May be used to represent additional information that is not part of the basic definition of the element, and that modifies the understanding of the element that contains it. Usually modifier elements provide negation or qualification. In order to make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions.",
        "comments": "There can be no stigma associated with the use of extensions by any application, project, or standard - regardless of the institution or jurisdiction that uses or defines the extensions.  The use of extensions is what allows the FHIR specification to retain a core level of simplicity for everyone.",
        "alias": [
          "extensions",
          "user content",
          "modifiers"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Extension"
          }
        ],
        "isModifier": true,
        "mapping": [
          {
            "identity": "rim",
            "map": "N/A"
          }
        ]
      },
      {
        "path": "Patient.contact.relationship",
        "short": "The kind of relationship",
        "definition": "The nature of the relationship between the patient and the contact person.",
        "requirements": "Used to determine which contact person is the most relevant to approach, depending on circumstances.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "binding": {
          "strength": "extensible",
          "description": "The nature of the relationship between a patient and a contact person for that patient.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/patient-contact-relationship"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-7, NK1-3"
          },
          {
            "identity": "rim",
            "map": "code"
          }
        ]
      },
      {
        "path": "Patient.contact.name",
        "short": "A name associated with the contact person",
        "definition": "A name associated with the contact person.",
        "requirements": "Contact persons need to be identified by name, but it is uncommon to need details about multiple other names for that contact person.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "HumanName"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-2"
          },
          {
            "identity": "rim",
            "map": "name"
          }
        ]
      },
      {
        "path": "Patient.contact.telecom",
        "short": "A contact detail for the person",
        "definition": "A contact detail for the person, e.g. a telephone number or an email address.",
        "comments": "Contact may have multiple ways to be contacted with different uses or applicable periods.  May need to have options for contacting the person urgently, and also to help with identification.",
        "requirements": "People have (primary) ways to contact them in some way such as phone, email.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "ContactPoint"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-5, NK1-6, NK1-40"
          },
          {
            "identity": "rim",
            "map": "telecom"
          }
        ]
      },
      {
        "path": "Patient.contact.address",
        "short": "Address for the contact person",
        "definition": "Address for the contact person.",
        "requirements": "Need to keep track where the contact person can be contacted per postal mail or visited.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "Address"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-4"
          },
          {
            "identity": "rim",
            "map": "addr"
          }
        ]
      },
      {
        "path": "Patient.contact.gender",
        "short": "male | female | other | unknown",
        "definition": "Administrative Gender - the gender that the contact person is considered to have for administration and record keeping purposes.",
        "requirements": "Needed to address the person correctly.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "code"
          }
        ],
        "binding": {
          "strength": "required",
          "description": "The gender of a person used for administrative purposes.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/administrative-gender"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-15"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/administrativeGender"
          }
        ]
      },
      {
        "path": "Patient.contact.organization",
        "short": "Organization that is associated with the contact",
        "definition": "Organization on behalf of which the contact is acting or for which the contact is working.",
        "requirements": "For guardians or business related contacts, the organization is relevant.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "Reference",
            "profile": [
              "http://hl7.org/fhir/StructureDefinition/Organization"
            ]
          }
        ],
        "condition": [
          "pat-1"
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-13, NK1-30, NK1-31, NK1-32, NK1-41"
          },
          {
            "identity": "rim",
            "map": "scoper"
          }
        ]
      },
      {
        "path": "Patient.contact.period",
        "short": "The period during which this contact person or organization is valid to be contacted relating to this patient",
        "definition": "The period during which this contact person or organization is valid to be contacted relating to this patient.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "Period"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "effectiveTime"
          }
        ]
      },
      {
        "extension": [
          {
            "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-explicit-type-name",
            "valueString": "Animal"
          }
        ],
        "path": "Patient.animal",
        "short": "This patient is known to be an animal (non-human)",
        "definition": "This patient is known to be an animal.",
        "comments": "The animal element is labeled \"Is Modifier\" since patients may be non-human. Systems SHALL either handle patient details appropriately (e.g. inform users patient is not human) or reject declared animal records.   The absense of the animal element does not imply that the patient is a human. If a system requires such a positive assertion that the patient is human, an extension will be required.  (Do not use a species of homo-sapiens in animal species, as this would incorrectly infer that the patient is an animal).",
        "requirements": "Many clinical systems are extended to care for animal patients as well as human.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "BackboneElement"
          }
        ],
        "isModifier": true,
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "player[classCode=ANM]"
          }
        ]
      },
      {
        "path": "Patient.animal.id",
        "representation": [
          "xmlAttr"
        ],
        "short": "xml:id (or equivalent in JSON)",
        "definition": "unique id for the element within a resource (for internal references).",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "id"
          }
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "n/a"
          }
        ]
      },
      {
        "path": "Patient.animal.extension",
        "short": "Additional Content defined by implementations",
        "definition": "May be used to represent additional information that is not part of the basic definition of the element. In order to make the use of extensions safe and manageable, there is a strict set of governance  applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.",
        "comments": "There can be no stigma associated with the use of extensions by any application, project, or standard - regardless of the institution or jurisdiction that uses or defines the extensions.  The use of extensions is what allows the FHIR specification to retain a core level of simplicity for everyone.",
        "alias": [
          "extensions",
          "user content"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Extension"
          }
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "n/a"
          }
        ]
      },
      {
        "path": "Patient.animal.modifierExtension",
        "short": "Extensions that cannot be ignored",
        "definition": "May be used to represent additional information that is not part of the basic definition of the element, and that modifies the understanding of the element that contains it. Usually modifier elements provide negation or qualification. In order to make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions.",
        "comments": "There can be no stigma associated with the use of extensions by any application, project, or standard - regardless of the institution or jurisdiction that uses or defines the extensions.  The use of extensions is what allows the FHIR specification to retain a core level of simplicity for everyone.",
        "alias": [
          "extensions",
          "user content",
          "modifiers"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Extension"
          }
        ],
        "isModifier": true,
        "mapping": [
          {
            "identity": "rim",
            "map": "N/A"
          }
        ]
      },
      {
        "path": "Patient.animal.species",
        "short": "E.g. Dog, Cow",
        "definition": "Identifies the high level taxonomic categorization of the kind of animal.",
        "comments": "If the patient is non-human, at least a species SHALL be specified. Species SHALL be a widely recognised taxonomic classification.  It may or may not be Linnaean taxonomy and may or may not be at the level of species. If the level is finer than species--such as a breed code--the code system used SHALL allow inference of the species.  (The common example is that the word \"Hereford\" does not allow inference of the species Bos taurus, because there is a Hereford pig breed, but the SNOMED CT code for \"Hereford Cattle Breed\" does.).",
        "requirements": "Need to know what kind of animal.",
        "min": 1,
        "max": "1",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "isSummary": true,
        "binding": {
          "strength": "example",
          "description": "The species of an animal.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/animal-species"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PID-35"
          },
          {
            "identity": "rim",
            "map": "code"
          }
        ]
      },
      {
        "path": "Patient.animal.breed",
        "short": "E.g. Poodle, Angus",
        "definition": "Identifies the detailed categorization of the kind of animal.",
        "comments": "Breed MAY be used to provide further taxonomic or non-taxonomic classification.  It may involve local or proprietary designation--such as commercial strain--and/or additional information such as production type.",
        "requirements": "May need to know the specific kind within the species.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "isSummary": true,
        "binding": {
          "strength": "example",
          "description": "The breed of an animal.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/animal-breeds"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PID-37"
          },
          {
            "identity": "rim",
            "map": "playedRole[classCode=GEN]/scoper[classCode=ANM, determinerCode=KIND]/code"
          }
        ]
      },
      {
        "path": "Patient.animal.genderStatus",
        "short": "E.g. Neutered, Intact",
        "definition": "Indicates the current state of the animal's reproductive organs.",
        "requirements": "Gender status can affect housing and animal behavior.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "isSummary": true,
        "binding": {
          "strength": "example",
          "description": "The state of the animal's reproductive organs.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/animal-genderstatus"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "N/A"
          },
          {
            "identity": "rim",
            "map": "genderStatusCode"
          }
        ]
      },
      {
        "path": "Patient.communication",
        "short": "A list of Languages which may be used to communicate with the patient about his or her health",
        "definition": "Languages which may be used to communicate with the patient about his or her health.",
        "comments": "If no language is specified, this *implies* that the default local language is spoken.  If you need to convey proficiency for multiple modes then you need multiple Patient.Communication associations.   For animals, language is not a relevant field, and should be absent from the instance. If the Patient does not speak the default local language, then the Interpreter Required Standard can be used to explicitly declare that an interpreter is required.",
        "requirements": "If a patient does not speak the local language, interpreters may be required, so languages spoken and proficiency is an important things to keep track of both for patient and other persons of interest.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "BackboneElement"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "patient.languageCommunication"
          },
          {
            "identity": "rim",
            "map": "LanguageCommunication"
          }
        ]
      },
      {
        "path": "Patient.communication.id",
        "representation": [
          "xmlAttr"
        ],
        "short": "xml:id (or equivalent in JSON)",
        "definition": "unique id for the element within a resource (for internal references).",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "id"
          }
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "n/a"
          }
        ]
      },
      {
        "path": "Patient.communication.extension",
        "short": "Additional Content defined by implementations",
        "definition": "May be used to represent additional information that is not part of the basic definition of the element. In order to make the use of extensions safe and manageable, there is a strict set of governance  applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.",
        "comments": "There can be no stigma associated with the use of extensions by any application, project, or standard - regardless of the institution or jurisdiction that uses or defines the extensions.  The use of extensions is what allows the FHIR specification to retain a core level of simplicity for everyone.",
        "alias": [
          "extensions",
          "user content"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Extension"
          }
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "n/a"
          }
        ]
      },
      {
        "path": "Patient.communication.modifierExtension",
        "short": "Extensions that cannot be ignored",
        "definition": "May be used to represent additional information that is not part of the basic definition of the element, and that modifies the understanding of the element that contains it. Usually modifier elements provide negation or qualification. In order to make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions.",
        "comments": "There can be no stigma associated with the use of extensions by any application, project, or standard - regardless of the institution or jurisdiction that uses or defines the extensions.  The use of extensions is what allows the FHIR specification to retain a core level of simplicity for everyone.",
        "alias": [
          "extensions",
          "user content",
          "modifiers"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Extension"
          }
        ],
        "isModifier": true,
        "mapping": [
          {
            "identity": "rim",
            "map": "N/A"
          }
        ]
      },
      {
        "path": "Patient.communication.language",
        "short": "The language which can be used to communicate with the patient about his or her health",
        "definition": "The ISO-639-1 alpha 2 code in lower case for the language, optionally followed by a hyphen and the ISO-3166-1 alpha 2 code for the region in upper case; e.g. \"en\" for English, or \"en-US\" for American English versus \"en-EN\" for England English.",
        "comments": "The structure aa-BB with this exact casing is one the most widely used notations for locale. However not all systems actually code this but instead have it as free text. Hence CodeableConcept instead of code as the data type.",
        "requirements": "Most systems in multilingual countries will want to convey language. Not all systems actually need the regional dialect.",
        "min": 1,
        "max": "1",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "binding": {
          "strength": "required",
          "description": "A human language.",
          "valueSetUri": "http://tools.ietf.org/html/bcp47"
        },
        "mapping": [
          {
            "identity": "cda",
            "map": ".languageCode"
          },
          {
            "identity": "v2",
            "map": "PID-15, LAN-2"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/languageCommunication/code"
          }
        ]
      },
      {
        "path": "Patient.communication.preferred",
        "short": "Language preference indicator",
        "definition": "Indicates whether or not the patient prefers this language (over other languages he masters up a certain level).",
        "comments": "This language is specifically identified for communicating healthcare information.",
        "requirements": "People that master multiple languages up to certain level may prefer one or more, i.e. feel more confident in communicating in a particular language making other languages sort of a fall back method.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "boolean"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": ".preferenceInd"
          },
          {
            "identity": "v2",
            "map": "PID-15"
          },
          {
            "identity": "rim",
            "map": "preferenceInd"
          }
        ]
      },
      {
        "path": "Patient.careProvider",
        "short": "Patient's nominated primary care provider",
        "definition": "Patient's nominated care provider.",
        "comments": "This may be the primary care provider (in a GP context), or it may be a patient nominated care manager in a community/disablity setting, or even organization that will provide people to perform the care provider roles.\n\nThis is not to be used to record Care Teams, these should be recorded on either the CarePlan or EpisodeOfCare resources.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Reference",
            "profile": [
              "http://hl7.org/fhir/StructureDefinition/Organization"
            ]
          },
          {
            "code": "Reference",
            "profile": [
              "http://hl7.org/fhir/StructureDefinition/Practitioner"
            ]
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PD1-4"
          },
          {
            "identity": "rim",
            "map": "subjectOf.CareEvent.performer.AssignedEntity"
          }
        ]
      },
      {
        "path": "Patient.managingOrganization",
        "short": "Organization that is the custodian of the patient record",
        "definition": "Organization that is the custodian of the patient record.",
        "comments": "There is only one managing organization for a specific patient record. Other organizations will have their own Patient record, and may use the Link property to join the records together (or a Person resource which can include confidence ratings for the association).",
        "requirements": "Need to know who recognizes this patient record, manages and updates it.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "Reference",
            "profile": [
              "http://hl7.org/fhir/StructureDefinition/Organization"
            ]
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": ".providerOrganization"
          },
          {
            "identity": "rim",
            "map": "scoper"
          }
        ]
      },
      {
        "path": "Patient.link",
        "short": "Link to another patient resource that concerns the same actual person",
        "definition": "Link to another patient resource that concerns the same actual patient.",
        "comments": "There is no assumption that linked patient records have mutual links.",
        "requirements": "There are multiple usecases: \n\n* Duplicate patient records due to the clerical errors associated with the difficulties of identifying humans consistently, and * Distribution of patient information across multiple servers.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "BackboneElement"
          }
        ],
        "isModifier": true,
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "outboundLink"
          }
        ]
      },
      {
        "path": "Patient.link.id",
        "representation": [
          "xmlAttr"
        ],
        "short": "xml:id (or equivalent in JSON)",
        "definition": "unique id for the element within a resource (for internal references).",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "id"
          }
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "n/a"
          }
        ]
      },
      {
        "path": "Patient.link.extension",
        "short": "Additional Content defined by implementations",
        "definition": "May be used to represent additional information that is not part of the basic definition of the element. In order to make the use of extensions safe and manageable, there is a strict set of governance  applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.",
        "comments": "There can be no stigma associated with the use of extensions by any application, project, or standard - regardless of the institution or jurisdiction that uses or defines the extensions.  The use of extensions is what allows the FHIR specification to retain a core level of simplicity for everyone.",
        "alias": [
          "extensions",
          "user content"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Extension"
          }
        ],
        "mapping": [
          {
            "identity": "rim",
            "map": "n/a"
          }
        ]
      },
      {
        "path": "Patient.link.modifierExtension",
        "short": "Extensions that cannot be ignored",
        "definition": "May be used to represent additional information that is not part of the basic definition of the element, and that modifies the understanding of the element that contains it. Usually modifier elements provide negation or qualification. In order to make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions.",
        "comments": "There can be no stigma associated with the use of extensions by any application, project, or standard - regardless of the institution or jurisdiction that uses or defines the extensions.  The use of extensions is what allows the FHIR specification to retain a core level of simplicity for everyone.",
        "alias": [
          "extensions",
          "user content",
          "modifiers"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Extension"
          }
        ],
        "isModifier": true,
        "mapping": [
          {
            "identity": "rim",
            "map": "N/A"
          }
        ]
      },
      {
        "path": "Patient.link.other",
        "short": "The other patient resource that the link refers to",
        "definition": "The other patient resource that the link refers to.",
        "min": 1,
        "max": "1",
        "type": [
          {
            "code": "Reference",
            "profile": [
              "http://hl7.org/fhir/StructureDefinition/Patient"
            ]
          }
        ],
        "isModifier": true,
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PID-3, MRG-1"
          },
          {
            "identity": "rim",
            "map": "id"
          }
        ]
      },
      {
        "path": "Patient.link.type",
        "short": "replace | refer | seealso - type of link",
        "definition": "The type of link between this patient resource and another patient resource.",
        "min": 1,
        "max": "1",
        "type": [
          {
            "code": "code"
          }
        ],
        "isModifier": true,
        "binding": {
          "strength": "required",
          "description": "The type of link between this patient resource and another patient resource.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/link-type"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "typeCode"
          }
        ]
      }
    ]
  },
  "differential": {
    "element": [
      {
        "path": "Patient",
        "short": "Information about an individual or animal receiving health care services",
        "definition": "Demographics and other administrative information about an individual or animal receiving care or other health-related services.",
        "alias": [
          "SubjectOfCare Client Resident"
        ],
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "DomainResource"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "ClinicalDocument.recordTarget.patientRole"
          },
          {
            "identity": "rim",
            "map": "Patient[classCode=PAT]"
          },
          {
            "identity": "w5",
            "map": "administrative.individual"
          }
        ]
      },
      {
        "path": "Patient.identifier",
        "short": "An identifier for this patient",
        "definition": "An identifier for this patient.",
        "requirements": "Patients are almost always assigned specific numerical identifiers.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Identifier"
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": ".id"
          },
          {
            "identity": "v2",
            "map": "PID-3"
          },
          {
            "identity": "rim",
            "map": "id"
          },
          {
            "identity": "w5",
            "map": "id"
          }
        ]
      },
      {
        "path": "Patient.active",
        "short": "Whether this patient's record is in active use",
        "definition": "Whether this patient record is in active use.",
        "comments": "Default is true. If a record is inactive, and linked to an active record, then future patient/record updates should occur on the other patient.",
        "requirements": "Need to be able to mark a patient record as not to be used because it was created in error.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "boolean"
          }
        ],
        "defaultValueBoolean": true,
        "isModifier": true,
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "statusCode"
          },
          {
            "identity": "w5",
            "map": "status"
          }
        ]
      },
      {
        "path": "Patient.name",
        "short": "A name associated with the patient",
        "definition": "A name associated with the individual.",
        "comments": "A patient may have multiple names with different uses or applicable periods. For animals, the name is a \"HumanName\" in the sense that is assigned and used by humans and has the same patterns.",
        "requirements": "Need to be able to track the patient by multiple names. Examples are your official name and a partner name.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "HumanName"
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": ".patient.name"
          },
          {
            "identity": "v2",
            "map": "PID-5, PID-9"
          },
          {
            "identity": "rim",
            "map": "name"
          }
        ]
      },
      {
        "path": "Patient.telecom",
        "short": "A contact detail for the individual",
        "definition": "A contact detail (e.g. a telephone number or an email address) by which the individual may be contacted.",
        "comments": "A Patient may have multiple ways to be contacted with different uses or applicable periods.  May need to have options for contacting the person urgently and also to help with identification. The address may not go directly to the individual, but may reach another party that is able to proxy for the patient (i.e. home phone, or pet owner's phone).",
        "requirements": "People have (primary) ways to contact them in some way such as phone, email.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "ContactPoint"
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": ".telecom"
          },
          {
            "identity": "v2",
            "map": "PID-13, PID-14, PID-40"
          },
          {
            "identity": "rim",
            "map": "telecom"
          }
        ]
      },
      {
        "path": "Patient.gender",
        "short": "male | female | other | unknown",
        "definition": "Administrative Gender - the gender that the patient is considered to have for administration and record keeping purposes.",
        "comments": "The gender may not match the biological sex as determined by genetics, or the individual's preferred identification. Note that for both humans and particularly animals, there are other legitimate possibilities than M and F, though the vast majority of systems and contexts only support M and F.  Systems providing decision support or enforcing business rules should ideally do this on the basis of Observations dealing with the specific gender aspect of interest (anatomical, chromosonal, social, etc.)  However, because these observations are infrequently recorded, defaulting to the administrative gender is common practice.  Where such defaulting occurs, rule enforcement should allow for the variation between administrative and biological, chromosonal and other gender aspects.  For example, an alert about a hysterectomy on a male should be handled as a warning or overrideable error, not a \"hard\" error.",
        "requirements": "Needed for identification of the individual, in combination with (at least) name and birth date. Gender of individual drives many clinical processes.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "code"
          }
        ],
        "isSummary": true,
        "binding": {
          "strength": "required",
          "description": "The gender of a person used for administrative purposes.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/administrative-gender"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": ".patient.administrativeGenderCode"
          },
          {
            "identity": "v2",
            "map": "PID-8"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/administrativeGender"
          }
        ]
      },
      {
        "path": "Patient.birthDate",
        "short": "The date of birth for the individual",
        "definition": "The date of birth for the individual.",
        "comments": "At least an estimated year should be provided as a guess if the real DOB is unknown  There is a standard extension \"patient-birthTime\" available that should be used where Time is required (such as in maternaty/infant care systems).",
        "requirements": "Age of the individual drives many clinical processes.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "date"
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "loinc",
            "map": "21112-8"
          },
          {
            "identity": "cda",
            "map": ".patient.birthTime"
          },
          {
            "identity": "v2",
            "map": "PID-7"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/birthTime"
          }
        ]
      },
      {
        "path": "Patient.deceased[x]",
        "short": "Indicates if the individual is deceased or not",
        "definition": "Indicates if the individual is deceased or not.",
        "comments": "If there's no value in the instance it means there is no statement on whether or not the individual is deceased. Most systems will interpret the absence of a value as a sign of the person being alive.",
        "requirements": "The fact that a patient is deceased influences the clinical process. Also, in human communication and relation management it is necessary to know whether the person is alive.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "boolean"
          },
          {
            "code": "dateTime"
          }
        ],
        "isModifier": true,
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PID-30  (bool) and PID-29 (datetime)"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/deceasedInd, player[classCode=PSN|ANM and determinerCode=INSTANCE]/deceasedTime"
          }
        ]
      },
      {
        "path": "Patient.address",
        "short": "Addresses for the individual",
        "definition": "Addresses for the individual.",
        "comments": "Patient may have multiple addresses with different uses or applicable periods.",
        "requirements": "May need to keep track of patient addresses for contacting, billing or reporting requirements and also to help with identification.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Address"
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": ".addr"
          },
          {
            "identity": "v2",
            "map": "PID-11"
          },
          {
            "identity": "rim",
            "map": "addr"
          }
        ]
      },
      {
        "path": "Patient.maritalStatus",
        "short": "Marital (civil) status of a patient",
        "definition": "This field contains a patient's most recent marital (civil) status.",
        "requirements": "Most, if not all systems capture it.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "binding": {
          "strength": "required",
          "description": "The domestic partnership status of a person.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/marital-status"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": ".patient.maritalStatusCode"
          },
          {
            "identity": "v2",
            "map": "PID-16"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN]/maritalStatusCode"
          }
        ]
      },
      {
        "path": "Patient.multipleBirth[x]",
        "short": "Whether patient is part of a multiple birth",
        "definition": "Indicates whether the patient is part of a multiple or indicates the actual birth order.",
        "requirements": "For disambiguation of multiple-birth children, especially relevant where the care provider doesn't meet the patient, such as labs.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "boolean"
          },
          {
            "code": "integer"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PID-24 (bool), PID-25 (integer)"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/multipleBirthInd,  player[classCode=PSN|ANM and determinerCode=INSTANCE]/multipleBirthOrderNumber"
          }
        ]
      },
      {
        "path": "Patient.photo",
        "short": "Image of the patient",
        "definition": "Image of the patient.",
        "requirements": "Many EHR systems have the capability to capture an image of the patient. Fits with newer social media usage too.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Attachment"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "OBX-5 - needs a profile"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/desc"
          }
        ]
      },
      {
        "extension": [
          {
            "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-explicit-type-name",
            "valueString": "Contact"
          }
        ],
        "path": "Patient.contact",
        "short": "A contact party (e.g. guardian, partner, friend) for the patient",
        "definition": "A contact party (e.g. guardian, partner, friend) for the patient.",
        "comments": "Contact covers all kinds of contact parties: family members, business contacts, guardians, caregivers. Not applicable to register pedigree and family ties beyond use of having contact.",
        "requirements": "Need to track people you can contact about the patient.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "BackboneElement"
          }
        ],
        "constraint": [
          {
            "key": "pat-1",
            "severity": "error",
            "human": "SHALL at least contain a contact's details or a reference to an organization",
            "xpath": "f:name or f:telecom or f:address or f:organization"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/scopedRole[classCode=CON]"
          }
        ]
      },
      {
        "path": "Patient.contact.relationship",
        "short": "The kind of relationship",
        "definition": "The nature of the relationship between the patient and the contact person.",
        "requirements": "Used to determine which contact person is the most relevant to approach, depending on circumstances.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "binding": {
          "strength": "extensible",
          "description": "The nature of the relationship between a patient and a contact person for that patient.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/patient-contact-relationship"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-7, NK1-3"
          },
          {
            "identity": "rim",
            "map": "code"
          }
        ]
      },
      {
        "path": "Patient.contact.name",
        "short": "A name associated with the contact person",
        "definition": "A name associated with the contact person.",
        "requirements": "Contact persons need to be identified by name, but it is uncommon to need details about multiple other names for that contact person.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "HumanName"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-2"
          },
          {
            "identity": "rim",
            "map": "name"
          }
        ]
      },
      {
        "path": "Patient.contact.telecom",
        "short": "A contact detail for the person",
        "definition": "A contact detail for the person, e.g. a telephone number or an email address.",
        "comments": "Contact may have multiple ways to be contacted with different uses or applicable periods.  May need to have options for contacting the person urgently, and also to help with identification.",
        "requirements": "People have (primary) ways to contact them in some way such as phone, email.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "ContactPoint"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-5, NK1-6, NK1-40"
          },
          {
            "identity": "rim",
            "map": "telecom"
          }
        ]
      },
      {
        "path": "Patient.contact.address",
        "short": "Address for the contact person",
        "definition": "Address for the contact person.",
        "requirements": "Need to keep track where the contact person can be contacted per postal mail or visited.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "Address"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-4"
          },
          {
            "identity": "rim",
            "map": "addr"
          }
        ]
      },
      {
        "path": "Patient.contact.gender",
        "short": "male | female | other | unknown",
        "definition": "Administrative Gender - the gender that the contact person is considered to have for administration and record keeping purposes.",
        "requirements": "Needed to address the person correctly.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "code"
          }
        ],
        "binding": {
          "strength": "required",
          "description": "The gender of a person used for administrative purposes.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/administrative-gender"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-15"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/administrativeGender"
          }
        ]
      },
      {
        "path": "Patient.contact.organization",
        "short": "Organization that is associated with the contact",
        "definition": "Organization on behalf of which the contact is acting or for which the contact is working.",
        "requirements": "For guardians or business related contacts, the organization is relevant.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "Reference",
            "profile": [
              "http://hl7.org/fhir/StructureDefinition/Organization"
            ]
          }
        ],
        "condition": [
          "pat-1"
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "NK1-13, NK1-30, NK1-31, NK1-32, NK1-41"
          },
          {
            "identity": "rim",
            "map": "scoper"
          }
        ]
      },
      {
        "path": "Patient.contact.period",
        "short": "The period during which this contact person or organization is valid to be contacted relating to this patient",
        "definition": "The period during which this contact person or organization is valid to be contacted relating to this patient.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "Period"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "effectiveTime"
          }
        ]
      },
      {
        "extension": [
          {
            "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-explicit-type-name",
            "valueString": "Animal"
          }
        ],
        "path": "Patient.animal",
        "short": "This patient is known to be an animal (non-human)",
        "definition": "This patient is known to be an animal.",
        "comments": "The animal element is labeled \"Is Modifier\" since patients may be non-human. Systems SHALL either handle patient details appropriately (e.g. inform users patient is not human) or reject declared animal records.   The absense of the animal element does not imply that the patient is a human. If a system requires such a positive assertion that the patient is human, an extension will be required.  (Do not use a species of homo-sapiens in animal species, as this would incorrectly infer that the patient is an animal).",
        "requirements": "Many clinical systems are extended to care for animal patients as well as human.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "BackboneElement"
          }
        ],
        "isModifier": true,
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "player[classCode=ANM]"
          }
        ]
      },
      {
        "path": "Patient.animal.species",
        "short": "E.g. Dog, Cow",
        "definition": "Identifies the high level taxonomic categorization of the kind of animal.",
        "comments": "If the patient is non-human, at least a species SHALL be specified. Species SHALL be a widely recognised taxonomic classification.  It may or may not be Linnaean taxonomy and may or may not be at the level of species. If the level is finer than species--such as a breed code--the code system used SHALL allow inference of the species.  (The common example is that the word \"Hereford\" does not allow inference of the species Bos taurus, because there is a Hereford pig breed, but the SNOMED CT code for \"Hereford Cattle Breed\" does.).",
        "requirements": "Need to know what kind of animal.",
        "min": 1,
        "max": "1",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "isSummary": true,
        "binding": {
          "strength": "example",
          "description": "The species of an animal.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/animal-species"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PID-35"
          },
          {
            "identity": "rim",
            "map": "code"
          }
        ]
      },
      {
        "path": "Patient.animal.breed",
        "short": "E.g. Poodle, Angus",
        "definition": "Identifies the detailed categorization of the kind of animal.",
        "comments": "Breed MAY be used to provide further taxonomic or non-taxonomic classification.  It may involve local or proprietary designation--such as commercial strain--and/or additional information such as production type.",
        "requirements": "May need to know the specific kind within the species.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "isSummary": true,
        "binding": {
          "strength": "example",
          "description": "The breed of an animal.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/animal-breeds"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PID-37"
          },
          {
            "identity": "rim",
            "map": "playedRole[classCode=GEN]/scoper[classCode=ANM, determinerCode=KIND]/code"
          }
        ]
      },
      {
        "path": "Patient.animal.genderStatus",
        "short": "E.g. Neutered, Intact",
        "definition": "Indicates the current state of the animal's reproductive organs.",
        "requirements": "Gender status can affect housing and animal behavior.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "isSummary": true,
        "binding": {
          "strength": "example",
          "description": "The state of the animal's reproductive organs.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/animal-genderstatus"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "N/A"
          },
          {
            "identity": "rim",
            "map": "genderStatusCode"
          }
        ]
      },
      {
        "path": "Patient.communication",
        "short": "A list of Languages which may be used to communicate with the patient about his or her health",
        "definition": "Languages which may be used to communicate with the patient about his or her health.",
        "comments": "If no language is specified, this *implies* that the default local language is spoken.  If you need to convey proficiency for multiple modes then you need multiple Patient.Communication associations.   For animals, language is not a relevant field, and should be absent from the instance. If the Patient does not speak the default local language, then the Interpreter Required Standard can be used to explicitly declare that an interpreter is required.",
        "requirements": "If a patient does not speak the local language, interpreters may be required, so languages spoken and proficiency is an important things to keep track of both for patient and other persons of interest.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "BackboneElement"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "patient.languageCommunication"
          },
          {
            "identity": "rim",
            "map": "LanguageCommunication"
          }
        ]
      },
      {
        "path": "Patient.communication.language",
        "short": "The language which can be used to communicate with the patient about his or her health",
        "definition": "The ISO-639-1 alpha 2 code in lower case for the language, optionally followed by a hyphen and the ISO-3166-1 alpha 2 code for the region in upper case; e.g. \"en\" for English, or \"en-US\" for American English versus \"en-EN\" for England English.",
        "comments": "The structure aa-BB with this exact casing is one the most widely used notations for locale. However not all systems actually code this but instead have it as free text. Hence CodeableConcept instead of code as the data type.",
        "requirements": "Most systems in multilingual countries will want to convey language. Not all systems actually need the regional dialect.",
        "min": 1,
        "max": "1",
        "type": [
          {
            "code": "CodeableConcept"
          }
        ],
        "binding": {
          "strength": "required",
          "description": "A human language.",
          "valueSetUri": "http://tools.ietf.org/html/bcp47"
        },
        "mapping": [
          {
            "identity": "cda",
            "map": ".languageCode"
          },
          {
            "identity": "v2",
            "map": "PID-15, LAN-2"
          },
          {
            "identity": "rim",
            "map": "player[classCode=PSN|ANM and determinerCode=INSTANCE]/languageCommunication/code"
          }
        ]
      },
      {
        "path": "Patient.communication.preferred",
        "short": "Language preference indicator",
        "definition": "Indicates whether or not the patient prefers this language (over other languages he masters up a certain level).",
        "comments": "This language is specifically identified for communicating healthcare information.",
        "requirements": "People that master multiple languages up to certain level may prefer one or more, i.e. feel more confident in communicating in a particular language making other languages sort of a fall back method.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "boolean"
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": ".preferenceInd"
          },
          {
            "identity": "v2",
            "map": "PID-15"
          },
          {
            "identity": "rim",
            "map": "preferenceInd"
          }
        ]
      },
      {
        "path": "Patient.careProvider",
        "short": "Patient's nominated primary care provider",
        "definition": "Patient's nominated care provider.",
        "comments": "This may be the primary care provider (in a GP context), or it may be a patient nominated care manager in a community/disablity setting, or even organization that will provide people to perform the care provider roles.\n\nThis is not to be used to record Care Teams, these should be recorded on either the CarePlan or EpisodeOfCare resources.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "Reference",
            "profile": [
              "http://hl7.org/fhir/StructureDefinition/Organization"
            ]
          },
          {
            "code": "Reference",
            "profile": [
              "http://hl7.org/fhir/StructureDefinition/Practitioner"
            ]
          }
        ],
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PD1-4"
          },
          {
            "identity": "rim",
            "map": "subjectOf.CareEvent.performer.AssignedEntity"
          }
        ]
      },
      {
        "path": "Patient.managingOrganization",
        "short": "Organization that is the custodian of the patient record",
        "definition": "Organization that is the custodian of the patient record.",
        "comments": "There is only one managing organization for a specific patient record. Other organizations will have their own Patient record, and may use the Link property to join the records together (or a Person resource which can include confidence ratings for the association).",
        "requirements": "Need to know who recognizes this patient record, manages and updates it.",
        "min": 0,
        "max": "1",
        "type": [
          {
            "code": "Reference",
            "profile": [
              "http://hl7.org/fhir/StructureDefinition/Organization"
            ]
          }
        ],
        "isSummary": true,
        "mapping": [
          {
            "identity": "cda",
            "map": ".providerOrganization"
          },
          {
            "identity": "rim",
            "map": "scoper"
          }
        ]
      },
      {
        "path": "Patient.link",
        "short": "Link to another patient resource that concerns the same actual person",
        "definition": "Link to another patient resource that concerns the same actual patient.",
        "comments": "There is no assumption that linked patient records have mutual links.",
        "requirements": "There are multiple usecases: \n\n* Duplicate patient records due to the clerical errors associated with the difficulties of identifying humans consistently, and * Distribution of patient information across multiple servers.",
        "min": 0,
        "max": "*",
        "type": [
          {
            "code": "BackboneElement"
          }
        ],
        "isModifier": true,
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "outboundLink"
          }
        ]
      },
      {
        "path": "Patient.link.other",
        "short": "The other patient resource that the link refers to",
        "definition": "The other patient resource that the link refers to.",
        "min": 1,
        "max": "1",
        "type": [
          {
            "code": "Reference",
            "profile": [
              "http://hl7.org/fhir/StructureDefinition/Patient"
            ]
          }
        ],
        "isModifier": true,
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "v2",
            "map": "PID-3, MRG-1"
          },
          {
            "identity": "rim",
            "map": "id"
          }
        ]
      },
      {
        "path": "Patient.link.type",
        "short": "replace | refer | seealso - type of link",
        "definition": "The type of link between this patient resource and another patient resource.",
        "min": 1,
        "max": "1",
        "type": [
          {
            "code": "code"
          }
        ],
        "isModifier": true,
        "binding": {
          "strength": "required",
          "description": "The type of link between this patient resource and another patient resource.",
          "valueSetReference": {
            "reference": "http://hl7.org/fhir/ValueSet/link-type"
          }
        },
        "mapping": [
          {
            "identity": "cda",
            "map": "n/a"
          },
          {
            "identity": "rim",
            "map": "typeCode"
          }
        ]
      }
    ]
  }
}
]]









-- https://www.hl7.org/fhir/patient.profile.xml.html
Patient.xml = [[
<StructureDefinition xmlns="http://hl7.org/fhir">
  <id value="Patient"/>
  <meta>
    <lastUpdated value="2015-10-24T07:41:03.495+11:00"/>
  </meta>
  <extension url="http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm">
    <valueInteger value="3"/>
  </extension>
  <url value="http://hl7.org/fhir/StructureDefinition/Patient"/>
  <name value="Patient"/>
  <status value="draft"/>
  <publisher value="Health Level Seven International (Patient Administration)"/>
  <contact>
    <telecom>
      <system value="other"/>
      <value value="http://hl7.org/fhir"/>
    </telecom>
  </contact>
  <contact>
    <telecom>
      <system value="other"/>
      <value value="http://www.hl7.org/Special/committees/pafm/index.cfm"/>
    </telecom>
  </contact>
  <date value="2015-10-24T07:41:03+11:00"/>
  <description value="Base StructureDefinition for Patient Resource"/>
  <requirements value="Tracking patient is the center of the healthcare process."/>
  <fhirVersion value="1.0.2"/>
  <mapping>
    <identity value="cda"/>
    <uri value="http://hl7.org/v3/cda"/>
    <name value="CDA (R2)"/>
  </mapping>
  <mapping>
    <identity value="rim"/>
    <uri value="http://hl7.org/v3"/>
    <name value="RIM"/>
  </mapping>
  <mapping>
    <identity value="w5"/>
    <uri value="http://hl7.org/fhir/w5"/>
    <name value="W5 Mapping"/>
  </mapping>
  <mapping>
    <identity value="v2"/>
    <uri value="http://hl7.org/v2"/>
    <name value="HL7 v2"/>
  </mapping>
  <mapping>
    <identity value="loinc"/>
    <uri value="http://loinc.org"/>
    <name value="LOINC"/>
  </mapping>
  <kind value="resource"/>
  <abstract value="false"/>
  <base value="http://hl7.org/fhir/StructureDefinition/DomainResource"/>
  <snapshot>
    <element>
      <path value="Patient"/>
      <short value="Information about an individual or animal receiving health care services"/>
      <definition value="Demographics and other administrative information about an individual or animal receiving
       care or other health-related services."/>
      <alias value="SubjectOfCare Client Resident"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="DomainResource"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="ClinicalDocument.recordTarget.patientRole"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="Patient[classCode=PAT]"/>
      </mapping>
      <mapping>
        <identity value="w5"/>
        <map value="administrative.individual"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.id"/>
      <short value="Logical id of this artifact"/>
      <definition value="The logical id of the resource, as used in the URL for the resource. Once assigned, this
       value never changes."/>
      <comments value="The only time that a resource does not have an id is when it is being submitted to the
       server using a create operation. Bundles always have an id, though it is usually a generated
       UUID."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="id"/>
      </type>
      <isSummary value="true"/>
    </element>
    <element>
      <path value="Patient.meta"/>
      <short value="Metadata about the resource"/>
      <definition value="The metadata about the resource. This is content that is maintained by the infrastructure.
       Changes to the content may not always be associated with version changes to the resource."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="Meta"/>
      </type>
      <isSummary value="true"/>
    </element>
    <element>
      <path value="Patient.implicitRules"/>
      <short value="A set of rules under which this content was created"/>
      <definition value="A reference to a set of rules that were followed when the resource was constructed, and
       which must be understood when processing the content."/>
      <comments value="Asserting this rule set restricts the content to be only understood by a limited set of
       trading partners. This inherently limits the usefulness of the data in the long term.
       However, the existing health eco-system is highly fractured, and not yet ready to define,
       collect, and exchange data in a generally computable sense. Wherever possible, implementers
       and/or specification writers should avoid using this element as much as possible."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="uri"/>
      </type>
      <isModifier value="true"/>
      <isSummary value="true"/>
    </element>
    <element>
      <path value="Patient.language"/>
      <short value="Language of the resource content"/>
      <definition value="The base language in which the resource is written."/>
      <comments value="Language is provided to support indexing and accessibility (typically, services such as
       text to speech use the language tag). The html language tag in the narrative applies 
       to the narrative. The language tag on the resource may be used to specify the language
       of other presentations generated from the data in the resource  Not all the content has
       to be in the base language. The Resource.language should not be assumed to apply to the
       narrative automatically. If a language is specified, it should it also be specified on
       the div element in the html (see rules in HTML5 for information about the relationship
       between xml:lang and the html lang attribute)."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="code"/>
      </type>
      <binding>
        <strength value="required"/>
        <description value="A human language."/>
        <valueSetUri value="http://tools.ietf.org/html/bcp47"/>
      </binding>
    </element>
    <element>
      <path value="Patient.text"/>
      <short value="Text summary of the resource, for human interpretation"/>
      <definition value="A human-readable narrative that contains a summary of the resource, and may be used to
       represent the content of the resource to a human. The narrative need not encode all the
       structured data, but is required to contain sufficient detail to make it &quot;clinically
       safe&quot; for a human to just read the narrative. Resource definitions may define what
       content should be represented in the narrative to ensure clinical safety."/>
      <comments value="Contained resources do not have narrative. Resources that are not contained SHOULD have
       a narrative."/>
      <alias value="narrative"/>
      <alias value="html"/>
      <alias value="xhtml"/>
      <alias value="display"/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="Narrative"/>
      </type>
      <condition value="dom-1"/>
      <mapping>
        <identity value="rim"/>
        <map value="Act.text?"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contained"/>
      <short value="Contained, inline Resources"/>
      <definition value="These resources do not have an independent existence apart from the resource that contains
       them - they cannot be identified independently, and nor can they have their own independent
       transaction scope."/>
      <comments value="This should never be done when the content can be identified properly, as once identification
       is lost, it is extremely difficult (and context dependent) to restore it again."/>
      <alias value="inline resources"/>
      <alias value="anonymous resources"/>
      <alias value="contained resources"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Resource"/>
      </type>
      <mapping>
        <identity value="rim"/>
        <map value="N/A"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.extension"/>
      <short value="Additional Content defined by implementations"/>
      <definition value="May be used to represent additional information that is not part of the basic definition
       of the resource. In order to make the use of extensions safe and manageable, there is
       a strict set of governance  applied to the definition and use of extensions. Though any
       implementer is allowed to define an extension, there is a set of requirements that SHALL
       be met as part of the definition of the extension."/>
      <comments value="There can be no stigma associated with the use of extensions by any application, project,
       or standard - regardless of the institution or jurisdiction that uses or defines the extensions.
        The use of extensions is what allows the FHIR specification to retain a core level of
       simplicity for everyone."/>
      <alias value="extensions"/>
      <alias value="user content"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Extension"/>
      </type>
      <mapping>
        <identity value="rim"/>
        <map value="N/A"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.modifierExtension"/>
      <short value="Extensions that cannot be ignored"/>
      <definition value="May be used to represent additional information that is not part of the basic definition
       of the resource, and that modifies the understanding of the element that contains it.
       Usually modifier elements provide negation or qualification. In order to make the use
       of extensions safe and manageable, there is a strict set of governance applied to the
       definition and use of extensions. Though any implementer is allowed to define an extension,
       there is a set of requirements that SHALL be met as part of the definition of the extension.
       Applications processing a resource are required to check for modifier extensions."/>
      <comments value="There can be no stigma associated with the use of extensions by any application, project,
       or standard - regardless of the institution or jurisdiction that uses or defines the extensions.
        The use of extensions is what allows the FHIR specification to retain a core level of
       simplicity for everyone."/>
      <alias value="extensions"/>
      <alias value="user content"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Extension"/>
      </type>
      <isModifier value="true"/>
      <mapping>
        <identity value="rim"/>
        <map value="N/A"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.identifier"/>
      <short value="An identifier for this patient"/>
      <definition value="An identifier for this patient."/>
      <requirements value="Patients are almost always assigned specific numerical identifiers."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Identifier"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value=".id"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-3"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="id"/>
      </mapping>
      <mapping>
        <identity value="w5"/>
        <map value="id"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.active"/>
      <short value="Whether this patient's record is in active use"/>
      <definition value="Whether this patient record is in active use."/>
      <comments value="Default is true. If a record is inactive, and linked to an active record, then future
       patient/record updates should occur on the other patient."/>
      <requirements value="Need to be able to mark a patient record as not to be used because it was created in error."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="boolean"/>
      </type>
      <defaultValueBoolean value="true"/>
      <isModifier value="true"/>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="statusCode"/>
      </mapping>
      <mapping>
        <identity value="w5"/>
        <map value="status"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.name"/>
      <short value="A name associated with the patient"/>
      <definition value="A name associated with the individual."/>
      <comments value="A patient may have multiple names with different uses or applicable periods. For animals,
       the name is a &quot;HumanName&quot; in the sense that is assigned and used by humans and
       has the same patterns."/>
      <requirements value="Need to be able to track the patient by multiple names. Examples are your official name
       and a partner name."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="HumanName"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value=".patient.name"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-5, PID-9"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="name"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.telecom"/>
      <short value="A contact detail for the individual"/>
      <definition value="A contact detail (e.g. a telephone number or an email address) by which the individual
       may be contacted."/>
      <comments value="A Patient may have multiple ways to be contacted with different uses or applicable periods.
        May need to have options for contacting the person urgently and also to help with identification.
       The address may not go directly to the individual, but may reach another party that is
       able to proxy for the patient (i.e. home phone, or pet owner's phone)."/>
      <requirements value="People have (primary) ways to contact them in some way such as phone, email."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="ContactPoint"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value=".telecom"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-13, PID-14, PID-40"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="telecom"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.gender"/>
      <short value="male | female | other | unknown"/>
      <definition value="Administrative Gender - the gender that the patient is considered to have for administration
       and record keeping purposes."/>
      <comments value="The gender may not match the biological sex as determined by genetics, or the individual's
       preferred identification. Note that for both humans and particularly animals, there are
       other legitimate possibilities than M and F, though the vast majority of systems and contexts
       only support M and F.  Systems providing decision support or enforcing business rules
       should ideally do this on the basis of Observations dealing with the specific gender aspect
       of interest (anatomical, chromosonal, social, etc.)  However, because these observations
       are infrequently recorded, defaulting to the administrative gender is common practice.
        Where such defaulting occurs, rule enforcement should allow for the variation between
       administrative and biological, chromosonal and other gender aspects.  For example, an
       alert about a hysterectomy on a male should be handled as a warning or overrideable error,
       not a &quot;hard&quot; error."/>
      <requirements value="Needed for identification of the individual, in combination with (at least) name and birth
       date. Gender of individual drives many clinical processes."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="code"/>
      </type>
      <isSummary value="true"/>
      <binding>
        <strength value="required"/>
        <description value="The gender of a person used for administrative purposes."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/administrative-gender"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value=".patient.administrativeGenderCode"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-8"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/administrativeGender"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.birthDate"/>
      <short value="The date of birth for the individual"/>
      <definition value="The date of birth for the individual."/>
      <comments value="At least an estimated year should be provided as a guess if the real DOB is unknown  There
       is a standard extension &quot;patient-birthTime&quot; available that should be used where
       Time is required (such as in maternaty/infant care systems)."/>
      <requirements value="Age of the individual drives many clinical processes."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="date"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="loinc"/>
        <map value="21112-8"/>
      </mapping>
      <mapping>
        <identity value="cda"/>
        <map value=".patient.birthTime"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-7"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/birthTime"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.deceased"/>
      <short value="Indicates if the individual is deceased or not"/>
      <definition value="Indicates if the individual is deceased or not."/>
      <comments value="If there's no value in the instance it means there is no statement on whether or not the
       individual is deceased. Most systems will interpret the absence of a value as a sign of
       the person being alive."/>
      <requirements value="The fact that a patient is deceased influences the clinical process. Also, in human communication
       and relation management it is necessary to know whether the person is alive."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="boolean"/>
      </type>
      <type>
        <code value="dateTime"/>
      </type>
      <isModifier value="true"/>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-30  (bool) and PID-29 (datetime)"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/deceasedInd, player[classCode=PSN|ANM
         and determinerCode=INSTANCE]/deceasedTime"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.address"/>
      <short value="Addresses for the individual"/>
      <definition value="Addresses for the individual."/>
      <comments value="Patient may have multiple addresses with different uses or applicable periods."/>
      <requirements value="May need to keep track of patient addresses for contacting, billing or reporting requirements
       and also to help with identification."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Address"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value=".addr"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-11"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="addr"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.maritalStatus"/>
      <short value="Marital (civil) status of a patient"/>
      <definition value="This field contains a patient's most recent marital (civil) status."/>
      <requirements value="Most, if not all systems capture it."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <binding>
        <strength value="required"/>
        <description value="The domestic partnership status of a person."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/marital-status"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value=".patient.maritalStatusCode"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-16"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN]/maritalStatusCode"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.multipleBirth"/>
      <short value="Whether patient is part of a multiple birth"/>
      <definition value="Indicates whether the patient is part of a multiple or indicates the actual birth order."/>
      <requirements value="For disambiguation of multiple-birth children, especially relevant where the care provider
       doesn't meet the patient, such as labs."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="boolean"/>
      </type>
      <type>
        <code value="integer"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-24 (bool), PID-25 (integer)"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/multipleBirthInd,  player[classCode=PSN|ANM
         and determinerCode=INSTANCE]/multipleBirthOrderNumber"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.photo"/>
      <short value="Image of the patient"/>
      <definition value="Image of the patient."/>
      <requirements value="Many EHR systems have the capability to capture an image of the patient. Fits with newer
       social media usage too."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Attachment"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="OBX-5 - needs a profile"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/desc"/>
      </mapping>
    </element>
    <element>
      <extension url="http://hl7.org/fhir/StructureDefinition/structuredefinition-explicit-type-name">
        <valueString value="Contact"/>
      </extension>
      <path value="Patient.contact"/>
      <short value="A contact party (e.g. guardian, partner, friend) for the patient"/>
      <definition value="A contact party (e.g. guardian, partner, friend) for the patient."/>
      <comments value="Contact covers all kinds of contact parties: family members, business contacts, guardians,
       caregivers. Not applicable to register pedigree and family ties beyond use of having contact."/>
      <requirements value="Need to track people you can contact about the patient."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="BackboneElement"/>
      </type>
      <constraint>
        <key value="pat-1"/>
        <severity value="error"/>
        <human value="SHALL at least contain a contact's details or a reference to an organization"/>
        <xpath value="f:name or f:telecom or f:address or f:organization"/>
      </constraint>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/scopedRole[classCode=CON]"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.id"/>
      <representation value="xmlAttr"/>
      <short value="xml:id (or equivalent in JSON)"/>
      <definition value="unique id for the element within a resource (for internal references)."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="id"/>
      </type>
      <mapping>
        <identity value="rim"/>
        <map value="n/a"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.extension"/>
      <short value="Additional Content defined by implementations"/>
      <definition value="May be used to represent additional information that is not part of the basic definition
       of the element. In order to make the use of extensions safe and manageable, there is a
       strict set of governance  applied to the definition and use of extensions. Though any
       implementer is allowed to define an extension, there is a set of requirements that SHALL
       be met as part of the definition of the extension."/>
      <comments value="There can be no stigma associated with the use of extensions by any application, project,
       or standard - regardless of the institution or jurisdiction that uses or defines the extensions.
        The use of extensions is what allows the FHIR specification to retain a core level of
       simplicity for everyone."/>
      <alias value="extensions"/>
      <alias value="user content"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Extension"/>
      </type>
      <mapping>
        <identity value="rim"/>
        <map value="n/a"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.modifierExtension"/>
      <short value="Extensions that cannot be ignored"/>
      <definition value="May be used to represent additional information that is not part of the basic definition
       of the element, and that modifies the understanding of the element that contains it. Usually
       modifier elements provide negation or qualification. In order to make the use of extensions
       safe and manageable, there is a strict set of governance applied to the definition and
       use of extensions. Though any implementer is allowed to define an extension, there is
       a set of requirements that SHALL be met as part of the definition of the extension. Applications
       processing a resource are required to check for modifier extensions."/>
      <comments value="There can be no stigma associated with the use of extensions by any application, project,
       or standard - regardless of the institution or jurisdiction that uses or defines the extensions.
        The use of extensions is what allows the FHIR specification to retain a core level of
       simplicity for everyone."/>
      <alias value="extensions"/>
      <alias value="user content"/>
      <alias value="modifiers"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Extension"/>
      </type>
      <isModifier value="true"/>
      <mapping>
        <identity value="rim"/>
        <map value="N/A"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.relationship"/>
      <short value="The kind of relationship"/>
      <definition value="The nature of the relationship between the patient and the contact person."/>
      <requirements value="Used to determine which contact person is the most relevant to approach, depending on
       circumstances."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <binding>
        <strength value="extensible"/>
        <description value="The nature of the relationship between a patient and a contact person for that patient."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/patient-contact-relationship"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-7, NK1-3"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="code"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.name"/>
      <short value="A name associated with the contact person"/>
      <definition value="A name associated with the contact person."/>
      <requirements value="Contact persons need to be identified by name, but it is uncommon to need details about
       multiple other names for that contact person."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="HumanName"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-2"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="name"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.telecom"/>
      <short value="A contact detail for the person"/>
      <definition value="A contact detail for the person, e.g. a telephone number or an email address."/>
      <comments value="Contact may have multiple ways to be contacted with different uses or applicable periods.
        May need to have options for contacting the person urgently, and also to help with identification."/>
      <requirements value="People have (primary) ways to contact them in some way such as phone, email."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="ContactPoint"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-5, NK1-6, NK1-40"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="telecom"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.address"/>
      <short value="Address for the contact person"/>
      <definition value="Address for the contact person."/>
      <requirements value="Need to keep track where the contact person can be contacted per postal mail or visited."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="Address"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-4"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="addr"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.gender"/>
      <short value="male | female | other | unknown"/>
      <definition value="Administrative Gender - the gender that the contact person is considered to have for administration
       and record keeping purposes."/>
      <requirements value="Needed to address the person correctly."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="code"/>
      </type>
      <binding>
        <strength value="required"/>
        <description value="The gender of a person used for administrative purposes."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/administrative-gender"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-15"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/administrativeGender"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.organization"/>
      <short value="Organization that is associated with the contact"/>
      <definition value="Organization on behalf of which the contact is acting or for which the contact is working."/>
      <requirements value="For guardians or business related contacts, the organization is relevant."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="Reference"/>
        <profile value="http://hl7.org/fhir/StructureDefinition/Organization"/>
      </type>
      <condition value="pat-1"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-13, NK1-30, NK1-31, NK1-32, NK1-41"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="scoper"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.period"/>
      <short value="The period during which this contact person or organization is valid to be contacted relating
       to this patient"/>
      <definition value="The period during which this contact person or organization is valid to be contacted relating
       to this patient."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="Period"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="effectiveTime"/>
      </mapping>
    </element>
    <element>
      <extension url="http://hl7.org/fhir/StructureDefinition/structuredefinition-explicit-type-name">
        <valueString value="Animal"/>
      </extension>
      <path value="Patient.animal"/>
      <short value="This patient is known to be an animal (non-human)"/>
      <definition value="This patient is known to be an animal."/>
      <comments value="The animal element is labeled &quot;Is Modifier&quot; since patients may be non-human.
       Systems SHALL either handle patient details appropriately (e.g. inform users patient is
       not human) or reject declared animal records.   The absense of the animal element does
       not imply that the patient is a human. If a system requires such a positive assertion
       that the patient is human, an extension will be required.  (Do not use a species of homo-sapiens
       in animal species, as this would incorrectly infer that the patient is an animal)."/>
      <requirements value="Many clinical systems are extended to care for animal patients as well as human."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="BackboneElement"/>
      </type>
      <isModifier value="true"/>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=ANM]"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.animal.id"/>
      <representation value="xmlAttr"/>
      <short value="xml:id (or equivalent in JSON)"/>
      <definition value="unique id for the element within a resource (for internal references)."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="id"/>
      </type>
      <mapping>
        <identity value="rim"/>
        <map value="n/a"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.animal.extension"/>
      <short value="Additional Content defined by implementations"/>
      <definition value="May be used to represent additional information that is not part of the basic definition
       of the element. In order to make the use of extensions safe and manageable, there is a
       strict set of governance  applied to the definition and use of extensions. Though any
       implementer is allowed to define an extension, there is a set of requirements that SHALL
       be met as part of the definition of the extension."/>
      <comments value="There can be no stigma associated with the use of extensions by any application, project,
       or standard - regardless of the institution or jurisdiction that uses or defines the extensions.
        The use of extensions is what allows the FHIR specification to retain a core level of
       simplicity for everyone."/>
      <alias value="extensions"/>
      <alias value="user content"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Extension"/>
      </type>
      <mapping>
        <identity value="rim"/>
        <map value="n/a"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.animal.modifierExtension"/>
      <short value="Extensions that cannot be ignored"/>
      <definition value="May be used to represent additional information that is not part of the basic definition
       of the element, and that modifies the understanding of the element that contains it. Usually
       modifier elements provide negation or qualification. In order to make the use of extensions
       safe and manageable, there is a strict set of governance applied to the definition and
       use of extensions. Though any implementer is allowed to define an extension, there is
       a set of requirements that SHALL be met as part of the definition of the extension. Applications
       processing a resource are required to check for modifier extensions."/>
      <comments value="There can be no stigma associated with the use of extensions by any application, project,
       or standard - regardless of the institution or jurisdiction that uses or defines the extensions.
        The use of extensions is what allows the FHIR specification to retain a core level of
       simplicity for everyone."/>
      <alias value="extensions"/>
      <alias value="user content"/>
      <alias value="modifiers"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Extension"/>
      </type>
      <isModifier value="true"/>
      <mapping>
        <identity value="rim"/>
        <map value="N/A"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.animal.species"/>
      <short value="E.g. Dog, Cow"/>
      <definition value="Identifies the high level taxonomic categorization of the kind of animal."/>
      <comments value="If the patient is non-human, at least a species SHALL be specified. Species SHALL be a
       widely recognised taxonomic classification.  It may or may not be Linnaean taxonomy and
       may or may not be at the level of species. If the level is finer than species--such as
       a breed code--the code system used SHALL allow inference of the species.  (The common
       example is that the word &quot;Hereford&quot; does not allow inference of the species
       Bos taurus, because there is a Hereford pig breed, but the SNOMED CT code for &quot;Hereford
       Cattle Breed&quot; does.)."/>
      <requirements value="Need to know what kind of animal."/>
      <min value="1"/>
      <max value="1"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <isSummary value="true"/>
      <binding>
        <strength value="example"/>
        <description value="The species of an animal."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/animal-species"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-35"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="code"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.animal.breed"/>
      <short value="E.g. Poodle, Angus"/>
      <definition value="Identifies the detailed categorization of the kind of animal."/>
      <comments value="Breed MAY be used to provide further taxonomic or non-taxonomic classification.  It may
       involve local or proprietary designation--such as commercial strain--and/or additional
       information such as production type."/>
      <requirements value="May need to know the specific kind within the species."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <isSummary value="true"/>
      <binding>
        <strength value="example"/>
        <description value="The breed of an animal."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/animal-breeds"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-37"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="playedRole[classCode=GEN]/scoper[classCode=ANM, determinerCode=KIND]/code"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.animal.genderStatus"/>
      <short value="E.g. Neutered, Intact"/>
      <definition value="Indicates the current state of the animal's reproductive organs."/>
      <requirements value="Gender status can affect housing and animal behavior."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <isSummary value="true"/>
      <binding>
        <strength value="example"/>
        <description value="The state of the animal's reproductive organs."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/animal-genderstatus"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="N/A"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="genderStatusCode"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.communication"/>
      <short value="A list of Languages which may be used to communicate with the patient about his or her
       health"/>
      <definition value="Languages which may be used to communicate with the patient about his or her health."/>
      <comments value="If no language is specified, this *implies* that the default local language is spoken.
        If you need to convey proficiency for multiple modes then you need multiple Patient.Communication
       associations.   For animals, language is not a relevant field, and should be absent from
       the instance. If the Patient does not speak the default local language, then the Interpreter
       Required Standard can be used to explicitly declare that an interpreter is required."/>
      <requirements value="If a patient does not speak the local language, interpreters may be required, so languages
       spoken and proficiency is an important things to keep track of both for patient and other
       persons of interest."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="BackboneElement"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="patient.languageCommunication"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="LanguageCommunication"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.communication.id"/>
      <representation value="xmlAttr"/>
      <short value="xml:id (or equivalent in JSON)"/>
      <definition value="unique id for the element within a resource (for internal references)."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="id"/>
      </type>
      <mapping>
        <identity value="rim"/>
        <map value="n/a"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.communication.extension"/>
      <short value="Additional Content defined by implementations"/>
      <definition value="May be used to represent additional information that is not part of the basic definition
       of the element. In order to make the use of extensions safe and manageable, there is a
       strict set of governance  applied to the definition and use of extensions. Though any
       implementer is allowed to define an extension, there is a set of requirements that SHALL
       be met as part of the definition of the extension."/>
      <comments value="There can be no stigma associated with the use of extensions by any application, project,
       or standard - regardless of the institution or jurisdiction that uses or defines the extensions.
        The use of extensions is what allows the FHIR specification to retain a core level of
       simplicity for everyone."/>
      <alias value="extensions"/>
      <alias value="user content"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Extension"/>
      </type>
      <mapping>
        <identity value="rim"/>
        <map value="n/a"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.communication.modifierExtension"/>
      <short value="Extensions that cannot be ignored"/>
      <definition value="May be used to represent additional information that is not part of the basic definition
       of the element, and that modifies the understanding of the element that contains it. Usually
       modifier elements provide negation or qualification. In order to make the use of extensions
       safe and manageable, there is a strict set of governance applied to the definition and
       use of extensions. Though any implementer is allowed to define an extension, there is
       a set of requirements that SHALL be met as part of the definition of the extension. Applications
       processing a resource are required to check for modifier extensions."/>
      <comments value="There can be no stigma associated with the use of extensions by any application, project,
       or standard - regardless of the institution or jurisdiction that uses or defines the extensions.
        The use of extensions is what allows the FHIR specification to retain a core level of
       simplicity for everyone."/>
      <alias value="extensions"/>
      <alias value="user content"/>
      <alias value="modifiers"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Extension"/>
      </type>
      <isModifier value="true"/>
      <mapping>
        <identity value="rim"/>
        <map value="N/A"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.communication.language"/>
      <short value="The language which can be used to communicate with the patient about his or her health"/>
      <definition value="The ISO-639-1 alpha 2 code in lower case for the language, optionally followed by a hyphen
       and the ISO-3166-1 alpha 2 code for the region in upper case; e.g. &quot;en&quot; for
       English, or &quot;en-US&quot; for American English versus &quot;en-EN&quot; for England
       English."/>
      <comments value="The structure aa-BB with this exact casing is one the most widely used notations for locale.
       However not all systems actually code this but instead have it as free text. Hence CodeableConcept
       instead of code as the data type."/>
      <requirements value="Most systems in multilingual countries will want to convey language. Not all systems actually
       need the regional dialect."/>
      <min value="1"/>
      <max value="1"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <binding>
        <strength value="required"/>
        <description value="A human language."/>
        <valueSetUri value="http://tools.ietf.org/html/bcp47"/>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value=".languageCode"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-15, LAN-2"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/languageCommunication/code"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.communication.preferred"/>
      <short value="Language preference indicator"/>
      <definition value="Indicates whether or not the patient prefers this language (over other languages he masters
       up a certain level)."/>
      <comments value="This language is specifically identified for communicating healthcare information."/>
      <requirements value="People that master multiple languages up to certain level may prefer one or more, i.e.
       feel more confident in communicating in a particular language making other languages sort
       of a fall back method."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="boolean"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value=".preferenceInd"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-15"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="preferenceInd"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.careProvider"/>
      <short value="Patient's nominated primary care provider"/>
      <definition value="Patient's nominated care provider."/>
      <comments value="This may be the primary care provider (in a GP context), or it may be a patient nominated
       care manager in a community/disablity setting, or even organization that will provide
       people to perform the care provider roles.  This is not to be used to record Care Teams,
       these should be recorded on either the CarePlan or EpisodeOfCare resources."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Reference"/>
        <profile value="http://hl7.org/fhir/StructureDefinition/Organization"/>
      </type>
      <type>
        <code value="Reference"/>
        <profile value="http://hl7.org/fhir/StructureDefinition/Practitioner"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PD1-4"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="subjectOf.CareEvent.performer.AssignedEntity"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.managingOrganization"/>
      <short value="Organization that is the custodian of the patient record"/>
      <definition value="Organization that is the custodian of the patient record."/>
      <comments value="There is only one managing organization for a specific patient record. Other organizations
       will have their own Patient record, and may use the Link property to join the records
       together (or a Person resource which can include confidence ratings for the association)."/>
      <requirements value="Need to know who recognizes this patient record, manages and updates it."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="Reference"/>
        <profile value="http://hl7.org/fhir/StructureDefinition/Organization"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value=".providerOrganization"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="scoper"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.link"/>
      <short value="Link to another patient resource that concerns the same actual person"/>
      <definition value="Link to another patient resource that concerns the same actual patient."/>
      <comments value="There is no assumption that linked patient records have mutual links."/>
      <requirements value="There are multiple usecases:   * Duplicate patient records due to the clerical errors
       associated with the difficulties of identifying humans consistently, and * Distribution
       of patient information across multiple servers."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="BackboneElement"/>
      </type>
      <isModifier value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="outboundLink"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.link.id"/>
      <representation value="xmlAttr"/>
      <short value="xml:id (or equivalent in JSON)"/>
      <definition value="unique id for the element within a resource (for internal references)."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="id"/>
      </type>
      <mapping>
        <identity value="rim"/>
        <map value="n/a"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.link.extension"/>
      <short value="Additional Content defined by implementations"/>
      <definition value="May be used to represent additional information that is not part of the basic definition
       of the element. In order to make the use of extensions safe and manageable, there is a
       strict set of governance  applied to the definition and use of extensions. Though any
       implementer is allowed to define an extension, there is a set of requirements that SHALL
       be met as part of the definition of the extension."/>
      <comments value="There can be no stigma associated with the use of extensions by any application, project,
       or standard - regardless of the institution or jurisdiction that uses or defines the extensions.
        The use of extensions is what allows the FHIR specification to retain a core level of
       simplicity for everyone."/>
      <alias value="extensions"/>
      <alias value="user content"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Extension"/>
      </type>
      <mapping>
        <identity value="rim"/>
        <map value="n/a"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.link.modifierExtension"/>
      <short value="Extensions that cannot be ignored"/>
      <definition value="May be used to represent additional information that is not part of the basic definition
       of the element, and that modifies the understanding of the element that contains it. Usually
       modifier elements provide negation or qualification. In order to make the use of extensions
       safe and manageable, there is a strict set of governance applied to the definition and
       use of extensions. Though any implementer is allowed to define an extension, there is
       a set of requirements that SHALL be met as part of the definition of the extension. Applications
       processing a resource are required to check for modifier extensions."/>
      <comments value="There can be no stigma associated with the use of extensions by any application, project,
       or standard - regardless of the institution or jurisdiction that uses or defines the extensions.
        The use of extensions is what allows the FHIR specification to retain a core level of
       simplicity for everyone."/>
      <alias value="extensions"/>
      <alias value="user content"/>
      <alias value="modifiers"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Extension"/>
      </type>
      <isModifier value="true"/>
      <mapping>
        <identity value="rim"/>
        <map value="N/A"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.link.other"/>
      <short value="The other patient resource that the link refers to"/>
      <definition value="The other patient resource that the link refers to."/>
      <min value="1"/>
      <max value="1"/>
      <type>
        <code value="Reference"/>
        <profile value="http://hl7.org/fhir/StructureDefinition/Patient"/>
      </type>
      <isModifier value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-3, MRG-1"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="id"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.link.type"/>
      <short value="replace | refer | seealso - type of link"/>
      <definition value="The type of link between this patient resource and another patient resource."/>
      <min value="1"/>
      <max value="1"/>
      <type>
        <code value="code"/>
      </type>
      <isModifier value="true"/>
      <binding>
        <strength value="required"/>
        <description value="The type of link between this patient resource and another patient resource."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/link-type"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="typeCode"/>
      </mapping>
    </element>
  </snapshot>
  <differential>
    <element>
      <path value="Patient"/>
      <short value="Information about an individual or animal receiving health care services"/>
      <definition value="Demographics and other administrative information about an individual or animal receiving
       care or other health-related services."/>
      <alias value="SubjectOfCare Client Resident"/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="DomainResource"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="ClinicalDocument.recordTarget.patientRole"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="Patient[classCode=PAT]"/>
      </mapping>
      <mapping>
        <identity value="w5"/>
        <map value="administrative.individual"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.identifier"/>
      <short value="An identifier for this patient"/>
      <definition value="An identifier for this patient."/>
      <requirements value="Patients are almost always assigned specific numerical identifiers."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Identifier"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value=".id"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-3"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="id"/>
      </mapping>
      <mapping>
        <identity value="w5"/>
        <map value="id"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.active"/>
      <short value="Whether this patient's record is in active use"/>
      <definition value="Whether this patient record is in active use."/>
      <comments value="Default is true. If a record is inactive, and linked to an active record, then future
       patient/record updates should occur on the other patient."/>
      <requirements value="Need to be able to mark a patient record as not to be used because it was created in error."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="boolean"/>
      </type>
      <defaultValueBoolean value="true"/>
      <isModifier value="true"/>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="statusCode"/>
      </mapping>
      <mapping>
        <identity value="w5"/>
        <map value="status"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.name"/>
      <short value="A name associated with the patient"/>
      <definition value="A name associated with the individual."/>
      <comments value="A patient may have multiple names with different uses or applicable periods. For animals,
       the name is a &quot;HumanName&quot; in the sense that is assigned and used by humans and
       has the same patterns."/>
      <requirements value="Need to be able to track the patient by multiple names. Examples are your official name
       and a partner name."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="HumanName"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value=".patient.name"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-5, PID-9"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="name"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.telecom"/>
      <short value="A contact detail for the individual"/>
      <definition value="A contact detail (e.g. a telephone number or an email address) by which the individual
       may be contacted."/>
      <comments value="A Patient may have multiple ways to be contacted with different uses or applicable periods.
        May need to have options for contacting the person urgently and also to help with identification.
       The address may not go directly to the individual, but may reach another party that is
       able to proxy for the patient (i.e. home phone, or pet owner's phone)."/>
      <requirements value="People have (primary) ways to contact them in some way such as phone, email."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="ContactPoint"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value=".telecom"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-13, PID-14, PID-40"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="telecom"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.gender"/>
      <short value="male | female | other | unknown"/>
      <definition value="Administrative Gender - the gender that the patient is considered to have for administration
       and record keeping purposes."/>
      <comments value="The gender may not match the biological sex as determined by genetics, or the individual's
       preferred identification. Note that for both humans and particularly animals, there are
       other legitimate possibilities than M and F, though the vast majority of systems and contexts
       only support M and F.  Systems providing decision support or enforcing business rules
       should ideally do this on the basis of Observations dealing with the specific gender aspect
       of interest (anatomical, chromosonal, social, etc.)  However, because these observations
       are infrequently recorded, defaulting to the administrative gender is common practice.
        Where such defaulting occurs, rule enforcement should allow for the variation between
       administrative and biological, chromosonal and other gender aspects.  For example, an
       alert about a hysterectomy on a male should be handled as a warning or overrideable error,
       not a &quot;hard&quot; error."/>
      <requirements value="Needed for identification of the individual, in combination with (at least) name and birth
       date. Gender of individual drives many clinical processes."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="code"/>
      </type>
      <isSummary value="true"/>
      <binding>
        <strength value="required"/>
        <description value="The gender of a person used for administrative purposes."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/administrative-gender"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value=".patient.administrativeGenderCode"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-8"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/administrativeGender"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.birthDate"/>
      <short value="The date of birth for the individual"/>
      <definition value="The date of birth for the individual."/>
      <comments value="At least an estimated year should be provided as a guess if the real DOB is unknown  There
       is a standard extension &quot;patient-birthTime&quot; available that should be used where
       Time is required (such as in maternaty/infant care systems)."/>
      <requirements value="Age of the individual drives many clinical processes."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="date"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="loinc"/>
        <map value="21112-8"/>
      </mapping>
      <mapping>
        <identity value="cda"/>
        <map value=".patient.birthTime"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-7"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/birthTime"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.deceased"/>
      <short value="Indicates if the individual is deceased or not"/>
      <definition value="Indicates if the individual is deceased or not."/>
      <comments value="If there's no value in the instance it means there is no statement on whether or not the
       individual is deceased. Most systems will interpret the absence of a value as a sign of
       the person being alive."/>
      <requirements value="The fact that a patient is deceased influences the clinical process. Also, in human communication
       and relation management it is necessary to know whether the person is alive."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="boolean"/>
      </type>
      <type>
        <code value="dateTime"/>
      </type>
      <isModifier value="true"/>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-30  (bool) and PID-29 (datetime)"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/deceasedInd, player[classCode=PSN|ANM
         and determinerCode=INSTANCE]/deceasedTime"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.address"/>
      <short value="Addresses for the individual"/>
      <definition value="Addresses for the individual."/>
      <comments value="Patient may have multiple addresses with different uses or applicable periods."/>
      <requirements value="May need to keep track of patient addresses for contacting, billing or reporting requirements
       and also to help with identification."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Address"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value=".addr"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-11"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="addr"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.maritalStatus"/>
      <short value="Marital (civil) status of a patient"/>
      <definition value="This field contains a patient's most recent marital (civil) status."/>
      <requirements value="Most, if not all systems capture it."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <binding>
        <strength value="required"/>
        <description value="The domestic partnership status of a person."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/marital-status"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value=".patient.maritalStatusCode"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-16"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN]/maritalStatusCode"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.multipleBirth"/>
      <short value="Whether patient is part of a multiple birth"/>
      <definition value="Indicates whether the patient is part of a multiple or indicates the actual birth order."/>
      <requirements value="For disambiguation of multiple-birth children, especially relevant where the care provider
       doesn't meet the patient, such as labs."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="boolean"/>
      </type>
      <type>
        <code value="integer"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-24 (bool), PID-25 (integer)"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/multipleBirthInd,  player[classCode=PSN|ANM
         and determinerCode=INSTANCE]/multipleBirthOrderNumber"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.photo"/>
      <short value="Image of the patient"/>
      <definition value="Image of the patient."/>
      <requirements value="Many EHR systems have the capability to capture an image of the patient. Fits with newer
       social media usage too."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Attachment"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="OBX-5 - needs a profile"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/desc"/>
      </mapping>
    </element>
    <element>
      <extension url="http://hl7.org/fhir/StructureDefinition/structuredefinition-explicit-type-name">
        <valueString value="Contact"/>
      </extension>
      <path value="Patient.contact"/>
      <short value="A contact party (e.g. guardian, partner, friend) for the patient"/>
      <definition value="A contact party (e.g. guardian, partner, friend) for the patient."/>
      <comments value="Contact covers all kinds of contact parties: family members, business contacts, guardians,
       caregivers. Not applicable to register pedigree and family ties beyond use of having contact."/>
      <requirements value="Need to track people you can contact about the patient."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="BackboneElement"/>
      </type>
      <constraint>
        <key value="pat-1"/>
        <severity value="error"/>
        <human value="SHALL at least contain a contact's details or a reference to an organization"/>
        <xpath value="f:name or f:telecom or f:address or f:organization"/>
      </constraint>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/scopedRole[classCode=CON]"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.relationship"/>
      <short value="The kind of relationship"/>
      <definition value="The nature of the relationship between the patient and the contact person."/>
      <requirements value="Used to determine which contact person is the most relevant to approach, depending on
       circumstances."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <binding>
        <strength value="extensible"/>
        <description value="The nature of the relationship between a patient and a contact person for that patient."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/patient-contact-relationship"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-7, NK1-3"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="code"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.name"/>
      <short value="A name associated with the contact person"/>
      <definition value="A name associated with the contact person."/>
      <requirements value="Contact persons need to be identified by name, but it is uncommon to need details about
       multiple other names for that contact person."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="HumanName"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-2"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="name"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.telecom"/>
      <short value="A contact detail for the person"/>
      <definition value="A contact detail for the person, e.g. a telephone number or an email address."/>
      <comments value="Contact may have multiple ways to be contacted with different uses or applicable periods.
        May need to have options for contacting the person urgently, and also to help with identification."/>
      <requirements value="People have (primary) ways to contact them in some way such as phone, email."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="ContactPoint"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-5, NK1-6, NK1-40"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="telecom"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.address"/>
      <short value="Address for the contact person"/>
      <definition value="Address for the contact person."/>
      <requirements value="Need to keep track where the contact person can be contacted per postal mail or visited."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="Address"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-4"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="addr"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.gender"/>
      <short value="male | female | other | unknown"/>
      <definition value="Administrative Gender - the gender that the contact person is considered to have for administration
       and record keeping purposes."/>
      <requirements value="Needed to address the person correctly."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="code"/>
      </type>
      <binding>
        <strength value="required"/>
        <description value="The gender of a person used for administrative purposes."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/administrative-gender"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-15"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/administrativeGender"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.organization"/>
      <short value="Organization that is associated with the contact"/>
      <definition value="Organization on behalf of which the contact is acting or for which the contact is working."/>
      <requirements value="For guardians or business related contacts, the organization is relevant."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="Reference"/>
        <profile value="http://hl7.org/fhir/StructureDefinition/Organization"/>
      </type>
      <condition value="pat-1"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="NK1-13, NK1-30, NK1-31, NK1-32, NK1-41"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="scoper"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.contact.period"/>
      <short value="The period during which this contact person or organization is valid to be contacted relating
       to this patient"/>
      <definition value="The period during which this contact person or organization is valid to be contacted relating
       to this patient."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="Period"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="effectiveTime"/>
      </mapping>
    </element>
    <element>
      <extension url="http://hl7.org/fhir/StructureDefinition/structuredefinition-explicit-type-name">
        <valueString value="Animal"/>
      </extension>
      <path value="Patient.animal"/>
      <short value="This patient is known to be an animal (non-human)"/>
      <definition value="This patient is known to be an animal."/>
      <comments value="The animal element is labeled &quot;Is Modifier&quot; since patients may be non-human.
       Systems SHALL either handle patient details appropriately (e.g. inform users patient is
       not human) or reject declared animal records.   The absense of the animal element does
       not imply that the patient is a human. If a system requires such a positive assertion
       that the patient is human, an extension will be required.  (Do not use a species of homo-sapiens
       in animal species, as this would incorrectly infer that the patient is an animal)."/>
      <requirements value="Many clinical systems are extended to care for animal patients as well as human."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="BackboneElement"/>
      </type>
      <isModifier value="true"/>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=ANM]"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.animal.species"/>
      <short value="E.g. Dog, Cow"/>
      <definition value="Identifies the high level taxonomic categorization of the kind of animal."/>
      <comments value="If the patient is non-human, at least a species SHALL be specified. Species SHALL be a
       widely recognised taxonomic classification.  It may or may not be Linnaean taxonomy and
       may or may not be at the level of species. If the level is finer than species--such as
       a breed code--the code system used SHALL allow inference of the species.  (The common
       example is that the word &quot;Hereford&quot; does not allow inference of the species
       Bos taurus, because there is a Hereford pig breed, but the SNOMED CT code for &quot;Hereford
       Cattle Breed&quot; does.)."/>
      <requirements value="Need to know what kind of animal."/>
      <min value="1"/>
      <max value="1"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <isSummary value="true"/>
      <binding>
        <strength value="example"/>
        <description value="The species of an animal."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/animal-species"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-35"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="code"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.animal.breed"/>
      <short value="E.g. Poodle, Angus"/>
      <definition value="Identifies the detailed categorization of the kind of animal."/>
      <comments value="Breed MAY be used to provide further taxonomic or non-taxonomic classification.  It may
       involve local or proprietary designation--such as commercial strain--and/or additional
       information such as production type."/>
      <requirements value="May need to know the specific kind within the species."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <isSummary value="true"/>
      <binding>
        <strength value="example"/>
        <description value="The breed of an animal."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/animal-breeds"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-37"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="playedRole[classCode=GEN]/scoper[classCode=ANM, determinerCode=KIND]/code"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.animal.genderStatus"/>
      <short value="E.g. Neutered, Intact"/>
      <definition value="Indicates the current state of the animal's reproductive organs."/>
      <requirements value="Gender status can affect housing and animal behavior."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <isSummary value="true"/>
      <binding>
        <strength value="example"/>
        <description value="The state of the animal's reproductive organs."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/animal-genderstatus"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="N/A"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="genderStatusCode"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.communication"/>
      <short value="A list of Languages which may be used to communicate with the patient about his or her
       health"/>
      <definition value="Languages which may be used to communicate with the patient about his or her health."/>
      <comments value="If no language is specified, this *implies* that the default local language is spoken.
        If you need to convey proficiency for multiple modes then you need multiple Patient.Communication
       associations.   For animals, language is not a relevant field, and should be absent from
       the instance. If the Patient does not speak the default local language, then the Interpreter
       Required Standard can be used to explicitly declare that an interpreter is required."/>
      <requirements value="If a patient does not speak the local language, interpreters may be required, so languages
       spoken and proficiency is an important things to keep track of both for patient and other
       persons of interest."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="BackboneElement"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="patient.languageCommunication"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="LanguageCommunication"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.communication.language"/>
      <short value="The language which can be used to communicate with the patient about his or her health"/>
      <definition value="The ISO-639-1 alpha 2 code in lower case for the language, optionally followed by a hyphen
       and the ISO-3166-1 alpha 2 code for the region in upper case; e.g. &quot;en&quot; for
       English, or &quot;en-US&quot; for American English versus &quot;en-EN&quot; for England
       English."/>
      <comments value="The structure aa-BB with this exact casing is one the most widely used notations for locale.
       However not all systems actually code this but instead have it as free text. Hence CodeableConcept
       instead of code as the data type."/>
      <requirements value="Most systems in multilingual countries will want to convey language. Not all systems actually
       need the regional dialect."/>
      <min value="1"/>
      <max value="1"/>
      <type>
        <code value="CodeableConcept"/>
      </type>
      <binding>
        <strength value="required"/>
        <description value="A human language."/>
        <valueSetUri value="http://tools.ietf.org/html/bcp47"/>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value=".languageCode"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-15, LAN-2"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="player[classCode=PSN|ANM and determinerCode=INSTANCE]/languageCommunication/code"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.communication.preferred"/>
      <short value="Language preference indicator"/>
      <definition value="Indicates whether or not the patient prefers this language (over other languages he masters
       up a certain level)."/>
      <comments value="This language is specifically identified for communicating healthcare information."/>
      <requirements value="People that master multiple languages up to certain level may prefer one or more, i.e.
       feel more confident in communicating in a particular language making other languages sort
       of a fall back method."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="boolean"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value=".preferenceInd"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-15"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="preferenceInd"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.careProvider"/>
      <short value="Patient's nominated primary care provider"/>
      <definition value="Patient's nominated care provider."/>
      <comments value="This may be the primary care provider (in a GP context), or it may be a patient nominated
       care manager in a community/disablity setting, or even organization that will provide
       people to perform the care provider roles.  This is not to be used to record Care Teams,
       these should be recorded on either the CarePlan or EpisodeOfCare resources."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="Reference"/>
        <profile value="http://hl7.org/fhir/StructureDefinition/Organization"/>
      </type>
      <type>
        <code value="Reference"/>
        <profile value="http://hl7.org/fhir/StructureDefinition/Practitioner"/>
      </type>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PD1-4"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="subjectOf.CareEvent.performer.AssignedEntity"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.managingOrganization"/>
      <short value="Organization that is the custodian of the patient record"/>
      <definition value="Organization that is the custodian of the patient record."/>
      <comments value="There is only one managing organization for a specific patient record. Other organizations
       will have their own Patient record, and may use the Link property to join the records
       together (or a Person resource which can include confidence ratings for the association)."/>
      <requirements value="Need to know who recognizes this patient record, manages and updates it."/>
      <min value="0"/>
      <max value="1"/>
      <type>
        <code value="Reference"/>
        <profile value="http://hl7.org/fhir/StructureDefinition/Organization"/>
      </type>
      <isSummary value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value=".providerOrganization"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="scoper"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.link"/>
      <short value="Link to another patient resource that concerns the same actual person"/>
      <definition value="Link to another patient resource that concerns the same actual patient."/>
      <comments value="There is no assumption that linked patient records have mutual links."/>
      <requirements value="There are multiple usecases:   * Duplicate patient records due to the clerical errors
       associated with the difficulties of identifying humans consistently, and * Distribution
       of patient information across multiple servers."/>
      <min value="0"/>
      <max value="*"/>
      <type>
        <code value="BackboneElement"/>
      </type>
      <isModifier value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="outboundLink"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.link.other"/>
      <short value="The other patient resource that the link refers to"/>
      <definition value="The other patient resource that the link refers to."/>
      <min value="1"/>
      <max value="1"/>
      <type>
        <code value="Reference"/>
        <profile value="http://hl7.org/fhir/StructureDefinition/Patient"/>
      </type>
      <isModifier value="true"/>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="v2"/>
        <map value="PID-3, MRG-1"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="id"/>
      </mapping>
    </element>
    <element>
      <path value="Patient.link.type"/>
      <short value="replace | refer | seealso - type of link"/>
      <definition value="The type of link between this patient resource and another patient resource."/>
      <min value="1"/>
      <max value="1"/>
      <type>
        <code value="code"/>
      </type>
      <isModifier value="true"/>
      <binding>
        <strength value="required"/>
        <description value="The type of link between this patient resource and another patient resource."/>
        <valueSetReference>
          <reference value="http://hl7.org/fhir/ValueSet/link-type"/>
        </valueSetReference>
      </binding>
      <mapping>
        <identity value="cda"/>
        <map value="n/a"/>
      </mapping>
      <mapping>
        <identity value="rim"/>
        <map value="typeCode"/>
      </mapping>
    </element>
  </differential>
</StructureDefinition>
]]

return Patient