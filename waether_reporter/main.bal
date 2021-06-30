import ballerina/http;
import ballerina/jballerina.java;
import weather_reporter.schedule;
import ballerina/task;

listener http:Listener weatherReporter = new (9091);
service /weather on weatherReporter {

    resource function post schedule(@http:Payload json payload) returns error|string {
         task:JobId id = check schedule:scheduleTask(payload);
         return id.toString();
    }

    resource function post schedule/[int count](@http:Payload json payload) returns error|string {
        if (count > 0) {
            task:JobId id = check schedule:scheduleTask(payload, count);
            return id.toString();
        } else {
            return error("Count should be grater than 1.");
        }
    }

    resource function get shutdown () {
        system_exit(0);
        return;
    }
}

function system_exit(int arg0) = @java:Method {
    name: "exit",
    'class: "java.lang.System",
    paramTypes: ["int"]
} external;

public function main() {

}
