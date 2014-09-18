create table CORP_ETL_MANAGE_WORK 
 (CEMW_ID number, 
	ASF_CANCEL_WORK varchar2(1) default 'N', 
	ASF_COMPLETE_WORK varchar2(1) default 'N', 
	AGE_IN_BUSINESS_DAYS number default 0, 
	AGE_IN_CALENDAR_DAYS number default 0, 
	CANCEL_WORK_DATE date, 
	CANCEL_WORK_FLAG varchar2(1) default 'N', 
	COMPLETE_DATE date, 
	COMPLETE_FLAG varchar2(1) default 'N', 
	CREATE_DATE date, 
	CREATED_BY_NAME varchar2(100), 
	ESCALATED_FLAG varchar2(1) default 'N', 
	ESCALATED_TO_NAME varchar2(100), 
	FORWARDED_BY_NAME varchar2(100), 
	FORWARDED_FLAG varchar2(1) default 'N', 
	GROUP_NAME varchar2(100), 
	GROUP_PARENT_NAME varchar2(100), 
	GROUP_SUPERVISOR_NAME varchar2(100), 
	JEOPARDY_FLAG varchar2(1) default 'N', 
	LAST_UPDATE_BY_NAME varchar2(100), 
	LAST_UPDATE_DATE date, 
	OWNER_NAME varchar2(100), 
	SLA_DAYS number, 
	SLA_DAYS_TYPE varchar2(1), 
	SLA_JEOPARDY_DAYS number, 
	SLA_TARGET_DAYS number, 
	SOURCE_REFERENCE_ID number(*,0), 
	SOURCE_REFERENCE_TYPE varchar2(30), 
	STATUS_AGE_IN_BUS_DAYS number default 0, 
	STATUS_AGE_IN_CAL_DAYS number default 0, 
	STATUS_DATE date, 
	TASK_ID number, 
	TASK_STATUS varchar2(50), 
	TASK_TYPE varchar2(100), 
	TEAM_NAME varchar2(100), 
	TEAM_PARENT_NAME varchar2(100), 
	TEAM_SUPERVISOR_NAME varchar2(100), 
	TIMELINESS_STATUS varchar2(20) default 'Not Complete', 
	UNIT_OF_WORK varchar2(30), 
	STG_EXTRACT_DATE DATE default SYSdate, 
	STG_LAST_UPDATE_DATE DATE default SYSdate, 
	STAGE_DONE_DATE date, 
	DATE_TODAY DATE
 );

