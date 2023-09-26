use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

create or replace view F_PI_TRANSCRIPTION_TOPICS_VW(
	PROJECTID,
	PROJECTNAME,
	PROGRAM_ID,
	PROGRAM_NAME,
	CONFIDENCE,
	CONVERSATIONID,
	PARTICIPANTNAME,
	QUEUEID,
	QUEUENAME,
	TOPICID,
	TOPICNAME,
	TOPICPHRASE,
	TOPICSTARTTIME,
	PROJECTTOPICSTARTTIME,
	TRANSCRIPTPHRASE,
	USERID,
	PROGRAMID,
	PROGRAMNAME
) COPY GRANTS AS
WITH
   	topics	AS 
   	(
         select
			ttb.projectid									AS	projectid,
	        ttb.programid									AS	program_id,
			ttb.programname									AS	program_name,
         	CAST(ttb.raw:conversationId AS VARCHAR(255))	AS	conversationId, 
		 	CAST(ttb.raw:topicStartTime AS DATETIME)		AS	topicStartTime, 
		 	CAST(ttb.raw:topicId AS VARCHAR(255)) 			AS 	topicId, 
		 	CAST(ttb.raw:topicName AS VARCHAR(255))			AS	topicName, 
		 	CAST(ttb.raw:topicPhrase AS VARCHAR(255))		AS	topicPhrase,
		 	CAST(ttb.raw:transcriptPhrase AS VARCHAR(255))	AS	transcriptPhrase, 
		 	CAST(ttb.raw:confidence AS DOUBLE)				AS	confidence, 
		 	CAST(ttb.raw:programId AS VARCHAR(255))			AS	programId, 		 	
		 	CAST(ttb.raw:participant AS VARCHAR(255))		AS	participant,
		 	max(ip.participantname)  						AS	participantName, 
		 	min(ip.queueName)								AS	queueName
         from
         	raw.transcription_topics_batched	ttb
         LEFT OUTER JOIN 
         	(
				SELECT  
					projectid,	
					conversationid, 
					participantname, 
					userid, 
					queuename, 
					sessionstarttime, 
					sessionendtime, 
					totalagentwrapupduration		
				FROM 
					F_PI_SESSION_SUMMARY_VW 	ss
				WHERE 
					ss.purpose in ('user','agent', 'acd')

         	)	ip 
         on 
         (
         		ip.sessionstarttime < CAST(ttb.raw:topicStartTime AS DATETIME)      
        	and dateadd(millisecond, -1 * ip.totalagentwrapupduration,  ip.sessionEndTime)  > CAST(ttb.raw:topicStartTime AS DATETIME)
            and ip.conversationid = CAST(ttb.raw:conversationId AS VARCHAR(255))
       	 )                  
         group by 1,2,3,4,5,6,7,8,9,10,11,12
  	),
    q	AS 
    (
    	select  
    		projectid,
    		CAST(co.raw:name AS VARCHAR(255))			AS	queuename, 
    		CAST(co.raw:id AS VARCHAR(255)) 			AS 	queueId 
    	from 
    		raw.configuration_objects	co 
    	where 
    		CAST(co.raw:type AS VARCHAR(255)) = 'queue'
    ),
	u	AS
    (
    	select  
    		projectid,
    		CAST(co.raw:name AS VARCHAR(255))			AS	username, 
    		CAST(co.raw:id AS VARCHAR(255)) 			AS 	userid 
    	from 
    		raw.configuration_objects	co 
    	where 
    		CAST(co.raw:type AS VARCHAR(255)) = 'user'
    ),
     program	AS	 
     (
     	select  
			projectid,
	     	CAST(raw:name AS VARCHAR(255))					AS	name, 
     		CAST(raw:id	AS VARCHAR(255))					AS	id
     	from 
     		raw.transcription_program_configuration
    )	
SELECT
	rt.projectId																			AS	projectId,
  	pr.projectName 																			AS 	projectName,
  	rt.program_Id 																			AS	program_Id,
  	rt.program_name 																		AS 	program_name,
  	rt.confidence																			AS	confidence,
  	rt.conversationId 																		AS 	conversationId,
  	rt.participantName																		AS	participantName,
  	q.queueId																				AS	queueId,
  	q.queueName																				AS	queueName,
  	rt.topicId																				AS	topicId,
  	rt.topicName																			AS	topicName,
  	rt.topicPhrase																			AS	topicPhrase,
  	rt.topicStartTime																		AS	topicStartTime,
  	convert_timezone('UTC',pr.projectTimezone, rt.topicStartTime) 							AS 	projecttopicStartTime,
	rt.transcriptPhrase  																	AS	transcriptPhrase,
	u.userId																				AS	userId,
	rt.programid																			AS	programid,
	program.name																			AS	programname	
FROM 
	topics	rt
JOIN 
	PUBLIC.D_PI_PROJECTS pr
ON
(
	rt.projectId = pr.projectId
)
LEFT OUTER JOIN 
	program 
ON
(
		rt.projectid	=	program.projectid
	AND	rt.programId 	= 	program.id
)
LEFT OUTER JOIN 
	q
ON
(
		rt.projectid	=	q.projectid
	AND	rt.queueName 	= 	q.queueName
)
LEFT OUTER JOIN 
	u 
ON 
(
		rt.projectid		=	u.projectid
	AND	rt.participantname 	= 	u.userName
);

GRANT SELECT ON F_PI_TRANSCRIPTION_TOPICS_VW TO BI_PRODUCT_DEV;   
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPICS_VW TO DATA_SUPPORT_ROLE;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPICS_VW TO DA_LAB_ADMIN;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPICS_VW TO DA_LAB_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPICS_VW TO MAX_DEV;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPICS_VW TO OPS_ANALYTICS_TEAM;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPICS_VW TO PUBLIC;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPICS_VW TO INFA_DATA_CATALOG_UAT_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPICS_VW TO PUREINSIGHTS_UAT_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_TOPICS_VWTO PI_DATA_INGEST_UAT_ALERT_USER;
GRANT DELETE, INSERT, REBUILD, REFERENCES, SELECT, TRUNCATE, UPDATE ON F_PI_TRANSCRIPTION_TOPICS_VW TO PUREINSIGHTS_DEV_POC;

SELECT * FROM F_PI_TRANSCRIPTION_TOPICS_VW WHERE conversationid = '0105eeac-d097-4b85-8258-9ffb531dc474';
SELECT * FROM RAW.TRANSCRIPTION_TOPICS_BATCHED WHERE raw:conversationId = '0105eeac-d097-4b85-8258-9ffb531dc474';

				SELECT  
					projectid,	
					conversationid, 
					participantname, 
					userid, 
					queuename, 
					sessionstarttime, 
					sessionendtime, 
					totalagentwrapupduration		
				FROM 
					F_PI_SESSION_SUMMARY_VW 	ss
				WHERE 
					ss.purpose in ('user','agent', 'acd')
				AND conversationid = '0105eeac-d097-4b85-8258-9ffb531dc474';

			SELECT * FROM raw.configuration_objects WHERE raw:name = 'Voicemail Day English';
			
{
  "DivisionId": "c7d2a255-b03a-4c33-b9a6-cd85d247735f",
  "DivisionName": "Home",
  "id": "ad82be16-5ef6-47bc-afd7-1572dc672a34",
  "name": "Voicemail Day English",
  "type": "queue"
}		