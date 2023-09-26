-- Clear2Work


-- CLEAR2WORK_BADGE
create table CLEAR2WORK_BADGE
  (
   DATE_TIME_RAW varchar2(24) not null,
   EVENT_USER_RAW varchar2(120) not null,
   SITE varchar2(100) not null,
   EVENT_USER varchar2(100),
   ACTIVITY_DATE date,
   FIRST_NAME varchar2(50),
   LAST_NAME varchar2(50),
   EMPLOYEE_PSEUDO_KEY varchar2(12),
   PROCESSED_FLAG varchar(1) default 'N' not null check (PROCESSED_FLAG in ('N','Y')),
   constraint CLEAR2WORK_BADGE_PK primary key (DATE_TIME_RAW,EVENT_USER_RAW,SITE)
  );

create bitmap index CLEAR2WORK_BADGE_PROCESSED_FLAG on CLEAR2WORK_BADGE (PROCESSED_FLAG);

grant select on CLEAR2WORK_BADGE to MOTS_READ_ONLY;

create or replace view CLEAR2WORK_BADGE_SV as
select
  ACTIVITY_DATE,
  EMPLOYEE_PSEUDO_KEY
from CLEAR2WORK_BADGE;

grant select on CLEAR2WORK_BADGE_SV to MOTS_READ_ONLY;


-- CLEAR2WORK_JOB_CONFIG
drop table CLEAR2WORK_JOB_CONFIG ;

create table CLEAR2WORK_JOB_CONFIG 
  (ENABLED_FLAG        char(1) default 'Y' not null,
   DEBUG_FLAG          char(1) default 'N' not null,
   PRESERVE_FILES_FLAG char(1) default 'N' not null,
   INPUT_FILE_DIR      varchar2(4000 byte) default 'INVALID_NOT_SET_YET' not null,
   CREATE_DATE         date,
   CREATED_BY          varchar2(50 byte),                                   
   LAST_MODIFIED_DATE  date,
   UPDATED_BY          varchar2(50 byte)
  );

alter table CLEAR2WORK_JOB_CONFIG add constraint CLEAR2WORK_JOB_CONFIG_PK primary key (INPUT_FILE_DIR);
alter table CLEAR2WORK_JOB_CONFIG add constraint C2W_ENABLED_FLAG_CHECK check (ENABLED_FLAG in ('Y','N'));
alter table CLEAR2WORK_JOB_CONFIG add constraint C2W_DEBUG_FLAG_CHECK check (DEBUG_FLAG in ('Y','N'));
alter table CLEAR2WORK_JOB_CONFIG add constraint C2W_PRESERVE_FILES_FLAG_CHECK check (PRESERVE_FILES_FLAG in ('Y','N'));

insert into CLEAR2WORK_JOB_CONFIG (INPUT_FILE_DIR) values ('/u01/maximus/maxdat/Clear2Work/Inbound');
commit;

grant select on CLEAR2WORK_JOB_CONFIG to MOTS_READ_ONLY;

create or replace view CLEAR2WORK_JOB_CONFIG_SV as
select * from CLEAR2WORK_JOB_CONFIG;

grant select on CLEAR2WORK_JOB_CONFIG_SV to MOTS_READ_ONLY;

create or replace trigger BIU_C2W_JOB_CONFIG
  before insert or update on CLEAR2WORK_JOB_CONFIG 
  for each row 
begin
  if INSERTING then     
	   :new.CREATE_DATE := sysdate;  
	   :new.CREATED_BY := user;
  end if;
  :new.UPDATED_BY := user;
  :new.LAST_MODIFIED_DATE := sysdate;
end; 
/


