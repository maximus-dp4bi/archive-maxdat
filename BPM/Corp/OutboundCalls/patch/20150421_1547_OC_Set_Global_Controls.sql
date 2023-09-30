/*
Created by Raj A. on 04/21/2015
Description: This script updates the global controls to selectively load Outbound Calls data in batches.
Adding Primary Key. Dropping individual indexes on the columns (Job_ID and Row_ID).

For ex: to load 04/21/2015 outbound calls data, set the below 
OUTBOUNDCALL_MIN_JOB_ID = 66673-10, OUTBOUNDCALL_MAX_JOB_ID = 66673+10

IMPORTANT: Other than when we want to load for a specific batch, OUTBOUNDCALL_MAX_JOB_ID should always be to 999999999

For ex: to load 04/21/2015 Predictive Dialer results data, set the below 
OUTBOUNDCALL_MIN_ETL_L_PDR_ID = 3308336, OUTBOUNDCALL_MAX_ETL_L_PDR_ID = 3325150

SQLs used to get the lower and upper bounds:
select trunc(j.start_ts), min(d.job_id), max(d.job_id)
from etl_e_dialer d
join job_run_data j on d.job_id = j.job_run_data_id
and j.start_ts >= trunc(sysdate)-10
group by trunc(j.start_ts)
order by trunc(j.start_ts);

select trunc(CALL_START_TS), min(ETL_L_PDR_ID), max(ETL_L_PDR_ID)
from etl_L_predictive_dialer_rslts pd
where trunc(CALL_START_TS) >= trunc(sysdate)-10
group by  trunc(pd.CALL_START_TS)
order by trunc(pd.CALL_START_TS);
*/
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('OUTBOUNDCALL_MIN_JOB_ID','N','65650','Value of the lower bound JOB_ID of Outbound Calls.',SYSDATE,SYSDATE);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('OUTBOUNDCALL_MAX_JOB_ID','N','65660','Value of the upper bound JOB_ID of Outbound Calls.',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('OUTBOUNDCALL_MIN_ETL_L_PDR_ID','N','3308336','Value of the lower bound ETL_L_PDR_ID of Predictive Dialer results.',SYSDATE,SYSDATE);
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('OUTBOUNDCALL_MAX_ETL_L_PDR_ID','N','3325150','Value of the upper bound ETL_L_PDR_ID of Predictive Dialer results.',SYSDATE,SYSDATE);

update CORP_ETL_CONTROL set Value = 58758-10 WHERE Name = 'OUTBOUNDCALL_MIN_JOB_ID';
update CORP_ETL_CONTROL set Value = 62511+10 WHERE Name = 'OUTBOUNDCALL_MAX_JOB_ID';

update CORP_ETL_CONTROL set Value = 3132336 WHERE Name = 'OUTBOUNDCALL_MIN_ETL_L_PDR_ID';
update CORP_ETL_CONTROL set Value = 99999999 WHERE Name = 'OUTBOUNDCALL_MAX_ETL_L_PDR_ID';

/*
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','MMC','','SUBPROGRAM',null,null,null,null,SYSDATE,SYSDATE);
*/
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','CSN','C','SUBPROGRAM',null,null,null,null,SYSDATE,SYSDATE);
/*
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','ACA','A','SUBPROGRAM',null,null,null,null,SYSDATE,SYSDATE);
*/
commit;

truncate table ETL_E_DIALER_RUN_STG;
truncate table CORP_ETL_PROC_OUTBND_CALL_OLTP;
truncate table CORP_ETL_PROC_OUTBND_CALL_WIP;
truncate table corp_etl_proc_outbnd_call_dtl;
truncate table corp_etl_proc_outbnd_call;
truncate table f_obc_by_date;
alter table f_obc_by_date disable constraint FOBCBD_DOBCCUR_FK;
truncate table d_obc_current;
alter table f_obc_by_date enable constraint FOBCBD_DOBCCUR_FK;

drop index ETL_E_DIALER_RUN_STG_INDX1;
drop index ETL_E_DIALER_RUN_STG_INDX2;
drop index ETL_E_DIALER_RUN_STG_INDX3;
drop index ETL_E_DIALER_RUN_STG_INDX4;
drop index ETL_E_DIALER_RUN_STG_INDX5;

alter table MAXDAT.ETL_E_DIALER_RUN_STG
  add constraint PK_ETL_E_DIALER_STG primary key (JOB_ID, ROW_ID)
;
create index MAXDAT.ETL_E_DIALER_RUN_STG_INDX3 on MAXDAT.ETL_E_DIALER_RUN_STG (CLIENT_ID)
  tablespace MAXDAT_INDX
  ;
create index MAXDAT.ETL_E_DIALER_RUN_STG_INDX4 on MAXDAT.ETL_E_DIALER_RUN_STG (CASE_ID)
  tablespace MAXDAT_INDX
  ;
create index MAXDAT.ETL_E_DIALER_RUN_STG_INDX5 on MAXDAT.ETL_E_DIALER_RUN_STG (CREATE_TS)
  tablespace MAXDAT_INDX
  ;