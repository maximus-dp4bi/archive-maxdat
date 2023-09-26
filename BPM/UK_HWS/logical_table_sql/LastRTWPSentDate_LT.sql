select distinct c.Id CaseId
, MAX(cn.CreatedDate) over(partition by c.Id) LatestRTWPSentDate
from [HWSInternal].[CASE].[CASE] c
 inner join [HWSInternal].[CASE].[CASENOTE] cn ON
 c.Id = cn.CaseId 
 and 
 (cn.CreatedBy = 'Service: Return To Work Plan' and cn.comment like 'RTWP%Employee%Sent')
 or
 (cn.CreatedBy = 'RTWP Service' and cn.comment like 'Employee RTWP approval%')