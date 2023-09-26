select distinct cn.CaseId
, MAX(cn.CreatedDate) over(partition by cn.CaseId) InitialContactDate
from [HWSInternal].[CASE].[CASENOTE] cn 
where cn.comment like 'Case status changed from Initial Contact%'
and cn.comment not like '% to Initial Contact%'
