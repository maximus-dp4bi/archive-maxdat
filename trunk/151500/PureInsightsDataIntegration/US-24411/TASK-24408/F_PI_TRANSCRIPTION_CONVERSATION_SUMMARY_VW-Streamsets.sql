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
	CONVERSATIONSTARTTIME,
	CONVERSATIONSTARTDATE,
	PROJECTCONVERSATIONSTARTTIME,
	PROJECTCONVERSATIONSTARTDATE,
	CONVERSATIONENDTIME,
	CONVERSATIONENDDATE,
	PROJECTCONVERSATIONENDTIME,
	PROJECTCONVERSATIONENDDATE,
	DURATION,
	AGENTTALKDURATION,
	CUSTOMERTALKDURATION,
	SILENCEDURATION,
	IVRDURATION,
	ACDDURATION,
	OVERTALKDURATION,
	OVERTALKCOUNT,
	OTHERDURATION,
	SENTIMENTTRENDCLASS
) COPY GRANTS as
Select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.conversationId as VARCHAR(255)) as conversationId,
  cast (rt.sentimentScore as DOUBLE ) as sentimentScore,  
  cast (rt.sentimentTrend as DOUBLE ) as sentimentTrend,
  cast (rt.conversationStartTime as DATETIME) as conversationStartTime,
  to_date(cast (rt.conversationStartTime as DATETIME)) as conversationStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.conversationStartTime as DATETIME)) as projectConversationStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.conversationStartTime as DATETIME))) as projectConversationStartDate,
  cast (rt.conversationEndTime as DATETIME) as conversationEndTime,
  to_date(cast (rt.conversationEndTime as DATETIME)) as conversationEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.conversationEndTime as DATETIME)) as projectConversationEndTime, 
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.conversationEndTime as DATETIME))) as projectConversationEndDate, 
  cast(duration as INTEGER) as duration, 
  cast(agentTalkDuration as INTEGER) as agentTalkDuration, 
  cast(customerTalkDuration as INTEGER) as customerTalkDuration, 
  cast(silenceDuration as INTEGER) as silenceDuration,
  cast(ivrDuration as INTEGER) as ivrDuration, 
  cast(acdDuration as INTEGER) as acdDuration, 
  cast(overtalkDuration as INTEGER) as overtalkDuration, 
  cast(overtalkCount as INTEGER) as overtalkCount, 
  cast(otherDuration as INTEGER) as otherDuration,
  cast (rt.sentimenttrendclass as VARCHAR(255)) AS sentimenttrendclass  
from raw.transcription_conversation_summary rt
join PUBLIC.D_PI_PROJECTS pr
on rt.projectId = pr.projectid;