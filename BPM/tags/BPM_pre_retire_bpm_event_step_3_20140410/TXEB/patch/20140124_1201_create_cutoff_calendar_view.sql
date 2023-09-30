create or replace view CUTOFF_CALENDAR_SV as
select * from CUTOFF_CALENDAR
with read only;

create or replace public synonym CUTOFF_CALENDAR_SV for CUTOFF_CALENDAR_SV;
grant select on CUTOFF_CALENDAR_SV to MAXDAT_READ_ONLY;