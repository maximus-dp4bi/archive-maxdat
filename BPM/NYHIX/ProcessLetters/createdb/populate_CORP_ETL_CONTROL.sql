/*
Created on 11-Jun-2014 by Raj A.
Modified the original file, BPM\ILEB\ProcessLetters\createdb\populate_CORP_ETL_CONTROL.sql, to add LETTERS_LAST_UPDATE_DATE.
Missing global control variable, PROCESSLETTERS_RUN_RUNALL_TODAY; added it.

Raj A. 15-Jul-2014 Added PL_SCHEDULE_START & PL_SCHEDULE_END controls.
Raj A. 29-Jul-2014 Added LAST_ETL_COMP_PIVOT global control.
Raj A. 31-Jul-2014 Added PL_SUCCESSFUL_RUN_LOOK_BACK_DAYS global control.
Raj A. 07-Aug-2014 Added NYHIX related SLA global controls. Initial deployment had ILEB global controls.
*/
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'LETTER_ERR_TASK','INLIST','Letter Request Creation Error',null,'STEP_DEFINITION_ID',22,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'LETTER_ERR_TASK','INLIST','Letter Generation Error',null,'STEP_DEFINITION_ID',26,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'LETTER_ERR_TASK','INLIST','Letter Voided Error',null,'STEP_DEFINITION_ID',27,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'LETTER_ERR_UPD10_10','INLIST','Letter Request Creation Error',null,'STEP_DEFINITION_ID',22,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'LETTER_ERR_UPD10_20','INLIST','Letter Generation Error',null,'STEP_DEFINITION_ID',26,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','XA-Application Material Request','2','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','XX-Material Request','2','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','XA-Application Material Request','B','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','XX-Material Request','B','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','XA-Application Material Request','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','XX-Material Request','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','XA-Application Material Request','2','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','XX-Material Request','2','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','RE-Return Email Material Request','2','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','RE-Return Email Material Request','B','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','RE-Return Email Material Request','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','RE-Return Email Material Request','2','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-2077','DD-MON-YYYY'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert INTO CORP_ETL_LIST_LKUP ( CELL_ID, name, LIST_TYPE, value, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS ) 
VALUES (SEQ_CELL_ID.NEXTVAL, 'LAST_ETL_COMP_PIVOT', 'PIVOT', 'Process_Letters_runall', '12' , 'BPM_EVENT_MASTER', 12, TRUNC(sysdate - 1), TO_DATE('07077777', 'mmddyyyy'), 'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID' , sysdate, sysdate );

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('PL_LAST_LMREQ_ID','N',0,'Used to fetch Letters from OLTP for Process Letters  process',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LETTERS_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the letter_request.update_ts from the previous run. update_ts of the most recent letter record from the previous run.',sysdate,sysdate);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('PROCESSLETTERS_RUN_RUNALL_TODAY','D','2014/04/27','This will control if Letters process should run or not for the current date. Designed to run once a day only. However, null it to run in the next hourly run.',sysdate,sysdate);

/* Added on 15-Jul-2014.
The below two global controls will let us control the ETL runs without disabling the RUNALL.kjb in the cron job.
For Ex: If we want PL ETL to NOT run in prod, we can still have the PL RUNALL.kjb enabled in cron job and have the setting as start time: 02:00 
and end time: 01:00
*/
insert into CORP_ETL_CONTROL
values ('PL_SCHEDULE_START','V','09:00:00','Process Letters ETL to run once daily on NYHIX. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('PL_SCHEDULE_END','V','22:00:00','Process Letters ETL to run once daily on NYHIX. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);

/*
NYHIX & ILEB have a bug in fetching new instances. Currently, the code is fetching new instances since the last successful run date. 
I changed to fetch new instances going back by few days or few hours. This global control can be changed to go back 180 days or 0.25 day i.e., 6 hours.
To insert all the missing instances since many months, I will use global control value=180 days; After the first run after this deployment, 
I will change to 4/24, i.e., 4 hours.
*/
insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('PL_SUCCESSFUL_RUN_LOOK_BACK_DAYS','N',30,'Last Successful ETL run date minus these many days. Ex: use 180 to go back 6 months. 0.25 to go back 6 hours.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LETTERS_STG_LOOK_BACK_DAYS','N','2','Number of days to look back when inserting/updating letters so records will not be missed',sysdate,sysdate);

commit;
