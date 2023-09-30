CREATE OR REPLACE VIEW PUBLIC.D_PI_AUDIO_QUALITY_VW AS

  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName, 
               
  cast (rt.RAW:codec as VARCHAR(255)) as codec,  
  cast (rt.RAW:conversationEndTime as DATETIME) as conversationEndTime,
  cast (rt.RAW:conversationEndTime as DATE) as conversationEndDate,           
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationEndTime as DATETIME)) as projectConversationEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationEndTime as DATETIME))) as projectConversationEndDate,       
  cast (rt.RAW:conversationStartTime as DATETIME) as conversationStartTime,
  cast (rt.RAW:conversationStartTime as DATE) as conversationStartDate,         
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationStartTime as DATETIME)) as projectConversationStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationStartTime as DATETIME))) as projectConversationStartDate,         
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationid,
  cast (rt.RAW:discardedPackets as INT) as discardedPackets,
  cast (rt.RAW:duplicatePackets as INT) as duplicatePackets,
  cast (rt.RAW:duration as INT) as duration,            
  cast (rt.RAW:edgeId as VARCHAR(255)) as edgeId,
  cast (rt.RAW:invalidPackets as INT) as invalidPackets,
  cast (rt.RAW:maxLatencyMs as INT) as maxLatencyMs,             
  cast (rt.RAW:mediaStatsMinConversationMos as DECIMAL(8,3)) as mediaStatsMinConversationMos,
  cast (rt.RAW:mediaStatsMinConversationRFactor as DECIMAL(8,3)) as mediaStatsMinConversationRFactor,
  cast (rt.RAW:minMos as DECIMAL(8,3)) as minMos,
  cast (rt.RAW:minRFactor as DECIMAL(8,3)) as minRFactor,
  cast (rt.RAW:originatingDirection as VARCHAR(255)) as originatingDirection,               
  cast (rt.RAW:overrunPackets as INT) as overrunPackets, 
  cast (rt.RAW:participantid as VARCHAR(255)) as participantid,
  cast (rt.RAW:participantName as VARCHAR(255)) as participantName,             
  cast (rt.RAW:processTime as DATETIME) as processTime,
  cast (rt.RAW:processTime as DATE) as processDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:processTime as DATETIME)) as projectProcessTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:processTime as DATETIME))) as projectProcessDate,             
  cast (rt.RAW:purpose as VARCHAR(255)) as purpose, 
  cast (rt.RAW:receivedPackets as INT) as receivedPackets,
  cast (rt.RAW:underrunPackets as INT) as underrunPackets,               
  cast (rt.RAW:userid as VARCHAR(255)) as userId           
  from RAW.AUDIO_QUALITY rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;
  
  CREATE OR REPLACE VIEW PUBLIC.D_PI_BILLABLE_USAGE_VW AS
  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,              
  cast (rt.RAW:department as VARCHAR(255)) as department, 
  cast (rt.RAW:divisionId as VARCHAR(255)) as divisionid, 
  cast (rt.RAW:divisionName as VARCHAR(255)) as divisionname,              
  cast (rt.RAW:id as VARCHAR(255)) as id, 
  cast (rt.RAW:licensedEntity as VARCHAR(255)) as licensedentity,
  cast (rt.RAW:licenseName as VARCHAR(255)) as licenseName,  
  cast (rt.RAW:name as VARCHAR(255)) as name, 
  cast (rt.RAW:observedDate as DATETIME) as observeddatetime,
  cast (rt.RAW:observedDate as DATE) as observeddate,           
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:observedDate as DATETIME)) as projectObservedDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:observedDate as DATETIME))) as projectObservedDate         
  from RAW.BILLABLE_USAGE rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;
  
CREATE OR REPLACE VIEW PUBLIC.D_PI_CONFIGURATION_OBJECTS_VW AS
  select
  PROJECTID as projectid,
  PROJECTNAME as projectname,
  PROGRAMID as programid,
  PROGRAMNAME as programname,
  cast (RAW:DivisionId as varchar(255)) as DivisionId,
  cast (RAW:DivisionName as varchar(255)) as DivisionName,
  cast (RAW:id as varchar(255)) as id,
  cast (RAW:name as varchar(255)) as name,
  cast (RAW:type as varchar(255)) as type  
from RAW.CONFIGURATION_OBJECTS;  



  CREATE OR REPLACE VIEW PUREINSIGHTS_DEV.PUBLIC.D_PI_CONTACT_CENTER_SETTINGS_VW AS
  select
  ccs.projectId as projectId,
  ccs.projectName as projectName,
  ccs.programId as programId,
  ccs.programName as programName,
  cast (ccs.RAW:abandonIntervalADuration as INT) as abandonIntervalADuration,       
  cast (ccs.RAW:abandonIntervalBDuration as INT) as abandonIntervalBDuration,        
  cast (ccs.RAW:abandonIntervalCDuration as INT) as abandonIntervalCDuration,        
  cast (ccs.RAW:abandonIntervalDDuration as INT) as abandonIntervalDDuration,
  cast (ccs.RAW:abandonIntervalEDuration as INT) as abandonIntervalEDuration,
  cast (ccs.RAW:abandonIntervalFDuration as INT) as abandonIntervalFDuration,
  cast (ccs.RAW:flowShortDisconnectDuration as INT) as flowShortDisconnectDuration,
  cast (ccs.RAW:includeAbandonsInServiceLevel as INT) as includeAbandonsInServiceLevel,
  cast (ccs.RAW:includeFlowOutsInServiceLevel as INT) as includeFlowOutsInServiceLevel,
  cast (ccs.RAW:includeShortAbandonsInServiceLevel as INT) as includeShortAbandonsInServiceLevel
  from RAW.CONTACT_CENTER_SETTINGS ccs;
  
  
  
  
  CREATE OR REPLACE VIEW PUBLIC.D_PI_CONVERSATIONS_DETAIL_VW AS
  select
  cd.PROJECTID as projectid,
  cd.PROJECTNAME as projectname,
  cd.PROGRAMID as programid,
  cd.PROGRAMNAME as programname,
  cast (RAW:addressFrom as VARCHAR(255)) as addressFrom,	
  cast (RAW:addressTo as VARCHAR(255)) as addressTo,
  cast (RAW:ani as VARCHAR(255)) as ani,
  cast (RAW:campaignName as varchar(255)) as campaignName,
  cast (RAW:contactListName as varchar(255)) as contactListName,
  cast (RAW:conversationEndTime as datetime) as conversationEndTime,
  cast (RAW:conversationEndTime as date) as conversationEndDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:conversationEndTime as DATETIME)) as projectConversationEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:conversationEndTime as DATETIME))) as projectConversationEndDate,      
  cast (RAW:conversationId as varchar(255)) as ConversationId,
  cast (RAW:conversationStartTime as datetime) as conversationStartTime,
  cast (RAW:conversationStartTime as date) as conversationStartDate,             
  convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:conversationStartTime as DATETIME)) as projectConversationStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:conversationStartTime as DATETIME))) as projectConversationStartDate,          
  cast (RAW:direction	as varchar(255))as	Direction,
  cast (RAW:disconnecttype as varchar(255)) as disconnectType,
  cast (RAW:dispositionAnalyzer as varchar(255)) as dispositionAnalyzer,
  cast (RAW:dispositionName as varchar(255)) as dispositionName,
  cast (RAW:dnis as varchar(255)) as dnis,
  cast (RAW:duration as int) as Duration,
  cast (RAW:mediatype as varchar(255)) as mediaType,
  cast (RAW:originatingDirection as varchar(255)) as originatingDirection,
  cast (RAW:outboundCampaignId as varchar(255)) as outboundCampaignId,
  cast (RAW:outboundContactId as varchar(255)) as outboundContactId,	
  cast (RAW:outboundContactListId as varchar(255)) as outboundContactListId,
  cast (RAW:participantName  as varchar(255)) as ParticipantName,
  cast (RAW:participantid as varchar(255)) as participantid,	
  cast (RAW:processTime as datetime) as processTime,
  cast (RAW:processTime as date) as processDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:processTime as DATETIME)) as ProjectprocessTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:processTime as DATETIME))) as ProjectprocessDate,
  cast (RAW:purpose as varchar(255)) as purpose,
  cast (RAW:queuename as varchar(255)) as queueName,
  cast (RAW:segmentduration as int) as segmentDuration,
  cast (RAW:segmentEndTime as	datetime) as segmentEndTime,
    cast (RAW:segmentEndTime as	date) as segmentEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:segmentEndTime as DATETIME)) as projectSegmentEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:segmentEndTime as DATETIME))) as projectSegmentEndDate,      
  cast (RAW:segmentStartTime as datetime) as segmentStartTime,
    cast (RAW:segmentStartTime as date) as segmentStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:segmentStartTime as DATETIME)) as projectSegmentStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:segmentStartTime as DATETIME))) as projectSegmentStartDate,
  cast (RAW:segmenttype as varchar(255)) as segmentType,
  cast (RAW:sessionDnis as varchar(255)) as sessionDnis,
  cast (RAW:sessionEndTime as	datetime) as sessionEndTime,
  cast (RAW:sessionEndTime as date) as sessionEndDate,           
  convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:sessionEndTime as DATETIME)) as projectSessionEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:sessionEndTime as DATETIME))) as projectSessionEndDate,
  cast (RAW:sessionId as varchar(255)) as sessionId,
  cast (RAW:sessionStartTime as datetime) as sessionStartTime,
  cast (RAW:sessionStartTime as date) as sessionStartDate,             
  convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:sessionStartTime as DATETIME)) as projectSessionStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:sessionStartTime as DATETIME))) as projectSessionStartDate,
  cast (RAW:userid as varchar(255)) as userId,
  cast (RAW:username as varchar(255)) as userName,
  cast (RAW:wrapUpCode as varchar(255)) as wrapUpCode,
  cast (RAW:wrapupCodeName as varchar(255)) as wrapupCodeName
