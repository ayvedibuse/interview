package com.cardConnect.steps.CardPointeIntegratedTerminalAPI;

import com.cardConnect.utility.Environment;
import com.cardConnect.utility.JsonReader;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.response.ValidatableResponse;
import io.restassured.specification.RequestSpecification;
import org.json.simple.JSONObject;
import org.junit.Assert;
import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.Map;


import static org.hamcrest.Matchers.notNullValue;

public class AuthCardEndPoint {

    public static RequestSpecification givenPart;

    public static Response response;
    public static ValidatableResponse thenPart;

    public static JsonPath jsonPath;

    public static Map<String, Object> responseMap;

    static String baseURL = Environment.API_BASE_URI;

    @Given("Content-Type is {string}")
    public void content_type_is(String contentType) {

        givenPart = RestAssured.given().accept(ContentType.JSON).contentType(contentType);
    }

    @Given("{string} header is {string}")
    public void header_is(String headerKey, String headerValue) {
        givenPart = givenPart.header(headerKey,headerValue);

    }

    @Given("User send payload fields as request body from {string} file")
    public void user_send_payload_fields_as_request_body_from_file(String payloadFileName) {

        givenPart = givenPart.body(new File("src/test/resources/data/authCard-responseJsonFiles/requestBody/" + payloadFileName));


    }

    @When("User send POST request to {string} end point")
    public void user_send_post_request_to_end_point(String endPoint) {
        response = givenPart.when().post(baseURL + endPoint);
        thenPart = response.then();
    }


    @Then("Verify status code {int}")
    public void verify_status_code(Integer statusCode) {
        thenPart.statusCode(statusCode);
    }


    @Then("Verify {string} field is generated")
    public void verify_field_is_generated(String fieldKeyValue) {

        jsonPath = thenPart.extract().jsonPath();
        thenPart.body(fieldKeyValue, notNullValue());
        String fieldValue = jsonPath.getString(fieldKeyValue);
        Assert.assertNotNull(fieldValue);
    }

    @Then("Verify {string} field max length is {int}")
    public void verify_field_max_length_is_and_in_the_format(String fieldKeyValue, Integer maxLength) {

        jsonPath = thenPart.extract().jsonPath();
        responseMap = jsonPath.getMap("");
        Integer actualFieldValue = (Integer) responseMap.get(fieldKeyValue);

        Assert.assertTrue((actualFieldValue+"").length() <= maxLength);

        System.out.println(responseMap.get("binType"));
    }


    @Then("Verify {string} field in the format MMYY and expiration date is bigger than current date")
    public void verify_field_max_length_is_and_in_the_format(String fieldKey) {

        LocalDate localDate = LocalDate.now();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("Myy");

        //get current date
        String currentMonthYear = dtf.format(localDate);
        String currentYear = currentMonthYear.substring(currentMonthYear.length()-2);
        String currentMonth = currentMonthYear.substring(0,currentMonthYear.length()-2);

        //get expiry date from response
        String givenMonthYearInResponse = responseMap.get(fieldKey)+"";
        String givenYearInResponse = givenMonthYearInResponse.substring(givenMonthYearInResponse.length()-2);
        String givenMonthInResponse = givenMonthYearInResponse.substring(0,givenMonthYearInResponse.length()-2);


        //compare the dates
        boolean result = false;
        if (Integer.parseInt(givenYearInResponse) > Integer.parseInt(currentYear)){
            result = true;
        }else if (Integer.parseInt(givenMonthInResponse) > Integer.parseInt(currentMonth)){
            result = true;
        }

        Assert.assertTrue(result);

    }


    @Then("Verify {string} field is {string}")
    public void verify_field_is(String fieldKey, String expectedFieldValue) {

        String actualValue = (String) responseMap.get(fieldKey);

        Assert.assertEquals(expectedFieldValue, actualValue);

    }

    @Given("User send request with the following fields")
    public void user_send_request_with_the_following_fields(Map<String, Object> fields) {

        //getting all required information from feature file into the map for request body
        Map<String, Object> fieldsTillUserFields = new LinkedHashMap<>();
        Map<String, Map<String, String>> userFields = new LinkedHashMap<>();
        Map<String, String> userFieldsInside = new LinkedHashMap<>();


        for (Map.Entry<String, Object> each : fields.entrySet()){
            if (each.getKey().equals("userFields.UDF1") && each.getKey().equals("userFields.UDF2") ){
                userFieldsInside.put(each.getKey(), (String)each.getValue());

            }else{
                fieldsTillUserFields.put(each.getKey(), each.getValue());
            }
        }

        userFields.put("userFields", userFieldsInside);


        //add request body by using map
        givenPart = givenPart.body(fieldsTillUserFields).body(userFields);


    }
    @Then("Verify error message {string} field is {string}")
    public void verify_error_message_field_is(String field, String expectedErrorMessage) {


        jsonPath = thenPart.extract().jsonPath();
        String actualErrorMessage = (String)jsonPath.getMap("error").get(field);

       Assert.assertEquals(expectedErrorMessage, actualErrorMessage);


    }





}
