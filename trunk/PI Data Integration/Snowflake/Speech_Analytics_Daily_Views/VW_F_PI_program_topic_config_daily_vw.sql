CREATE OR REPLACE VIEW  F_PI_program_topic_config_daily_vw AS 
WITH PT AS
(SELECT 
PT.PROJECTID,
P.PROJECTNAME,
PT.PROGRAMID,
P.PROGRAMNAME,
PT.SPEECH_PROGRAM_ID,
P.RAW:name SPEECH_PROGRAM_NAME,
P.RAW:description PROGRAM_DESCRIPTION,
P.RAW:published PROGRAM_PUBLISHED,
P.RAW:default PROGRAM_DEFAULT,
P.RAW:modifiedDate PROGRAM_PROJECTMODIFIEDDATE,
P.RAW:modifiedByUserId PROGRAM_MODIFIEDBY,
T.RAW:id AS TOPIC_ID,
T.RAW:name AS TOPIC_NAME,
T.RAW:description TOPIC_DESCRIPTION,
T.RAW:published TOPIC_PUBLISHED,
T.RAW:strictness TOPIC_STRICTNESS,
T.RAW:dialect TOPIC_DIALECT,
T.RAW:participants TOPIC_PARTICIPANTS,
T.RAW:modifiedDate TOPIC_PROJECTMODIFIEDDATE,
T.RAW:modifiedByUserId TOPIC_MODIFIEDBY,
T.RAW:publishedDate TOPIC_PROJECTPUBLISHEDDATE,
T.RAW:publishedByUserId TOPIC_PUBLISHEDBY,
AS_OF_DATE AS START_DATE,
CASE WHEN CURRENT_USER_RECORD = 1 THEN CAST('2100-12-31' AS DATE) ELSE LEAD(AS_OF_DATE) OVER (PARTITION BY PT.PROJECTID, PT.SPEECH_PROGRAM_ID, PT.TOPICID ORDER BY AS_OF_DATE ASC)-1 END END_DATE 
FROM DECISIONPOINT_DEV."STAGE".PI_TRANSCRIPTION_PROGRAM_TOPIC_MAPPING_HISTORY PT
JOIN RAW.TRANSCRIPTION_PROGRAM_CONFIGURATION P
ON PT.PROJECTID = P.PROJECTID AND PT.SPEECH_PROGRAM_ID =P.RAW:id
JOIN RAW.TRANSCRIPTION_TOPIC_CONFIGURATION T
ON PT.PROJECTID = T.PROJECTID AND PT.TOPICID =T.RAW:id )
SELECT DD.DATE RECORDDT,PT.*  FROM PT 
LEFT JOIN DECISIONPOINT_DEV.PUBLIC.D_DATES dd ON dd.DATE BETWEEN START_DATE AND END_DATE AND dd.DATE <= CAST(SYSDATE() AS DATE) 
ORDER BY DD.DATE, PROJECTID DESC