use HWSInternal;
go


/*
select 'grant select on [' + TABLE_SCHEMA + '].[' + TABLE_NAME + '] to MAXDAT_READ_ONLY;' 
from INFORMATION_SCHEMA.TABLES 
order by 
  TABLE_SCHEMA asc, 
  TABLE_NAME asc;
*/
grant select on [Appointment].[Appointment] to MAXDAT_READ_ONLY;
grant select on [Appointment].[AppointmentDocument] to MAXDAT_READ_ONLY;
grant select on [Appointment].[AppointmentStatus] to MAXDAT_READ_ONLY;
grant select on [Appointment].[AppointmentType] to MAXDAT_READ_ONLY;
grant select on [Assessment].[Answer] to MAXDAT_READ_ONLY;
grant select on [Assessment].[AnswerLookup] to MAXDAT_READ_ONLY;
grant select on [Assessment].[Assessment] to MAXDAT_READ_ONLY;
grant select on [Assessment].[AssessmentCompletion] to MAXDAT_READ_ONLY;
grant select on [Assessment].[AssessmentObstacle] to MAXDAT_READ_ONLY;
grant select on [Assessment].[AssessmentQuestionnaire] to MAXDAT_READ_ONLY;
grant select on [Assessment].[AssessmentQuestionnaireAnswer] to MAXDAT_READ_ONLY;
grant select on [Assessment].[AssessmentStatus] to MAXDAT_READ_ONLY;
grant select on [Assessment].[FitStatus] to MAXDAT_READ_ONLY;
grant select on [Assessment].[Obstacle] to MAXDAT_READ_ONLY;
grant select on [Assessment].[ObstacleType] to MAXDAT_READ_ONLY;
grant select on [Assessment].[Questionnaire] to MAXDAT_READ_ONLY;
grant select on [Assessment].[QuestionnaireAnswer] to MAXDAT_READ_ONLY;
grant select on [Assessment].[QuestionnaireQuestion] to MAXDAT_READ_ONLY;
grant select on [Assessment].[QuestionnaireQuestionAnswer] to MAXDAT_READ_ONLY;
grant select on [Assessment].[QuestionnaireTotalBand] to MAXDAT_READ_ONLY;
grant select on [Assessment].[QuestionTemplate] to MAXDAT_READ_ONLY;
grant select on [Assessment].[Recommendation] to MAXDAT_READ_ONLY;
grant select on [Assessment].[ReturnToWorkObstacle] to MAXDAT_READ_ONLY;
grant select on [Assessment].[ReturnToWorkOption] to MAXDAT_READ_ONLY;
grant select on [Assessment].[ReturnToWorkPlan] to MAXDAT_READ_ONLY;
grant select on [Assessment].[ReturnToWorkPlanIntervention] to MAXDAT_READ_ONLY;
grant select on [Assessment].[ReturnToWorkPlanOption] to MAXDAT_READ_ONLY;
grant select on [Assessment].[ReturnToWorkPlanOutcome] to MAXDAT_READ_ONLY;
grant select on [Assessment].[ReturnToWorkPlanSignposting] to MAXDAT_READ_ONLY;
grant select on [Assessment].[Section] to MAXDAT_READ_ONLY;
grant select on [Assessment].[SectionQuestion] to MAXDAT_READ_ONLY;
grant select on [Assessment].[Signpost] to MAXDAT_READ_ONLY;
grant select on [Assessment].[ViewCounter] to MAXDAT_READ_ONLY;
grant select on [Assessment].[WorkplaceAdjustment] to MAXDAT_READ_ONLY;
grant select on [Audit].[AuditAction] to MAXDAT_READ_ONLY;
grant select on [Audit].[AuditLog] to MAXDAT_READ_ONLY;
grant select on [Audit].[AuditProperty] to MAXDAT_READ_ONLY;
grant select on [Audit].[StatusHistory] to MAXDAT_READ_ONLY;
grant select on [Audit].[WorkLog] to MAXDAT_READ_ONLY;
grant select on [Authentication].[NetworkDoctorMembership] to MAXDAT_READ_ONLY;
grant select on [Case].[Case] to MAXDAT_READ_ONLY;
grant select on [Case].[CaseCTATeam] to MAXDAT_READ_ONLY;
grant select on [Case].[CaseHPTeam] to MAXDAT_READ_ONLY;
grant select on [Case].[CaseNote] to MAXDAT_READ_ONLY;
grant select on [Case].[CaseNotesFileType] to MAXDAT_READ_ONLY;
grant select on [Case].[CaseNoteType] to MAXDAT_READ_ONLY;
grant select on [Case].[CaseStatus] to MAXDAT_READ_ONLY;
grant select on [Complaint].[Complaint] to MAXDAT_READ_ONLY;
grant select on [Complaint].[ComplaintAction] to MAXDAT_READ_ONLY;
grant select on [Complaint].[ComplaintCase] to MAXDAT_READ_ONLY;
grant select on [Complaint].[ComplaintDocument] to MAXDAT_READ_ONLY;
grant select on [Complaint].[ComplaintNote] to MAXDAT_READ_ONLY;
grant select on [dbo].[AuditLog] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblBookmarks] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblButtonGroups] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblClinic2OHP] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblClinic2Specialisation] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblClinician2Specialisation] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblCountries] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblDocumentCategories] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblDr2Specialisation] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblInvuDocuments] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblInvuIndexExceptions] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblNetworkOHPs] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblOHPClinics] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblOHQualifications] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblScannedDocumentTypes] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblSpecialisations] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblTemplateButtons] to MAXDAT_READ_ONLY;
grant select on [dbo].[tblTemplates] to MAXDAT_READ_ONLY;
grant select on [dbo].[vwAssessmentBookmarkData] to MAXDAT_READ_ONLY;
grant select on [dbo].[vwClinic2OHPDetail] to MAXDAT_READ_ONLY;
grant select on [INVU].[DocumentType] to MAXDAT_READ_ONLY;
grant select on [Logging].[DatabaseMeasure] to MAXDAT_READ_ONLY;
grant select on [Logging].[ErrorLog] to MAXDAT_READ_ONLY;
grant select on [Logging].[FunctionTiming] to MAXDAT_READ_ONLY;
grant select on [Logging].[MSMQMeasure] to MAXDAT_READ_ONLY;
grant select on [Lookup].[CaseOnHoldReason] to MAXDAT_READ_ONLY;
grant select on [Lookup].[DiagnosticCode] to MAXDAT_READ_ONLY;
grant select on [Lookup].[DischargeReason] to MAXDAT_READ_ONLY;
grant select on [Lookup].[HardOfHearingPreferrences] to MAXDAT_READ_ONLY;
grant select on [Lookup].[Lookup] to MAXDAT_READ_ONLY;
grant select on [Lookup].[LookupItem] to MAXDAT_READ_ONLY;
grant select on [Referral].[Employee] to MAXDAT_READ_ONLY;
grant select on [Referral].[EmployeeDisability] to MAXDAT_READ_ONLY;
grant select on [Referral].[Employer] to MAXDAT_READ_ONLY;
grant select on [Referral].[EmployerService] to MAXDAT_READ_ONLY;
grant select on [Referral].[GeneralPractitioner] to MAXDAT_READ_ONLY;
grant select on [Referral].[Referral] to MAXDAT_READ_ONLY;
grant select on [Referral].[ReferralEligibility] to MAXDAT_READ_ONLY;
grant select on [Resources].[CaseViewHistory] to MAXDAT_READ_ONLY;
grant select on [Resources].[Client] to MAXDAT_READ_ONLY;
grant select on [Resources].[CTATeam] to MAXDAT_READ_ONLY;
grant select on [Resources].[Resource] to MAXDAT_READ_ONLY;
grant select on [Resources].[ResourceSkill] to MAXDAT_READ_ONLY;
grant select on [Resources].[Skill] to MAXDAT_READ_ONLY;
grant select on [Template].[GenericTemplate] to MAXDAT_READ_ONLY;
grant select on [Template].[GenericTemplateText] to MAXDAT_READ_ONLY;
grant select on [Template].[SMSTemplate] to MAXDAT_READ_ONLY;
grant select on [Assessment].[Assessment] to MAXDAT_READ_ONLY;
go


