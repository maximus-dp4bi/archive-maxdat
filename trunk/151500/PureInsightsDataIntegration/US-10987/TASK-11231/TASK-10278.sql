USE DATABASE PUREINSIGHTS_UAT;
USE SCHEMA PUBLIC;

-- ********** CAHCO **********

-- Get list of tables
select  
    *
from  
    d_pi_tables t
where  
    not exists (
                    select
                        1
                    from
                        d_pi_project_unavailable_tables uat
                    where
                        uat.project_id  =   (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')
                    and uat.table_name  =   t.table_name
                )
and t.active    =   TRUE;                

-- ********** audio_quality **********

-- Source

select count(*) from purecloud.audio_quality;
-- Returned 8408

select
	codec,  
	conversationEndTime,
	conversationStartTime,
	conversationid,
	discardedPackets,
	duplicatePackets,
	duration,            
	edgeId,
	invalidPackets,
	maxLatencyMs,             
	mediaStatsMinConversationMos,
	mediaStatsMinConversationRFactor,	
    minMos,
	minRFactor,
	originatingDirection,               
	overrunPackets, 
	participantid,
	participantName,             
	processTime,
	purpose, 
	receivedPackets,
	underrunPackets,               
    userId           
from
		purecloud.audio_quality
order by
	codec,  
	conversationEndTime,
	conversationStartTime,
	conversationid,
	discardedPackets,
	duplicatePackets,
	duration,            
	edgeId,
	invalidPackets,
	maxLatencyMs,             
	mediaStatsMinConversationMos,
	mediaStatsMinConversationRFactor,	
    minMos,
	minRFactor,
	originatingDirection,               
	overrunPackets, 
	participantid,
	participantName,             
	processTime,
	purpose, 
	receivedPackets,
	underrunPackets,               
    userId;


-- Target

select count(*) from raw.audio_quality where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 8408

select count(*) from d_pi_audio_quality_vw where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 8408

select
	codec,  
	conversationEndTime,
	conversationStartTime,
	conversationid,
	discardedPackets,
	duplicatePackets,
	duration,            
	edgeId,
	invalidPackets,
	maxLatencyMs,             
	mediaStatsMinConversationMos,
	mediaStatsMinConversationRFactor,	
    minMos,
	minRFactor,
	originatingDirection,               
	overrunPackets, 
	participantid,
	participantName,             
	processTime,
	purpose, 
	receivedPackets,
	underrunPackets,               
    userId           
from
    d_pi_audio_quality_vw 
where 
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')        
order by
	codec,  
	conversationEndTime,
	conversationStartTime,
	conversationid,
	discardedPackets,
	duplicatePackets,
	duration,            
	edgeId,
	invalidPackets,
	maxLatencyMs,             
	mediaStatsMinConversationMos,
	mediaStatsMinConversationRFactor,	
    minMos,
	minRFactor,
	originatingDirection,               
	overrunPackets, 
	participantid,
	participantName,             
	processTime,
	purpose, 
	receivedPackets,
	underrunPackets,               
    userId;

-- ********** billable_usage **********

-- Source

select count(*) from purecloud.billable_usage;
-- Returned 1425

select 
	department, 
	divisionid, 
	divisionname,              
	id, 
	licensedentity,
	licenseName,  
	name, 
	observedDate  as observeddatetime
from
	purecloud.billable_usage
order by
	department, 
	divisionid, 
	divisionname,              
	id, 
	licensedentity,
	licenseName,  
	name, 
	observedDate;


-- Target

select count(*) from raw.billable_usage where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 1425

select count(*) from d_pi_billable_usage_vw where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 1425

select 
	department, 
	divisionid, 
	divisionname,              
	id, 
	licensedentity,
	licenseName,  
	name, 
	observeddatetime
from
    d_pi_billable_usage_vw
where
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')        
order by
	department, 
	divisionid, 
	divisionname,              
	id, 
	licensedentity,
	licenseName,  
	name, 
	observedDate;

-- ********** configuration_objects **********

-- Source

select count(*) from purecloud.configuration_objects;
-- Returned 540    

select
    DivisionId,
    DivisionName,
    id,
    name,
    type  
from
    purecloud.configuration_objects
order by
    DivisionId,
    DivisionName,
    id,
    name,
    type;


-- Target

select count(*) from raw.configuration_objects where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 532

select count(*) from d_pi_configuration_objects_vw where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 532

select
    DivisionId,
    DivisionName,
    id,
    name,
    type  
from
    d_pi_configuration_objects_vw 
where 
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')
order by
    DivisionId,
    DivisionName,
    id,
    name,
    type;


-- ********** conversations **********

-- Source

select count(*) from purecloud.conversations;
-- Returned 8254

select
	conversationEndTime,
	conversationId,
	conversationStartTime,
	duration,
	mediastatsminconversationmos,
	mediastatsminconversationrfactor,
	originatingDirection,
	processTime
from
	purecloud.conversations
order by
	conversationEndTime,
	conversationId,
	conversationStartTime,
	duration,
	mediastatsminconversationmos,
	mediastatsminconversationrfactor,
	originatingDirection,
	processTime;

-- Target

select count(*) from raw.conversations where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 8254

select count(*) from d_pi_conversations_vw where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 

select
	conversationEndTime,
	conversationId,
	conversationStartTime,
	duration,
	mediastatsminconversationmos,
	mediastatsminconversationrfactor,
	originatingDirection,
	processTime
from
    d_pi_conversations_vw
where 
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')
order by
	conversationEndTime,
	conversationId,
	conversationStartTime,
	duration,
	mediastatsminconversationmos,
	mediastatsminconversationrfactor,
	originatingDirection,
	processTime;

-- ********** conversations_detail **********

select count(*) from purecloud.conversations_detail;  
-- Returned 82731  

select
	addressFrom,	
	addressTo,
	ani,
	campaignName,
	contactListName,
	conversationEndTime,
	ConversationId,
	conversationStartTime,
	Direction,
	disconnectType,
	dispositionAnalyzer,
	dispositionName,
	dnis,
	Duration,
	mediaType,
	originatingDirection,
	outboundCampaignId,
	outboundContactId,	
	outboundContactListId,
	ParticipantName,
	participantid,	
	processTime,
	purpose,
	queueName,
	segmentDuration,
	segmentEndTime,
	segmentStartTime,
	segmentType,
	sessionDnis,
	sessionEndTime,
	sessionId,
	sessionStartTime,
	userId,
	userName,
	wrapUpCode,
	wrapupCodeName
from
		purecloud.conversations_detail
order by
	addressFrom,	
	addressTo,
	ani,
	campaignName,
	contactListName,
	conversationEndTime,
	ConversationId,
	conversationStartTime,
	Direction,
	disconnectType,
	dispositionAnalyzer,
	dispositionName,
	dnis,
	Duration,
	mediaType,
	originatingDirection,
	outboundCampaignId,
	outboundContactId,	
	outboundContactListId,
	ParticipantName,
	participantid,	
	processTime,
	purpose,
	queueName,
	segmentDuration,
	segmentEndTime,
	segmentStartTime,
	segmentType,
	sessionDnis,
	sessionEndTime,
	sessionId,
	sessionStartTime,
	userId,
	userName,
	wrapUpCode,
	wrapupCodeName;


-- Target

select count(*) from raw.conversations_detail where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 82731

select count(*) from d_pi_conversations_detail_vw where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 82731


select
	addressFrom,	
	addressTo,
	ani,
	campaignName,
	contactListName,
	conversationEndTime,
	ConversationId,
	conversationStartTime,
	Direction,
	disconnectType,
	dispositionAnalyzer,
	dispositionName,
	dnis,
	Duration,
	mediaType,
	originatingDirection,
	outboundCampaignId,
	outboundContactId,	
	outboundContactListId,
	ParticipantName,
	participantid,	
	processTime,
	purpose,
	queueName,
	segmentDuration,
	segmentEndTime,
	segmentStartTime,
	segmentType,
	sessionDnis,
	sessionEndTime,
	sessionId,
	sessionStartTime,
	userId,
	userName,
	wrapUpCode,
	wrapupCodeName
from
    d_pi_conversations_detail_vw 
where
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')
order by
	addressFrom,	
	addressTo,
	ani,
	campaignName,
	contactListName,
	conversationEndTime,
	ConversationId,
	conversationStartTime,
	Direction,
	disconnectType,
	dispositionAnalyzer,
	dispositionName,
	dnis,
	Duration,
	mediaType,
	originatingDirection,
	outboundCampaignId,
	outboundContactId,	
	outboundContactListId,
	ParticipantName,
	participantid,	
	processTime,
	purpose,
	queueName,
	segmentDuration,
	segmentEndTime,
	segmentStartTime,
	segmentType,
	sessionDnis,
	sessionEndTime,
	sessionId,
	sessionStartTime,
	userId,
	userName,
	wrapUpCode,
	wrapupCodeName;


-- ********** conversation_attributes **********

-- Source

select count(*) from purecloud.conversation_attributes;  
-- Returned 53421  

select 
	department, 
	divisionid, 
	divisionname,              
	id, 
	licensedentity,
	licenseName,  
	name, 
	observedDate  as observeddatetime
from
	purecloud.billable_usage
order by
	department, 
	divisionid, 
	divisionname,              
	id, 
	licensedentity,
	licenseName,  
	name, 
	observedDate;


-- Target

select count(*) from raw.conversation_attributes where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 53421

select count(*) from d_pi_conversation_attributes_vw where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 53421

select
	ca.conversationId,
	ca.key,
	ca.participantEndTime,
	ca.participantid,
	ca.participantName,
	ca.participantStartTime,
	ca.purpose,
	ca.userId,
	ca.value
from 
	d_pi_conversation_attributes_vw ca
where 
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')
order by
	ca.conversationId,
	ca.key,
	ca.participantEndTime,
	ca.participantid,
	ca.participantName,
	ca.participantStartTime,
	ca.purpose,
	ca.userId,
	ca.value;
    

-- ********** dialer_detail **********

-- Source

select count(*) from purecloud.dialer_detail;
-- Returned 368

select
	abandoned, 
	attempt, 
	attemptResult,
	attemptTime,
	campaignName, 
	contactUncallable
    contactListName,
	contactUncallable,
	conversationId,
	conversationStartTime,
	dispositionAnalyzer,
	dispositionName,
	dnis,
	firstAgentName,
	firstAgentWrapup,
	firstIvrWrapup,
	numberUncallable,
	ReachedAgent,
	ReachedFlow,
	rightPartyContact,
	totalAttempts
from
	purecloud.dialer_detail
order by
	abandoned, 
	attempt, 
	attemptResult,
	attemptTime,
	campaignName, 
	contactUncallable,
    contactListName,
	contactUncallable,
	conversationId,
	conversationStartTime,
	dispositionAnalyzer,
	dispositionName,
	dnis,
	firstAgentName,
	firstAgentWrapup,
	firstIvrWrapup,
	numberUncallable,
	ReachedAgent,
	ReachedFlow,
	rightPartyContact,
	totalAttempts;


-- Target

select count(*) from raw.dialer_detail where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 368

select count(*) from d_pi_dialer_detail_vw where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 368

select
	abandoned, 
	attempt, 
	attemptResult,
	attemptTime,
	campaignName, 
	contactUncallable
    contactListName,
	contactUncallable,
	conversationId,
	conversationStartTime,
	dispositionAnalyzer,
	dispositionName,
	dnis,
	firstAgentName,
	firstAgentWrapup,
	firstIvrWrapup,
	numberUncallable,
	ReachedAgent,
	ReachedFlow,
	rightPartyContact,
	totalAttempts
from
d_pi_dialer_detail_vw 
where 
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')
order by
	abandoned, 
	attempt, 
	attemptResult,
	attemptTime,
	campaignName, 
	contactUncallable,
    contactListName,
	contactUncallable,
	conversationId,
	conversationStartTime,
	dispositionAnalyzer,
	dispositionName,
	dnis,
	firstAgentName,
	firstAgentWrapup,
	firstIvrWrapup,
	numberUncallable,
	ReachedAgent,
	ReachedFlow,
	rightPartyContact,
	totalAttempts;


-- ********** dialer_preview_detail **********

-- Source

select count(*) from purecloud.dialer_preview_detail; 
-- Returned 19   

select 
	department, 
	divisionid, 
	divisionname,              
	id, 
	licensedentity,
	licenseName,  
	name, 
	observedDate  as observeddatetime
from
	purecloud.billable_usage
order by
	department, 
	divisionid, 
	divisionname,              
	id, 
	licensedentity,
	licenseName,  
	name, 
	observedDate;


-- Target

select count(*) from raw.dialer_preview_detail where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 19

select count(*) from d_pi_dialer_preview_detail_vw where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 19

select
	agentDuration, 
	agentName,
	attemptDuration, 
	attemptEndTime,
	attemptResult, 
	attemptStartTime,
	campaignName, 
	contactUncallable,          
	conversationId,
	conversationStartTime,
	dnis,
	numberUncallable,   
	previewDuration,
	queueName,
	rightPartyContact,
	sessionEndTime,
	sessionId,
	sessionStartTime,
	skipped,
	totalAttemptDuration,          
	wrapupCodeName
from
    d_pi_dialer_preview_detail_vw 
where 
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')
order by
	agentDuration, 
	agentName,
	attemptDuration, 
	attemptEndTime,
	attemptResult, 
	attemptStartTime,
	campaignName, 
	contactUncallable,          
	conversationId,
	conversationStartTime,
	dnis,
	numberUncallable,   
	previewDuration,
	queueName,
	rightPartyContact,
	sessionEndTime,
	sessionId,
	sessionStartTime,
	skipped,
	totalAttemptDuration,
    wrapupCodeName;


-- ********** divisions **********

-- Source

select count(*) from purecloud.divisions;
-- Returned 8254    

select 
	department, 
	divisionid, 
	divisionname,              
	id, 
	licensedentity,
	licenseName,  
	name, 
	observedDate  as observeddatetime
from
	purecloud.billable_usage
order by
	department, 
	divisionid, 
	divisionname,              
	id, 
	licensedentity,
	licenseName,  
	name, 
	observedDate;


-- Target

select count(*) from raw.divisions where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 8254

select count(*) from d_pi_divisions_vw where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 8254

select
	conversationId,
	divisionId,
	divisionName
from
    d_pi_divisions_vw 
where 
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')
order by
	conversationId,
	divisionId,
	divisionName;
    
-- ********** flow_outcomes **********

-- Source

select count(*) from purecloud.flow_outcomes;
-- Returned 32621

select
	conversationId,
	endingLanguage,
	exitReason,              
	flowId,
	flowName,
	flowType,               
	flowVersion,            
	issuedCallback,
	outcomeId,
	outcomeName,
	outcomeStartTime,    
	outcomeValue,      
	participantId,    
	sessionId,        
	sessionStartTime,    
	startingLanguage,
	transferTargetAddress,
	transferTargetName,
	transferType
from
	purecloud.flow_outcomes
order by
	conversationId,
	endingLanguage,
	exitReason,              
	flowId,
	flowName,
	flowType,               
	flowVersion,            
	issuedCallback,
	outcomeId,
	outcomeName,
	outcomeStartTime,    
	outcomeValue,      
	participantId,    
	sessionId,        
	sessionStartTime,    
	startingLanguage,
	transferTargetAddress,
	transferTargetName,
	transferType;


-- Target

select count(*) from raw.flow_outcomes where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 31008

select count(*) from d_pi_flow_outcomes_vw where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO');
-- Returned 31008

select
	conversationId,
	endingLanguage,
	exitReason,              
	flowId,
	flowName,
	flowType,               
	flowVersion,            
	issuedCallback,
	outcomeId,
	outcomeName,
	outcomeStartTime,    
	outcomeValue,      
	participantId,    
	sessionId,        
	sessionStartTime,    
	startingLanguage,
	transferTargetAddress,
	transferTargetName,
	transferType
from
    d_pi_flow_outcomes_vw 
where 
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'CA HCO')
order by
	conversationId,
	endingLanguage,
	exitReason,              
	flowId,
	flowName,
	flowType,               
	flowVersion,            
	issuedCallback,
	outcomeId,
	outcomeName,
	outcomeStartTime,    
	outcomeValue,      
	participantId,    
	sessionId,        
	sessionStartTime,    
	startingLanguage,
	transferTargetAddress,
	transferTargetName,
	transferType;
