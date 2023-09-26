curl --tlsv1 \
     --request POST \
     --header 'Authorization: Bearer 9C06CA1A3CE530D63CF5E0171FB37136216B571435BDE6F8097CE32EA1312201' \
     --url 'https://medchatapp.com/analyticsapi/external/orgs/651311f5-01a5-242c-2cec-39f4bfcd939c/queries/adhoc?asDynamicList=true' \
     --header 'Accept: text/plain' \
     --header 'Content-Type: application/*+json' \
	 --fail \
	 -s \
	 -S \
	 -o "/u01/maximus/maxdat/NCUI/processing/unprocessed/ChatTopics.txt" \
     --data '
{
    "name": "test",
    "description": "test query",
    "shouldConvertDateTimesToLocalTime": "true",
    "queryText": "let endDateTim = endofday(datetime_add(\"Day\", -1, now()));
let startDateTim = startofday(datetime_add(\"Day\", -1, now()));
let endDateTime = datetime_add(\"Hour\", '$TIMEZONE_OFFSET', endDateTim);
let startDateTime = datetime_add(\"Hour\", '$TIMEZONE_OFFSET',  startDateTim);
LiveChats 
| where InitiatedDateTime >= startDateTime and InitiatedDateTime < endDateTime 
| join kind=leftouter ChatBotExecutions on LiveChatId 
| join kind=leftouter LiveChatTasks on LiveChatId
| extend NoAgentNecessary = 
    iff(
        AgentMessageCount == 0 and
        isnotnull(ChatBotExecutionId) and
        (TaskType == \"OfflineChatFollowUp\" or
            (ChatEndReason == \"EndedByUser\" and not(RanToCompletion)) or
            (OfflineBotUsed and RanToCompletion)),
        true,
    iff(
        AgentMessageCount == 0 and 
        isnotnull(ChatBotExecutionId) and
        not(RanToCompletion),
        bool(null),
        false))
| extend MissedOpportunity = (isnull(FirstAgentAssignedDateTime) and NoAgentNecessary != true)
| summarize 
    TotalChats = count(), 
    TotalDefByBot = countif(MissedOpportunity) + countif(NoAgentNecessary),
    TotalMissedChats = countif(isnotnull(FirstAgentAssignedDateTime) and AgentMessageCount == 0),
    TotalMissedOpportunities = countif(MissedOpportunity),     
    TotalNoAgentNecessary = countif(NoAgentNecessary)
    by OrganizationName, WidgetId, WidgetName, TopicId, TopicName 
| sort by WidgetName asc, TopicName asc 
| project  TopicName, 
    TotalChats, DefByBot = TotalDefByBot, MissedChats = TotalMissedChats, MissedOpportunities = TotalMissedOpportunities, NoAgentNecessary = TotalNoAgentNecessary"
}'

