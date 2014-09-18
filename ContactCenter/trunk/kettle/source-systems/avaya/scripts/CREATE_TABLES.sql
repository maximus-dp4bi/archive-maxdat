CREATE TABLE "dbo"."Agent"
(
   SurName VARCHAR(64) NOT NULL,
   GivenName VARCHAR(64),
   URI varchar(4096),
   SIP_Terminal VARCHAR(255),
   Comment VARCHAR(127),
   Department VARCHAR(64),
   Title VARCHAR(64),
   TelsetLoginID VARCHAR(16),
   PersonalDN VARCHAR(32),
   SwitchID INTEGER,
   SwitchPortAddress VARCHAR(30),
   SwitchPortName VARCHAR(30),
   TemplateID INTEGER,
   TemplateName VARCHAR(30) NOT NULL,
   ThresholdTemplateID INTEGER NOT NULL,
   ThresholdTemplateName VARCHAR(30) NOT NULL,
   UserID VARCHAR(32) NOT NULL,
   UnionBreakTimer SMALLINT NOT NULL,
   CallForceOption VARCHAR(255),
   CallForceDelayTimer INTEGER,
   TelsetShowReserve VARCHAR(255),
   ReturnToQueueOnNoAnswer VARCHAR(255),
   ReturnToQueueWaitInterval SMALLINT NOT NULL,
   ReturnToQueueMode VARCHAR(80) NOT NULL,
   AlternateCallAnswer VARCHAR(255),
   ACD_Queue VARCHAR(10),
   ACD_QueueStatus VARCHAR(6),
   URIList varchar(4096),
   MultiplicityTemplateID SMALLINT NOT NULL,
   MultiplicityTemplateDesc VARCHAR(31),
   UserType SMALLINT NOT NULL,
   UserTypeDesc VARCHAR(80),
   AGState SMALLINT,
   AGPassword VARCHAR(255),
   AGRecorded SMALLINT,
   AGLicensed SMALLINT,
   DialogPassword VARCHAR(31),
   CtiEnabled BIT,
   SwitchType SMALLINT,
   ExternalServer VARCHAR(16),
   ExternalAgentID INTEGER,
   OffsiteAllowed BIT,
   OffsiteMode BIT,
   OffsitePhone1 VARCHAR(30),
   OffsitePhone2 VARCHAR(30),
   OffsiteAlternatePhone BIT
)
;


CREATE TABLE "dbo"."Application"
(
   ApplicationID INTEGER NOT NULL,
   Name VARCHAR(30) NOT NULL,
   ServiceLevelThreshold INTEGER,
   TemplateID INTEGER NOT NULL,
   CallByCall SMALLINT NOT NULL
)
;

CREATE TABLE "dbo"."dAgentBySkillsetStat"
(
   "Timestamp" timestamp NOT NULL,
   AgentLogin VARCHAR(16) NOT NULL,
   AgentSurName VARCHAR(64),
   AgentGivenName VARCHAR(64),
   SkillsetID INTEGER NOT NULL,
   Skillset VARCHAR(30) NOT NULL,
   ContactType VARCHAR(30),
   CallsAnswered INTEGER NOT NULL,
   PostCallProcessingTime INTEGER NOT NULL,
   ShortCallsAnswered INTEGER NOT NULL,
   TalkTime INTEGER NOT NULL,
   TotalStaffedTime INTEGER NOT NULL,
   UserID VARCHAR(32) NOT NULL,
   "Time" VARCHAR(5),
   SiteID INTEGER NOT NULL,
   Site VARCHAR(30) NOT NULL,
   WaitTime INTEGER NOT NULL,
   HoldTime INTEGER NOT NULL,
   ConsultTime INTEGER NOT NULL,
   CallsTransferred INTEGER NOT NULL,
   DNOutExtTalkTime INTEGER NOT NULL,
   DNOutIntTalkTime INTEGER NOT NULL,
   CallsConferenced INTEGER NOT NULL,
   CallsOffered INTEGER NOT NULL,
   CallsReturnToQ INTEGER NOT NULL,
   CallsReturnToQDueToTimeout INTEGER NOT NULL,
   RingTime INTEGER NOT NULL,
   ContactTalkTime INTEGER NOT NULL,
   ContactHoldTime INTEGER NOT NULL,
   BlendedActiveTime INTEGER NOT NULL,
   MaxCapacityTotalStaffedTime INTEGER NOT NULL,
   MaxCapacityIdleTime INTEGER NOT NULL,
   IdleTime INTEGER NOT NULL,
   NotReadyTime INTEGER NOT NULL
)
;

