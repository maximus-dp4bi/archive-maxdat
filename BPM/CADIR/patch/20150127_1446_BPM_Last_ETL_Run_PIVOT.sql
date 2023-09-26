/*
Created on 01/27/2015 by Raj A.
Description: Modified the view to remove the BPM_EVENT_MASTER and BPM_PROCESS_LKUP tables. Adding MW entry into Corp_etl_list_lkup to monitor MW process.
*/
CREATE OR REPLACE VIEW MAXDAT_CADR.BPM_LAST_ETL_RUN_SV AS
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
inner join corp_etl_list_lkup cell on cell.ref_id = bsl.BSL_ID
inner join corp_etl_job_statistics cjs on cjs.job_name = cell.value
where cjs.job_status_cd = 'COMPLETED'
group by bsl.BSL_ID, bsl.NAME, cell.name;

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (SEQ_CELL_ID.nextval,'LAST_ETL_COMP_PIVOT','PIVOT','ManageWork_RUNALL','1','BPM_SOURCE_LKUP',1,trunc(sysdate),to_date('07077777','mmddyyyy'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM_SOURCE_LKUP and ref id is BSL_ID',sysdate,sysdate);
commit;