comment on column CORP_ETL_MANAGE_WORK.CEMW_ID is 'sequence';
comment on column CORP_ETL_MANAGE_WORK.ASF_CANCEL_WORK is 'Indicates if the Cancel Work step in the business process has been completed';
comment on column CORP_ETL_MANAGE_WORK.ASF_COMPLETE_WORK is 'Indicates if the Complete Work step in the business process has been completed.';
comment on column CORP_ETL_MANAGE_WORK.AGE_IN_BUSINESS_DAYS is 'Number of days from the Create Date to the Complete Date, or to the Current Date for tasks that are not yet complete, excluding weekends and project holidays.';
comment on column CORP_ETL_MANAGE_WORK.AGE_IN_CALENDAR_DAYS is 'Number of days from the Creates Date to the Complete Date, or to the current date for tasks that are not yet complete.';
comment on column CORP_ETL_MANAGE_WORK.CANCEL_WORK_DATE is 'Indicates the date the ETL discovered that the task was no longer available to be worked.';
comment on column CORP_ETL_MANAGE_WORK.CANCEL_WORK_FLAG is 'Indicates if the task is no longer available to be worked (deleted or disregarded).';
comment on column CORP_ETL_MANAGE_WORK.COMPLETE_DATE is 'Date the task was completed (worked) in MAXe';
comment on column CORP_ETL_MANAGE_WORK.COMPLETE_FLAG is 'Indicates if the task was completed in MAXe';
comment on column CORP_ETL_MANAGE_WORK.CREATE_DATE is 'Date the task was created in MAXe';
comment on column CORP_ETL_MANAGE_WORK.CREATED_BY_NAME is 'Name of the staff member that created the task in MAXe.';
comment on column CORP_ETL_MANAGE_WORK.ESCALATED_FLAG is 'Indicates if the task is currently escalated.';
comment on column CORP_ETL_MANAGE_WORK.ESCALATED_TO_NAME is 'Name of the staff member in MAXe to whom the task has been escalated.';
comment on column CORP_ETL_MANAGE_WORK.FORWARDED_BY_NAME is 'Name of the staff member in MAXe to whom the task has been escalated.';
comment on column CORP_ETL_MANAGE_WORK.FORWARDED_FLAG is 'Indicates if the task was forwarded to the current location.';
comment on column CORP_ETL_MANAGE_WORK.GROUP_NAME is 'Name of the MAXe Group to which this task is assigned.';
comment on column CORP_ETL_MANAGE_WORK.GROUP_PARENT_NAME is 'Name of the MAXe Group identified as the parent group of the MAXe Group to which this task is assigned.';
comment on column CORP_ETL_MANAGE_WORK.GROUP_SUPERVISOR_NAME is 'Name of the staff member in MAXe identified as the supervisor of the group to which this task is assigned.';
comment on column CORP_ETL_MANAGE_WORK.JEOPARDY_FLAG is 'Indicates if the task is in jeopardy based on the SLA Days Type and SLA Jeopardy Days.';
comment on column CORP_ETL_MANAGE_WORK.LAST_UPDATE_BY_NAME is 'Name of the staff member that last claimed, modified, worked, escalated, or forwarded the task in MAXe.';
comment on column CORP_ETL_MANAGE_WORK.LAST_UPDATE_DATE is 'Date the task was last updated in MAXe';
comment on column CORP_ETL_MANAGE_WORK.OWNER_NAME is 'Name of the staff member that owns the task in MAXe.';
comment on column CORP_ETL_MANAGE_WORK.SLA_DAYS is 'Age at which time the task is determined to be untimely. If no SLA applies then this value is null.';
comment on column CORP_ETL_MANAGE_WORK.SLA_DAYS_TYPE is 'Indicates if the SLA is based on Business Days or Calendar Days. If no SLA applies then this value is null.';
comment on column CORP_ETL_MANAGE_WORK.SLA_JEOPARDY_DAYS is 'Age at which time the task is determined to be in Jeopardy. If no SLA applies then this value is null.';
comment on column CORP_ETL_MANAGE_WORK.SLA_TARGET_DAYS is 'Age at which time the task is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null.';
comment on column CORP_ETL_MANAGE_WORK.SOURCE_REFERENCE_ID is 'Unique identifier for the item to which this task is associated (Application ID, Document ID, etc). This is useful for looking up more details in the source system.';
comment on column CORP_ETL_MANAGE_WORK.SOURCE_REFERENCE_TYPE is 'Indicates the type of Source Reference ID that is being provided.';
comment on column CORP_ETL_MANAGE_WORK.STATUS_AGE_IN_BUS_DAYS is 'Number of days from the Status Date to the current date excluding weekends and project holidays for tasks that are not yet complete. Once a task is complete, this value should be 0.';
comment on column CORP_ETL_MANAGE_WORK.STATUS_AGE_IN_CAL_DAYS is 'Number of days from the Status Date to the current date for tasks that are not yet complete. Once a task is complete, this value should be 0.';
comment on column CORP_ETL_MANAGE_WORK.STATUS_DATE is 'Date the Task Status was set in MAXe';
comment on column CORP_ETL_MANAGE_WORK.TASK_ID is 'Unique identifier for the task in MAXe';
comment on column CORP_ETL_MANAGE_WORK.TASK_STATUS is 'Current status of the task in MAXe indicating if the task is claimed or unclaimed.';
comment on column CORP_ETL_MANAGE_WORK.TASK_TYPE is 'Indicates the type of work.';
comment on column CORP_ETL_MANAGE_WORK.TEAM_NAME is 'Name of the MAXe Group identified as the team to which this task is assigned';
comment on column CORP_ETL_MANAGE_WORK.TEAM_PARENT_NAME is 'Name of the MAXe Group identified as the parent group of the MAXe Group identified to which this task is assigned.';
comment on column CORP_ETL_MANAGE_WORK.TEAM_SUPERVISOR_NAME is 'Name of the staff member in MAXe identified as the supervisor of the team to which this task is assigned.';
comment on column CORP_ETL_MANAGE_WORK.TIMELINESS_STATUS is 'Indicates if the task was processed timely or untimely based on the SLA Days Type, SLA Days, and Age of task.';
comment on column CORP_ETL_MANAGE_WORK.UNIT_OF_WORK is 'Indicates the Production Planning Unit of Work to which this task is assigned.';
comment on column CORP_ETL_MANAGE_WORK.STG_EXTRACT_DATE is 'On INSERT only, sets the current system date that the record was created.';
comment on column CORP_ETL_MANAGE_WORK.STG_LAST_UPDATE_DATE is 'On INSERT or UPdate, sets the current system date that the record was created or updated.';
comment on column CORP_ETL_MANAGE_WORK.STAGE_DONE_DATE is 'Indicates the date ETL processing stopped for this record.';