/*
select 'grant select on [' + s.NAME + '].[' + v.NAME + '] to MAXDAT_READ_ONLY;' 
from SYS.VIEWS v 
inner join SYS.SCHEMAs s on s.SCHEMA_ID = v.SCHEMA_ID
order by 
  s.NAME asc, 
  v.NAME asc;
*/
grant select on [dbo].[vwAssessmentBookmarkData] to MAXDAT_READ_ONLY;
grant select on [dbo].[vwClinic2OHPDetail] to MAXDAT_READ_ONLY;
go


/*
select 'grant select on [' + SCHEMA_NAME(SCHEMA_ID) + '].[' + NAME + '] to MAXDAT_READ_ONLY;' 
from SYS.OBJECTS
where TYPE_DESC = 'SQL_TABLE_VALUED_FUNCTION'
order by 
  SCHEMA_NAME(SCHEMA_ID) asc, 
  NAME asc;
*/
grant select on [dbo].[Split] to MAXDAT_READ_ONLY;
go


/*
select 'grant execute on [' + SCHEMA_NAME(SCHEMA_ID) + '].[' + NAME + '] to MAXDAT_READ_ONLY;' 
from SYS.OBJECTS
where TYPE_DESC = 'SQL_SCALAR_FUNCTION'
order by 
  SCHEMA_NAME(SCHEMA_ID) asc, 
  NAME asc;
*/
grant execute on [dbo].[udfComputeDistance] to MAXDAT_READ_ONLY;
grant execute on [dbo].[udfPreferredClinicDoctor] to MAXDAT_READ_ONLY;
go
