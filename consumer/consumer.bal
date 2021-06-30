import ballerinax/kafka;
import ballerina/log;

kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "group-id",
    topics: ["weather"],
    pollingInterval: 1,
    autoCommit: false
};

listener kafka:Listener kafkaListener = new (kafka:DEFAULT_URL, consumerConfigs);

service kafka:Service on kafkaListener {
    remote function onConsumerRecord(kafka:Caller caller,
                                kafka:ConsumerRecord[] records) returns error? {
        foreach var kafkaRecord in records {
            check processKafkaRecord(kafkaRecord);
        }

        kafka:Error? commitResult = caller->commit();

        if commitResult is error {
            log:printError("Error occurred while committing the " +
                "offsets for the consumer ", 'error = commitResult);
        }
    }
}
function processKafkaRecord(kafka:ConsumerRecord kafkaRecord) returns error? {
    byte[] value = kafkaRecord.value;

    string messageContent = check string:fromBytes(value);
    log:printInfo("Temperature has changed now. Current temperature: " + messageContent);
}