CREATE TABLE "dbo"."dAgentPerformanceStat"
(
   "Timestamp" timestamp NOT NULL,
   AgentLogin VARCHAR(16) NOT NULL,
   AgentSurName VARCHAR(64),
   AgentGivenName VARCHAR(64),
   SupervisorLogin VARCHAR(16),
   SupervisorSurName VARCHAR(64),
   SupervisorGivenName VARCHAR(64),
   ACDCallsAnswered INTEGER,
   ACDCallsConfToCDN INTEGER NOT NULL,
   ACDCallsConfToDN INTEGER NOT NULL,
   ACDCallsConfToIncalls INTEGER NOT NULL,
   ACDCallsConfToOther INTEGER NOT NULL,
   ACDCallsTalkTime INTEGER NOT NULL,
   ACDCallsTransferredToCDN INTEGER NOT NULL,
   ACDCallsTransferredToDN INTEGER NOT NULL,
   ACDCallsTransferredToIncalls INTEGER NOT NULL,
   ACDCallsTransferredToOther INTEGER NOT NULL,
   BreakTime INTEGER NOT NULL,
   BusyOnDNTime INTEGER NOT NULL,
   BusyMiscTime INTEGER NOT NULL,
   CallsAnswered INTEGER NOT NULL,
   CallsOffered INTEGER NOT NULL,
   CallsReturnedToQ INTEGER NOT NULL,
   CallsReturnedToQDueToTimeout INTEGER NOT NULL,
   CDNCallsConfToCDN INTEGER NOT NULL,
   CDNCallsConfToDN INTEGER NOT NULL,
   CDNCallsConfToIncalls INTEGER NOT NULL,
   CDNCallsConfToOther INTEGER NOT NULL,
   CDNCallsTransferredToCDN INTEGER NOT NULL,
   CDNCallsTransferredToDN INTEGER NOT NULL,
   CDNCallsTransferredToIncalls INTEGER NOT NULL,
   CDNCallsTransferredToOther INTEGER NOT NULL,
   ConsultationTime INTEGER NOT NULL,
   DNCallsConfToACDDN INTEGER NOT NULL,
   DNCallsConfToCDN INTEGER NOT NULL,
   DNCallsConfToDN INTEGER NOT NULL,
   DNCallsConfToOther INTEGER NOT NULL,
   DNCallsTransferredToACDDN INTEGER NOT NULL,
   DNCallsTransferredToCDN INTEGER NOT NULL,
   DNCallsTransferredToDN INTEGER NOT NULL,
   DNCallsTransferredToOther INTEGER NOT NULL,
   DNInExtCalls INTEGER NOT NULL,
   DNInExtCallsTalkTime INTEGER NOT NULL,
   DNInIntCalls INTEGER NOT NULL,
   DNInIntCallsTalkTime INTEGER NOT NULL,
   DNOutExtCalls INTEGER NOT NULL,
   DNOutExtCallsTalkTime INTEGER NOT NULL,
   DNOutIntCalls INTEGER NOT NULL,
   DNOutIntCallsTalkTime INTEGER NOT NULL,
   HoldTime INTEGER NOT NULL,
   LoggedInTime INTEGER NOT NULL,
   NACDCallsAnswered INTEGER NOT NULL,
   NACDCallsTalkTime INTEGER NOT NULL,
   NetworkCallsAnswered INTEGER NOT NULL,
   NetworkCallsTalkTime INTEGER NOT NULL,
   NotReadyTime INTEGER NOT NULL,
   ReservedForCall INTEGER NOT NULL,
   ReservedTime INTEGER NOT NULL,
   RingTime INTEGER NOT NULL,
   ShortCallsAnswered INTEGER NOT NULL,
   TalkTime INTEGER NOT NULL,
   WaitingTime INTEGER NOT NULL,
   WalkawayTime INTEGER NOT NULL,
   UserID VARCHAR(32) NOT NULL,
   SupervisorUserID VARCHAR(32) NOT NULL,
   "Time" VARCHAR(5),
   SiteID INTEGER NOT NULL,
   Site VARCHAR(30) NOT NULL,
   DNInExtCallsHoldTime INTEGER NOT NULL,
   DNInIntCallsHoldTime INTEGER NOT NULL,
   DNOutExtCallsHoldTime INTEGER NOT NULL,
   DNOutIntCallsHoldTime INTEGER NOT NULL,
   NumberTimesNotReady INTEGER NOT NULL,
   ContactTalkTime INTEGER NOT NULL,
   ContactHoldTime INTEGER NOT NULL,
   BlendedActiveTime INTEGER NOT NULL,
   MaxCapacityLoggedInTime INTEGER NOT NULL,
   MaxCapacityIdleTime INTEGER NOT NULL,
   MaxCapacityTime INTEGER NOT NULL,
   PresentationDeniedTime INTEGER NOT NULL,
   PostCallProcessingTime INTEGER NOT NULL
)
;