FROM RAW.CONVERSATIONS_DETAIL cd
  join PUBLIC.D_PI_PROJECTS pr
  on cd.projectId = pr.projectId;
  
  CREATE OR REPLACE VIEW PUBLIC.D_PI_CONVERSATIONS_VW AS
  select
  cd.PROJECTID as projectid,
  cd.PROJECTNAME as projectname,
  cd.PROGRAMID as programid,
  cd.PROGRAMNAME as programname,
  cast (RAW:conversationEndTime as DATETIME) as conversationEndTime,
  cast (RAW:conversationEndTime as DATE) as conversationEndDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:conversationEndTime as DATETIME)) as projectconversationEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:conversationEndTime as DATETIME))) as projectconversationEndDate,        
  cast (RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (RAW:conversationStartTime as DATETIME) as conversationStartTime,
  cast (RAW:conversationStartTime as DATE) as conversationStartDate,          
  convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:conversationStartTime as DATETIME)) as projectconversationStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:conversationStartTime as DATETIME))) as projectconversationStartDate,
  cast (RAW:duration as INT) as duration,
  cast (RAW:mediastatsminconversationmos as VARCHAR(255)) as mediastatsminconversationmos,
  cast (RAW:mediastatsminconversationrfactor as VARCHAR(255)) as mediastatsminconversationrfactor,
  cast (RAW:originatingDirection as VARCHAR(255)) as originatingDirection,
  cast (RAW:processTime as DATETIME) as processTime,
  cast (RAW:processTime as DATE) as processDate,         
  convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:processTime as DATETIME)) as projectprocessTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (cd.RAW:processTime as DATETIME))) as projectprocessDate
 from RAW.CONVERSATIONS cd
join PUBLIC.D_PI_PROJECTS pr
  on cd.projectId = pr.projectId;
  
  CREATE OR REPLACE VIEW PUBLIC.D_PI_CONVERSATION_ATTRIBUTES_VW AS
  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:key as VARCHAR(255)) as key,
  cast (rt.RAW:participantEndTime as DATETIME) as participantEndTime,
  cast (rt.RAW:participantEndTime as DATE) as participantEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:participantEndTime as DATETIME)) as projectParticipantEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:participantEndTime as DATETIME))) as projectParticipantEndDate,
  cast (rt.RAW:participantid as VARCHAR(255)) as participantid,
  cast (rt.RAW:participantName as VARCHAR(255)) as participantName,
  cast (rt.RAW:participantStartTime as DATETIME) as participantStartTime,
  cast (rt.RAW:participantStartTime as DATE) as participantStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:participantStartTime as DATETIME)) as projectParticipantStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:participantStartTime as DATETIME))) as projectParticipantStartDate,
  cast (rt.RAW:purpose as VARCHAR(255)) as purpose,
  cast (rt.RAW:userid as VARCHAR(255)) as userId,
  cast (rt.RAW:value as VARCHAR(255)) as value
  from RAW.CONVERSATION_ATTRIBUTES rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;
  
  CREATE OR REPLACE VIEW PUBLIC.D_PI_DIALER_DETAIL_VW AS
  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,              
  cast (rt.RAW:abandoned as INT) as abandoned, 
  cast (rt.RAW:attempt as INT) as attempt, 
  cast (rt.RAW:attemptResult as VARCHAR(255)) as attemptResult,
  cast (rt.RAW:attemptTime as DATETIME) as attemptTime,
  cast (rt.RAW:attemptTime as DATE) as attemptDate,          
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:attemptTime as DATETIME)) as projectAttemptTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:attemptTime as DATETIME))) as projectAttemptDate,          
  cast (rt.RAW:campaignName as VARCHAR(255)) as campaignName, 
  cast (rt.RAW:contactListName as VARCHAR(255)) as contactListName,
  cast (rt.RAW:contactUncallable as INT) as contactUncallable,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:conversationStartTime as DATETIME) as conversationStartTime,
  cast (rt.RAW:conversationStartTime as DATE) as conversationStartDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationStartTime as DATETIME)) as projectConversationStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationStartTime as DATETIME))) as projectConversationStartDate,           
  cast (rt.RAW:dispositionAnalyzer as VARCHAR(255)) as dispositionAnalyzer,
  cast (rt.RAW:dispositionName as VARCHAR(255)) as dispositionName,
  cast (rt.RAW:dnis as VARCHAR(255)) as dnis,
  cast (rt.RAW:firstAgentName as VARCHAR(255)) as firstAgentName,
  cast (rt.RAW:firstAgentWrapup as VARCHAR(255)) as firstAgentWrapup,
  cast (rt.RAW:firstIvrWrapup as VARCHAR(255)) as firstIvrWrapup,
  cast (rt.RAW:numberUncallable as INT) as numberUncallable,
  cast (rt.RAW:ReachedAgent as INT) as ReachedAgent,
  cast (rt.RAW:ReachedFlow as INT) as ReachedFlow,
  cast (rt.RAW:rightPartyContact as INT) as rightPartyContact,
  cast (rt.RAW:totalAttempts as INT) as totalAttempts
  from RAW.DIALER_DETAIL rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;
  
  
   CREATE OR REPLACE VIEW PUBLIC.D_PI_DIALER_PREVIEW_DETAIL_VW AS
  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,              

  cast (rt.RAW:agentDuration as INT) as agentDuration, 
  cast (rt.RAW:agentName as VARCHAR(255)) as agentName,
  cast (rt.RAW:attemptDuration as INT) as attemptDuration, 
  cast (rt.RAW:attemptEndTime as DATETIME) as attemptEndTime,
  date(cast (rt.RAW:attemptEndTime as DATETIME)) as attemptEndDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:attemptEndTime as DATETIME)) as projectAttemptEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:attemptEndTime as DATETIME))) as projectAttemptEndDate,           
  cast (rt.RAW:attemptResult as VARCHAR(255)) as attemptResult, 
  cast (rt.RAW:attemptStartTime as DATETIME) as attemptStartTime,
  date(cast (rt.RAW:attemptStartTime as DATETIME)) as attemptStartDate,           
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:attemptStartTime as DATETIME)) as projectAttemptStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:attemptStartTime as DATETIME))) as projectAttemptStartDate,      
  cast (rt.RAW:campaignName as VARCHAR(255)) as campaignName, 
  cast (rt.RAW:contactUncallable as INT) as contactUncallable,          
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:conversationStartTime as DATETIME) as conversationStartTime,
  date(cast (rt.RAW:conversationStartTime as DATETIME)) as conversationStartDate,         
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationStartTime as DATETIME)) as projectConversationStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationStartTime as DATETIME))) as projectConversationStartDate,          
  cast (rt.RAW:dnis as VARCHAR(255)) as dnis,
  cast (rt.RAW:numberUncallable as INT) as numberUncallable,   
  cast (rt.RAW:previewDuration as INT) as previewDuration,
  cast (rt.RAW:queuename as VARCHAR(255)) as queueName,
  cast (rt.RAW:rightPartyContact as INT) as rightPartyContact,
  cast (rt.RAW:sessionEndTime as DATETIME) as sessionEndTime,
  date(cast (rt.RAW:sessionEndTime as DATETIME)) as sessionEndDate,         
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionEndTime as DATETIME)) as projectSessionEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionEndTime as DATETIME))) as projectSessionEndDate,         
  cast (rt.RAW:sessionId as VARCHAR(255)) as sessionId,
  cast (rt.RAW:sessionStartTime as DATETIME) as sessionStartTime,
  date(cast (rt.RAW:sessionStartTime as DATETIME)) as sessionStartDate,        
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionStartTime as DATETIME)) as projectSessionStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionStartTime as DATETIME))) as projectSessionStartDate,    
  cast (rt.RAW:skipped as INT) as skipped,
  cast (rt.RAW:totalAttemptDuration as INT) as totalAttemptDuration,          
  cast (rt.RAW:wrapupCodeName as VARCHAR(255)) as wrapupCodeName
  from RAW.DIALER_PREVIEW_DETAIL rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;
  
  
CREATE OR REPLACE VIEW PUBLIC.D_PI_DIVISIONS_VW AS
  select
  PROJECTID as projectid,
  PROJECTNAME as projectname,
  PROGRAMID as programid,
  PROGRAMNAME as programname,
  cast (RAW:conversationId as varchar(255)) as conversationId,
  cast (RAW:divisionId as varchar(255)) as divisionId,
  cast (RAW:divisionName as varchar(255)) as divisionName
from RAW.DIVISIONS;  
  
  
  
