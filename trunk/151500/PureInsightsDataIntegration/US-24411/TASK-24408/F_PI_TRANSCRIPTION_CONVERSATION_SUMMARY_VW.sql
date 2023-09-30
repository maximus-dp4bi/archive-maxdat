use role SYSADMIN;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

create or replace view F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW(
	PROJECTID,
	PROJECTNAME,
	PROGRAMID,
	PROGRAMNAME,
	CONVERSATIONID,
	SENTIMENTSCORE,
	SENTIMENTTREND,
	SENTIMENTTRENDCLASS,
	CONVERSATIONSTARTTIME,
	CONVERSATIONSTARTDATE,
	PROJECTCONVERSATIONSTARTTIME,
	PROJECTCONVERSATIONSTARTDATE,
	CONVERSATIONENDTIME,
	CONVERSATIONENDDATE,
	PROJECTCONVERSATIONENDTIME,
	PROJECTCONVERSATIONENDDATE,
	DURATION,
	AGENTDURATIONPERCENTAGE,
	AGENTTALKDURATION,
	CUSTOMERDURATIONPERCENTAGE,
	CUSTOMERTALKDURATION,
	SILENCEDURATIONPERCENTAGE,
	SILENCEDURATION,
	IVRDURATIONPERCENTAGE,
	IVRDURATION,
	ACDDURATIONPERCENTAGE,
	ACDDURATION,
	OVERTALKDURATIONPERCENTAGE,
	OVERTALKDURATION,
	OVERTALKCOUNT,
	OTHERDURATION
) COPY GRANTS as
SELECT	D.*,
		D.duration - 
		CAST
		(
			(
				agentDurationPercentage + 
				customerDurationPercentage + 
				silenceDurationPercentage + 
				ivrDurationPercentage + 
				acdDurationPercentage + 
				overtalkDurationPercentage
			) * D.duration
			AS
			NUMBER(38,0)
		) 																																				as	otherduration			
FROM
	(
		Select
			  rt.projectId 																																as 	projectId,
			  pr.projectName																															as 	projectName,
			  rt.programId																																as 	programId,
			  rt.programName 																															as 	programName,
			  cast (rt.raw:conversationId as VARCHAR(255)) 																								as 	conversationId,
			  cast (rt.raw:sentimentScore as DOUBLE ) * 100																								as 	sentimentScore,  
			  cast (rt.raw:sentimentTrend as DOUBLE ) * 100 																							as 	sentimentTrend,
			  cast (rt.raw:sentimentTrendClass as VARCHAR(255)) 																						as 	sentimentTrendClass,
			  cast (c.raw:conversationStartTime as DATETIME) 																							as 	conversationStartTime,
			  to_date(cast (c.raw:conversationStartTime as DATETIME)) 																					as 	conversationStartDate,
			  convert_timezone('UTC',pr.projectTimezone,cast (c.raw:conversationStartTime as DATETIME)) 												as 	projectConversationStartTime,
			  to_date(convert_timezone('UTC',pr.projectTimezone,cast (c.raw:conversationStartTime as DATETIME))) 										as 	projectConversationStartDate,
			  cast (c.raw:conversationEndTime as DATETIME) 																								as 	conversationEndTime,
			  to_date(cast (c.raw:conversationEndTime as DATETIME)) 																					as 	conversationEndDate,
			  convert_timezone('UTC',pr.projectTimezone,cast (c.raw:conversationEndTime as DATETIME)) 													as 	projectConversationEndTime, 
			  to_date(convert_timezone('UTC',pr.projectTimezone,cast (c.raw:conversationEndTime as DATETIME))) 											as 	projectConversationEndDate, 
			  COALESCE(cast(c.raw:duration as NUMBER(38,0)),0) 																							as 	duration, 
			  COALESCE(cast(rt.raw:agentDurationPercentage AS DOUBLE),0)																				as	agentDurationPercentage,
			  COALESCE(cast((cast(c.raw:duration as NUMBER(38,0)) * cast(rt.raw:agentDurationPercentage AS DOUBLE)) AS NUMBER(38,0)),0) 				as 	agentTalkDuration, 
			  COALESCE(cast(rt.raw:customerDurationPercentage AS DOUBLE),0)																				as	customerDurationPercentage,
			  COALESCE(cast((cast(c.raw:duration as NUMBER(38,0)) * cast(rt.raw:customerDurationPercentage as DOUBLE)) AS NUMBER(38,0)),0) 				as 	customerTalkDuration, 
			  COALESCE(cast(rt.raw:silenceDurationPercentage AS DOUBLE),0)																				as	silenceDurationPercentage,
			  COALESCE(cast((cast(c.raw:duration as NUMBER(38,0)) * cast(rt.raw:silenceDurationPercentage as DOUBLE)) AS NUMBER(38,0)),0) 				as 	silenceDuration, 
			  COALESCE(cast(rt.raw:ivrDurationPercentage AS DOUBLE),0)																					as	ivrDurationPercentage,
			  COALESCE(cast((cast(c.raw:duration as NUMBER(38,0)) * cast(rt.raw:ivrDurationPercentage as DOUBLE)) AS NUMBER(38,0)),0) 					as 	ivrDuration, 
			  COALESCE(cast(rt.raw:acdDurationPercentage AS DOUBLE),0)																					as	acdDurationPercentage,
			  COALESCE(cast((cast(c.raw:duration as NUMBER(38,0)) * cast(rt.raw:acdDurationPercentage as DOUBLE)) AS NUMBER(38,0)),0) 					as 	acdDuration, 
			  COALESCE(cast(rt.raw:overtalkDurationPercentage AS DOUBLE),0)																				as	overtalkDurationPercentage,
			  COALESCE(cast((cast(c.raw:duration as NUMBER(38,0)) * cast(rt.raw:overtalkDurationPercentage as DOUBLE)) AS NUMBER(38,0)),0) 				as 	overtalkDuration, 
			  COALESCE(cast(rt.raw:overtalkCount as NUMBER(38,0)),0) 																						as 	overtalkCount
		from 
			raw.transcription_conversation_summary_batched 		rt
		join 
			PUBLIC.D_PI_PROJECTS				 				pr
		on 
			rt.projectId = pr.projectid
		join
			raw.conversations c 
		ON
		(
				rt.raw:conversationId = c.raw:conversationId
			AND	rt.projectid = c.projectid
		)
	) D;

GRANT SELECT ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO BI_PRODUCT_DEV;   
GRANT SELECT ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO DATA_SUPPORT_ROLE;
GRANT SELECT ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO DA_LAB_ADMIN;
GRANT SELECT ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO DA_LAB_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO MAX_DEV;
GRANT SELECT ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO OPS_ANALYTICS_TEAM;
GRANT SELECT ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO PUBLIC;
GRANT SELECT ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO INFA_DATA_CATALOG_UAT_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO PUREINSIGHTS_UAT_READ;
GRANT SELECT ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO PI_DATA_INGEST_UAT_ALERT_USER;
GRANT DELETE, INSERT, REBUILD, REFERENCES, SELECT, TRUNCATE, UPDATE ON F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW TO PUREINSIGHTS_DEV_POC;

SELECT projectid, projectname, count(*) FROM F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW GROUP BY projectid, projectname;
SELECT projectid, projectname, max(CONVERSATIONSTARTTIME) FROM F_PI_TRANSCRIPTION_CONVERSATION_SUMMARY_VW GROUP BY projectid, projectname;
