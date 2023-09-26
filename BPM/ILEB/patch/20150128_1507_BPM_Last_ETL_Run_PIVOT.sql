/*
Created on 01/28/2015 by Raj A.
Description: 
1. Modified the view to remove the BPM_EVENT_MASTER and BPM_PROCESS_LKUP tables. This was originally deployed to CADIR (CADIR-554, 555)
2. Updating Corp_Etl_List_Lkup table as the ref_id is now pointing to BSL_ID, NOT BEM_ID.
*/
CREATE OR REPLACE VIEW MAXDAT.BPM_LAST_ETL_RUN_SV AS
Select
  bsl.BSL_ID,
  bsl.name as "Process Name",
  max(cjs.job_start_date) as "Last Completed ETL Start Time",
  max(cjs.job_end_date) as "Last Completed ETL End Time",
  nvl(round(((sysdate - min(EVENT_DATE)) * 24),2),0) "Queue Hours Behind",
  count(distinct bueq.identifier) "Instances Pending",
  case when nvl(round(((sysdate - min(EVENT_DATE)) * 24),2),0) = 0 then 'Complete'
  else 'Pending'
  end
  "Queue Processing"
from BPM_SOURCE_LKUP bsl
left outer join BPM_UPDATE_EVENT_QUEUE bueq on bsl.BSL_ID = bueq.BSL_ID
inner join corp_etl_list_lkup cell on cell.ref_id = to_char(bsl.BSL_ID)
inner join corp_etl_job_statistics cjs on cjs.job_name = cell.value
where cjs.job_status_cd = 'COMPLETED'
group by bsl.BSL_ID, bsl.NAME, cell.name;

Update Corp_Etl_List_Lkup
  Set Ref_Type = 'BPM_SOURCE_LKUP',
      comments = 'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM_SOURCE_LKUP and ref id is BSL_ID'
 Where List_Type = 'PIVOT';
 commit;