CREATE TABLE "dbo"."iAgentBySkillsetStat"
(
   "Timestamp" timestamp NOT NULL,
   AgentLogin VARCHAR(16) NOT NULL,
   AgentSurName VARCHAR(64),
   AgentGivenName VARCHAR(64),
   SkillsetID INTEGER NOT NULL,
   Skillset VARCHAR(30) NOT NULL,
   ContactType VARCHAR(30),
   CallsAnswered INTEGER NOT NULL,
   PostCallProcessingTime INTEGER NOT NULL,
   ShortCallsAnswered INTEGER NOT NULL,
   TalkTime INTEGER NOT NULL,
   TotalStaffedTime INTEGER NOT NULL,
   UserID VARCHAR(32) NOT NULL,
   "Time" VARCHAR(5),
   SiteID INTEGER NOT NULL,
   Site VARCHAR(30) NOT NULL,
   WaitTime INTEGER NOT NULL,
   HoldTime INTEGER NOT NULL,
   ConsultTime INTEGER NOT NULL,
   CallsTransferred INTEGER NOT NULL,
   DNOutExtTalkTime INTEGER NOT NULL,
   DNOutIntTalkTime INTEGER NOT NULL,
   CallsConferenced INTEGER NOT NULL,
   CallsOffered INTEGER NOT NULL,
   CallsReturnToQ INTEGER NOT NULL,
   CallsReturnToQDueToTimeout INTEGER NOT NULL,
   RingTime INTEGER NOT NULL,
   ContactTalkTime INTEGER NOT NULL,
   ContactHoldTime INTEGER NOT NULL,
   BlendedActiveTime INTEGER NOT NULL,
   MaxCapacityTotalStaffedTime INTEGER NOT NULL,
   MaxCapacityIdleTime INTEGER NOT NULL,
   IdleTime INTEGER NOT NULL,
   NotReadyTime INTEGER NOT NULL
)
;

CREATE TABLE "dbo"."iAgentByApplicationStat"
(
   "Timestamp" timestamp NOT NULL,
   AgentLogin VARCHAR(16) NOT NULL,
   AgentSurName VARCHAR(64),
   AgentGivenName VARCHAR(64),
   ApplicationID INTEGER NOT NULL,
   Application VARCHAR(30) NOT NULL,
   CallsAnswered INTEGER NOT NULL,
   PostCallProcessingTime INTEGER NOT NULL,
   TalkTime INTEGER NOT NULL,
   UserID VARCHAR(32) NOT NULL,
   "Time" VARCHAR(5),
   SiteID INTEGER NOT NULL,
   Site VARCHAR(30) NOT NULL,
   WaitTime INTEGER NOT NULL,
   HoldTime INTEGER NOT NULL,
   ConsultTime INTEGER NOT NULL,
   CallsTransferred INTEGER NOT NULL,
   DNOutExtTalkTime INTEGER NOT NULL,
   DNOutIntTalkTime INTEGER NOT NULL,
   CallsConferenced INTEGER NOT NULL,
   CallsOffered INTEGER NOT NULL,
   CallsReturnToQ INTEGER NOT NULL,
   CallsReturnToQDueToTimeout INTEGER NOT NULL,
   RingTime INTEGER NOT NULL,
   ContactType VARCHAR(30),
   SourceApplicationName VARCHAR(30) NOT NULL,
   ContactTalkTime INTEGER NOT NULL,
   ContactHoldTime INTEGER NOT NULL,
   BlendedActiveTime INTEGER NOT NULL
)
;

