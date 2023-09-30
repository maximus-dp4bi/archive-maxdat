curl --tlsv1 \
--request POST \
--header 'Authorization: Bearer 9C06CA1A3CE530D63CF5E0171FB37136216B571435BDE6F8097CE32EA1312201' \
--url 'https://medchatapp.com/analyticsapi/external/orgs/651311f5-01a5-242c-2cec-39f4bfcd939c/queries/adhoc?asDynamicList=true' \
--header 'Accept: text/plain' \
--header 'Content-Type: application/*+json' \
--fail \
-s \
-S \
-o "/u01/maximus/maxdat/NCUI/processing/unprocessed/VirtualAgentMetrics.txt" \
--data '{
"name": "Virtual Agent Metrics",
"description": "Virtual Agent Metrics",
"shouldConvertDateTimesToLocalTime": "false",
"queryText": "let endDateTim = endofday(datetime_add(\"Day\", -1, now()));
let startDateTim = startofday(datetime_add(\"Day\", -1, now()));
let endDateTime = datetime_add(\"Hour\", '$TIMEZONE_OFFSET', endDateTim);
let startDateTime = datetime_add(\"Hour\", '$TIMEZONE_OFFSET',  startDateTim);
ArticleViews 
| where EnqueuedDateTime >= startDateTime and EnqueuedDateTime < endDateTime 
| project  OrganizationId
| summarize TotalArticleViews = count() by OrganizationId
| join kind=leftouter (ArticleViews
| where EnqueuedDateTime  >= startDateTime and EnqueuedDateTime < endDateTime
| distinct OrganizationId,SessionId 
| summarize  UniqueSessions = count() by OrganizationId
) on OrganizationId
| join kind=leftouter (ArticleViews
| where Timestamp  >= startDateTime and Timestamp < endDateTime
| summarize  CategoryCount = count() by OrganizationId, CategoryName 
| summarize MostPopularCategoryCount = arg_max(CategoryCount, CategoryName) by OrganizationId
) on OrganizationId
| join kind=leftouter (SearchConcepts
| join PerformedSearchConcepts on SearchConceptId
| join PerformedSearches on EventId
| where Timestamp >= startDateTime and Timestamp < endDateTime
| summarize SearchTermCount = count() by OrganizationId, DisplayText
| order by SearchTermCount, DisplayText asc
| limit 1
) on OrganizationId
| project Date = startDateTime, 
    TotalArticleViews, 
    UniqueSessions, 
    MostPopularCategory = CategoryName, 
    MostPopularCategorySearches = MostPopularCategoryCount, 
    MostSearchedTerm = DisplayText , 
    MostSearchedTermSearches = SearchTermCount
	"
}'

