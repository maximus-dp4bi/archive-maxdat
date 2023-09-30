/*
Created on 02-Oct-2014 by Raj A.
Description: Created for Manage Work V2 

v2 11/06/2014 Raj A.  Per NYHIX-7711 & MAXDAT-216, removed MW_V2_ADD_TO_WHERE_CLAUSE. Added this control to the Corp_etl_List_lkup as I needed a bigger size column.
v3 10/14/2015 Raj A.  Removed the word 'NYHIX' from this script as this script is used as a Corp deploy install and do NOT want NYHIX to show up in other projects.
*/
insert into CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) 
values ('MW_V2_LOAD_START_DATE', 'D', '2014/09/1 00:00:00', 'Variable used to load MW V2 tasks based on create date.',sysdate,sysdate);

insert into CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) 
values ('MW_V2_LOAD_END_DATE', 'D', '2014/09/30 00:00:00', 'Variable used to load MW V2 tasks based on create date.',sysdate,sysdate);

-- Mismatched task status update for NYEC and NYHIX.
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) 
values ('MW_V2_BATCH_MISMATCH_LAST_UPDATE','D',TO_CHAR(SYSDATE-1,'YYYY/MM/DD'),'Last date the MW Task status mismatch job ran (format YYYY/MM/DD). Initially scheduled every week on Sunday.');

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) 
values ('MW_V2_BATCH_MISMATCH_DAY','V','MON, TUE, WED, THU, FRI, SAT, SUN','Batch scheduled to run only during the weekend. This control originally set for SAT and SUN.');

/* Added on 15-Jul-2014.
The below two global controls will let us control the ETL runs without disabling the RUNALL.kjb in the cron job.
For Ex: If we want MW V2 ETL to NOT run in prod, we can still have the MW V2 RUNALL.kjb enabled in cron job and have the setting as start time: 02:00 
and end time: 01:00
*/
insert into CORP_ETL_CONTROL
values ('MW_V2_SCHEDULE_START','V','00:00:00','MW V2 ETL to run once daily. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('MW_V2_SCHEDULE_END','V','11:00:00','MW V2 ETL to run once daily. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);

commit;
