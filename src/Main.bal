import ballerina/http;
import ballerina/log;
import chanakal/gtasks;
import ballerina/test;
import ballerina/io;

function main(string... args) {

    endpoint gtasks:Client gtasksClient {
        clientConfig: {
            auth: {
                scheme: http:OAUTH2,
                accessToken: "ya29.Glv2Bdp1LtiiDnjDnELKc3tfD7xIAysAaNO2Rqywdjc2NK50bXuFo0Ko6ac1fP7G6Hqcay8Tl5TjHyAPNBT2ze9W21ohizrxT43hOWfxNK3daQ0bcBnk0oTbWGDD",
                clientId: "393635643440-m8il5r1b41j7h712qcs8fh7vog3ek41c.apps.googleusercontent.com",
                clientSecret: "37a_D47owxqXtEMqfvmXmtW7",
                refreshToken: "1/Eovb7HL-fLd1yaxFiqaekGH7MoM-ZwM0nibfrAGfZJCAwFgQRzS8Z2kaHoUBJID3"
            }
        }
    };

    var details = gtasksClient->listTaskLists();
    match details {
        json response => io:println(response);
        gtasks:GTasksError gtasksError => test:assertFail(msg = gtasksError.message);
    }
}