CREATE TABLE "dbo"."iApplicationStat"
(
   "Timestamp" timestamp NOT NULL,
   ApplicationID INTEGER NOT NULL,
   Application VARCHAR(30) NOT NULL,
   CallsAbandoned INTEGER NOT NULL,
   CallsAbandonedAftThreshold INTEGER NOT NULL,
   CallsAbandonedDelay INTEGER NOT NULL,
   CallsAnswered INTEGER NOT NULL,
   CallsAnsweredAftThreshold INTEGER NOT NULL,
   CallsAnsweredDelay INTEGER NOT NULL,
   CallsAnsweredDelayAtSkillset INTEGER NOT NULL,
   CallsConferencedIn INTEGER NOT NULL,
   CallsConferencedOut INTEGER NOT NULL,
   CallsGivenBroadcast INTEGER NOT NULL,
   CallsGivenDefault INTEGER NOT NULL,
   CallsGivenForceBusy INTEGER NOT NULL,
   CallsGivenForceDisconnect INTEGER NOT NULL,
   CallsGivenForceOverflow INTEGER NOT NULL,
   CallsGivenHostLookup INTEGER NOT NULL,
   CallsGivenIVR INTEGER NOT NULL,
   CallsGivenMusic INTEGER NOT NULL,
   CallsGivenNACD INTEGER NOT NULL,
   CallsGivenRAN INTEGER NOT NULL,
   CallsGivenRouteTo INTEGER NOT NULL,
   CallsNACDOut INTEGER NOT NULL,
   CallsOffered INTEGER NOT NULL,
   CallsTransferredIn INTEGER NOT NULL,
   CallsTransferredOut INTEGER NOT NULL,
   IVRAbandoned INTEGER NOT NULL,
   IVRTerminated INTEGER NOT NULL,
   IVRTransferred INTEGER NOT NULL,
   MaxCallsAbandonedDelay INTEGER NOT NULL,
   MaxCallsAnsDelay INTEGER NOT NULL,
   MaxCallsAnsDelayAtSkillset INTEGER NOT NULL,
   MaxNetOutCallsAbandonedDelay INTEGER NOT NULL,
   MaxNetOutCallsAnsweredDelay INTEGER NOT NULL,
   NetOutCalls INTEGER NOT NULL,
   NetOutCallsAbandoned INTEGER NOT NULL,
   NetOutCallsAbandonedDelay INTEGER NOT NULL,
   NetOutCallsAnswered INTEGER NOT NULL,
   NetOutCallsAnsweredDelay INTEGER NOT NULL,
   NetOutCallsReachNonISDN INTEGER NOT NULL,
   TimeBeforeDefault INTEGER NOT NULL,
   TimeBeforeForceBusy INTEGER NOT NULL,
   TimeBeforeForceDisconnect INTEGER NOT NULL,
   TimeBeforeForceOverflow INTEGER NOT NULL,
   TimeBeforeInterflow INTEGER NOT NULL,
   TimeBeforeIVRTransferred INTEGER NOT NULL,
   TimeBeforeNACDOut INTEGER NOT NULL,
   TimeBeforeNetOut INTEGER NOT NULL,
   TimeBeforeReachNonISDN INTEGER NOT NULL,
   TimeBeforeRouteTo INTEGER NOT NULL,
   PostCallProcessingTime INTEGER NOT NULL,
   TalkTime INTEGER NOT NULL,
   WaitTime INTEGER NOT NULL,
   DNOutExtCallsTalkTime INTEGER NOT NULL,
   DNOutIntCallsTalkTime INTEGER NOT NULL,
   AbdDelay2 INTEGER NOT NULL,
   AbdDelay4 INTEGER NOT NULL,
   AbdDelay6 INTEGER NOT NULL,
   AbdDelay8 INTEGER NOT NULL,
   AbdDelay10 INTEGER NOT NULL,
   AbdDelay12 INTEGER NOT NULL,
   AbdDelay14 INTEGER NOT NULL,
   AbdDelay16 INTEGER NOT NULL,
   AbdDelay18 INTEGER NOT NULL,
   AbdDelay20 INTEGER NOT NULL,
   AbdDelay22 INTEGER NOT NULL,
   AbdDelay24 INTEGER NOT NULL,
   AbdDelay26 INTEGER NOT NULL,
   AbdDelay28 INTEGER NOT NULL,
   AbdDelay30 INTEGER NOT NULL,
   AbdDelay32 INTEGER NOT NULL,
   AbdDelay34 INTEGER NOT NULL,
   AbdDelay36 INTEGER NOT NULL,
   AbdDelay38 INTEGER NOT NULL,
   AbdDelay40 INTEGER NOT NULL,
   AbdDelay42 INTEGER NOT NULL,
   AbdDelay44 INTEGER NOT NULL,
   AbdDelay46 INTEGER NOT NULL,
   AbdDelay48 INTEGER NOT NULL,
   AbdDelay50 INTEGER NOT NULL,
   AbdDelay52 INTEGER NOT NULL,
   AbdDelay54 INTEGER NOT NULL,
   AbdDelay56 INTEGER NOT NULL,
   AbdDelay58 INTEGER NOT NULL,
   AbdDelay60 INTEGER NOT NULL,
   AbdDelay70 INTEGER NOT NULL,
   AbdDelay80 INTEGER NOT NULL,
   AbdDelay90 INTEGER NOT NULL,
   AbdDelay100 INTEGER NOT NULL,
   AbdDelay110 INTEGER NOT NULL,
   AbdDelay120 INTEGER NOT NULL,
   AbdDelay130 INTEGER NOT NULL,
   AbdDelay140 INTEGER NOT NULL,
   AbdDelay150 INTEGER NOT NULL,
   AbdDelay160 INTEGER NOT NULL,
   AbdDelay170 INTEGER NOT NULL,
   AbdDelay180 INTEGER NOT NULL,
   AbdDelay190 INTEGER NOT NULL,
   AbdDelay200 INTEGER NOT NULL,
   AbdDelay210 INTEGER NOT NULL,
   AbdDelay220 INTEGER NOT NULL,
   AbdDelay230 INTEGER NOT NULL,
   AbdDelay240 INTEGER NOT NULL,
   AbdDelay250 INTEGER NOT NULL,
   AbdDelay260 INTEGER NOT NULL,
   AbdDelay270 INTEGER NOT NULL,
   AbdDelay280 INTEGER NOT NULL,
   AbdDelay290 INTEGER NOT NULL,
   AbdDelay300 INTEGER NOT NULL,
   AbdDelay360 INTEGER NOT NULL,
   AbdDelay420 INTEGER NOT NULL,
   AbdDelay480 INTEGER NOT NULL,
   AbdDelay540 INTEGER NOT NULL,
   AbdDelay600 INTEGER NOT NULL,
   AbdDelayBeyond INTEGER NOT NULL,
   AnsDelay2 INTEGER NOT NULL,
   AnsDelay4 INTEGER NOT NULL,
   AnsDelay6 INTEGER NOT NULL,
   AnsDelay8 INTEGER NOT NULL,
   AnsDelay10 INTEGER NOT NULL,
   AnsDelay12 INTEGER NOT NULL,
   AnsDelay14 INTEGER NOT NULL,
   AnsDelay16 INTEGER NOT NULL,
   AnsDelay18 INTEGER NOT NULL,
   AnsDelay20 INTEGER NOT NULL,
   AnsDelay22 INTEGER NOT NULL,
   AnsDelay24 INTEGER NOT NULL,
   AnsDelay26 INTEGER NOT NULL,
   AnsDelay28 INTEGER NOT NULL,
   AnsDelay30 INTEGER NOT NULL,
   AnsDelay32 INTEGER NOT NULL,
   AnsDelay34 INTEGER NOT NULL,
   AnsDelay36 INTEGER NOT NULL,
   AnsDelay38 INTEGER NOT NULL,
   AnsDelay40 INTEGER NOT NULL,
   AnsDelay42 INTEGER NOT NULL,
   AnsDelay44 INTEGER NOT NULL,
   AnsDelay46 INTEGER NOT NULL,
   AnsDelay48 INTEGER NOT NULL,
   AnsDelay50 INTEGER NOT NULL,
   AnsDelay52 INTEGER NOT NULL,
   AnsDelay54 INTEGER NOT NULL,
   AnsDelay56 INTEGER NOT NULL,
   AnsDelay58 INTEGER NOT NULL,
   AnsDelay60 INTEGER NOT NULL,
   AnsDelay70 INTEGER NOT NULL,
   AnsDelay80 INTEGER NOT NULL,
   AnsDelay90 INTEGER NOT NULL,
   AnsDelay100 INTEGER NOT NULL,
   AnsDelay110 INTEGER NOT NULL,
   AnsDelay120 INTEGER NOT NULL,
   AnsDelay130 INTEGER NOT NULL,
   AnsDelay140 INTEGER NOT NULL,
   AnsDelay150 INTEGER NOT NULL,
   AnsDelay160 INTEGER NOT NULL,
   AnsDelay170 INTEGER NOT NULL,
   AnsDelay180 INTEGER NOT NULL,
   AnsDelay190 INTEGER NOT NULL,
   AnsDelay200 INTEGER NOT NULL,
   AnsDelay210 INTEGER NOT NULL,
   AnsDelay220 INTEGER NOT NULL,
   AnsDelay230 INTEGER NOT NULL,
   AnsDelay240 INTEGER NOT NULL,
   AnsDelay250 INTEGER NOT NULL,
   AnsDelay260 INTEGER NOT NULL,
   AnsDelay270 INTEGER NOT NULL,
   AnsDelay280 INTEGER NOT NULL,
   AnsDelay290 INTEGER NOT NULL,
   AnsDelay300 INTEGER NOT NULL,
   AnsDelay360 INTEGER NOT NULL,
   AnsDelay420 INTEGER NOT NULL,
   AnsDelay480 INTEGER NOT NULL,
   AnsDelay540 INTEGER NOT NULL,
   AnsDelay600 INTEGER NOT NULL,
   AnsDelayBeyond INTEGER NOT NULL,
   "Time" VARCHAR(5),
   SiteID INTEGER NOT NULL,
   Site VARCHAR(30) NOT NULL,
   ContactType VARCHAR(30)
)
;

