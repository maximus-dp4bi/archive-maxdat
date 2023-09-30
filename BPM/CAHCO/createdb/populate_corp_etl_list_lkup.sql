delete from CORP_ETL_LIST_LKUP where cell_id < 6;
commit;

REM INSERTING into CORP_ETL_LIST_LKUP
SET DEFINE OFF;
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (2,'FORM_CREATEDBY_SCRIPT','FORM_CREATEDBY_SCRIPT','User IDs for System inserted data','''errorusr'',''recon'',''newelig'',''newelg'',''errusr'',''errmed'',''rcnfix''',null,null,to_date('10-APR-18','DD-MON-RR'),null,null,to_date('10-APR-18','DD-MON-RR'),to_date('10-APR-18','DD-MON-RR'));

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (1,'PACKET_TYPE','PACKET_TYPE','Packet Types','''IA'',''BB'',''PM'',''PV'',''DP'',''IM''',null,null,to_date('04-APR-18','DD-MON-RR'),null,null,to_date('04-APR-18','DD-MON-RR'),to_date('04-APR-18','DD-MON-RR'));

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (4,'EDER','FORM_SLA_DAYS','B','2',null,null,to_date('13-APR-18','DD-MON-RR'),null,null,to_date('13-APR-18','DD-MON-RR'),to_date('13-APR-18','DD-MON-RR'));

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (3,'Exemption','FORM_SLA_DAYS','B','3',null,null,to_date('13-APR-18','DD-MON-RR'),null,null,to_date('13-APR-18','DD-MON-RR'),to_date('13-APR-18','DD-MON-RR'));

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (5,'Choice Form','FORM_SLA_DAYS','B','2',null,null,to_date('13-APR-18','DD-MON-RR'),null,null,to_date('13-APR-18','DD-MON-RR'),to_date('13-APR-18','DD-MON-RR'));

Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values ('LOCAL_INIT_PLAN_ID','PLAN_ID','Local Initiative Plans', '''029'',''300'',''301'',''303'',''304'',''305'',''306'',''307'',''308'',''309'',''312'',''315'',''316'',''317''',null,null,trunc(sysdate),null,null,sysdate,sysdate);

Insert into CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values ('GMC_PLAN_COUNTY','COUNTY_CODE','GMC Counties', '''34'',''37''',null,null,trunc(sysdate),null,null,sysdate,sysdate);


commit;

