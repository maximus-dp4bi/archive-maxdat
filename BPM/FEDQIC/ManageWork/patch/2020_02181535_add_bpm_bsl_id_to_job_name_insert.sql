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
