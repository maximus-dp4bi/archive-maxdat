curl --tlsv1 \
     --request POST \
     --header 'Authorization: Bearer 9C06CA1A3CE530D63CF5E0171FB37136216B571435BDE6F8097CE32EA1312201' \
     --url 'https://medchatapp.com/analyticsapi/external/orgs/651311f5-01a5-242c-2cec-39f4bfcd939c/queries/adhoc?asDynamicList=true' \
     --header 'Accept: text/plain' \
     --header 'Content-Type: application/*+json' \
	 -o "/u01/maximus/maxdat/NCUI/processing/unprocessed/AgentChatMetrics.txt" \
     --fail \
     -S \
     -s \
     --data '
{
    "name": "Agent Chat Totals",
    "description": "Agent Chat Metric Totals",
    "shouldConvertDateTimesToLocalTime": false,
    "queryText": "let endDateTim = endofday(datetime_add(\"Day\", -1, now()));
let startDateTim = startofday(datetime_add(\"Day\", -1, now()));
let endDateTime = datetime_add(\"Hour\", '$TIMEZONE_OFFSET', endDateTim);
let startDateTime = datetime_add(\"Hour\", '$TIMEZONE_OFFSET',  startDateTim);
LiveChatAgents 
| where AssignedDateTime >= startDateTime and AssignedDateTime < endDateTime and MessageCount > 0
| join kind=leftouter Users on UserId 
| summarize TotalChats = count(),
 AvgChatTime = avg(AgentChatTime),
 AvgRespTime = avg(AverageResponseTime),
 MissedChats = 0,
 MissedOpportunities = 0,
 AverageHoldTime=0,
 AverageWaitTime=0,
 AverageArchiveTime=0
    by UserId, EmailAddress, FirstName, LastName, IsActive, Roles, bin(AssignedDateTime, 1d) 
| order by iif(isnotempty(LastName), strcat(FirstName, \" \",LastName), \" No Agent Assigned\") asc
| project Name=iif(isnotempty(LastName), strcat(FirstName, \" \",LastName), \" No Agent Assigned\"),
    Id=iif(isnotempty(UserId), UserId, guid(00000000-0000-0000-0000-000000000000)),
    Total = TotalChats, MissedChats, MissedOpportunities,
    AverageHoldSeconds = AverageHoldTime, 
    AverageWaitSeconds = AverageWaitTime,
    AverageServiceSeconds = AvgChatTime / 1s,
    AverageArchiveSeconds=AverageArchiveTime,
    AverageResponseTimeSeconds = AvgRespTime / 1s
"
}'


