create or replace view maxdat.bpm_last_etl_run_sv as
Select
  be.bem_id,
  bsl.BSL_ID,
  bsl.NAME "Process Name",
  max(cjs.job_start_date) as "Last Completed ETL Start Time",
  case when max(cjs.job_end_date) > max(cjs.job_start_date) then max(cjs.job_end_date) else null end as "Last Completed ETL End Time",
  nvl(round(((sysdate - min(EVENT_DATE)) * 24),2),0) "Queue Hours Behind",
  count(distinct bueq.identifier) "Instances Pending",
  case when nvl(round(((sysdate - min(EVENT_DATE)) * 24),2),0) = 0 then 'Complete'
  else 'Pending'
  end
  "Queue Processing"
from BPM_SOURCE_LKUP bsl
left outer join BPM_UPDATE_EVENT_QUEUE bueq on bsl.BSL_ID = bueq.BSL_ID
inner join BPM_EVENT_MASTER be on be.bem_id = bsl.bsl_id
inner join BPM_PROCESS_LKUP bpl on bpl.BPROL_ID = be.BPROL_ID
inner join corp_etl_list_lkup cell on cell.ref_id = be.bprol_id
inner join corp_etl_job_statistics cjs on cjs.job_name = cell.value
where cjs.job_status_cd = 'COMPLETED'
group by bsl.BSL_ID,bsl.NAME,be.bem_id,cell.name;

/