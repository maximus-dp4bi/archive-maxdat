use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema STAGE;

CREATE OR REPLACE PROCEDURE LOAD_PI_TEAMS_MEMBERSHIP_HISTORY_PROC(PROJECTID VARCHAR(16777216), REINGESTFLAG BOOLEAN, RUNFROMBASHFLAG BOOLEAN)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS 
$$
declare environment varchar;                
        tempTableName varchar default 'LOAD_PI_TEAMS_MEMBERSHIP_HIST_TEMP';
        tgtTableName varchar default 'PI_TEAMS_MEMBERSHIP_HISTORY';
        srcTableName varchar default 'LOAD_PI_TEAMS_MEMBERSHIP_HISTORY_VW';
        tempTableText varchar;
        mergeInsertUpdate varchar;
        mergeCloseCurrent varchar;
                
BEGIN 
                
SELECT CURRENT_DATABASE() || '.' || CURRENT_SCHEMA() || '.' INTO :environment;
      
tempTableText:= 'CREATE OR REPLACE TEMPORARY TABLE ' || :environment || :tempTableName || ' AS SELECT a.*, b.ROW_HASH TGT_ROW_HASH, b.AS_OF_DATE TGT_AS_OF_DATE FROM ' || :environment || :srcTableName || ' a 
              LEFT JOIN ' || :environment || :tgtTableName || ' b ON a.USERID = b.USERID AND b.CURRENT_USER_RECORD = 1 
             WHERE (a.ROW_HASH != b.ROW_HASH OR (a.AS_OF_DATE = b.AS_OF_DATE) OR (b.USERID IS NULL))' || CASE WHEN TRY_TO_NUMBER(:PROJECTID) IS NULL THEN '' ELSE ' AND a.PROJECTID =' || :PROJECTID END;

mergeInsertUpdate:= 'MERGE INTO ' || :environment || :tgtTableName || ' tgt USING (SELECT * FROM ' || :environment || :tempTableName || ') src ON (tgt.USERID = src.USERID AND tgt.PROJECTID = src.PROJECTID AND tgt.AS_OF_DATE = src.AS_OF_DATE AND tgt.CURRENT_USER_RECORD = 1) 
                WHEN MATCHED THEN UPDATE
                    SET tgt.PROGRAMID = src.PROGRAMID
                    ,   tgt.INGESTIONDATETIME = src.INGESTIONDATETIME
                    ,   tgt.TEAMID = src.TEAMID
                    ,   tgt.TEAMNAME = tgt.TEAMNAME 
                    ,   tgt.USERID = src.USERID 
                    ,   tgt.USERNAME = src.USERNAME
                    ,   tgt.DIVISIONID = src.DIVISIONID
                    ,   tgt.DIVISIONNAME = src.DIVISIONNAME
                    ,   tgt.RAW = src.RAW
                    ,   tgt.ROW_HASH = src.ROW_HASH
                    ,   tgt.SNOWFLAKE_UPDATE_DATETIME = src.SNOWFLAKE_UPDATE_DATETIME
                WHEN NOT MATCHED AND src.TGT_ROW_HASH != src.ROW_HASH OR src.TGT_ROW_HASH IS NULL THEN INSERT (PROJECTID,
	PROGRAMID,
	INGESTIONDATETIME,
	TEAMID,
	TEAMNAME,
	USERID,
	USERNAME,
	DIVISIONID,
	DIVISIONNAME,
	RAW,
	ROW_HASH,
	SNOWFLAKE_INSERT_DATETIME,
	AS_OF_DATE,
	INSERT_BY,
	CURRENT_USER_RECORD) values(
    src.PROJECTID,
	src.PROGRAMID,
	src.INGESTIONDATETIME,
	src.TEAMID,
	src.TEAMNAME,
	src.USERID,
	src.USERNAME,
	src.DIVISIONID,
	src.DIVISIONNAME,
	src.RAW,
	src.ROW_HASH,
	src.SNOWFLAKE_INSERT_DATETIME,
	src.AS_OF_DATE,
	src.INSERT_BY,
	src.CURRENT_USER_RECORD)';                


mergeCloseCurrent:= 'MERGE INTO ' || :environment || :tgtTableName || ' tgt USING (SELECT * FROM ' || :environment || :tempTableName || ') src ON (tgt.USERID = src.USERID AND tgt.PROJECTID = src.PROJECTID AND tgt.CURRENT_USER_RECORD = 1 AND src.TGT_AS_OF_DATE = tgt.AS_OF_DATE)
                WHEN MATCHED AND src.ROW_HASH != src.TGT_ROW_HASH AND src.TGT_ROW_HASH IS NOT NULL THEN UPDATE
                    SET SNOWFLAKE_UPDATE_DATETIME = src.SNOWFLAKE_UPDATE_DATETIME
                    ,   CURRENT_USER_RECORD = 0' ;                                



--EXECUTE IMMEDIATE 'delete from stage.stage_log';
--EXECUTE IMMEDIATE 'insert into stage.stage_log (message) values (''' || tempTableText || ''')';
EXECUTE IMMEDIATE tempTableText;

--BEGIN TRANSACTION;
--EXECUTE IMMEDIATE 'insert into stage.stage_log (message) values (''' || mergeInsertUpdate || ''')';
--COMMIT;

BEGIN TRANSACTION;
EXECUTE IMMEDIATE mergeInsertUpdate;

--BEGIN TRANSACTION;
--EXECUTE IMMEDIATE 'insert into stage.stage_log (message) values (''' || mergeInsertUpdate || ''')';
--COMMIT;

EXECUTE IMMEDIATE 'insert into stage.stage_log (message) values (''' || mergeCloseCurrent || ''')';
EXECUTE IMMEDIATE mergeCloseCurrent;

COMMIT;              
RETURN 'Success';--PROJECTID;
EXCEPTION
  WHEN OTHER THEN
  ROLLBACK;
  RETURN 'Error';                
--RETURN mergeInsertUpdate;
END;
$$;

GRANT USAGE ON PROCEDURE LOAD_PI_TEAMS_MEMBERSHIP_HISTORY_PROC(VARCHAR, BOOLEAN, BOOLEAN) TO ROLE PI_DATA_INGEST_DEV_ALERT_USER WITH GRANT OPTION;