CREATE OR REPLACE VIEW PUREINSIGHTS_UAT.PUBLIC.D_PI_EVALUATIONS_VW AS
  WITH
 a AS (SELECT cob.RAW:id AS agentId , cob.RAW:name AS agentName, cob.projectid as projectid FROM raw.configuration_objects cob  WHERE cob.RAW:type = 'user'),
 e AS (SELECT cob2.RAW:id AS evaluatorId , cob2.RAW:name AS evaluatorName, cob2.projectid as projectid FROM raw.configuration_objects cob2 WHERE cob2.RAW:type = 'user'),
 conversations AS (SELECT co.RAW:userid as aId, co.RAW:conversationId as cid, co.RAW:organizationid as orgid, 
                  co.RAW:queuename as queueName, co.projectid, min(co.RAW:conversationStartTime) as conversationStartTime from raw.conversations_detail co group by 1,2, 3,4,5),
 mv as (select efMax.RAW:questionID as questionId, efMax.projectid as projectid, max(efMax.RAW:answerValue) as maxQuestionScore from raw.evaluation_forms efMax group by 1,2)
  select
  ev.projectId as projectId,
  ev.projectName as projectName,
  ev.programId as programId,
  ev.programName as programName,
  cast (ev.RAW:answersAgentComments as VARCHAR(255)) as agentComments,
  cast (ev.RAW:agentHasRead as BOOLEAN) as agentHasRead,
  cast (ev.RAW:agentId as VARCHAR(255)) as agentId,
  cast (a.agentName as VARCHAR(255)) as agentName,
  cast (ef.RAW:answerId as VARCHAR(255)) as answerId,
--cast (ev.RAW:questionAnswerID as VARCHAR(255)) as answerID,
  cast (ef.RAW:answerText as VARCHAR(4000)) as answerText,
  cast (ef.RAW:answerValue as INT) as answerValue,
  cast (ev.RAW:answersAnyFailedKillQuestions as BOOLEAN) as anyFailedKillQuestions,    
  cast (ev.RAW:assignedDate as DATETIME) as assignedDateTime,
  to_date(cast (ev.RAW:assignedDate as DATETIME)) as assignedDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:assignedDate as DATETIME)) as projectAssignedDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:assignedDate as DATETIME))) as projectAssignedDate,
  cast (ev.RAW:calibrationId as VARCHAR(255)) as calibrationId,
  cast (ev.RAW:changedDate as DATETIME) as changedDateTime,
  to_date(cast (ev.RAW:changedDate as DATETIME)) as changedDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:changedDate as DATETIME)) as projectChangedDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:changedDate as DATETIME))) as projectChangedDate,
  cast (ev.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (conversations.conversationStartTime as DATETIME) as conversationStartTime,
  to_date(cast (conversations.conversationStartTime as DATETIME)) as conversationStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (conversations.ConversationStartTime as DATETIME)) as projectConversationStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (conversations.ConversationStartTime as DATETIME))) as projectConversationStartDate,
  cast (ev.RAW:answersComments as VARCHAR(4000)) as evaluationComments,
  cast (ef.RAW:name as VARCHAR(255)) as evaluationFormName,       
  cast (ev.RAW:id as VARCHAR(255)) as evaluationId,        
  cast (ev.RAW:evaluationFormId as VARCHAR(255)) as evaluationFormId,        
  cast (ev.RAW:EvaluatorId as VARCHAR(255)) as EvaluatorId,
  cast (e.evaluatorName as VARCHAR(255)) as evaluatorName,
  cast (ev.RAW:questionFailedKillQuestion as BOOLEAN) as failedKillQuestion,
  cast (ev.RAW:questionMarkedNA as BOOLEAN) as markedNA,
  cast (to_double(mv.maxQuestionScore) as DECIMAL(38,19)) as maxQuestionScore,
  cast (to_double(ev.RAW:questionGroupMaxTotalCriticalScore) as DECIMAL(38,19)) as maxgrouptotalcriticalscore,
  cast (to_double(ev.RAW:questionGroupMaxTotalCriticalScoreUnweighted) as DECIMAL(38,19)) as maxgrouptotalcriticalscoreunweighted,        
  cast (to_double(ev.RAW:questionGroupMaxTotalScore) as DECIMAL(38,19)) as maxgrouptotalscore,
  cast (to_double(ev.RAW:questionGroupMaxTotalScoreUnweighted) as DECIMAL(38,19)) as maxgrouptotalscoreunweighted,        
  cast (ev.RAW:neverRelease as BOOLEAN) as neverRelease,
  cast (ev.RAW:questionGroupMarkedNA as BOOLEAN) as questionGroupMarkedNA,
  cast (ef.RAW:questionGroupName as VARCHAR(255)) as questionGroupName,
  cast (to_double(ef.RAW:questionGroupWeight) as DECIMAL(38,19)) as questionGroupWeight, 
  cast (ev.RAW:questionComments as VARCHAR(4000)) as questionScoreComment,
  cast (ef.RAW:questionText as VARCHAR(4000)) as questionText,
  cast (ef.RAW:questionGroupID as VARCHAR(255)) as questionGroupId,
  cast (ev.RAW:questionId as VARCHAR(255)) as questionId,
  cast (ev.RAW:questionScore as INT) as questionScore,
  cast (conversations.QueueName as VARCHAR(255)) as queueName,        
  cast (ev.RAW:releaseDate as DATETIME) as releaseDateTime,
  to_date(cast (ev.RAW:releaseDate as DATETIME)) as releaseDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:releaseDate as DATETIME)) as projectReleaseDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:releaseDate as DATETIME))) as projectReleaseDate,
  cast (ev.RAW:status as VARCHAR(255)) as status,
  cast (to_double(ev.RAW:answersTotalCriticalScore) as DECIMAL(38,19)) as totalEvaluationCriticalScore,  
  cast (to_double(ev.RAW:answersTotalScore) as DECIMAL(38,19)) as totalEvaluationScore,     
  cast (to_double(ev.RAW:questionGroupTotalCriticalScore) as DECIMAL(38,19)) as totalgroupcriticalscore,
  cast (to_double(ev.RAW:questionGroupTotalCriticalScoreUnweighted) as DECIMAL(38,19)) as totalgroupcriticalscoreunweighted,
  cast (ef.RAW:questionIsCritical as BOOLEAN) as questionisCritical,
  cast (ef.RAW:questionIsKill as BOOLEAN) as questionisKill,
  cast (ef.RAW:weightMode as VARCHAR(255)) as weightMode
  --below not in DD 
  --cast (RAW:questionGroupTotalScore as DECIMAL(38,38)) as questionGroupTotalScore,
  --cast (RAW:questionGroupTotalScoreUnweighted as DECIMAL(38,38)) as questionGroupTotalScoreUnweighted,
  from RAW.EVALUATIONS ev
  inner join PUBLIC.D_PI_PROJECTS pr
  on ev.projectId = pr.projectId
  INNER JOIN RAW.EVALUATION_FORMS ef 
  ON ev.RAW:evaluationFormId = ef.RAW:id
  and ev.RAW:questionAnswerID = ef.RAW:answerId
  and ev.projectid = ef.projectid
  INNER JOIN conversations conversations
  ON ev.RAW:conversationId = conversations.cid 
  and ev.RAW:agentId = conversations.aId
  and ev.projectid = conversations.projectid
  --and ev.RAW:organizationid = conversations.orgid
  LEFT OUTER JOIN a a ON ev.RAW:agentId = a.agentid and ev.projectid = a.projectid
LEFT OUTER JOIN e e ON ev.RAW:EvaluatorId = e.evaluatorId and ev.projectid = e.projectid
LEFT OUTER JOIN mv mv ON ev.RAW:questionId = mv.questionId and ev.projectid = mv.projectid
where ev.RAW:calibrationId = '' or ev.RAW:calibrationId is null;

CREATE OR REPLACE VIEW PUREINSIGHTS_DEV.PUBLIC.D_PI_EVALUATION_CALIBRATIONS_VW AS
  WITH
 a AS (SELECT cob.RAW:id AS agentId , cob.RAW:name AS agentName, cob.projectid as projectid FROM raw.configuration_objects cob  WHERE cob.RAW:type = 'user'),
 c AS (SELECT cob3.RAW:id AS calibratorId , cob3.RAW:name AS calibratorName, cob3.projectid as projectid FROM raw.configuration_objects cob3  WHERE cob3.RAW:type = 'user'),
 e AS (SELECT cob2.RAW:id AS evaluatorId , cob2.RAW:name AS evaluatorName, cob2.projectid as projectid FROM raw.configuration_objects cob2 WHERE cob2.RAW:type = 'user'),
 conversations AS (SELECT co.RAW:userid as aId, co.RAW:conversationId as cid, co.RAW:organizationid as orgid, 
                  co.RAW:queuename as queueName, co.projectid, min(co.RAW:conversationStartTime) as conversationStartTime from raw.conversations_detail co group by 1,2, 3,4,5),
 mv as (select efMax.RAW:questionID as questionId, efMax.projectid as projectid, max(efMax.RAW:answerValue) as maxQuestionScore from raw.evaluation_forms efMax group by 1,2)
  select
  ev.projectId as projectId,
  ev.projectName as projectName,
  ev.programId as programId,
  ev.programName as programName,
  cast (ev.RAW:answersAgentComments as VARCHAR(255)) as agentComments,
  cast (ev.RAW:agentHasRead as BOOLEAN) as agentHasRead,
  cast (ev.RAW:agentId as VARCHAR(255)) as agentId,
  cast (a.agentName as VARCHAR(255)) as agentName,
  cast (ef.RAW:answerId as VARCHAR(255)) as answerId,
