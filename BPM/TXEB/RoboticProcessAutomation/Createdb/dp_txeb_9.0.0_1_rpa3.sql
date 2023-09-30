DECLARE

DBChangeID VARCHAR2(50) := 'TXEB-17589_3';
ExecutionOrder NUMBER(10,0) := 3;
LODNumber VARCHAR2(20) := '9.0.0';
BuildNumber VARCHAR2(10) := '1';
CreatedBy VARCHAR2(100) := 'Guy Thibodeau';
CreatedDate DATE := sysdate;
DBChangeType VARCHAR2(50) := 'DML';
FunctionalArea VARCHAR2(50) := 'RoboticProcessAutomation';
TargetSchema VARCHAR2(50) := 'MAXDAT';
ObjectsAffected VARCHAR2(4000) := 'CORP_ETL_CONTROL';
Comm VARCHAR2(4000) := 'CREATE ENTRIES IN THE CORP_ETL_CONTROL TABLE';
Path VARCHAR2(500) := '/Database/schema/maxdat/Objects/dp_txeb_9.0.0_1_rpa3.sql';

Rowcount NUMBER(10,0);
SqlErr VARCHAR2(500);
AlreadyRun   EXCEPTION;
PRAGMA EXCEPTION_INIT (AlreadyRun, -20003);


BEGIN

db_change_pkg.log_db_change_start (DBChangeID,ExecutionOrder,LODNumber,BuildNumber,CreatedBy,CreatedDate,DBChangeType,FunctionalArea,TargetSchema,ObjectsAffected,Comm,Path);       

-- -------------------
-- BEGIN SQL PAYLOAD
-- -------------------

execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_NOTE_LU'', ''N'', ''16156213'', ''Primary Key of the end of the last run, starting point for the next run'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_DOCUMENT_LU'', ''D'', ''2020/04/01 00:00:00'', ''Timestamp of the end of the last run, starting point for the next run'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_EVENT_LU'', ''N'', ''2101400000'', ''Primary Key of the end of the last run, starting point for the next run'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_NOTE_FILTER'', ''V'', ''NOTE.category_cd = ''imaging'' '', ''Where clause filter for source data'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_CLIENT_DATA_LU'', ''N'', ''2730422'', ''Primary Key of the end of the last run, starting point for the next run'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_FORM_DATA_LU'', ''N'', ''2350987'', ''Primary Key of the end of the last run, starting point for the next run'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_PLAN_INFO_DATA_LU'', ''N'', ''7756353'', ''Primary Key of the end of the last run, starting point for the next run'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_STEP_INSTANCE_LU'', ''N'', ''487028608'', ''Primary Key of the end of the last run, starting point for the next run'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_HUMAN_TASK_INSTANCE_LU'', ''N'', ''487114158'', ''Primary Key of the end of the last run, starting point for the next run'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_DOCUMENT_FILTER'', ''V'', ''DOCUMENT.doc_form_type IN(''EB-ETF'', ''EB-DTF'')'', ''Where clause filter for source data'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_EVENT_FILTER'', ''V'', ''EVENT.event_type_cd IN(''DOCUMENT_AUTOPROCESSING_FAILURE'')'', ''Where clause filter for source data'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_STEP_INSTANCE_FILTER'', ''V'', ''STEP_INSTANCE.step_definition_id IN(1200, 1052)'', ''Where clause filter for source data'',null,null)';
execute immediate 'INSERT INTO MAXDAT.CORP_ETL_CONTROL VALUES (''RPA_D_HUMAN_TASK_INSTANCE_FILTER'', ''V'', ''HUMAN_TASK_INSTANCE.step_definition_id IN(32301)'', ''Where clause filter for source data'',null,null)';
execute immediate 'commit';

-- -------------------
-- END SQL PAYLOAD
-- -------------------

Rowcount:= sql%rowcount;

db_change_pkg.log_db_change_end (DBChangeID,Rowcount,'DB Change completed successfully');

EXCEPTION

When AlreadyRun THEN
      DBMS_OUTPUT.PUT_LINE('This was run before');
      
WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(substr(SQLERRM, 1, 500));
      SqlErr:= SUBSTR(SQLERRM(SQLCODE), 1, 400);
      db_change_pkg.log_db_change_end (DBChangeID,Rowcount,'DB Change Execution Failed: ' || SqlErr);
      ROLLBACK;

END;