create unique index CORP_ETL_MANAGE_WORK_IX1 on CORP_ETL_MANAGE_WORK (TASK_ID);
create unique index SYS_C0010375 on CORP_ETL_MANAGE_WORK (CEMW_ID);

alter table CORP_ETL_MANAGE_WORK modify (ASF_CANCEL_WORK not null enable);
alter table CORP_ETL_MANAGE_WORK modify (ASF_COMPLETE_WORK not null enable);
alter table CORP_ETL_MANAGE_WORK modify (AGE_IN_BUSINESS_DAYS not null enable);
alter table CORP_ETL_MANAGE_WORK modify (AGE_IN_CALENDAR_DAYS not null enable);
alter table CORP_ETL_MANAGE_WORK modify (CANCEL_WORK_FLAG not null enable);
alter table CORP_ETL_MANAGE_WORK modify (COMPLETE_FLAG not null enable);
alter table CORP_ETL_MANAGE_WORK modify (CREATE_DATE not null enable);
alter table CORP_ETL_MANAGE_WORK modify (ESCALATED_FLAG not null enable);
alter table CORP_ETL_MANAGE_WORK modify (FORWARDED_FLAG not null enable);
alter table CORP_ETL_MANAGE_WORK modify (JEOPARDY_FLAG not null enable);
alter table CORP_ETL_MANAGE_WORK modify (LAST_UPDATE_DATE not null enable);
alter table CORP_ETL_MANAGE_WORK modify (STATUS_AGE_IN_BUS_DAYS not null enable);
alter table CORP_ETL_MANAGE_WORK modify (STATUS_AGE_IN_CAL_DAYS not null enable);
alter table CORP_ETL_MANAGE_WORK modify (STATUS_DATE not null enable);
alter table CORP_ETL_MANAGE_WORK modify (TASK_ID not null enable);
alter table CORP_ETL_MANAGE_WORK modify (TASK_STATUS not null enable);
alter table CORP_ETL_MANAGE_WORK modify (TASK_TYPE not null enable);
alter table CORP_ETL_MANAGE_WORK modify (TIMELINESS_STATUS not null enable);
alter table CORP_ETL_MANAGE_WORK modify (STG_EXTRACT_DATE not null enable);
alter table CORP_ETL_MANAGE_WORK modify (STG_LAST_UPDATE_DATE not null enable);
alter table CORP_ETL_MANAGE_WORK add constraint CHECK_SOURCE_REFERENCE_TYPE check (SOURCE_REFERENCE_TYPE in ('Application ID','Document ID','Document Set ID','Image ID','Case ID','Client ID','Call ID','Incident ID',null)) enable;
alter table CORP_ETL_MANAGE_WORK add constraint CHECK_SLA_DAYS_TYPE check (SLA_DAYS_TYPE                 in ('B','C',null)) enable;
alter table CORP_ETL_MANAGE_WORK add constraint CHECK_ASF_CANCEL_WORK check (ASF_CANCEL_WORK             in ('N','Y')) enable;
alter table CORP_ETL_MANAGE_WORK add constraint CHECK_ASF_COMPLETE_WORK check (ASF_COMPLETE_WORK         in ('N','Y')) enable;
alter table CORP_ETL_MANAGE_WORK add constraint CHECK_CANCEL_WORK_FLAG check (CANCEL_WORK_FLAG           in ('N','Y')) enable;
alter table CORP_ETL_MANAGE_WORK add constraint CHECK_COMPLETE_FLAG check (COMPLETE_FLAG                 in ('N','Y')) enable;
alter table CORP_ETL_MANAGE_WORK add constraint CHECK_ESCALATED_FLAG check (ESCALATED_FLAG               in ('N','Y')) enable;
alter table CORP_ETL_MANAGE_WORK add constraint CHECK_FORWARDED_FLAG check (FORWARDED_FLAG               in ('N','Y')) enable;
alter table CORP_ETL_MANAGE_WORK add constraint CHECK_JEOPARDY_FLAG check (JEOPARDY_FLAG                 in ('N','Y')) enable;
alter table CORP_ETL_MANAGE_WORK add constraint CHECK_TIMELINESS_STATUS check (TIMELINESS_STATUS         in ('Timely','Untimely','Not Required','Not Complete')) enable;
alter table CORP_ETL_MANAGE_WORK add primary key (CEMW_ID) enable;