--cast (ev.RAW:questionAnswerID as VARCHAR(255)) as answerID,
  cast (ef.RAW:answerText as VARCHAR(4000)) as answerText,
  cast (ef.RAW:answerValue as INT) as answerValue,
  cast (ev.RAW:answersAnyFailedKillQuestions as BOOLEAN) as anyFailedKillQuestions,    
  cast (ev.RAW:assignedDate as DATETIME) as assignedDateTime,
  to_date(cast (ev.RAW:assignedDate as DATETIME)) as assignedDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:assignedDate as DATETIME)) as projectAssignedDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:assignedDate as DATETIME))) as projectAssignedDate,
  cast (ev.RAW:calibrationId as VARCHAR(255)) as calibrationId,
  cast (ev.RAW:changedDate as DATETIME) as changedDateTime,
  to_date(cast (ev.RAW:changedDate as DATETIME)) as changedDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:changedDate as DATETIME)) as projectChangedDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:changedDate as DATETIME))) as projectChangedDate,
  cast (ev.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (conversations.conversationStartTime as DATETIME) as conversationStartTime,
  to_date(cast (conversations.conversationStartTime as DATETIME)) as conversationStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (conversations.ConversationStartTime as DATETIME)) as projectConversationStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (conversations.ConversationStartTime as DATETIME))) as projectConversationStartDate,
  cast (ev.RAW:answersComments as VARCHAR(4000)) as evaluationComments,
  cast (ef.RAW:name as VARCHAR(255)) as evaluationFormName,       
  cast (ev.RAW:id as VARCHAR(255)) as evaluationId,        
  cast (ev.RAW:evaluationFormId as VARCHAR(255)) as evaluationFormId,        
  cast (ev.RAW:EvaluatorId as VARCHAR(255)) as EvaluatorId,
  cast (e.evaluatorName as VARCHAR(255)) as evaluatorName,
  cast (ev.RAW:questionFailedKillQuestion as BOOLEAN) as failedKillQuestion,
  cast (ev.RAW:questionMarkedNA as BOOLEAN) as markedNA,
  cast (to_double(mv.maxQuestionScore) as DECIMAL(38,19)) as maxQuestionScore,
  cast (to_double(ev.RAW:questionGroupMaxTotalCriticalScore) as DECIMAL(38,19)) as maxgrouptotalcriticalscore,
  cast (to_double(ev.RAW:questionGroupMaxTotalCriticalScoreUnweighted) as DECIMAL(38,19)) as maxgrouptotalcriticalscoreunweighted,        
  cast (to_double(ev.RAW:questionGroupMaxTotalScore) as DECIMAL(38,19)) as maxgrouptotalscore,
  cast (to_double(ev.RAW:questionGroupMaxTotalScoreUnweighted) as DECIMAL(38,19)) as maxgrouptotalscoreunweighted,        
  cast (ev.RAW:neverRelease as BOOLEAN) as neverRelease,
  cast (ev.RAW:questionGroupMarkedNA as BOOLEAN) as questionGroupMarkedNA,
  cast (ef.RAW:questionGroupName as VARCHAR(255)) as questionGroupName,
  cast (to_double(ef.RAW:questionGroupWeight) as DECIMAL(38,19)) as questionGroupWeight, 
  cast (ev.RAW:questionComments as VARCHAR(4000)) as questionScoreComment,
  cast (ef.RAW:questionText as VARCHAR(4000)) as questionText,
  cast (ef.RAW:questionGroupID as VARCHAR(255)) as questionGroupId,
  cast (ev.RAW:questionId as VARCHAR(255)) as questionId,
  cast (ev.RAW:questionScore as INT) as questionScore,
  cast (conversations.QueueName as VARCHAR(255)) as queueName,        
  cast (ev.RAW:releaseDate as DATETIME) as releaseDateTime,
  to_date(cast (ev.RAW:releaseDate as DATETIME)) as releaseDate,
  convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:releaseDate as DATETIME)) as projectReleaseDateTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (ev.RAW:releaseDate as DATETIME))) as projectReleaseDate,
  cast (ev.RAW:status as VARCHAR(255)) as status,
  cast (to_double(ev.RAW:answersTotalCriticalScore) as DECIMAL(38,19)) as totalEvaluationCriticalScore,  
  cast (to_double(ev.RAW:answersTotalScore) as DECIMAL(38,19)) as totalEvaluationScore,     
  cast (to_double(ev.RAW:questionGroupTotalCriticalScore) as DECIMAL(38,19)) as totalgroupcriticalscore,
  cast (to_double(ev.RAW:questionGroupTotalCriticalScoreUnweighted) as DECIMAL(38,19)) as totalgroupcriticalscoreunweighted,
  cast (ef.RAW:questionIsCritical as BOOLEAN) as questionisCritical,
  cast (ef.RAW:questionIsKill as BOOLEAN) as questionisKill,
  cast (ef.RAW:weightMode as VARCHAR(255)) as weightMode,
  cast (ec.RAW:averageScore as VARCHAR(255)) as averageScore,
  cast (ec.RAW:highScore as VARCHAR(255)) as highScore,
  cast (ec.RAW:lowScore as VARCHAR(255)) as lowScore,
  cast (ec.RAW:createdDate as VARCHAR(255)) as calibrationCreatedDate,
  cast (c.calibratorName as VARCHAR(255)) as calibratorName
  --below not in DD 
  --cast (RAW:questionGroupTotalScore as DECIMAL(38,38)) as questionGroupTotalScore,
  --cast (RAW:questionGroupTotalScoreUnweighted as DECIMAL(38,38)) as questionGroupTotalScoreUnweighted,
  from RAW.EVALUATIONS ev
  inner join PUBLIC.D_PI_PROJECTS pr
  on ev.projectId = pr.projectId
  INNER JOIN RAW.EVALUATION_FORMS ef 
  ON ev.RAW:evaluationFormId = ef.RAW:id
  and ev.RAW:questionAnswerID = ef.RAW:answerId
  and ev.projectid = ef.projectid
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
LEFT OUTER JOIN mv mv ON ev.RAW:questionId = mv.questionId and ev.projectid = mv.projectid
where ev.RAW:calibrationId != '' and ev.RAW:calibrationId is not null;
    
  
  CREATE OR REPLACE VIEW PUBLIC.D_PI_FLOW_OUTCOMES_VW AS
  WITH
  a AS (SELECT cob.RAW:id AS foId , cob.RAW:name AS foName, cob.projectid as projectid FROM raw.configuration_objects cob  WHERE cob.RAW:type = 'flowoutcome')
  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:endingLanguage as VARCHAR(255)) as endingLanguage,
  cast (rt.RAW:exitReason as VARCHAR(255)) as exitReason,              
  cast (rt.RAW:flowId as VARCHAR(255)) as flowId,
  cast (rt.RAW:flowName as VARCHAR(255)) as flowName,
  cast (rt.RAW:flowType as VARCHAR(255)) as flowType,               
  cast (rt.RAW:flowVersion as VARCHAR(255)) as flowVersion,            
  cast (rt.RAW:issuedCallback as BOOLEAN) as issuedCallback,
  cast (rt.RAW:outcome as VARCHAR(255)) as outcome,
  cast (rt.RAW:outcomeEndTimestamp as DATETIME) as outcomeEndTime,
  cast (rt.RAW:outcomeEndTimestamp as DATE) as outcomeEndDate,          
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:outcomeEndTimestamp as DATETIME)) as projectOutcomeEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:outcomeEndTimestamp as DATETIME))) as projectOutcomeEndDate,          
  cast (rt.RAW:outcomeId as VARCHAR(255)) as outcomeId,
  cast (a.foName as VARCHAR(255)) as outcomeName,
  cast (rt.RAW:outcomeStartTimestamp as DATETIME) as outcomeStartTime,
  cast (rt.RAW:outcomeStartTimestamp as DATE) as outcomeStartDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:outcomeStartTimestamp as DATETIME)) as projectOutcomeStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:outcomeStartTimestamp as DATETIME))) as projectOutcomeStartDate,             
  cast (rt.RAW:outcomeValue as VARCHAR(255)) as outcomeValue,       
  cast (rt.RAW:participantId as VARCHAR(255)) as participantId,
  cast (rt.RAW:sessionEndTime as DATETIME) as sessionEndTime,
  cast (rt.RAW:sessionEndTime as DATE) as sessionEndDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionEndTime as DATETIME)) as projectSessionEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionEndTime as DATETIME))) as projectSessionEndDate,            
  cast (rt.RAW:sessionId as VARCHAR(255)) as sessionId,    
  cast (rt.RAW:sessionStartTime as DATETIME) as sessionStartTime,
  cast (rt.RAW:sessionStartTime as DATE) as sessionStartDate,          
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionStartTime as DATETIME)) as projectSessionStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionStartTime as DATETIME))) as projectSessionStartDate,            
  cast (rt.RAW:startingLanguage as VARCHAR(255)) as startingLanguage,
  cast (rt.RAW:transferTargetAddress as VARCHAR(255)) as transferTargetAddress,
  cast (rt.RAW:transferTargetName as VARCHAR(255)) as transferTargetName,
  cast (rt.RAW:transferType as VARCHAR(255)) as transferType
  from RAW.FLOW_OUTCOMES rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId
  left outer join a on rt.raw:outcomeId = a.foId and rt.projectid = a.projectid;
  
  
  CREATE OR REPLACE VIEW PUBLIC.D_PI_GROUPS_MEMBERSHIP_VW AS
