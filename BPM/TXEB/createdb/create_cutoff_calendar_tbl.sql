create table CUTOFF_CALENDAR
  (CUTOFF_ID	        number(18) not null,	
   PLAN_TYPE	        varchar2(32),
   PROGRAM_TYPE_CD	        varchar2(32),
   PROGRAM_STATUS	        varchar2(128),
   SUB_PROGRAM_TYPES	varchar2(128),
   PLAN_SERVICE_TYPES	varchar2(128),
   SCOPE	                varchar2(400),
   TRANSACTION_TYPE_CD	varchar2(32),
   MONTH_YEAR	        varchar2(10)not null,
   STATE_CUTOFF_DATE_1	date,
   MAXIMUS_CUTOFF_DATE_1	date,
   RETRO_ELIG_CUTOFF_DATE_1	date,
   START_DATE_BEFORE_CUTOFF_1	date,
   START_DATE_AFTER_CUTOFF_1	date,
   CREATED_BY	        varchar2(80),
   CREATE_TS	        date,
   UPDATED_BY	        varchar2(80),
   UPDATE_TS	        date,
   STATE_CUTOFF_DATE_2	date,
   MAXIMUS_CUTOFF_DATE_2	date,
   RETRO_ELIG_CUTOFF_DATE_2	date,
   START_DATE_BEFORE_CUTOFF_2	date,
   START_DATE_AFTER_CUTOFF_2	date,
   MAXIMUS_CUTOFF_TIME1	varchar2(32),
   MAXIMUS_CUTOFF_TIME2	varchar2(32))
tablespace MAXDAT_DATA;

alter table cutoff_calendar add constraint cutoff_pk primary key (cutoff_id) using index tablespace MAXDAT_INDX;


grant select on CUTOFF_CALENDAR to MAXDAT_READ_ONLY;

create or replace view EMRS_D_CUTOFF_CALENDAR_SV as
select * from EMRS_D_CUTOFF_CALENDAR
with read only;

grant select on EMRS_D_CUTOFF_CALENDAR_SV to MAXDAT_READ_ONLY;