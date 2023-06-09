// // Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.

// This software is the property of WSO2 LLC. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein is strictly forbidden, unless permitted by WSO2 in accordance with
// the WSO2 Software License available at: https://wso2.com/licenses/eula/3.2
// For specific language governing the permissions and limitations under
// this license, please see the license as well as any agreement you’ve
// entered into with WSO2 governing the purchase of this software and any
// associated services.
//
// AUTO-GENERATED FILE.
//
// This file is auto-generated by WSO2 Healthcare Team for implementing source system connections.
// Developers are allowed modify this file as per the requirement.

import ballerina/http ;
import wso2healthcare/healthcare.fhir.r4 ;

configurable string sourceSystem = "http://localhost:9091";

final string READ = sourceSystem.endsWith("/") ? "read/" : "/read/";
final string SEARCH = sourceSystem.endsWith("/") ? "search" : "/search";
final string CREATE = sourceSystem.endsWith("/") ? "create" : "/create";

final http:Client sourceEp = check new (sourceSystem);

public isolated class InternationalExplanationofbenefitSourceConnect {

    *ExplanationOfBenefitSourceConnect;
    isolated function profile() returns r4:uri {
        return "http://hl7.org/fhir/StructureDefinition/ExplanationOfBenefit";
    }

    isolated function read(string id, r4:FHIRContext fhirContext) returns ExplanationOfBenefit|r4:FHIRError {

        http:Response|http:ClientError res =  sourceEp->get(READ + id);
        if (res is http:ClientError) {
            r4:FHIRError fhirError = r4:createFHIRError("Error occured when calling the source system.", r4:CODE_SEVERITY_ERROR,r4:TRANSIENT_EXCEPTION);
            return fhirError;
        } else {
            json|error payload = res.getJsonPayload();
            if (payload is error) {
                r4:FHIRError fhirError = r4:createFHIRError("Unable to extract JSON payload from the source response.", r4:CODE_SEVERITY_ERROR,r4:TRANSIENT_EXCEPTION);
                return fhirError;
            } else {
                r4:ExplanationOfBenefit|error fhirResource = payload.cloneWithType(r4:ExplanationOfBenefit);
                if (fhirResource is error) {
                    r4:FHIRError fhirError = r4:createFHIRError("Did not get a FHIR Resource from source.", r4:CODE_SEVERITY_ERROR,r4:TRANSIENT_EXCEPTION);
                    return fhirError;
                } else {
                    return fhirResource;
                }
            }
        }
    }

    isolated function search(map<r4:RequestSearchParameter[]> params, r4:FHIRContext fhirContext) returns r4:Bundle|ExplanationOfBenefit[]|r4:FHIRError {

        //convert search parameters to map<string|string[]>
        map<string|string[]> searchParams = {};
        foreach var [key, value] in params.entries() {
            foreach var param in value {
                searchParams[key] = param.value;
            }
        }
        //convert search parameters to query string
        string queryString = "";
        foreach var [key, value] in searchParams.entries() {
            // check if value is an array
            if (value is string[]) {
                foreach var v in value {
                    queryString = queryString + key + "=" + v + "&";
                }
            } else {
                queryString = queryString + key + "=" + <string>value + "&";
            }
        }
        //remove last & if query string is not empty
        if (queryString != "") {
            queryString = "?" + queryString.substring(0, queryString.length() - 1);
        }

        http:Response|http:ClientError res = sourceEp->get(SEARCH + queryString);
        if (res is http:ClientError) {
            r4:FHIRError fhirError = r4:createFHIRError("Error occured when calling the source system.", r4:CODE_SEVERITY_ERROR, r4:TRANSIENT_EXCEPTION);
            return fhirError;
        } else {
            json|error payload = res.getJsonPayload();
            if (payload is error) {
                r4:FHIRError fhirError = r4:createFHIRError("Unable to extract JSON payload from the source response.", r4:CODE_SEVERITY_ERROR, r4:TRANSIENT_EXCEPTION);
                return fhirError;
            } else {
                if (payload is json[]) {
                    json[] payloadArray = <json[]>payload;
                    ExplanationOfBenefit[] fhirResources = [];
                    foreach var p in payloadArray {
                        r4:ExplanationOfBenefit|error fhirResource = p.cloneWithType(r4:ExplanationOfBenefit);
                        if (fhirResource is error) {
                            r4:FHIRError fhirError = r4:createFHIRError("Did not get a FHIR Resource from source.", r4:CODE_SEVERITY_ERROR, r4:TRANSIENT_EXCEPTION);
                            return fhirError;
                        } else {
                            fhirResources.push(fhirResource);
                        }
                    }
                    return fhirResources;
                } else {
                    r4:FHIRError fhirError = r4:createFHIRError("Did not get a JSON[] from the source.", r4:CODE_SEVERITY_ERROR, r4:TRANSIENT_EXCEPTION);
                    return fhirError;
                }
            }
        }
    }

    isolated function create(r4:FHIRResourceEntity resourceEntity, r4:FHIRContext fhirContext) returns string|r4:FHIRError {

        //Implement source system connection here and persist FHIR resource.
        //Must respond with ID in order to create Location header

        r4:FHIRError fhirError = r4:createFHIRError("Not implemented", r4:CODE_SEVERITY_ERROR, r4:TRANSIENT_EXCEPTION, httpStatusCode = 415);
        return fhirError;
    }
}
