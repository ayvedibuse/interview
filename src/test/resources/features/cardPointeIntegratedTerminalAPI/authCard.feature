Feature: authCard endpoint

  @US1-AC1
  Scenario: Verify all response fields meets with the requirements written in the document

    Given Content-Type is "application/json"
    And "Authorization" header is "0"
    And "X-CardConnect-SessionKey" header is "0"
    And User send payload fields as request body from "requestBodyHappyPath.json" file
    When User send POST request to "/api/v3/authCard" end point
    Then Verify status code 200
    Then Verify "tokenn" field is generated
    Then Verify "expiry" field max length is 4
    Then Verify "expiry" field in the format MMYY and expiration date is bigger than current date
    Then Verify "signature" field is "<base64-encoded, gzipped BMP>"

    @US1-AC2
  Scenario: Verify all response fields meets with the requirements written in the document

    Given Content-Type is "application/json"
    And "Authorization" header is "0"
    And "X-CardConnect-SessionKey" header is "0"
    And User send payload fields as request body from "requestBodyHappyPath.json" file
    When User send POST request to "/api/v3/authCard" end point
    Then Verify status code 200
    Then Verify "token" field is generated
    Then Verify "expiryy" field max length is 4
    Then Verify "expiry" field in the format MMYY and expiration date is bigger than current date
    Then Verify "signature" field is "<base64-encoded, gzipped BMP>"

    @US1-AC3
  Scenario: Verify all response fields meets with the requirements written in the document

    Given Content-Type is "application/json"
    And "Authorization" header is "0"
    And "X-CardConnect-SessionKey" header is "0"
    And User send payload fields as request body from "requestBodyHappyPath.json" file
    When User send POST request to "/api/v3/authCard" end point
    Then Verify status code 200
    Then Verify "token" field is generated
    Then Verify "expiry" field max length is 4
    Then Verify "expiryy" field in the format MMYY and expiration date is bigger than current date
    Then Verify "signature" field is "<base64-encoded, gzipped BMP>"

  @US2-AC1
  Scenario Outline: Verify all error message information written in the response body when some fields are missing in the request body
    Given Content-Type is "application/json"
    And "Authorization" header is "0"
    And "X-CardConnect-SessionKey" header is "0"
    And User send request with the following fields
      | merchantID           | <merchantID>           |
      | hsn                  | <hsn>                  |
      | amount               | <amount>               |
      | aid                  | <aid>                  |
      | authCode             | <authCode>             |
      | authMerchantId       | <authMerchantId>       |
      | bin                  | <bin>                  |
      | beep                 | <beep>                 |
      | capture              | <capture>              |
      | clearDisplayDelay    | <clearDisplayDelay>    |
      | confirmAmount        | <confirmAmount>        |
      | createProfile        | <createProfile>        |
      | gzipSignature        | <gzipSignature>        |
      | includeAmountDisplay | <includeAmountDisplay> |
      | includeAVS           | <includeAVS>           |
      | includePIN           | <includePIN>           |
      | includeSignature     | <includeSignature>     |
      | InvoiceId            | <InvoiceId>            |
      | orderID              | <orderID>              |
      | printDelay           | <printDelay>           |
      | printExtraReceipt    | <printExtraReceipt>    |
      | printReceipt         | <printReceipt>         |
      | signatureDimensions  | <signatureDimensions>  |
      | signatureFormat      | <signatureFormat>      |
      | termId               | <termId>               |
      | userFields.UDF1      | <UDF1>                 |
      | userFields.UDF2      | <UDF2>                 |
    When User send POST request to "/api/v3/authCard" end point
    Then Verify status code 404
    Then Verify error message "name" field is "mockRequestNotFoundError"
    Then Verify error message "message" field is "Double check your method and the request path and try again."
    Examples:
      | merchantID | hsn             | amount | aid    | authCode | authMerchantId | bin   | beep | capture | clearDisplayDelay | confirmAmount | createProfile | gzipSignature | includeAmountDisplay | includeAVS | includePIN | includeSignature | InvoiceId    | orderID    | printDelay | printExtraReceipt | printReceipt | signatureDimensions | signatureFormat | termId | UDF1     | UDF2           |
      |            | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       |                 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 |        | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    |        | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      |                | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         |       | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false |      | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true |         | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    |                   | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               |               | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          |               | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          |               | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         |                      | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 |            | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       |            | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      |                  | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            |              | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 |            | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 |            | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          |                   | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             |              | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         |                     | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   |                 | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             |        | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string |          | Good info here |
      | 1234       | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 |                |
      |            |                 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      |            | 14012PP20131409 | 100    | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      |            | 14012PP20131409 |        | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      |            | 14012PP20131409 | 100    |        | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      |            | 14012PP20131409 | 100    | credit |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       |                 |        | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       |                 | 100    |        | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       |                 | 100    | credit |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 |        |        | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 |        | credit |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 | 100    |        |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      |            |                 |        | credit | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      |            |                 | 100    |        | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      |            |                 | 100    | credit |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      |            | 14012PP20131409 |        |        | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      |            | 14012PP20131409 |        | credit |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      |            | 14012PP20131409 | 100    |        |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       |                 |        |        | 100      | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       |                 |        | credit |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       |                 | 100    |        |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |
      | 1234       | 14012PP20131409 |        |        |          | string         | false | true | true    | 500               | true          | true          | false         | true                 | true       | false      | false            | 123456789012 | 1233200399 | 0          | false             | true         | 0                   | png             | string | 12345678 | Good info here |











