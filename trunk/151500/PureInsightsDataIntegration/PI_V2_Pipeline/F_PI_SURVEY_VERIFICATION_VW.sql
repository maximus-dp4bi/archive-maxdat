use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

create or replace view F_PI_SURVEY_VERIFICATION_VW(
	PROJECTID,
	PROJECTNAME,
	SURVEYNAME,
	CONVERSATIONID,
	PARTICIPANTSTARTDATE,
	PROJECTPARTICIPANTSTARTDATE,
	VALUE
) COPY GRANTS as 
select distinct al.PROJECTID,
al.PROJECTNAME,
al.SURVEYNAME,
al.conversationid,
al.participantStartDate,
al.projectParticipantStartDate,
al.value
from
((with ca3 as (select distinct
projectId,
projectName,
programId,
programName,
conversationid,
key as SURVEYNAME,
Substr(right(key,6),1,3) as LANGUAGE,
value,
case when len(value) = 4 then left(value, 2)
when (len(value) = 5  and substr(value,3,1) = 'A') then left(value, 2)
when (len(value) = 5  and substr(value,4,1) = 'A') then left(value, 3)
when len(value) = 8 then left(value, 2)
when len(value) = 9 then left(value, 2)
when len(value) = 10 then left(value, 3)
when len(value) = 12 then left(value, 2)
when len(value) = 13 then left(value, 2)
else null end as QUESTIONNR,
case when len(value) = 4 then right(value, 2)
when (len(value) = 5 and substr(value,3,1) = 'A') then right(value, 3)
when (len(value) = 5 and substr(value,4,1) = 'A') then right(value, 2)
when len(value) = 8 then substr(value,3,2)
when (len(value) = 9  and substr(value,6,1) = '_') then substr(value,4,2)
when (len(value) = 9  and substr(value,6,1) != '_') then substr(value,3,2)
when len(value) = 12 then substr(value,3,2)
when len(value) = 13 then substr(value,3,2)
else '' end as ANSWERNR,
participantEndTime,
participantEndDate,
projectParticipantEndTime,
projectParticipantEndDate,
participantid,
participantName,
participantStartTime,
participantStartDate,
projectParticipantStartTime,
projectParticipantStartDate,
purpose,
userId
from
(select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:key as VARCHAR(255)) as key,
  cast (to_char(rp.RAW:participantEndTime) as DATETIME) as participantEndTime,
  cast (to_char(rp.RAW:participantEndTime) as DATE) as participantEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME)) as projectParticipantEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME))) as projectParticipantEndDate,
  cast (rt.RAW:participantid as VARCHAR(255)) as participantid,
  cast (rp.RAW:participantName as VARCHAR(255)) as participantName,
  cast (to_char(rp.RAW:participantStartTime) as DATETIME) as participantStartTime,
  cast (to_char(rp.RAW:participantStartTime) as DATE) as participantStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME)) as projectParticipantStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME))) as projectParticipantStartDate,
  cast (rp.RAW:purpose as VARCHAR(255)) as purpose,
  cast (rp.RAW:userid as VARCHAR(255)) as userId,
  cast (rt.RAW:value as VARCHAR(255)) as col
  from RAW.CONVERSATION_ATTRIBUTES rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId
  left join RAW.participants rp
  on rt.projectid = rp.projectid
  and rt.RAW:participantId =rp.RAW:participantId
 --where participantstartdate between add_months(last_day(current_date())+1, -1) and current_date() - 1
  where key like ('%CSAT%') or key like ('CoverVA%')
),  lateral split_to_table(COL, '||')
where VALUE <> '')
  select ca3.PROJECTID,
ca3.PROJECTNAME,
ca3.SURVEYNAME,
ca3.QUESTIONNR,
ca3.ANSWERNR,
si.SURVEYNAME as config_surveyname,
si.QUESTIONNR as config_questionnr,
si.ANSWERNR as config_answernr,
 ca3.conversationid,
ca3.participantStartDate,
ca3.projectParticipantStartDate,
cast(ca3.value as varchar) as value
from CA3 
LEFT OUTER JOIN PUBLIC.D_CSAT_QUESTIONS_INFO SI
on ca3.projectID = si.projectId
and ca3.SURVEYNAME = si.SURVEYNAME
and ((ca3.QUESTIONNR = si.QUESTIONNR
and ca3.ANSWERNR = si.ANSWERNR) or
     (ca3.value = si.questanscombo))

)
UNION ALL
(with ca2 as (select distinct
projectId,
projectName,
programId,
programName,
conversationid,
key as SURVEYNAME,
Substr(right(key,6),1,3) as LANGUAGE,
value,
case when len(value) = 8 then left(value, 4)
when (len(value) = 9 and substr(value,6,1) = '_') then left(value, 5)
when (len(value) = 9 and substr(value,6,1) != '_') then left(value, 4)
when len(value) = 12 then left(value, 4)
when (len(value) = 13 and substr(value,6,1) != '_') then left(value,4)
when (len(value) = 13 and substr(value,6,1) = '_') then left(value,5)
else null end as QUESTIONNR,
case when len(value) = 8 then right(value, 3)
when (len(value) = 9 and substr(value,6,1) = '_') then right(value, 3)
when (len(value) = 9 and substr(value,6,1) != '_') then right(value, 4)
when len(value) = 12 then substr(value,6,3)
when (len(value) = 13 and substr(value,6,1) != '_') then substr(value,6,3)
when (len(value) = 13 and substr(value,6,1) = '_') then substr(value,7,3)
else '' end as ANSWERNR,
participantEndTime,
participantEndDate,
projectParticipantEndTime,
projectParticipantEndDate,
participantid,
participantName,
participantStartTime,
participantStartDate,
projectParticipantStartTime,
projectParticipantStartDate,
purpose,
userId
from
(select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:key as VARCHAR(255)) as key,
  cast (to_char(rp.RAW:participantEndTime) as DATETIME) as participantEndTime,
  cast (to_char(rp.RAW:participantEndTime) as DATE) as participantEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME)) as projectParticipantEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME))) as projectParticipantEndDate,
  cast (rt.RAW:participantid as VARCHAR(255)) as participantid,
  cast (rp.RAW:participantName as VARCHAR(255)) as participantName,
  cast (to_char(rp.RAW:participantStartTime) as DATETIME) as participantStartTime,
  cast (to_char(rp.RAW:participantStartTime) as DATE) as participantStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME)) as projectParticipantStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME))) as projectParticipantStartDate,
  cast (rp.RAW:purpose as VARCHAR(255)) as purpose,
  cast (rp.RAW:userid as VARCHAR(255)) as userId,
  cast (rt.RAW:value as VARCHAR(255)) as col
  from RAW.CONVERSATION_ATTRIBUTES rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId
  left join RAW.participants rp
  on rt.projectid = rp.projectid
  and rt.RAW:participantId =rp.RAW:participantId