WITH u AS (SELECT raw:id AS userid , raw:name AS userName, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'user'),
g AS (SELECT raw:id AS groupid , raw:name AS groupname, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'group')
SELECT
  gm.projectId as projectId,
  gm.projectName as projectName,
  gm.programId as programId,
  gm.programName as programName,
  cast (g.groupid as VARCHAR(255)) as groupId,
  cast (g.groupname as VARCHAR(255)) as groupName,
  cast (u.userid as VARCHAR(255)) as userId,
  cast (u.userName as VARCHAR(255)) as userName
FROM raw.groups_membership gm
LEFT OUTER JOIN g ON gm.raw:name = g.groupid and gm.projectid = g.projectid 
LEFT OUTER JOIN u ON gm.raw:userId = u.userid and gm.projectid = u.projectid
;
    
  CREATE OR REPLACE VIEW PUBLIC.D_PI_PARTICIPANTS_VW AS
  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:participantDuration as INT) as participantDuration, 
  cast (rt.RAW:participantEndTime as DATETIME) as participantEndTime,
  cast (rt.RAW:participantEndTime as DATE) as participantEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:participantEndTime as DATETIME)) as projectParticipantEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:participantEndTime as DATETIME))) as projectParticipantEndDate,
  cast (rt.RAW:participantEndTimeMillis as INT) as participantEndTimeMillis,
  cast (rt.RAW:participantid as VARCHAR(255)) as participantid,
  cast (rt.RAW:participantName as VARCHAR(255)) as participantName,
  cast (rt.RAW:participantStartTime as DATETIME) as participantStartTime,
  cast (rt.RAW:participantStartTime as DATE) as participantStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:participantStartTime as DATETIME)) as projectParticipantStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:participantStartTime as DATETIME))) as projectParticipantStartDate,
  cast (rt.RAW:participantStartTimeMillis as INT) as participantStartTimeMillis,
  cast (rt.RAW:purpose as VARCHAR(255)) as purpose,
  cast (rt.RAW:userid as VARCHAR(255)) as userId
  from RAW.PARTICIPANTS rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;
  
  CREATE OR REPLACE VIEW PUBLIC.D_PI_PRIMARY_PRESENCE_VW AS
  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:duration as INT) as duration,
  cast (rt.RAW:organizationpresence as VARCHAR(255)) as organizationPresence,   
  cast (rt.RAW:presenceEndTime as DATETIME) as presenceEndTime,
  cast (rt.RAW:presenceEndTime as DATE) as presenceEndDate,
  cast (rt.RAW:presenceStartTime as DATETIME) as presenceStartTime,
  cast (rt.RAW:presenceStartTime as DATE) as presenceStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:presenceEndTime as DATETIME)) as projectPresenceEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:presenceEndTime as DATETIME))) as projectPresenceEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:presenceStartTime as DATETIME)) as projectPresenceStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:presenceStartTime as DATETIME))) as projectPresenceStartDate,
  cast (rt.RAW:systemPresence as VARCHAR(255)) as systemPresence,
  cast (rt.RAW:userid as VARCHAR(255)) as userId,
  cast (rt.RAW:username as VARCHAR(255)) as userName
  from RAW.PRIMARY_PRESENCE rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;
 
    create or replace view d_pi_primary_presence_daily_duration_vw as
   with rtable as (select rt.projectid, date(min(rt.ingestiondatetime)) as miningest from raw.primary_presence rt group by 1)
   select 
   pp.projectid,
   pp.projectname,
   pp.programid, 
   pp.programname,
   pp.userid,
   pp.userName,
   dd.date as PROJECTPRESENCESTARTDATE,
   case when dd.date = pp.projectPresenceStartDate then pp.projectPresenceStartTime else dd.date end as PROJECTPRESENCESTARTTIME, 
   pp.systempresence,
   pp.organizationpresence,
   case when pp.projectPresenceEndDate is not null and dd.date = pp.projectPresenceEndDate 
    then pp.projectPresenceEndTime else DATEADD(second,86399,dd.date) end as PROJECTPRESENCEENDTIME,
   dd.date as PROJECTPRESENCEENDDATE,
   case when dd.date  = pp.projectPresenceStartDate and pp.projectPresenceEndDate is not null and pp.projectPresenceEndDate = pp.projectPresenceStartDate
    then datediff(millisecond,pp.projectPresenceStartTime,pp.projectPresenceEndTime)
   when dd.date = pp.projectPresenceStartDate and (pp.projectPresenceEndDate is null or dd.date < pp.projectPresenceEndDate )  
    then datediff(millisecond, pp.projectPresenceStartTime, DATEADD(day,1,pp.projectPresenceStartDate))
   when dd.date > pp.projectPresenceStartDate and (pp.projectPresenceEndDate is null or dd.date < pp.projectPresenceEndDate )
    then 24 * 60*60*1000 
   when dd.date > pp.projectPresenceStartDate and (pp.projectPresenceEndDate is not null and dd.date = pp.projectPresenceEndDate )
    then datediff(milliseconds, dd.date, pp.projectPresenceEndTime)
   else null end as dailyduration,
   case when pp.projectPresenceEndDate is not null and dd.date = pp.projectPresenceEndDate then pp.duration else null end as totalDuration
   from d_pi_primary_presence_vw pp
   join rtable on rtable.projectid = pp.projectid
   join d_dates dd 
   on dd.date >= pp.projectPresenceStartDate 
   and (dd.date <= pp.projectPresenceEndDate or pp.projectPresenceEndDate is null)
   and dd.date < date(rtable.miningest)
   --and dd.date <= (select case when date_part(hour, max(mx.projectpresencestarttime)) >= 06 
   --                 then max(mx.projectpresencestartdate) else max(mx.projectpresencestartdate) -1 end  from d_pi_primary_presence_vw mx) 
   
   order by pp.projectid, pp.programid, pp.userid,dd.date,pp.projectPresenceStartTime, pp.systempresence, pp.organizationpresence; 
   
   
        
  
CREATE OR REPLACE VIEW PUBLIC.D_PI_QUEUE_CONFIGURATION_VW AS
  select
  projectId as projectId,
  projectName as projectName,
  programId as programId,
  programName as programName,
  cast (RAW:callServiceLevelDuration as INT) as callServiceLevelDuration,
  cast (RAW:callServiceLevelPercent as DECIMAL(38,19)) as callServiceLevelPercent,
  cast (RAW:callbackServiceLevelDuration as INT) as callbackServiceLevelDuration,
  cast (RAW:callbackServiceLevelPercent as DECIMAL(38,19)) as callbackServiceLevelPercent,
  cast (RAW:chatServiceLevelDuration as INT) as chatServiceLevelDuration,
  cast (RAW:chatServiceLevelPercent as DECIMAL(38,19)) as chatServiceLevelPercent,
  cast (RAW:divisionId as VARCHAR(255)) as divisionId,
  cast (RAW:divisionName as VARCHAR(255)) as divisionName,
  cast (RAW:emailServiceLevelDuration as INT) as emailServiceLevelDuration,
  cast (RAW:emailServiceLevelPercent as DECIMAL(38,19)) as emailServiceLevelPercent,
  cast (RAW:id as VARCHAR(255)) as id,
  cast (RAW:messageServiceLevelDuration as INT) as messageServiceLevelDuration,
  cast (RAW:messageServiceLevelPercent as DECIMAL(38,19)) as messageServiceLevelPercent,
  cast (RAW:name as VARCHAR(255)) as name,
  cast (RAW:socialServiceLevelDuration as INT) as socialServiceLevelDuration,
  cast (RAW:socialServiceLevelPercent as DECIMAL(38,19)) as socialServiceLevelPercent,
  cast (RAW:videoServiceLevelDuration as INT) as videoServiceLevelDuration,
  cast (RAW:videoServiceLevelPercent as DECIMAL(38,19)) as videoServiceLevelPercent
 from RAW.QUEUE_CONFIGURATION;  
  
  
  select * from raw.configuration_objects where raw:type='queue';
  
 CREATE OR REPLACE VIEW PUBLIC.D_PI_QUEUE_MEMBERSHIP_VW AS
WITH u AS (SELECT raw:id AS userid , raw:name AS userName, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'user'),
q AS (SELECT raw:id AS queueid , raw:name AS queuename, raw:DivisionId as divisionid, raw:DivisionName as divisionName, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'queue')
SELECT 
  qm.projectId as projectId,
  qm.projectName as projectName,
  qm.programId as programId,
  qm.programName as programName,
