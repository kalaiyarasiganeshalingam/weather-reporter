import ballerina/task;
import ballerina/log;
import ballerina/http;
import ballerinax/kafka;

http:Client clientEndpoint = check new ("http://wttr.in");
kafka:Producer kafkaProducer = check new (kafka:DEFAULT_URL);

class Job {

    *task:Job;
    string temp;

    public function execute() {
        json|error resp = clientEndpoint->get("/?format=j1");
        if (resp is json) {
            json|error unionResult = resp.current_condition;
            if unionResult is json {
                json|error temperature = (<json[]> unionResult)[0].temp_C;
                if temperature is json {
                    string msg = temperature.toString();
                    if (!msg.equalsIgnoreCaseAscii(self.temp)) {
                        self.temp = temperature.toString();
                        log:printInfo(msg);
                        error? output = kafkaProducer->send({topic: "weather", value: msg.toBytes()});
                        if output is error {
                            log:printError("Error", output);
                        }
                    } else {
                        log:printInfo("Ignored sending a message to the consumer as the temperature is the same now.");
                    }
                } else {
                    log:printError("Error", temperature);
                }
            }
        } else {
            log:printError("Error", resp);
        }
    }

    isolated function init() {
        self.temp = "";
    }
}