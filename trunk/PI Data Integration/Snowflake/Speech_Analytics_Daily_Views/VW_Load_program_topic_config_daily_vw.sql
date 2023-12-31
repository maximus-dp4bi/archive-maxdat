create or replace view LOAD_PI_TRANSCRIPTION_PROGRAM_TOPIC_MAPPING_HISTORY_VW as         
SELECT 
PROJECTID
, PROJECTNAME
, PROGRAMID
, PROGRAMNAME
, INGESTIONDATETIME,
RAW:programId::varchar AS SPEECH_program_Id,
RAW:topicId::varchar AS topicId,
HASH(Raw) AS ROW_HASH,
SYSDATE() AS SNOWFLAKE_INSERT_DATETIME,
SYSDATE() AS SNOWFLAKE_UPDATE_DATETIME,
CAST(INGESTIONDATETIME AS DATE) AS AS_OF_DATE,
'PI_USER_LOAD' AS INSERT_BY,
1 AS CURRENT_USER_RECORD
FROM PUREINSIGHTS_DEV.RAW.TRANSCRIPTION_PROGRAM_TOPIC_MAPPING;