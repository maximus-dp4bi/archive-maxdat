use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

create or replace view D_PI_EVALUATION_CALIBRATIONS_VW(
	PROJECTID,
	PROJECTNAME,
	PROGRAMID,
	PROGRAMNAME,
	AGENTCOMMENTS,
	AGENTHASREAD,
	AGENTID,
	AGENTNAME,
	ANSWERID,
	ANSWERTEXT,
	ANSWERVALUE,
	ANYFAILEDKILLQUESTIONS,
	ASSIGNEDDATETIME,
	ASSIGNEDDATE,
	PROJECTASSIGNEDDATETIME,
	PROJECTASSIGNEDDATE,
	CALIBRATIONID,
	CHANGEDDATETIME,
	CHANGEDDATE,
	PROJECTCHANGEDDATETIME,
	PROJECTCHANGEDDATE,
	CONVERSATIONID,
	CONVERSATIONSTARTTIME,
	CONVERSATIONSTARTDATE,
	PROJECTCONVERSATIONSTARTTIME,
	PROJECTCONVERSATIONSTARTDATE,
	EVALUATIONCOMMENTS,
	EVALUATIONFORMNAME,
	EVALUATIONID,
	EVALUATIONFORMID,
	EVALUATIONFORMCONTEXTID,
	EVALUATIONFORMLASTMODIFIED,
	ISPUBLISHED,
	EVALUATORID,
	EVALUATORNAME,
	FAILEDKILLQUESTION,
	MARKEDNA,
	MAXQUESTIONSCORE,
	MAXQUESTIONSCOREWEIGHTED,
	MAXGROUPTOTALCRITICALSCORE,
	MAXGROUPTOTALCRITICALSCOREUNWEIGHTED,
	MAXGROUPTOTALSCORE,
	MAXGROUPTOTALSCOREUNWEIGHTED,
	NEVERRELEASE,
	QUESTIONGROUPMARKEDNA,
	QUESTIONGROUPNAME,
	QUESTIONGROUPWEIGHT,
	QUESTIONSCORECOMMENT,
	QUESTIONTEXT,
	QUESTIONGROUPID,
	QUESTIONID,
	QUESTIONSCORE,
	QUESTIONSCOREWEIGHTED,
	QUEUENAME,
	RELEASEDATETIME,
	RELEASEDATE,
	PROJECTRELEASEDATETIME,
	PROJECTRELEASEDATE,
	STATUS,
	TOTALEVALUATIONCRITICALSCORE,
	TOTALEVALUATIONSCORE,
	TOTALGROUPCRITICALSCORE,
	TOTALGROUPCRITICALSCOREUNWEIGHTED,
	QUESTIONISCRITICAL,
	QUESTIONISKILL,
	WEIGHTMODE,
	CALIBRATIONCREATEDDATETIME,
	PROJECTCALIBRATIONCREATEDDATETIME,
	CALIBRATIONCREATEDDATE,
	PROJECTCALIBRATIONCREATEDDATE,
	AVERAGESCORE,
	HIGHSCORE,
	LOWSCORE,
	CALIBRATORNAME,
	EVALUATION_FORM_DISPLAY_NAME,
	QUESTION_DISPLAY_NAME,
	QUESTION_SORT_ORDER,
	QUESTION_GROUP_DISPLAY_NAME,
	QUESTIONHELPTEXT,
	QUESTION_GROUP_SORT_ORDER,
	QUESTIONGROUPDEFAULTANSWERSTOHIGHEST,
	QUESTIONGROUPDEFAULTANSWERSTONA,
	QUESTIONGROUPMANUALWEIGHT,
	QUESTIONGROUPNAENABLED,
	QUESTIONGROUPTYPE,
	QUESTIONCOMMENTSREQUIRED,
	QUESTIONNAENABLED,
	QUESTIONTYPE
) COPY GRANTS as
  WITH
 a AS (SELECT cob.RAW:id AS agentId , cob.RAW:name AS agentName, cob.projectid as projectid FROM raw.configuration_objects cob  WHERE cob.RAW:type = 'user'),
 c AS (SELECT cob3.RAW:id AS calibratorId , cob3.RAW:name AS calibratorName, cob3.projectid as projectid FROM raw.configuration_objects cob3  WHERE cob3.RAW:type = 'user'),
 e AS (SELECT cob2.RAW:id AS evaluatorId , cob2.RAW:name AS evaluatorName, cob2.projectid as projectid FROM raw.configuration_objects cob2 WHERE cob2.RAW:type = 'user'),
 q AS (SELECT  projectid, RAW:id AS queueId , RAW:name AS queueName FROM raw.configuration_objects  WHERE RAW:type = 'queue'),
 conversations AS (SELECT co.RAW:userId as aId, co.RAW:conversationId as cid, co.RAW:organizationid as orgid, 
                  co.RAW:queueId as queueId, co.projectid, min(co.RAW:conversationStartTime) as conversationStartTime from raw.conversations_detail co group by 1,2, 3,4,5),
 forms as (select projectid,
                  RAW:id as evaluationFormId, RAW:questionID as questionId, RAW:questionGroupId as questionGroupId, RAW:questionGroupManualWeight as questionGroupManualWeight,
                  RAW:questionGroupNaEnabled as questionGroupNaEnabled, RAW:questionGroupType as questionGroupType, RAW:questionCommentsRequired as questionCommentsRequired,
                  RAW:questionNaEnabled as questionNaEnabled, RAW:questionType as questionType, RAW:contextId as contextId, RAW:modifiedDate as modifiedDate,
                  RAW:published as published, RAW:questionHelpText as questionHelpText, min(RAW:questionGroupName) as questiongroupname,
                  min(RAW:questionText) as questiontext, min(RAW:questionGroupWeight) as questiongroupweight, min(RAW:name) AS evaluationFormName,
                  min(RAW:weightMode) as weightMode, min(RAW:questionIsKill) as questionIsKill, min(RAW:questionIsCritical) as questionIsCritical,
                  min(RAW:questionGroupDefaultAnswersToHighest) as questionGroupDefaultAnswersToHighest, min(RAW:questionGroupDefaultAnswersToNA) as questionGroupDefaultAnswersToNA,
                  max(RAW:answerValue) as maxQuestionScore
              FROM RAW.evaluation_forms
              group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14)
