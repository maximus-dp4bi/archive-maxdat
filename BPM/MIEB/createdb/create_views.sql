create or replace view STAFF_KEY_LOOKUP_SV
as
select 
  STAFF_ID,
  EXT_STAFF_NUMBER staff_key
from STAFF
union all
select 
  STAFF_ID,
  to_char(STAFF_ID) staff_key
from STAFF
where EXT_STAFF_NUMBER != to_char(STAFF_ID)
with read only;

grant select on STAFF_KEY_LOOKUP_SV to MAXDAT_REPORTS;

