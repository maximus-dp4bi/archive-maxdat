-- Patch for MAXDAT-108

update (
select 
  bi.IDENTIFIER,
  bi.END_DATE,
  coalesce(cemw.COMPLETE_DATE,cemw.CANCEL_WORK_DATE) enddate
from 
  BPM_INSTANCE bi,
  CORP_ETL_MANAGE_WORK cemw
where 
  bi.BEM_ID = 1
  and bi.IDENTIFIER = cemw.TASK_ID
  and (cemw.COMPLETE_DATE is not null 
       or cemw.CANCEL_WORK_DATE is not null)
  and bi.END_DATE != coalesce(cemw.COMPLETE_DATE,cemw.CANCEL_WORK_DATE))
set END_DATE = enddate;