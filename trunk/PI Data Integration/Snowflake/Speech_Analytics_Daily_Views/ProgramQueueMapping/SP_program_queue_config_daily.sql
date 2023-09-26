CREATE OR REPLACE PROCEDURE "LOAD_PI_TRANSCRIPTION_PROGRAM_QUEUE_MAPPING_HISTORY_PROC"("PROJECTID" VARCHAR(16777216), "REINGESTFLAG" BOOLEAN, "RUNFROMBASHFLAG" BOOLEAN)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS 'declare environment varchar;                
        tempTableName varchar default ''LOAD_PI_TRANSCRIPTION_PROGRAM_QUEUE_MAPPING_HIST_TEMP'';
        tgtTableName varchar default ''PI_TRANSCRIPTION_PROGRAM_QUEUE_MAPPING_HISTORY'';
        srcTableName varchar default ''LOAD_PI_TRANSCRIPTION_PROGRAM_QUEUE_MAPPING_HISTORY_VW'';
        tempTableText varchar;
        mergeInsertUpdate varchar;
        mergeCloseCurrent varchar;
                
BEGIN 
                
SELECT CURRENT_DATABASE() || ''.'' || CURRENT_SCHEMA() || ''.'' INTO :environment;
      
tempTableText:= ''CREATE OR REPLACE TEMPORARY TABLE '' || :environment || :tempTableName || '' AS SELECT a.*, b.ROW_HASH TGT_ROW_HASH, b.AS_OF_DATE TGT_AS_OF_DATE FROM '' || :environment || :srcTableName || '' a 
              LEFT JOIN '' || :environment || :tgtTableName || '' b ON a.SPEECH_PROGRAM_ID = b.SPEECH_PROGRAM_ID AND a.QUEUEID =b.QUEUEID AND b.CURRENT_USER_RECORD = 1 
             WHERE (a.ROW_HASH != b.ROW_HASH OR a.AS_OF_DATE = b.AS_OF_DATE OR b.SPEECH_PROGRAM_ID IS NULL OR b.QUEUEID is null )'' || CASE WHEN TRY_TO_NUMBER(:PROJECTID) IS NULL THEN '''' ELSE '' AND a.PROJECTID ='' || :PROJECTID END;

mergeInsertUpdate:= ''MERGE INTO '' || :environment || :tgtTableName || '' tgt USING (SELECT * FROM '' || :environment || :tempTableName || '') src ON (tgt.SPEECH_PROGRAM_ID = src.SPEECH_PROGRAM_ID AND tgt.QUEUEID = src.QUEUEID  AND tgt.PROJECTID = src.PROJECTID AND tgt.AS_OF_DATE = src.AS_OF_DATE AND tgt.CURRENT_USER_RECORD = 1) 
                WHEN MATCHED THEN UPDATE
                    SET tgt.PROGRAMID = src.PROGRAMID
                    ,   tgt.INGESTIONDATETIME = src.INGESTIONDATETIME
 		    ,   tgt.RAW = src.RAW              
                    ,   tgt.ROW_HASH = src.ROW_HASH
                    ,   tgt.SNOWFLAKE_UPDATE_DATETIME = src.SNOWFLAKE_UPDATE_DATETIME
                WHEN NOT MATCHED AND src.TGT_ROW_HASH != src.ROW_HASH OR src.TGT_ROW_HASH IS NULL THEN INSERT (PROJECTID,
	PROGRAMID,
	INGESTIONDATETIME,
	SPEECH_PROGRAM_ID,
	QUEUEID,
	RAW,
	ROW_HASH,
	SNOWFLAKE_INSERT_DATETIME,
	AS_OF_DATE,
	INSERT_BY,
	CURRENT_USER_RECORD) values(
    src.PROJECTID,
	src.PROGRAMID,
	src.INGESTIONDATETIME,
	src.SPEECH_PROGRAM_ID,
	src.QUEUEID,	
	src.RAW,
	src.ROW_HASH,
	src.SNOWFLAKE_INSERT_DATETIME,
	src.AS_OF_DATE,
	src.INSERT_BY,
	src.CURRENT_USER_RECORD)'' ;                


mergeCloseCurrent:= ''MERGE INTO '' || :environment || :tgtTableName || '' tgt USING (SELECT * FROM '' || :environment || :tempTableName || '') src ON (tgt.SPEECH_PROGRAM_ID = src.SPEECH_PROGRAM_ID AND tgt.QUEUEID =src.QUEUEID AND tgt.PROJECTID = src.PROJECTID AND tgt.CURRENT_USER_RECORD = 1 AND src.TGT_AS_OF_DATE = tgt.AS_OF_DATE)
                WHEN MATCHED AND src.ROW_HASH != src.TGT_ROW_HASH AND src.TGT_ROW_HASH IS NOT NULL THEN UPDATE
                    SET SNOWFLAKE_UPDATE_DATETIME = src.SNOWFLAKE_UPDATE_DATETIME
                    ,   CURRENT_USER_RECORD = 0'' ;                                

EXECUTE IMMEDIATE tempTableText;
                
BEGIN TRANSACTION;

EXECUTE IMMEDIATE mergeInsertUpdate;
EXECUTE IMMEDIATE mergeCloseCurrent;
            
COMMIT;              
  RETURN ''Success'';--PROJECTID;
EXCEPTION
  WHEN OTHER THEN
  ROLLBACK;
  RETURN ''Error'';                
--RETURN mergeInsertUpdate;
END';
