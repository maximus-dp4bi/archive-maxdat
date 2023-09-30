create or replace force view bpm_d_date_hour_sv as
select bdd.D_DATE + (bdh.D_HOUR/24) D_DATE_HOUR
from 
  BPM_D_DATES bdd,
  BPM_D_HOURS bdh
where bdd.D_DATE <= sysdate - (bdh.D_HOUR/24)
with read only;
grant select, insert, update on BPM_D_DATE_HOUR_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select, insert, update, delete on BPM_D_DATE_HOUR_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on BPM_D_DATE_HOUR_SV to MAXDAT_MITRAN_READ_ONLY;


