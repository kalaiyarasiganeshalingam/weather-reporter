# weather-reporter

This project is used to schedule the recurrence task to get the temperature of your current location if there is a weather change at trigger time. 
This project has following subparts.
* Weather reporter
* Consumer

## Prerequisites

* Ballerina Swan Lake Beta1 Installed
* Install zookeeper and start

## Run the App

Execute the below commands to test the source.

- To run the Consumer:

        bal run consumer
    
- To run the Weather reporter:
    
        bal run weather-reporter
        

## Sample request

### Schedule the recurrence task forever to get the temperature

    curl -v http://localhost:9091/weather/schedule --data "{\"startTime\":\"START_TIME\", \"interval\":\"DURATION_BETWEEN_EVERY_TRIGGER\"}"
    Eg curl -v http://localhost:9091/weather/schedule --data "{\"startTime\":\"2021-06-30T10:45:00.000+05:30[Asia/Colombo]\", \"interval\":\"60\"}"

### Schedule the recurrence task with a specific trigger count to get the temperature

    curl -v http://localhost:9091/weather/schedule/[TRIGGER_COUT] --data "{\"startTime\":\"START_TIME\", \"interval\":\"DURATION_BETWEEN_EVERY_TRIGGER\"}"
    Eg curl -v http://localhost:9091/weather/schedule/10 --data "{\"startTime\":\"2021-06-30T10:45:00.000+05:30[Asia/Colombo]\", \"interval\":\"60\"}"

### Shutdown service
    curl -v http://localhost:9091/weather/shutdown

