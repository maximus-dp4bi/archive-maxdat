
curl --tlsv1 \
     --request POST \
     --header 'Authorization: Bearer 9C06CA1A3CE530D63CF5E0171FB37136216B571435BDE6F8097CE32EA1312201' \
     --url 'https://medchatapp.com/analyticsapi/external/orgs/651311f5-01a5-242c-2cec-39f4bfcd939c/queries/adhoc?asDynamicList=true' \
     --header 'Accept: text/plain' \
     --header 'Content-Type: application/*+json' \
	 --fail \
	 -s \
	 -S \
	 -o "/u01/maximus/maxdat/NCUI/processing/unprocessed/ChatMetricTotal.txt" \
     --data '
{
    "name": "Chat Totals",
    "description": "Chat Metric Totals",
    "shouldConvertDateTimesToLocalTime": false,
    "queryText": "let endDateTim = endofday(datetime_add(\"Day\", -1, now()));
let startDateTim = startofday(datetime_add(\"Day\", -1, now()));
let endDateTime = datetime_add(\"Hour\", '$TIMEZONE_OFFSET', endDateTim);
let startDateTime = datetime_add(\"Hour\", '$TIMEZONE_OFFSET',  startDateTim);
LiveChats
| where InitiatedDateTime >= startDateTime
    and InitiatedDateTime < endDateTime  
| join kind=leftouter (LiveChatAgents
                       | where AssignedDateTime >= startDateTime
                           and AssignedDateTime < endDateTime 
                       | project LiveChatId, UserId, FirstName, LastName, 
                           AverageResponseTime = iff(isnull(AverageResponseTime), 0s, AverageResponseTime), 
                           Weight = iff(isnull(Weight), 0, Weight) 
                       | summarize TotalWeightedAverageResponseTime=sum(AverageResponseTime * Weight), 
                           TotalWeight=sum(Weight)
    by LiveChatId) on LiveChatId 
| summarize Total=count(),
            MissedChats=countif(isnotnull(FirstAgentAssignedDateTime) and AgentMessageCount == 0), 
            MissedOpportunities=countif(isnull(FirstAgentAssignedDateTime)), 
            AverageHoldTime=avg(HoldTime), 
            AverageWaitTime=avg(WaitTime), 
            AverageServiceTime=avg(ServiceTime), 
            AverageArchiveTime=avg(ArchiveTime), 
            AverageResponseTime=sum(TotalWeightedAverageResponseTime) / sum(TotalWeight) 
| project
    Total, MissedChats, MissedOpportunities, 
    AverageHoldSeconds = floor(AverageHoldTime / 1s, 1), 
    AverageWaitSeconds = floor(AverageWaitTime / 1s, 1), 
    AverageServiceSeconds = floor(AverageServiceTime / 1s, 1), 
    AverageArchiveSeconds = floor(AverageArchiveTime / 1s, 1), 
    AverageResponseTimeSeconds = floor(AverageResponseTime / 1s, 1)"
}'
