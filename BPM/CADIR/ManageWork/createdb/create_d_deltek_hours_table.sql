/*
Created on 01/12/2014 by Raj for CADIR-490 and 503.
Deployment tickets: 495, 496.
*/
--drop table  D_DELTEK_HOURS;
create table  D_DELTEK_HOURS
(
DDH_ID number not null,
EMPLOYEE_ID varchar2(30),
LABOR_GRP_TYPE varchar2(400),
LAST_NAME varchar2(400),
FIRST_NAME varchar2(400),
TITLE varchar2(400),
EMPL_ORG_ID varchar2(400),
EMPL_ORG_NAME varchar2(400),
APPROVAL_NAME varchar2(400),
PROJECT_ID varchar2(400),
PROJECT_NAME varchar2(400),
ORG_ID varchar2(400),
ORG_NAME varchar2(400),
PAY_TYPE varchar2(400),
PLC_ID varchar2(400),
HOURS_DATE date,
ENTERED_HOURS number,
PRODUCTIVE_HOURS number,
COMMENTS varchar2(4000),
NOTES varchar2(4000),
MAXDAT_AUDIT_CREATE_DT date,
MAXDAT_AUDIT_UPDATE_DT date
)
tablespace MAXDAT_DATA ;

--Create primary key, foreign key
alter table D_DELTEK_HOURS add primary key (DDH_ID) 
using index tablespace MAXDAT_INDX;

alter table D_DELTEK_HOURS ADD CONSTRAINT deltek_unique unique (EMPLOYEE_ID,PROJECT_ID,PAY_TYPE, HOURS_DATE)
using index tablespace MAXDAT_INDX;

create sequence seq_ddh_id;

create or replace view D_DELTEK_HOURS_SV as
select
DDH_ID,
EMPLOYEE_ID,
LABOR_GRP_TYPE,
LAST_NAME,
FIRST_NAME,
TITLE,
EMPL_ORG_ID,
EMPL_ORG_NAME,
APPROVAL_NAME,
PROJECT_ID,
PROJECT_NAME,
ORG_ID,
ORG_NAME,
PAY_TYPE,
PLC_ID,
HOURS_DATE,
ENTERED_HOURS,
PRODUCTIVE_HOURS,
COMMENTS,
NOTES,
MAXDAT_AUDIT_CREATE_DT,
MAXDAT_AUDIT_UPDATE_DT
from D_DELTEK_HOURS;
grant select on D_DELTEK_HOURS_SV to MAXDAT_READ_ONLY;

create or replace view D_PERSON_SV as
select * from D_PERSON
with read only;
grant select on D_PERSON_SV to MAXDAT_READ_ONLY;

create or replace view D_SUPERVISOR_SV as
select * from D_SUPERVISOR
with read only;
grant select on D_SUPERVISOR_SV to MAXDAT_READ_ONLY;