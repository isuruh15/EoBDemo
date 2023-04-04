

# ExplanationOfBenefit Template

## Template Overview

This template provides a boilerplate code for rapid implementation of FHIR APIs and creating, accessing and manipulating FHIR resources.


| Module/Element       | Version |
|---| --- |
| FHIR version         | r4 |
| Implementation Guide | [http://hl7.org/fhir](http://hl7.org/fhir) |
| Profile URL          |[http://hl7.org/fhir/StructureDefinition/ExplanationOfBenefit](http://hl7.org/fhir/StructureDefinition/ExplanationOfBenefit)|

### Dependency List

| Module | Version |
| --- | --- |
| wso2healthcare/healthcare.fhir.r4 | 0.1.13 |
| wso2healthcare/healthcare.base | 0.1.3 |
|

This template includes,

- Ballerina service for 'FHIR Resource Name' FHIR resource with following FHIR interactions.
- READ
- SEARCH
- CREATE
- Generated Utility functions to handle context data
- Pre-engaged FHIR pre-processors and post-processors for built-in FHIR Server capabilities


## Prerequisites

Pull the template from central

    ` bal new -t wso2healthcare/healthcare.fhir.r4.api.explanationofbenefit ExplanationOfBenefitAPI `

## Implementing Source System Connections

- Implement each FHIR interaction in `<resource name>_connect.bal` file which included in the project.
- You can use relevant client connector, object to initialize the connection to fetch/push data from/to the source system.
- Method signatures should not be modified and request information will be populated in the `fhirContext` for ease of access.

## Run the template
- Run the Ballerina project created by the service template by executing bal run from the root.
- Once successfully executed, Listener will be started at port 9090. Then you need to invoke the service using the following curl command
    ` $ curl http://localhost:9090/fhir/r4/ExplanationOfBenefit `
- Now service will be invoked and returns the message as FHIR bundle

    ```
    {

        "resourceType":"Bundle",

        "entry":[{},{}]

    }
    ```
## Adding a Custom Profile/Combination of Profiles

- Introduce a new file containing a class which implements functions for FHIR interactions.
- This class need to implement `ExplanationOfBenefitSourceConnect` object type
- It needs to have the same structure as the ` international_explanationofbenefit_connect ` file.
- Register the new class in the `service.bal` file.
- Add and entry to `profileImpl` map as `profileURL:instantiated source connect class`. Eg: `"http://hl7.org/fhir/StructureDefinition/ExplanationOfBenefit": new InternationalExplanationOfBenefitSourceConnect()`
- Add profile type to the aggregated resource type. Eg: `public type ExplanationOfBenefit r4:ExplanationOfBenefit|<Other_ExplanationOfBenefit_Profile>;`.
    - Add the new profile URL in `api_config.bal` file.
    - Add as a string inside the `profiles` array.
    - Eg: `profiles: ["http://hl7.org/fhir/StructureDefinition/ExplanationOfBenefit", "new_profile_url"]`

## Onboard as a Choreo project
This project can be onboarded directly to Choreo via Github.
For more info, Refer: https://wso2.com/choreo/docs/tutorials/connect-your-existing-ballerina-project-to-choreo/#connect-your-existing-ballerina-project-to-choreo