-- CLEAR2WORK_JOB_RUN
create table CLEAR2WORK_JOB_RUN
  (JOB_RUN_ID          number not null,
   ENABLED_FLAG        char(1) default 'Y' not null,
   DEBUG_FLAG          char(1) default 'N' not null,
   PRESERVE_FILES_FLAG char(1) default 'N' not null,
   JOB_RUN_FILE_SUFFIX varchar2(19 byte) not null,
   RUN_BY              varchar2(32 byte) not null,
   RUN_STATUS          varchar2(11 byte) not null,
   START_RUN_DATE      date not null,
   END_RUN_DATE        date
  );

alter table CLEAR2WORK_JOB_RUN add constraint CLEAR2WORK_JOB_RUN_PK primary key (JOB_RUN_ID);
alter table CLEAR2WORK_JOB_RUN add constraint C2WJR_ENABLED_FLAG_CHECK check (ENABLED_FLAG in ('Y','N'));
alter table CLEAR2WORK_JOB_RUN add constraint C2WJR_DEBUG_FLAG_CHECK check (DEBUG_FLAG in ('Y','N'));
alter table CLEAR2WORK_JOB_RUN add constraint C2WJR_PRESERVE_FILES_FLAG_CHECK check (PRESERVE_FILES_FLAG in ('Y','N'));
alter table CLEAR2WORK_JOB_RUN add constraint C2WJR_RUN_STATUS_CHECK check (RUN_STATUS in ('COMPLETED','FAILED','NOT_ENABLED','PROCESSING'));

grant select on CLEAR2WORK_JOB_RUN to MOTS_READ_ONLY;

create or replace view CLEAR2WORK_JOB_RUN_SV as
select * from CLEAR2WORK_JOB_RUN with read only;

grant select on CLEAR2WORK_JOB_RUN_SV to MOTS_READ_ONLY;

create sequence SEQ_CLEAR2WORK_JOB_RUN_ID start with 1 increment by 1 maxvalue 9999999999999999999 minvalue 1 cache 20;

grant select on SEQ_CLEAR2WORK_JOB_RUN_ID to MOTS_READ_ONLY;


-- CLEAR2WORK_SITE
create table CLEAR2WORK_SITE
  (
   SITE_NAME varchar2(100) not null,
   CLEAR_SITE varchar2(100),
   BRIVO_SITE varchar2(100),
   SITE_GROUP varchar2(20),
   DIVISION varchar2(20),
   constraint CLEAR2WORK_SITE_PK primary key (SITE_NAME)
  );
  
grant select on CLEAR2WORK_SITE to MOTS_READ_ONLY;

create or replace view CLEAR2WORK_SITE_SV as
select * from CLEAR2WORK_SITE with read only;

grant select on CLEAR2WORK_SITE_SV to MOTS_READ_ONLY;


-- CLEAR2WORK_SURVEY
create table CLEAR2WORK_SURVEY
  (
   SUBMISSION_TIME_RAW varchar2(23) not null,
   ASSIGNEE_RAW varchar2(100) not null,
   SITE varchar2(100) not null,
   CLEAR number(1),
   SUBMISSION_DATE date,
   ASSIGNEE varchar2(100),
   FIRST_NAME varchar2(50),
   LAST_NAME varchar2(50),
   ASSIGNEE_PSEUDO_KEY varchar2(12),
   PROCESSED_FLAG varchar(1) default 'N' not null check (PROCESSED_FLAG in ('N','Y')),
   constraint CLEAR2WORK_SURVEY_PK primary key (SUBMISSION_TIME_RAW,ASSIGNEE_RAW)
  );

create bitmap index CLEAR2WORK_SURVEY_PROCESSED_FLAG on CLEAR2WORK_SURVEY (PROCESSED_FLAG);

grant select on CLEAR2WORK_SURVEY to MOTS_READ_ONLY;

create or replace view CLEAR2WORK_SURVEY_SV as
select
  SUBMISSION_DATE,
  ASSIGNEE_PSEUDO_KEY
from CLEAR2WORK_SURVEY;

grant select on CLEAR2WORK_SURVEY_SV to MOTS_READ_ONLY;