CREATE TABLE "dbo"."Skillset"
(
   SkillsetID INTEGER NOT NULL,
   Skillset VARCHAR(30) NOT NULL,
   Comment VARCHAR(127),
   IsNetworked VARCHAR(255),
   ActivityCode VARCHAR(32) NOT NULL,
   NightServiceType SMALLINT,
   CallSourcePreference SMALLINT,
   CallAgePreference SMALLINT,
   CallRequestQueueSize INTEGER,
   CallRequestQueueSizeThreshold INTEGER,
   NetworkSkillsetID INTEGER,
   NetworkSkillsetName VARCHAR(30),
   NetworkSkillsetComment VARCHAR(127),
   UseBestNode VARCHAR(255),
   IdleAgentsPriority SMALLINT,
   UseRoundRobin VARCHAR(255),
   ServiceLevelThreshold INTEGER,
   MinShortCallDelay INTEGER,
   TemplateID INTEGER NOT NULL,
   DN VARCHAR(10),
   ContactName VARCHAR(30) NOT NULL,
   TargetServiceLevel SMALLINT,
   ServiceLevelRouting SMALLINT,
   DynamicAssignment SMALLINT
)
;


CREATE TABLE "dbo"."SkillsetByAgent"
(
   SkillsetID INTEGER NOT NULL,
   UserID VARCHAR(32) NOT NULL,
   SkillsetState VARCHAR(80) NOT NULL,
   Priority SMALLINT
)
;