select
  ev.projectId as projectId,
  ev.projectName as projectName,
  ev.programId as programId,
  ev.programName as programName,
  trim(cast (ev.RAW:answersAgentComments as VARCHAR(4000))) as agentComments,
  cast (ev.RAW:agentHasRead as BOOLEAN) as agentHasRead,
  trim(cast (ev.RAW:agentId as VARCHAR(255))) as agentId,
  trim(cast (a.agentName as VARCHAR(255))) as agentName,
  trim(cast (ef.RAW:answerId as VARCHAR(255))) as answerId,
--cast (ev.RAW:questionAnswerID as VARCHAR(255)) as answerID,
  trim(cast (ef.RAW:answerText as VARCHAR(4000))) as answerText,
  cast (ef.RAW:answerValue as INT) as answerValue,
  cast (ev.RAW:answersAnyFailedKillQuestions as BOOLEAN) as anyFailedKillQuestions,    
  cast (ev.RAW:assignedDate as DATETIME) as assignedDateTime,
  to_date(cast (ev.RAW:assignedDate as DATETIME)) as assignedDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:assignedDate as DATETIME)) as projectAssignedDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:assignedDate as DATETIME))) as projectAssignedDate,
  trim(cast (ev.RAW:calibrationId as VARCHAR(255))) as calibrationId,
  cast (ev.RAW:changedDate as DATETIME) as changedDateTime,
  to_date(cast (ev.RAW:changedDate as DATETIME)) as changedDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:changedDate as DATETIME)) as projectChangedDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:changedDate as DATETIME))) as projectChangedDate,
  trim(cast (ev.RAW:conversationId as VARCHAR(255))) as conversationId,
  cast (conversations.conversationStartTime as DATETIME) as conversationStartTime,
  to_date(cast (conversations.conversationStartTime as DATETIME)) as conversationStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (conversations.ConversationStartTime as DATETIME)) as projectConversationStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (conversations.ConversationStartTime as DATETIME))) as projectConversationStartDate,
  trim(cast (ev.RAW:answersComments as VARCHAR(4000))) as evaluationComments,
  trim(cast (replace (replace(replace(ef2.evaluationFormName,'\t',' '),'\r',' '),'\n',' ') as VARCHAR(255))) as evaluationFormName,     
  trim(cast (ev.RAW:id as VARCHAR(255))) as evaluationId,        
  trim(cast (ev.RAW:evaluationFormId as VARCHAR(255))) as evaluationFormId,      
  trim(cast (ef2.contextId as VARCHAR(255))) as evaluationFormContextId,    
  cast (ef2.modifiedDate as DATETIME) as evaluationFormLastModified,     
  cast (ef2.published as BOOLEAN) as isPublished,                        
  trim(cast (ev.RAW:EvaluatorId as VARCHAR(255))) as EvaluatorId,
  trim(cast (e.evaluatorName as VARCHAR(255))) as evaluatorName,
  cast (ev.RAW:questionFailedKillQuestion as BOOLEAN) as failedKillQuestion,
  cast (ev.RAW:questionMarkedNA as BOOLEAN) as markedNA,
  cast (to_double(ef2.maxQuestionScore) as DECIMAL(38,19)) as maxQuestionScore,
  Case when weightmode ='OFF' then  to_double(ef2.maxquestionscore)/100.0 else (to_double(ef2.maxquestionscore)*(to_double(ef2.questionGroupWeight)/100.0)) end as maxquestionscoreweighted,
  cast (to_double(ev.RAW:questionGroupMaxTotalCriticalScore) as DECIMAL(38,19)) as maxgrouptotalcriticalscore,
  cast (to_double(ev.RAW:questionGroupMaxTotalCriticalScoreUnweighted) as DECIMAL(38,19)) as maxgrouptotalcriticalscoreunweighted,        
  cast (to_double(ev.RAW:questionGroupMaxTotalScore) as DECIMAL(38,19)) as maxgrouptotalscore,
  cast (to_double(ev.RAW:questionGroupMaxTotalScoreUnweighted) as DECIMAL(38,19)) as maxgrouptotalscoreunweighted,        
  cast (ev.RAW:neverRelease as BOOLEAN) as neverRelease,
  cast (ev.RAW:questionGroupMarkedNA as BOOLEAN) as questionGroupMarkedNA,
  trim(cast (replace (replace(replace(ef2.questionGroupName,'\t',' '),'\r',' '),'\n',' ') as VARCHAR(255))) as questionGroupName,
  cast (to_double(ef2.questionGroupWeight) as DECIMAL(38,19)) as questionGroupWeight, 
  trim(cast (ev.RAW:questionComments as VARCHAR(4000))) as questionScoreComment,
  trim(replace (replace(replace(ef2.questionText,'\t',' '),'\r',' '),'\n',' ')) as questionText,
  trim(cast (ef2.questionGroupID as VARCHAR(255))) as questionGroupId,
  trim(cast (ev.RAW:questionId as VARCHAR(255))) as questionId,
  cast (ev.RAW:questionScore as INT) as questionScore,
  Case when weightmode ='OFF' then to_double(ev.RAW:questionScore)/100.0 else (to_double(ev.RAW:questionScore)*(to_double(ef2.questionGroupWeight)/100.0)) end as questionscoreweighted,
  trim(cast (q.queueName as VARCHAR(255))) as queueName,        
  cast (ev.RAW:releaseDate as DATETIME) as releaseDateTime,
  to_date(cast (ev.RAW:releaseDate as DATETIME)) as releaseDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:releaseDate as DATETIME)) as projectReleaseDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:releaseDate as DATETIME))) as projectReleaseDate,
  trim(cast (ev.RAW:status as VARCHAR(255))) as status,
  cast (to_double(ev.RAW:answersTotalCriticalScore) as DECIMAL(38,19)) as totalEvaluationCriticalScore,  
  cast (to_double(ev.RAW:answersTotalScore) as DECIMAL(38,19)) as totalEvaluationScore,     
  cast (to_double(ev.RAW:questionGroupTotalCriticalScore) as DECIMAL(38,19)) as totalgroupcriticalscore,
  cast (to_double(ev.RAW:questionGroupTotalCriticalScoreUnweighted) as DECIMAL(38,19)) as totalgroupcriticalscoreunweighted,
  cast (ef2.questionIsCritical as BOOLEAN) as questionisCritical,
  cast (ef2.questionIsKill as BOOLEAN) as questionisKill,
  trim(cast (ef2.weightMode as VARCHAR(255))) as weightMode,
  cast (ec.RAW:createdDate as DATETIME) as calibrationCreatedDateTime,
  convert_timezone('UTC',pr.projectTimezone,cast (ec.RAW:createdDate as DATETIME)) as projectCalibrationCreatedDateTime,
  to_date(cast (ec.RAW:createdDate as DATETIME)) as calibrationCreatedDate,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ec.RAW:createdDate as DATETIME))) as projectCalibrationCreatedDate,
  cast (ec.RAW:averageScore as INT) as averageScore,
  cast (ec.RAW:highScore as INT) as highScore,
  cast (ec.RAW:lowScore as INT) as lowScore,
  trim(cast (c.calibratorName as VARCHAR(255))) as calibratorName,
  trim(eqi.EVALUATION_FORM_DISPLAY_NAME) as evaluation_form_display_name,
  trim(eqi.QUESTION_DISPLAY_NAME) as question_display_name,
  eqi.QUESTION_SORT_ORDER,
  trim(eqi.QUESTION_GROUP_DISPLAY_NAME) as question_group_display_name,      
  trim(ef2.questionHelpText) as questionHelpText, 	
  eqi.QUESTION_GROUP_SORT_ORDER,
  cast (ef2.questionGroupDefaultAnswersToHighest as boolean) as questionGroupDefaultAnswersToHighest,
  cast (ef2.questionGroupDefaultAnswersToNA as boolean) as questionGroupDefaultAnswersToNA,
  cast (ef2.questionGroupManualWeight as decimal(38,19)) as questionGroupManualWeight,
  cast (ef2.questionGroupNaEnabled as boolean) as questionGroupNaEnabled,  
  trim( cast (ef2.questionGroupType as varchar)) as questionGroupType,
  cast (ef2.questionCommentsRequired as boolean) as questionCommentsRequired,
  cast (ef2.questionNaEnabled as boolean) as questionNaEnabled,
  trim( cast(ef2.questionType as varchar)) as questionType
  --below not in DD 
  --cast (RAW:questionGroupTotalScore as DECIMAL(38,38)) as questionGroupTotalScore,
  --cast (RAW:questionGroupTotalScoreUnweighted as DECIMAL(38,38)) as questionGroupTotalScoreUnweighted,
  from RAW.EVALUATIONS ev
  inner join PUBLIC.D_PI_PROJECTS pr
  on ev.projectId = pr.projectId
  LEFT OUTER JOIN RAW.EVALUATION_FORMS ef 
  ON ev.RAW:evaluationFormId = ef.RAW:id
  and ev.RAW:questionAnswerID = ef.RAW:answerId
  and ev.projectid = ef.projectid
  LEFT OUTER JOIN forms ef2 
  ON ev.RAW:evaluationFormId = ef2.evaluationFormId
  and ev.RAW:questionId = ef2.questionId
  and ev.projectid = ef2.projectid
  INNER JOIN conversations conversations
  ON ev.RAW:conversationId = conversations.cid 
  and ev.RAW:agentId = conversations.aId
  and ev.projectid = conversations.projectid
  --and ev.RAW:organizationid = conversations.orgid
  LEFT JOIN RAW.EVALUATION_CALIBRATIONS ec
  ON ev.RAW:calibrationId = ec.RAW:id 
  and ev.RAW:conversationId = ec.RAW:conversationId 
  LEFT OUTER JOIN a a ON ev.RAW:agentId = a.agentid and ev.projectid = a.projectid
  LEFT OUTER JOIN c c ON ec.RAW:calibratorId = c.calibratorid and ev.projectid = c.projectid
LEFT OUTER JOIN e e ON ev.RAW:EvaluatorId = e.evaluatorId and ev.projectid = e.projectid
LEFT OUTER JOIN q q ON conversations.queueId = q.queueId and ev.projectid = q.projectid
LEFT OUTER JOIN d_evaluations_questions_info eqi ON ev.projectid = eqi.projectid and ev.RAW:questionId = eqi.question_id
where ev.RAW:calibrationId != '' and ev.RAW:calibrationId is not NULL;