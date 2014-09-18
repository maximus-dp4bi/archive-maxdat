/*
Created on 07-Aug-2014 by Raj A.
NYHIX has different SLA_category types, hence a different semantic package too.

Deleting old NYHIX Letters related global controls.
After inserting the new Semantic attribute lookup values, calculated them for Complete and Active instances.

Inserts the missing letter, ID: 9252888
*/
delete CORP_ETL_LIST_LKUP
where ref_type = 'LETTER_TYPE';
commit;

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','XA-Application Material Request','2','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','XX-Material Request','2','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','XA-Application Material Request','B','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','XX-Material Request','B','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','XA-Application Material Request','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','XX-Material Request','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','XA-Application Material Request','2','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','XX-Material Request','2','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);
commit;

execute PROCESS_LETTERS.CALC_DPLCUR;

update D_PL_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = PROCESS_LETTERS.GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DATE),
      AGE_IN_CALENDAR_DAYS = PROCESS_LETTERS.GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,COMPLETE_DATE),
      TIMELINESS_STATUS = PROCESS_LETTERS.GET_TIMELINESS_STATUS(LETTER_TYPE,NEWBORN_FLAG,CREATE_DATE,COMPLETE_DATE),
      JEOPARDY_STATUS = (case when BPM_COMMON.BUS_DAYS_BETWEEN(CREATE_DATE,COMPLETE_DATE) > 1 then 'Y' else 'N' end),
      SLA_CATEGORY = LETTER_TYPE,
      SLA_DAYS = PROCESS_LETTERS.GET_SLA_DAYS(LETTER_TYPE,NEWBORN_FLAG),
      SLA_DAYS_TYPE = PROCESS_LETTERS.GET_SLA_DAYS_TYPE(LETTER_TYPE,NEWBORN_FLAG),
      SLA_JEOPARDY_DATE = PROCESS_LETTERS.GET_JEOPARDY_DATE(LETTER_TYPE,NEWBORN_FLAG,CREATE_DATE),
      SLA_JEOPARDY_DAYS = PROCESS_LETTERS.GET_JEOPARDY_DAYS(LETTER_TYPE,NEWBORN_FLAG),
      SLA_TARGET_DAYS = PROCESS_LETTERS.GET_SLA_TARGET_DAYS(LETTER_TYPE,NEWBORN_FLAG)
    where instance_status = 'Complete';
commit;

insert into corp_etl_proc_letters (
LETTER_REQUEST_ID,
CREATE_DT,
REQUEST_DT,
INSTANCE_STATUS,
LETTER_TYPE,
PROGRAM,
CASE_ID,
COUNTY_CODE,
ZIP_CODE,
LANGUAGE,
REPRINT,
REQUEST_DRIVER_TYPE,
REQUEST_DRIVER_TABLE,
STATUS,
STATUS_DT,
ASSD_PROCESS_LETTER_REQ,
CREATE_BY,
NEWBORN_FLAG,
ASF_PROCESS_LETTER_REQ,
ASF_TRANSMIT,
ASF_RECEIVE_CONFIRMATION,
ASF_CREATE_ROUTE_WORK
)
values
(9252888,to_date('01-oct-2013 11:34:59 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('01-oct-2013 11:34:59 AM', 'dd-mon-yyyy hh:mi:ss PM'),'Active','XA-Application Material Request','','','Orange County','','','N','','MATERIAL_REQUEST','Requested',to_date('01-oct-2013 11:34:59 AM', 'dd-mon-yyyy hh:mi:ss PM'),to_date('01-oct-2013 11:34:59 AM', 'dd-mon-yyyy hh:mi:ss PM'),'S62507','','N','N','N','N');
commit;