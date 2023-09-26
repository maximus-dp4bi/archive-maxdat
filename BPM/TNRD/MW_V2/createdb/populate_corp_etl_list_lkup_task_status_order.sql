REM INSERTING into CORP_ETL_LIST_LKUP
SET DEFINE OFF;
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (282,'MW_TASK_STATUS_ORDER','ORDER','CLAIMED','20',null,null,to_date('01/23/2014 14:53:33','mm/dd/yyyy hh24:mi:ss'),to_date('07/07/7777 00:00:00','mm/dd/yyyy hh24:mi:ss'),'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.',to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'),to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'));
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (283,'MW_TASK_STATUS_ORDER','ORDER','COMPLETED','100',null,null,to_date('01/23/2014 14:53:33','mm/dd/yyyy hh24:mi:ss'),to_date('07/07/7777 00:00:00','mm/dd/yyyy hh24:mi:ss'),'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.',to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'),to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'));
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (284,'MW_TASK_STATUS_ORDER','ORDER','INPROCESS','30',null,null,to_date('01/23/2014 14:53:33','mm/dd/yyyy hh24:mi:ss'),to_date('07/07/7777 00:00:00','mm/dd/yyyy hh24:mi:ss'),'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.',to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'),to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'));
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (285,'MW_TASK_STATUS_ORDER','ORDER','SUSPENDED','40',null,null,to_date('01/23/2014 14:53:33','mm/dd/yyyy hh24:mi:ss'),to_date('07/07/7777 00:00:00','mm/dd/yyyy hh24:mi:ss'),'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.',to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'),to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'));
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (286,'MW_TASK_STATUS_ORDER','ORDER','TERMINATED','50',null,null,to_date('01/23/2014 14:53:33','mm/dd/yyyy hh24:mi:ss'),to_date('07/07/7777 00:00:00','mm/dd/yyyy hh24:mi:ss'),'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.',to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'),to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'));
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (287,'MW_TASK_STATUS_ORDER','ORDER','TIMEOUT','60',null,null,to_date('01/23/2014 14:53:33','mm/dd/yyyy hh24:mi:ss'),to_date('07/07/7777 00:00:00','mm/dd/yyyy hh24:mi:ss'),'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.',to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'),to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'));
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (288,'MW_TASK_STATUS_ORDER','ORDER','UNCLAIMED','10',null,null,to_date('01/23/2014 14:53:33','mm/dd/yyyy hh24:mi:ss'),to_date('07/07/7777 00:00:00','mm/dd/yyyy hh24:mi:ss'),'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.',to_date('01/23/2014 14:53:33','mm/dd/yyyy hh24:mi:ss'),to_date('01/23/2014 14:53:33','mm/dd/yyyy hh24:mi:ss'));
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (289,'MW_TASK_STATUS_ORDER','ORDER','VOIDED','80',null,null,to_date('01/23/2014 14:53:33','mm/dd/yyyy hh24:mi:ss'),to_date('07/07/7777 00:00:00','mm/dd/yyyy hh24:mi:ss'),'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.',to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'),to_date('01/23/2014 14:53:34','mm/dd/yyyy hh24:mi:ss'));

commit;