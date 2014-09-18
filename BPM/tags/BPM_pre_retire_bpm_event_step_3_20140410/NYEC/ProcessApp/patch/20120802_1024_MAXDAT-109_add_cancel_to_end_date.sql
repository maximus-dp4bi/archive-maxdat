-- Patch for MAXDAT-109

create unique index NYEC_ETL_PROCESS_APP_UK1 on NYEC_ETL_PROCESS_APP (CEPA_ID);
create unique index NYEC_ETL_PROCESS_APP_UK2 on NYEC_ETL_PROCESS_APP (APP_ID);

update (
select 
  bi.IDENTIFIER,
  bi.END_DATE,
  coalesce(nepa.COMPLETE_DT,nepa.CANCEL_DATE) enddate
from 
  BPM_INSTANCE bi,
  NYEC_ETL_PROCESS_APP nepa
where 
  bi.BEM_ID = 2
  and bi.IDENTIFIER = nepa.APP_ID
  and (nepa.COMPLETE_DT is not null 
       or nepa.CANCEL_DATE is not null)
  and bi.END_DATE != coalesce(nepa.COMPLETE_DT,nepa.CANCEL_DATE))
set END_DATE = enddate;

