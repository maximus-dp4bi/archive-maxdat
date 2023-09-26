create or replace view BPM_LAST_ETL_RUN_SV as
select
  bsl.BSL_ID,
  bsl.NAME as "Process Name",
  max(cejs.JOB_START_DATE) as "Last Completed ETL Start Time",
  case 
    when max(cejs.JOB_END_DATE) > max(cejs.JOB_START_DATE) then max(cejs.JOB_END_DATE) 
    else null 
    end as "Last Completed ETL End Time",
  nvl(round(((sysdate - min(min_event_date)) * 24),2),0) "Queue Hours Behind",
  max(bueq."Instances Pending") "Instances Pending",
  case 
    when nvl(round(((sysdate - min(min_event_date)) * 24),2),0) = 0 then 'Complete'
    else 'Pending'
    end "Queue Processing"
from BPM_SOURCE_LKUP bsl
left outer join 
  (select 
     BSL_ID,
     min(EVENT_DATE) min_event_date,
     count(distinct IDENTIFIER) "Instances Pending" 
   from BPM_UPDATE_EVENT_QUEUE 
   group by BSL_ID) bueq 
  on bsl.BSL_ID = bueq.BSL_ID
inner join CORP_ETL_LIST_LKUP cell on bsl.BSL_ID = cell.REF_ID
inner join CORP_ETL_JOB_STATISTICS cejs on cell.value = cejs.JOB_NAME
where cejs.JOB_STATUS_CD = 'COMPLETED'
group by 
  bsl.BSL_ID,
  bsl.NAME,
  cell.NAME
with read only;

grant select on BPM_LAST_ETL_RUN_SV to MAXDAT_READ_ONLY;
