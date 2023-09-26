curl --tlsv1 \
     --request POST \
     --header 'Authorization: Bearer 9C06CA1A3CE530D63CF5E0171FB37136216B571435BDE6F8097CE32EA1312201' \
     --url 'https://medchatapp.com/analyticsapi/external/orgs/651311f5-01a5-242c-2cec-39f4bfcd939c/queries/adhoc?asDynamicList=true' \
     --header 'Accept: text/plain' \
     --header 'Content-Type: application/*+json' \
	 --fail \
	 -s \
	 -S \
	 -o "/u01/maximus/maxdat/NCUI/processing/unprocessed/ChatsbyDayMetrics.txt" \
     --data '
{
    "name": "Chats by Day Totals",
    "description": "Chats by Day Metric Totals",
    "queryText": "let endDateTim = endofday(datetime_add(\"Day\", -1, now()));
let startDateTim = startofday(datetime_add(\"Day\", -1, now()));
let endDateTime = datetime_add(\"Hour\", '$TIMEZONE_OFFSET', endDateTim);
let startDateTime = datetime_add(\"Hour\", '$TIMEZONE_OFFSET',  startDateTim);
LiveChats 
| where InitiatedDateTime >= startDateTime and InitiatedDateTime < endDateTime
| extend WeekDay = case(dayofweek(startDateTime) == time(0.00:00:00), \"Sunday\",
                        dayofweek(startDateTime) == time(1.00:00:00), \"Monday\",
                        dayofweek(startDateTime) == time(2.00:00:00), \"Tuesday\",
                        dayofweek(startDateTime) == time(3.00:00:00), \"Wednesday\",
                        dayofweek(startDateTime) == time(4.00:00:00), \"Thursday\",
                        dayofweek(startDateTime) == time(5.00:00:00), \"Friday\",
                        dayofweek(startDateTime) == time(6.00:00:00), \"Saturday\",
                     \"NoDay\")
| extend BusyTimeStart = case(datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime)) < 12 , strcat(datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime)),\"am\"),
                              datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime)) == 12, strcat(datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime)),\"pm\"),
                              datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime)) > 12, strcat(datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime))-12,\"pm\"),
                     \"NoHour\")
| extend BusyTimeEnd = case(datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime))+1 < 12, strcat(datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime))+1,\"am\"),
                            datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime))+1 == 12, strcat(datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime))+1,\"pm\"),
                            datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime))+1 > 12, strcat((datetime_part(\"hour\",datetime_add(\"Hour\",-'$TIMEZONE_OFFSET',InitiatedDateTime))+1)-12,\"pm\"),
                     \"NoHour\")
| summarize BusyTimeCnt = count() by BusyTime = bin(InitiatedDateTime, 1h), WeekDay, BusiestTime = strcat(tostring(BusyTimeStart),\"-\",tostring(BusyTimeEnd))
| sort by BusyTimeCnt desc
| project BusyTimeCnt,  BusiestTime, WeekDay
"
}'