cast (q.divisionId as VARCHAR(255)) as divisionId,
cast (q.divisionName as VARCHAR(255)) as divisionName,
cast (q.queueid as VARCHAR(255)) as queueId,
cast (q.queuename as VARCHAR(255)) as queueName,
cast (u.userid as VARCHAR(255)) as userId,
cast (u.userName as VARCHAR(255)) as userName
FROM raw.queues_membership qm
LEFT OUTER JOIN q ON qm.raw:name = q.queueid and qm.projectid = q.projectid
LEFT OUTER JOIN u ON qm.raw:userId = u.userid and qm.projectid = u.projectid
; 
    
  CREATE OR REPLACE VIEW PUBLIC.D_PI_SESSIONS_VW AS
  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:addressFrom as VARCHAR(255)) as addressFrom,
  cast (rt.RAW:addressTo as VARCHAR(255)) as addressTo,
  cast (rt.RAW:ani as VARCHAR(255)) as ani,
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:direction as VARCHAR(255)) as direction,
  cast (rt.RAW:dispositionAnalyzer as VARCHAR(255)) as dispositionAnalyzer,
  cast (rt.RAW:dispositionName as VARCHAR(255)) as dispositionName,
  cast (rt.RAW:dnis as VARCHAR(255)) as dnis,
  cast (rt.RAW:edgeId as VARCHAR(255)) as edgeId,
  cast (rt.RAW:mediatype as VARCHAR(255)) as mediatype,
  cast (rt.RAW:outboundCampaignId as VARCHAR(255)) as outboundCampaignId,
  cast (rt.RAW:outboundContactId as VARCHAR(255)) as outboundContactId,
  cast (rt.RAW:outboundContactListId as VARCHAR(255)) as outboundContactListId,
  cast (rt.RAW:participantid as VARCHAR(255)) as participantid,
  cast (rt.RAW:sessionDnis as VARCHAR(255)) as sessionDnis,
  cast (rt.RAW:sessionDuration as INT) as sessionDuration,
  cast (rt.RAW:sessionEndTime as DATETIME) as sessionEndTime,
  cast (rt.RAW:sessionEndTime as DATE) as sessionEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionEndTime as DATETIME)) as projectSessionEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionEndTime as DATETIME))) as projectSessionEndDate,
  cast (rt.RAW:sessionEndTimeMillis as INT) as sessionEndTimeMillis,
  cast (rt.RAW:sessionId as VARCHAR(255)) as sessionId,
  cast (rt.RAW:sessionStartTime as DATETIME) as sessionStartTime,
  cast (rt.RAW:sessionStartTime as DATE) as sessionStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionStartTime as DATETIME)) as projectSessionStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionStartTime as DATETIME))) as projectSessionStartDate,
  cast (rt.RAW:sessionStartTimeMillis as INT) as sessionStartTimeMillis
  from RAW.SESSIONS rt
    join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;
  
 CREATE OR REPLACE VIEW PUBLIC.D_PI_USER_DETAILS_VW AS
  select
  UD.projectId as projectId,
  UD.projectName as projectName,
  UD.programId as programId,
  UD.programName as programName,
  cast (UD.RAW:department as VARCHAR(255)) as department,
  cast (UD.RAW:divisionId as VARCHAR(255)) as divisionId,
  cast (UD.RAW:divisionName as VARCHAR(255)) as divisionName,
  cast (UD.RAW:email as VARCHAR(255)) as email,
  cast (UD.RAW:employeeId as VARCHAR(255)) as employeeId,
  cast (UD.RAW:id as VARCHAR(255)) as id,
  cast (UD.RAW:managerId as VARCHAR(255)) as managerId,
  cast (CO.RAW:name as VARCHAR(255)) as managerName,
  cast (UD.RAW:name as VARCHAR(255)) as name,
  cast (UD.RAW:state as VARCHAR(255)) as state,
  cast (UD.RAW:title as VARCHAR(255)) as title 
 from RAW.USER_DETAILS UD
 left outer join RAW.CONFIGURATION_OBJECTS CO
 on UD.RAW:managerId = CO.RAW:id
 and CO.RAW:type = 'user'
 and UD.projectid = CO.projectid;
 
 
 CREATE OR REPLACE VIEW PUBLIC.D_PI_USER_LOCATIONS_VW AS
  select
  UL.projectId as projectId,
  UL.projectName as projectName,
  UL.programId as programId,
  UL.programName as programName,
  cast (L.RAW:city as VARCHAR(255)) as city,
  cast (L.RAW:country as VARCHAR(255)) as country,
  cast (L.RAW:countryname as VARCHAR(255)) as countryname,
  cast (UL.RAW:locationId as VARCHAR(255)) as locationId,
  cast (L.RAW:name as VARCHAR(255)) as locationName,
  cast (UL.RAW:name as VARCHAR(255)) as name,
  cast (L.RAW:notes as VARCHAR(255)) as notes,
  cast (L.RAW:state as VARCHAR(255)) as state,
  cast (L.RAW:street1 as VARCHAR(255)) as street1,
  cast (UL.RAW:id as VARCHAR(255)) as userId,
  cast (L.RAW:zipcode as VARCHAR(255)) as zipcode
 from RAW.USER_LOCATIONS UL
 left outer join RAW.LOCATIONS L
 on (UL.RAW:locationId = L.RAW:id
    and UL.projectId = L.projectId);
  
 
  
 CREATE OR REPLACE VIEW PUBLIC.D_PI_USER_ROLES_VW AS
  select
  projectId as projectId,
  projectName as projectName,
  programId as programId,
  programName as programName,
  cast (RAW:userId as VARCHAR(255)) as userId,
  cast (RAW:name as VARCHAR(255)) as name,
  cast (RAW:roleId as VARCHAR(255)) as roleId,
  cast (RAW:roleName as VARCHAR(255)) as roleName
  from RAW.USER_ROLES; 
  
  CREATE OR REPLACE VIEW PUBLIC.D_PI_USER_SKILLS_VW AS
  select
  projectId as projectId,
  projectName as projectName,
  programId as programId,
  programName as programName,
  --cast (RAW:id as VARCHAR(255)) as id,
  cast (RAW:name as VARCHAR(255)) as name,
  cast (RAW:proficiency as INT) as proficiency,
  cast (RAW:skillId as VARCHAR(255)) as skillId,
  cast (RAW:skillName as VARCHAR(255)) as skillName,
  cast (RAW:state as VARCHAR(255)) as state,
  cast (RAW:id as VARCHAR(255)) as userid
 from RAW.USER_SKILLS;
  
 
  
  drop view PUBLIC.F_PI_CONVERSATION_SEGMENTS_VW;
  CREATE OR REPLACE VIEW PUBLIC.F_PI_SEGMENTS_VW AS
  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (rt.RAW:audioMuted as BOOLEAN) as audioMuted,
  cast (rt.RAW:conference as BOOLEAN) as conference,             
  cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
  cast (rt.RAW:disconnecttype as VARCHAR(255)) as disconnectType,           
  cast (rt.RAW:participantid as VARCHAR(255)) as participantId,  
  cast (rt.RAW:queueId as VARCHAR(255)) as queueId, 
  cast (rt.RAW:segmentduration as INT) as segmentDuration,
  cast (rt.RAW:segmentEndTime as DATETIME) as segmentEndTime,
  cast (rt.RAW:segmentEndTime as DATE) as segmentEndDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:segmentEndTime as DATETIME)) as projectSegmentEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:segmentEndTime as DATETIME))) as projectSegmentEndDate,             
  cast (rt.RAW:segmentStartTime as DATETIME) as segmentStartTime,
  cast (rt.RAW:segmentStartTime as DATE) as segmentStartDate,           
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:segmentStartTime as DATETIME)) as projectSegmentStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:segmentStartTime as DATETIME))) as projectSegmentStartDate,            
  cast (rt.RAW:segmenttype as VARCHAR(255)) as segmentType, 
  cast (rt.RAW:sessionId as VARCHAR(255)) as sessionId, 
  cast (rt.RAW:subject as VARCHAR(255)) as subject, 
  --cast (rt.RAW:wrapUpNote as VARCHAR(255)) as wrapUpNote, 
  cast (rt.RAW:wrapupCode as VARCHAR(255)) as wrapupCode 
  from RAW.SEGMENTS rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;
    
 CREATE OR REPLACE VIEW PUBLIC.F_PI_MYSQL_QUERY_HISTORY_VW AS
  select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,                       
  cast (rt.RAW:ipaddress as VARCHAR(255)) as ipaddress,  
  cast (rt.RAW:query as VARCHAR) as query, 
  cast (rt.RAW:timestamp as DATETIME) as timestamp,
  cast (rt.RAW:timestamp as DATE) as timestampDate,           
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:timestamp as DATETIME)) as projectTimestamp,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:timestamp as DATETIME))) as projectTimestampDate,
  cast (rt.RAW:user as VARCHAR(255)) as user
  from RAW.MYSQL_AUDITS rt
  join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;CREATE OR REPLACE VIEW PUREINSIGHTS_DEV.PUBLIC.F_PI_QUEUE_ABANDONS_VW AS
WITH intervals as (SELECT  projectid, RAW:abandonIntervalADuration as intervalA,RAW:abandonIntervalBDuration as intervalB,RAW:abandonIntervalCDuration as intervalC,
                   RAW:abandonIntervalDDuration as intervalD,RAW:abandonIntervalEDuration as intervalE,RAW:abandonIntervalFDuration as intervalF 
                   FROM RAW.contact_center_settings)
  select cast(ss.projectid as varchar) as projectid, 
    cast(ss.projectname as varchar) as projectname,
    cast(ss.programid as varchar) as programid, 
    cast(ss.programname as varchar) as programname,
    cast(ss.RAW:conversationId as varchar) as conversationid,
    cast(ss.RAW:sessionId as varchar) as sessionid,
    cast(ss.RAW:sessionStartTime as datetime) as sessionstarttime,
    convert_timezone('UTC',pr.projectTimezone,cast (ss.RAW:sessionStartTime as DATETIME)) as projectSessionStartTime,
    cast(ss.RAW:dnis as varchar) as dnis,
    cast(ss.RAW:queuename as varchar) as queuename,
    cast(ss.RAW:mediatype as varchar) as mediatype,
    cast(ss.RAW:sessionDuration as int) as sessionduration,
    cast(case when (ss.RAW:sessionDuration < iv.intervalA) then 1 else 0 end as int) as abandonedIntervalA,
    cast(case when (ss.RAW:sessionDuration >= iv.intervalA and ss.RAW:sessionDuration < iv.intervalB) then 1 else 0 end as int) as abandonedIntervalB,
    cast(case when (ss.RAW:sessionDuration >= iv.intervalB and ss.RAW:sessionDuration < iv.intervalC) then 1 else 0 end as int) as abandonedIntervalC,
    cast(case when (ss.RAW:sessionDuration >= iv.intervalC and ss.RAW:sessionDuration < iv.intervalD) then 1 else 0 end as int) as abandonedIntervalD,
    cast(case when (ss.RAW:sessionDuration >= iv.intervalD and ss.RAW:sessionDuration < iv.intervalE) then 1 else 0 end as int) as abandonedIntervalE,
    cast(case when (ss.RAW:sessionDuration >= iv.intervalE and ss.RAW:sessionDuration < iv.intervalF) then 1 else 0 end as int) as abandonedIntervalF,
    cast(case when (ss.RAW:sessionDuration >= iv.intervalF) then 1 else 0 end as int) as abandonedIntervalG
  from RAW.session_summary ss
  inner join PUBLIC.D_PI_PROJECTS pr
  on ss.projectId = pr.projectId
  inner join intervals iv on ss.projectid = iv.projectid
  where ss.RAW:abandoned = 1
  and ss.RAW:purpose = 'acd';

  
   
  CREATE OR REPLACE VIEW PUBLIC.F_PI_ROUTING_STATUS_VW AS
