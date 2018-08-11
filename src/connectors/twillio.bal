import ballerina/config;
import ballerina/io;
import wso2/twilio;

function main (string... args) {
    endpoint twilio:Client twilioClient {
        accountSId:"AC82f1d57b796e742d791fb762d3323b97",
        authToken:"f2f94a040db71fb8c359d3ad3e95bd50"
    };

    string fromMobile = "+1 510 939 7262";
    string toMobile = "+94716849672";
    string message = "Hi Sajitha";

    var details = twilioClient->sendSms(fromMobile, toMobile, message);
    match details {
        twilio:SmsResponse smsResponse => io:println(smsResponse);
        twilio:TwilioError twilioError => io:println(twilioError);
    }
}