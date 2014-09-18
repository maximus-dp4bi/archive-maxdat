drop view CUTOFF_CALENDAR_SV;

create or replace view EMRS_D_CUTOFF_CALENDAR_SV as
select * from CUTOFF_CALENDAR
with read only;

create or replace public synonym EMRS_D_CUTOFF_CALENDAR_SV for EMRS_D_CUTOFF_CALENDAR_SV;
grant select on EMRS_D_CUTOFF_CALENDAR_SV to MAXDAT_READ_ONLY;