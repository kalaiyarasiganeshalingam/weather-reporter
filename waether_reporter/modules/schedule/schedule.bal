import ballerina/task;
import ballerina/time;

public isolated function scheduleTask(json payload, int? count = ()) returns error|task:JobId {
    string civliInString = (check payload.startTime).toString();
    
    time:Civil startTime = {day: 0, hour: 0, minute: 0, month: 0, year: 0};
    if (civliInString != "") {
        startTime = check time:civilFromString(civliInString);
    }
    decimal interval = check decimal:fromString((check payload.interval));
    if (count is int) {
        return check task:scheduleJobRecurByFrequency(new Job(), interval, count, startTime);
    } else {
        return check task:scheduleJobRecurByFrequency(new Job(), interval, startTime = startTime);
    }
}