select
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (RAW:duration as INT) as duration,
  cast (RAW:routingStatus as varchar(255)) as routingStatus,
  cast (RAW:statusEndTime as DATETIME) as statusEndTime,
  cast (RAW:statusEndTime as DATE) as statusEndDate,            
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:statusEndTime as DATETIME)) as projectstatusEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:statusEndTime as DATETIME))) as projectstatusEndDate,            
  cast (RAW:statusStartTime as DATETIME) as statusStartTime,
  cast (RAW:statusStartTime as DATE) as statusStartDate,          
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:statusStartTime as DATETIME)) as projectstatusStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:statusStartTime as DATETIME))) as projectstatusStartDate,
  cast (RAW:userName as varchar(255)) as userName,
  cast (RAW:userid as VARCHAR(255)) as userid
from RAW.ROUTING_STATUS rt
    join PUBLIC.D_PI_PROJECTS pr
  on rt.projectId = pr.projectId;
  
CREATE OR REPLACE VIEW PUREINSIGHTS_DEV.PUBLIC.F_PI_SESSION_SUMMARY_VW AS
select
rt.projectId as projectId,
rt.projectName as projectName,
rt.programId as programId,
rt.programName as programName,
cast (rt.RAW:abandoned as INT) as abandoned,
cast (rt.RAW:addressFrom as VARCHAR(255)) as addressFrom,
cast (rt.RAW:addressTo as VARCHAR(255)) as addressTo,
cast (rt.RAW:agentAnswered as INT) as agentAnswered,
cast (rt.RAW:alertNoAnswer as INT) as alertNoAnswer,
cast (rt.RAW:ani as VARCHAR(255)) as ani,
cast (rt.RAW:blindTransferred as INT) as blindTransferred,
cast (rt.RAW:campaignName as VARCHAR(255)) as campaignName,
cast (rt.RAW:consultCount as INT) as consultCount,
cast (rt.RAW:consultTransferred as INT) as consultTransferred,
cast (rt.RAW:conversationEndTime as DATETIME) as conversationEndTime,
cast (rt.RAW:conversationEndTime as DATE) as conversationEndDate,
convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationEndTime as DATETIME)) as projectConversationEndTime,
to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationEndTime as DATETIME))) as projectConversationEndDate,
cast (rt.RAW:conversationId as VARCHAR(255)) as conversationId,
cast (rt.RAW:conversationStartTime as DATETIME) as conversationStartTime,
cast (rt.RAW:conversationStartTime as DATE) as conversationStartDate,
convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationStartTime as DATETIME)) as projectConversationStartTime,
to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:conversationStartTime as DATETIME))) as projectConversationStartDate,
cast (rt.RAW:direction as VARCHAR(255)) as direction,
cast (rt.RAW:disconnectType as VARCHAR(255)) as disconnectType,
cast (rt.RAW:dnis as VARCHAR(255)) as dnis,
cast (rt.RAW:errors as INT) as errors,
cast (rt.RAW:flowOut as INT) as flowOut,
cast (rt.RAW:holdCount as INT) as holdCount,
cast (rt.RAW:mediatype as VARCHAR(255)) as mediaType,
cast (rt.RAW:monitoringDuration as INT) as monitoringDuration,
cast (rt.RAW:offered as INT) as offered,
cast (rt.RAW:originatingDirection as VARCHAR(255)) as originatingDirection,
cast (rt.RAW:originatingDnis as VARCHAR(255)) as originatingDnis,
cast (rt.RAW:participantid as VARCHAR(255)) as participantId,
cast (rt.RAW:participantName as VARCHAR(255)) as participantName,
cast (rt.RAW:purpose as VARCHAR(255)) as purpose,
cast (rt.RAW:queueAnswered as INT) as queueAnswered,
cast (rt.RAW:queuename as VARCHAR(255)) as queueName,
cast (rt.RAW:sessionCount as INT) as sessionCount,
cast (rt.RAW:sessionDuration as INT) as sessionDuration,
cast (rt.RAW:sessionEndTime as DATETIME) as sessionEndTime,
cast (rt.RAW:sessionEndTime as DATE) as sessionEndDate,
convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionEndTime as DATETIME)) as projectSessionEndTime,
to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionEndTime as DATETIME))) as projectSessionEndDate,
cast (rt.RAW:sessionId as VARCHAR(255)) as sessionId,
cast (rt.RAW:sessionIndex as INT) as sessionIndex,
cast (rt.RAW:sessionStartTime as DATETIME) as sessionStartTime,
cast (rt.RAW:sessionStartTime as DATE) as sessionStartDate,
convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionStartTime as DATETIME)) as projectSessionStartTime,
to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:sessionStartTime as DATETIME))) as projectSessionStartDate,
cast (rt.RAW:totalAcdWaitDuration as INT) as totalAcdWaitDuration,
cast (rt.RAW:totalAgentAlertDuration as INT) as totalAgentAlertDuration,
cast (rt.RAW:totalAgentHoldDuration as INT) as totalAgentHoldDuration,
cast (rt.RAW:totalAgentTalkDuration as INT) as totalAgentTalkDuration,
cast (rt.RAW:totalAgentWrapupDuration as INT) as totalAgentWrapupDuration,
cast (rt.RAW:totalContactingDuration as INT) as totalContactingDuration ,
cast (rt.RAW:totalDialingDuration as INT) as totalDialingDuration,
cast (rt.RAW:transferTo as VARCHAR(255)) as transferTo,
cast (rt.RAW:transferToPurpose as VARCHAR(255)) as transferToPurpose,
cast (rt.RAW:transferred as INT) as transferred,
cast (rt.RAW:userHandled as INT) as userHandled,
cast (rt.RAW:userid as VARCHAR(255)) as userId,
cast (rt.RAW:username as VARCHAR(255)) as userName,
cast (rt.RAW:wrapupCode as VARCHAR(255)) as wrapupCode,
cast (rt.RAW:wrapupCodeName as VARCHAR(255)) as wrapupCodeName,
cast (qc.RAW:callServiceLevelDuration as INT) as callServiceLevelDuration,
cast (qc.RAW:callServiceLevelPercent as DECIMAL(38,19)) as callServiceLevelPercent,
cast (qc.RAW:callbackServiceLevelDuration as INT) as callbackServiceLevelDuration,
cast (qc.RAW:callbackServiceLevelPercent as DECIMAL(38,19)) as callbackServiceLevelPercent,
cast (qc.RAW:chatServiceLevelDuration as INT) as chatServiceLevelDuration,
cast (qc.RAW:chatServiceLevelPercent as DECIMAL(38,19)) as chatServiceLevelPercent,
cast (qc.RAW:emailServiceLevelDuration as INT) as emailServiceLevelDuration,
cast (qc.RAW:emailServiceLevelPercent as DECIMAL(38,19)) as emailServiceLevelPercent,
cast (qc.RAW:messageServiceLevelDuration as INT) as messageServiceLevelDuration,
cast (qc.RAW:messageServiceLevelPercent as DECIMAL(38,19)) as messageServiceLevelPercent,
cast (qc.RAW:socialServiceLevelDuration as INT) as socialServiceLevelDuration,
cast (qc.RAW:socialServiceLevelPercent as DECIMAL(38,19)) as socialServiceLevelPercent,
cast (qc.RAW:videoServiceLevelDuration as INT) as videoServiceLevelDuration,
cast (qc.RAW:videoServiceLevelPercent as DECIMAL(38,19)) as videoServiceLevelPercent
from RAW.SESSION_SUMMARY rt
join PUBLIC.D_PI_PROJECTS pr
on rt.projectId = pr.projectId
left join RAW.QUEUE_CONFIGURATION qc
on rt.projectId = qc.projectId
and rt.RAW:queuename = qc.RAW:name;
  
  CREATE OR REPLACE VIEW PUBLIC.F_PI_WFM_ADHERENCE_ACTUAL_ACTIVITIES_VW AS
WITH
 mu AS (SELECT RAW:id AS managementunitid, RAW:name AS managementunitname, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'managementunit'),
 u AS (SELECT RAW:id AS userid, RAW:name AS userName, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'user')
