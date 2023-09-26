use role SYSADMIN;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

create or replace view F_PI_TRANSCRIPTION_SENTIMENT_VW(
	PROJECTID,
	PROJECTNAME,
	PROGRAM_ID,
	PROGRAMNAME,
	CONVERSATIONID,
	PARTICIPANTNAME,
	PHRASE,
	QUEUENAME,
	SENTIMENT,
	SENTIMENTSTARTTIME,
	PROJECTSENTIMENTSTARTTIME
) COPY GRANTS as
WITH
	ip 	AS 
	(
		SELECT  
			projectid,	
			conversationId,
			participantname, 
			queuename, 
			sessionstarttime, 
			sessionendtime, 
			totalagentwrapupduration 
		FROM 
			F_PI_SESSION_SUMMARY_VW 	ss
		WHERE 
			ss.purpose in ('user','agent')
	)
SELECT
	rt.projectId as projectId,
  	pr.projectName as projectName,
  	rt.programId as program_Id,
  	rt.programName as programName,
  	cast (rt.raw:conversationId as VARCHAR(255)) as conversationId,
    Case
        when rt.raw:participant = 'external' then 'External'
        else (select min(participantname) from ip
              where ip.sessionstarttime < cast (rt.raw:sentimentStartTime as DATETIME)
                and dateadd(millisecond, -1 * ip.totalagentwrapupduration,  ip.sessionEndTime) > cast (rt.raw:sentimentStartTime as DATETIME)
                and ip.conversationid = cast (rt.raw:conversationId as VARCHAR(255))
                 )
        end as participantName,
  	cast (rt.raw:phrase as VARCHAR) as phrase,
    (
    	select 
    		min(queuename) 
    	from 
    		ip
	    where 
	    	ip.sessionstarttime < cast (rt.raw:sentimentStartTime as DATETIME)
	    and dateadd(millisecond, -1 * ip.totalagentwrapupduration,  ip.sessionEndTime) > cast (rt.raw:sentimentStartTime as DATETIME)
       	and ip.conversationid = cast (rt.raw:conversationId as VARCHAR(255))
   	) as queueName,
  	cast (rt.raw:sentiment as DOUBLE ) as sentiment,
  	cast (rt.raw:sentimentStartTime as DATETIME) as sentimentStartTime,
  	convert_timezone('UTC',pr.projectTimezone,cast (rt.raw:sentimentStartTime as DATETIME)) as projectsentimentStartTime
FROM 
	RAW.TRANSCRIPTION_SENTIMENT_BATCHED rt
JOIN 
	PUBLIC.D_PI_PROJECTS pr
ON
(
	rt.projectId = pr.projectId
);

GRANT SELECT ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO BI_PRODUCT_DEV;   
GRANT SELECT ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO DATA_SUPPORT_ROLE;
GRANT SELECT ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO DA_LAB_ADMIN;
GRANT SELECT ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO DA_LAB_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO MAX_DEV;
GRANT SELECT ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO OPS_ANALYTICS_TEAM;
GRANT SELECT ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO PUBLIC;
GRANT SELECT ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO INFA_DATA_CATALOG_DEV_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO PUREINSIGHTS_DEV_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO PI_DATA_INGEST_DEV_ALERT_USER;
GRANT DELETE, INSERT, REBUILD, REFERENCES, SELECT, TRUNCATE, UPDATE ON F_PI_TRANSCRIPTION_SENTIMENT_VW TO PUREINSIGHTS_DEV_POC;
