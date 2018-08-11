import ballerina/http;
import ballerina/log;
import chanakal/gtasks;
import ballerina/test;
import ballerina/io;
import wso2/twilio;

function main(string... args) {
    endpoint gtasks:Client gtasksClient {
        clientConfig: {
            auth: {
                scheme: http:OAUTH2,
                accessToken: "ya29.Glv2BYnU1MWdShFS2QNMqDDRbYkytgpaVtOG9FhxEeAgCsg648u7KnsfWzxVcNBT1ylnS_9G8ilwBAxXtDadn-CRUW1Ef93XwkqRZDe-tXpYiJCvt5Y-9zbQonfn",
                clientId: "393635643440-m8il5r1b41j7h712qcs8fh7vog3ek41c.apps.googleusercontent.com",
                clientSecret: "37a_D47owxqXtEMqfvmXmtW7",
                refreshToken: "1/hInvbI6JABQddWv9tuSbik7Uwc4UHPVuDCGbug-31GM"
            }
        }
    };

    var details = gtasksClient->listTaskLists();
    json res;

    match details {
        json response => res = response;
        gtasks:GTasksError gtasksError => test:assertFail(msg = gtasksError.message);
    }

    int x = 0;
    while(x < lengthof res.items) {
        string task = res.items[x].title.toString();
        io:println(task);
        twillio(task);
        //details = gtasksClient->listTasks(res.items[x].title.toString());
        //match details {
        //    json response => io:println(response);
        //    gtasks:GTasksError gtasksError => test:assertFail(msg = gtasksError.message);
        //}

        x++;
    }

}

function twillio(string task){
    endpoint twilio:Client twilioClient {
        accountSId:"AC82f1d57b796e742d791fb762d3323b97",
        authToken:"f2f94a040db71fb8c359d3ad3e95bd50"
    };

    string fromMobile = "+1 510 939 7262";
    string toMobile = "+94716849672";
    string message = task;

    var details = twilioClient->sendSms(fromMobile, toMobile, untaint message);
    match details {
        twilio:SmsResponse smsResponse => io:println(smsResponse);
        twilio:TwilioError twilioError => io:println(twilioError);
    }
}