--where participantstartdate between add_months(last_day(current_date())+1, -1) and current_date() - 1
  where key like ('%CSAT%') or key like ('CoverVA%')
),  lateral split_to_table(COL, '||')
where VALUE <> '')
 select ca2.PROJECTID,
ca2.PROJECTNAME,
ca2.SURVEYNAME,
ca2.QUESTIONNR,
ca2.ANSWERNR,
si.SURVEYNAME as config_surveyname,
si.QUESTIONNR as config_questionnr,
si.ANSWERNR as config_answernr,
 ca2.conversationid,
ca2.participantStartDate,
ca2.projectParticipantStartDate,
cast(ca2.value as varchar) as value
from CA2 
LEFT OUTER JOIN PUBLIC.D_CSAT_QUESTIONS_INFO SI
on ca2.projectID = si.projectId
and ca2.SURVEYNAME = si.SURVEYNAME
and ((ca2.QUESTIONNR = si.QUESTIONNR
and ca2.ANSWERNR = si.ANSWERNR) or
     (ca2.value = si.questanscombo))

)
UNION ALL
(with ca as (select distinct
projectId,
projectName,
programId,
programName,
conversationid,
key as SURVEYNAME,
Substr(right(key,6),1,3) as LANGUAGE,
value,
case when len(value) = 12 then left(value, 8)
when (len(value) = 13 and substr(value,5,1) = '_') then left(value,8)
when (len(value) = 13 and substr(value,6,1) = '_') then left(value,9)
else null end as QUESTIONNR,
case when len(value) = 12 then right(value,3)
when (len(value) = 13 and substr(value,5,1) = '_') then right(value,4)
when (len(value) = 13 and substr(value,6,1) = '_') then right(value,3)
else '' end as ANSWERNR,
participantEndTime,
participantEndDate,
projectParticipantEndTime,
projectParticipantEndDate,
participantid,
participantName,
participantStartTime,
participantStartDate,
projectParticipantStartTime,
projectParticipantStartDate,
purpose,
userId
from
(select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:key as VARCHAR(255)) as key,
  cast (to_char(rp.RAW:participantEndTime) as DATETIME) as participantEndTime,
  cast (to_char(rp.RAW:participantEndTime) as DATE) as participantEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME)) as projectParticipantEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantEndTime) as DATETIME))) as projectParticipantEndDate,
  cast (rt.RAW:participantid as VARCHAR(255)) as participantid,
  cast (rp.RAW:participantName as VARCHAR(255)) as participantName,
  cast (to_char(rp.RAW:participantStartTime) as DATETIME) as participantStartTime,
  cast (to_char(rp.RAW:participantStartTime) as DATE) as participantStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME)) as projectParticipantStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (to_char(rp.RAW:participantStartTime) as DATETIME))) as projectParticipantStartDate,
  cast (rp.RAW:purpose as VARCHAR(255)) as purpose,
  cast (rp.RAW:userid as VARCHAR(255)) as userId,
  cast (rt.RAW:value as VARCHAR(255)) as col
  from RAW.CONVERSATION_ATTRIBUTES rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId
  left join RAW.participants rp
  on rt.projectid = rp.projectid
  and rt.RAW:participantId =rp.RAW:participantId
--where participantstartdate between add_months(last_day(current_date())+1, -1) and current_date() - 1
  where key like ('%CSAT%') or key like ('CoverVA%')
),  lateral split_to_table(COL, '||')
where VALUE <> '')
 select ca.PROJECTID,
ca.PROJECTNAME,
ca.SURVEYNAME,
ca.QUESTIONNR,
ca.ANSWERNR,
si.SURVEYNAME as config_surveyname,
si.QUESTIONNR as config_questionnr,
si.ANSWERNR as config_answernr,
 ca.conversationid,
ca.participantStartDate,
ca.projectParticipantStartDate,
cast(ca.value as varchar) as value
from CA 
LEFT OUTER JOIN PUBLIC.D_CSAT_QUESTIONS_INFO SI
on ca.projectID = si.projectId
and ca.SURVEYNAME = si.SURVEYNAME
and ((ca.QUESTIONNR = si.QUESTIONNR
and ca.ANSWERNR = si.ANSWERNR) or
     (ca.value = si.questanscombo))

)) al
left join D_CSAT_QUESTIONS_INFO cq
on cq.projectid = al.projectid
and (cq.questanscombo = al.value
     or cq.questionnr || cq.answernr = al.questionnr || al.answernr)
where config_questionnr is null
--and al.questionnr is null
and cq.questionnr is NULL;