SELECT
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (mu.managementunitname as VARCHAR(255)) as managementunitname, 
  cast (u.userName as VARCHAR(255)) as userName,
  cast (rt.raw:managementUnitId as VARCHAR(255)) as managementUnitId,
  cast (rt.raw:userId as VARCHAR(255)) as userId,
  cast (rt.raw:activityCategory as VARCHAR(255)) as activityCategory,
  cast (rt.raw:activityStartTime as DATETIME) as activityStartTime,
  cast (rt.raw:activityStartTime as DATE) as activityStartDate, 
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:activityStartTime as DATETIME)) as projectActivityStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:activityStartTime as DATETIME))) as projectActivityStartDate,
  cast (rt.raw:activityEndTime as DATETIME) as activityEndTime,
  cast (rt.raw:activityEndTime as DATE) as activityEndDate, 
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:activityEndTime as DATETIME)) as projectActivityEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:activityEndTime as DATETIME))) as projectActivityEndDate,
  cast (rt.raw:durationSeconds as VARCHAR(255)) as durationSeconds
  //cast (rt.raw:organizationId as VARCHAR(255)) as organizationIds
FROM RAW.wfm_historical_actuals rt
join PUBLIC.D_PI_PROJECTS pr on rt.projectId = pr.projectId
LEFT OUTER JOIN mu ON rt.raw:managementUnitId = mu.managementunitid and rt.projectid = mu.projectid
LEFT OUTER JOIN u ON rt.raw:userId = u.userid and rt.projectid = mu.projectid;


CREATE OR REPLACE VIEW PUBLIC.F_PI_WFM_ADHERENCE_EXCEPTIONS_VW AS
WITH
 mu AS (SELECT raw:id AS managementunitid , raw:name AS managementunitname, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'managementunit'),
 u AS (SELECT raw:id AS userid , raw:name AS userName , projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'user'),
 codes AS (SELECT raw:id as activityCodeId, raw:name as scheduledActivityName, raw:category as scheduledActivityCategory, raw:businessUnitId as businessunitid, projectid as projectid  FROM raw.wfm_activity_codes)
SELECT
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (mu.managementunitname as VARCHAR(255)) as managementunitname, 
  cast (u.USERNAME as VARCHAR(255)) as userName,
  --cast (rt.raw:scheduledActivityId as VARCHAR(255)) as scheduledActivityCodeId,
  cast (codes.scheduledActivityName as VARCHAR(255)) as scheduledActivityName,
  cast (codes.scheduledActivityCategory as VARCHAR(255)) as scheduledActivityCategory,
  cast(rt.RAW:managementUnitId as VARCHAR(255)) as managementUnitId,
  cast(rt.RAW:userId as VARCHAR(255)) as userId,
  cast(rt.RAW:actualActivityCategory as VARCHAR(255)) as actualActivityCategory,
  cast(rt.RAW:exceptionStartTime as DATETIME) as exceptionStartTime,
  cast(rt.RAW:exceptionStartTime as DATE) as exceptionStartDate, 
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:exceptionStartTime as DATETIME)) as projectExceptionStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:exceptionStartTime as DATETIME))) as projectExceptionStartDate,           
  cast(rt.RAW:exceptionEndTime as DATETIME) as exceptionEndTime,
  cast(rt.RAW:exceptionEndTime as DATE) as exceptionEndDate, 
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:exceptionEndTime as DATETIME)) as projectExceptionEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:exceptionEndTime as DATETIME))) as projectExceptionEndDate,
  cast(rt.RAW:durationSeconds as VARCHAR(255)) as durationSeconds,
  cast(rt.RAW:systemPresence as VARCHAR(255)) as systemPresence,
  cast(rt.RAW:routingStatus as VARCHAR(255)) as routingStatus,
  cast(rt.RAW:impact as VARCHAR(255)) as impact
FROM raw.wfm_historical_exceptions rt
join PUBLIC.D_PI_PROJECTS pr on rt.projectId = pr.projectId
LEFT OUTER JOIN mu ON rt.RAW:managementUnitId= mu.managementUnitId and rt.projectid = mu.projectid
LEFT OUTER JOIN u ON rt.RAW:userId= u.userid and rt.projectid = u.projectid
LEFT OUTER JOIN codes ON rt.RAW:scheduledActivityCodeId= codes.activityCodeId and rt.RAW:businessUnitId  = codes.businessunitid and rt.projectid = codes.projectid;


CREATE OR REPLACE VIEW PUBLIC.F_PI_WFM_SCHEDULES_VW AS
WITH
 bu AS (SELECT raw:id AS businessunitid , raw:name AS businessunitname, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'businessunit'),
 mu AS (SELECT raw:id AS managementunitid , raw:name AS managementunitname, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'managementunit'),
 u AS (SELECT raw:id AS userid , raw:name AS userName, projectid as projectid FROM raw.configuration_objects  WHERE raw:type = 'user'),
 codes AS (SELECT raw:id as activityCodeId, raw:name as activityName, raw:category as activityCategory, raw:businessUnitId as businessunitid, projectid as projectid FROM raw.wfm_activity_codes)
SELECT 
  rt.projectId as projectId,
  rt.projectName as projectName,
  rt.programId as programId,
  rt.programName as programName,
  cast (bu.businessunitName as VARCHAR(255)) as businessunitname, 
  cast (mu.managementunitName as VARCHAR(255)) as managementunitname, 
  cast (u.userName as VARCHAR(255)) as userName,
  cast (codes.activityName as VARCHAR(255)) as activityName,
  cast (codes.activityCategory as VARCHAR(255)) as activityCategory,
  cast (rt.RAW:businessUnitId as VARCHAR(255)) as businessUnitId,
  cast (rt.RAW:managementUnitId as VARCHAR(255)) as managementUnitId,
  cast (rt.RAW:userId as VARCHAR(255)) as userId,
  cast (rt.RAW:shiftId as VARCHAR(255)) as shiftId,
  cast (rt.RAW:manuallyEdited as BOOLEAN) as manuallyEdited,
  cast (rt.RAW:durationMinutes as VARCHAR(255)) as durationMinutes,
  cast (rt.RAW:description as VARCHAR(255)) as description,
  cast (rt.RAW:paid as BOOLEAN) as paid,
  cast (rt.RAW:activityStartTime as DATETIME) as activityStartTime,           
  cast (rt.RAW:activityStartTime as DATE) as activityStartDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:activityStartTime as DATETIME)) as projectActivityStartTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:activityStartTime as DATETIME))) as projectActivityStartDate,
  cast (rt.RAW:activityEndTime as DATETIME) as activityEndTime,
  cast (rt.RAW:activityEndTime as DATE) as activityEndDate,
  convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:activityEndTime as DATETIME)) as projectActivityEndTime,
  to_date(convert_timezone('UTC',pr.projectTimezone,cast (rt.RAW:activityEndTime as DATETIME))) as projectActivityEndDate
FROM raw.wfm_schedule rt
join PUBLIC.D_PI_PROJECTS pr on rt.projectId = pr.projectId
LEFT OUTER JOIN bu ON rt.RAW:businessUnitId= bu.businessunitId and rt.projectid = bu.projectid
LEFT OUTER JOIN mu ON rt.RAW:managementUnitId= mu.managementunitId and rt.projectid = mu.projectid
LEFT OUTER JOIN u ON rt.RAW:userId= u.userId and rt.projectid = u.projectid
LEFT OUTER JOIN codes ON rt.RAW:activityCodeId= codes.activityCodeId and rt.RAW:businessUnitId  = codes.businessunitid and rt.projectid = codes.projectid;


GRANT MONITOR,REFERENCE_USAGE, USAGE ON DATABASE PUREINSIGHTS_PRD TO ROLE BI_PRODUCT_DEV;
GRANT USAGE ON SCHEMA PUREINSIGHTS_PRD.PUBLIC TO ROLE BI_PRODUCT_DEV;
GRANT SELECT ON ALL TABLES IN SCHEMA PUREINSIGHTS_PRD.PUBLIC TO ROLE BI_PRODUCT_DEV;
--GRANT SELECT ON FUTURE TABLES IN SCHEMA PUREINSIGHTS_PRD.PUBLIC TO ROLE BI_PRODUCT_DEV;
GRANT SELECT ON ALL VIEWS IN SCHEMA PUREINSIGHTS_PRD.PUBLIC TO ROLE BI_PRODUCT_DEV;
--GRANT SELECT ON FUTURE VIEWS IN SCHEMA PUREINSIGHTS_PRD.PUBLIC TO ROLE BI_PRODUCT_DEV;


GRANT MONITOR,REFERENCE_USAGE, USAGE ON DATABASE PUREINSIGHTS_UAT TO ROLE BI_PRODUCT_DEV;
GRANT USAGE ON SCHEMA PUREINSIGHTS_UAT.PUBLIC TO ROLE BI_PRODUCT_DEV;
GRANT SELECT ON ALL TABLES IN SCHEMA PUREINSIGHTS_UAT.PUBLIC TO ROLE BI_PRODUCT_DEV;
GRANT SELECT ON FUTURE TABLES IN SCHEMA PUREINSIGHTS_UAT.PUBLIC TO ROLE BI_PRODUCT_DEV;
GRANT SELECT ON ALL VIEWS IN SCHEMA PUREINSIGHTS_UAT.PUBLIC TO ROLE BI_PRODUCT_DEV;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA PUREINSIGHTS_UAT.PUBLIC TO ROLE BI_PRODUCT_DEV;
