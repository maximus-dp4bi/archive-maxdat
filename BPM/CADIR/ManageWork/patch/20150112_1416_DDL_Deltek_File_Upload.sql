/*
Created on 01/12/2015 by Raj A.
Description: Created for CADIR Deltek File upload process. CADIR-490 & 503.
*/
alter table d_deltek_hours add PRODUCTIVE_HOURS number;

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