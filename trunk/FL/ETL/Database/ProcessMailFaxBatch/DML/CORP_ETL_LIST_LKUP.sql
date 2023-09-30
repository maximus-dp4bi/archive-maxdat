--------------------------------------------------------
--  File created - Thursday-June-26-2014   
--------------------------------------------------------
REM INSERTING into  CORP_ETL_LIST_LKUP
SET DEFINE OFF;
Insert into  CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (2,'MFB_TIMELINESS_DAYS','TIMELINESS_DAYS_THRESHOLD','Threshold for Timeliness Days','2',null,null,to_date('18-JUN-14','DD-MON-RR'),null,null,to_date('18-JUN-14','DD-MON-RR'),to_date('24-JUN-14','DD-MON-RR'));
Insert into  CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (3,'MFB_TIMELINESS_DAYS_TYPE','TIMELINESS_DAYS_TYPE_THRESHOLD','Threshold for Timeliness Days Type','B',null,null,to_date('18-JUN-14','DD-MON-RR'),null,null,to_date('18-JUN-14','DD-MON-RR'),to_date('24-JUN-14','DD-MON-RR'));
Insert into  CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (4,'MFB_JEOPARDY_DAYS','JEOPARDY_DAYS_THRESHOLD','Threshold for Jeopardy Days','1',null,null,to_date('18-JUN-14','DD-MON-RR'),null,null,to_date('18-JUN-14','DD-MON-RR'),to_date('24-JUN-14','DD-MON-RR'));
Insert into  CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (5,'MFB_JEOPARDY_DAYS_TYPE','JEOPARDY_DAYS_TYPE_THRESHOLD','Threshold for Jeopardy Days Type','B',null,null,to_date('18-JUN-14','DD-MON-RR'),null,null,to_date('18-JUN-14','DD-MON-RR'),to_date('24-JUN-14','DD-MON-RR'));
Insert into  CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (6,'MFB_TARGET_DAYS','TARGET_DAYS_THRESHOLD','Threshold for Target Days','0',null,null,to_date('18-JUN-14','DD-MON-RR'),null,null,to_date('18-JUN-14','DD-MON-RR'),to_date('24-JUN-14','DD-MON-RR'));
