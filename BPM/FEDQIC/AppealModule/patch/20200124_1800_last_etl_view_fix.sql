CREATE OR REPLACE VIEW BPM_LAST_ETL_RUN_SV
AS Select
  be.bem_id,
  bsl.BSL_ID,
  bsl.NAME "Process Name",
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
inner join BPM_EVENT_MASTER be on be.bem_id = bsl.bsl_id
inner join BPM_PROCESS_LKUP bpl on bpl.BPROL_ID = be.BPROL_ID
inner join corp_etl_list_lkup cell on (cell.ref_id = be.bem_id and cell.ref_type = 'BPM_EVENT_MASTER')
inner join corp_etl_job_statistics cjs on cjs.job_name = cell.value
where cjs.job_status_cd = 'COMPLETED'
group by bsl.BSL_ID,bsl.NAME,be.bem_id,cell.name;

GRANT SELECT ON BPM_LAST_ETL_RUN_SV TO MAXDAT_READ_ONLY;


update maxdat.bpm_event_master
set bem_id = 2007 where name = 'FEDQIC Claim Line Items';
update maxdat.bpm_event_master
set bem_id = 2006 where name = 'FEDQIC Claims';
update maxdat.bpm_event_master
set bem_id = 2005 where name = 'FEDQIC Documents';
update maxdat.bpm_event_master
set bem_id = 2004 where name = 'FEDQIC Appeals';
update maxdat.bpm_event_master
set bem_id = 2003 where name = 'Federal QIC';


Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values ('LAST_ETL_COMP_PIVOT','PIVOT','ManageWork_RUNALL','2003','BPM_EVENT_MASTER',2003,to_date('1900-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),
to_date('7777-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',
sysdate,sysdate);

Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values ('LAST_ETL_COMP_PIVOT','PIVOT','ProcessAppeals_RUNALL','2004','BPM_EVENT_MASTER',2004,to_date('1900-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),
to_date('7777-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',
sysdate,sysdate);

Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values ('LAST_ETL_COMP_PIVOT','PIVOT','ProcessDocuments_RUNALL','2005','BPM_EVENT_MASTER',2005,to_date('1900-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),
to_date('7777-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',
sysdate,sysdate);

Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values ('LAST_ETL_COMP_PIVOT','PIVOT','ProcessClaims_RUNALL','2006','BPM_EVENT_MASTER',2006,to_date('1900-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),
to_date('7777-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',
sysdate,sysdate);

Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values ('LAST_ETL_COMP_PIVOT','PIVOT','ProcessClaims_LI_RUNALL','2007','BPM_EVENT_MASTER',2007,to_date('1900-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),
to_date('7777-07-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID',
sysdate,sysdate);


commit;