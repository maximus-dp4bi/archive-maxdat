create or replace view BPM_D_DATE_HOUR_SV as
select bdd.D_DATE + (bdh.D_HOUR/24) D_DATE_HOUR
from 
  BPM_D_DATES bdd,
  BPM_D_HOURS bdh
where bdd.D_DATE <= sysdate - (bdh.D_HOUR/24)
with read only;
/

create or replace public synonym BPM_D_DATE_HOUR_SV for BPM_D_DATE_HOUR_V;
grant select on BPM_D_DATE_HOUR_SV to MAXDAT_READ_ONLY;
