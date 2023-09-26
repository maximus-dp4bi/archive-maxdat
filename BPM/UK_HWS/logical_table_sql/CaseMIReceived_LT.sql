select caseid, min(createddate) MIReceivedDate
from [HWSInternal].[CASE].[CASENOTE] 
where comment like '%Referrer Contact Required%Initial Contact Required%'
group by caseid
