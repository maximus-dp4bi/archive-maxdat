create or replace view D_AGE_IN_CALENDAR_DAYS as 
with 
  attr_create_date as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'Create Date' and bal.BAL_ID = ba.BAL_ID)),
  attr_age_in_calendar_days as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'Age in Calendar Days' and bal.BAL_ID = ba.BAL_ID))
select 
  vdcrd.BI_ID,
  attr_age_in_calendar_days.BAL_ID,
  attr_age_in_calendar_days.BA_ID,
  trunc(nvl(vdcod."Complete Date",sysdate)) - trunc(vdcrd."Create Date") "Age in Calendar Days"
from
  V_D_CREATE_DATE vdcrd,
  V_D_COMPLETE_DATE vdcod,
  attr_create_date,
  attr_age_in_calendar_days
where
  vdcrd.BI_ID = vdcod.BI_ID (+)
  and vdcrd.BA_ID = attr_create_date.BA_ID
  and attr_create_date.BEM_ID = attr_age_in_calendar_days.BEM_ID;

create or replace view D_STATUS_AGE_IN_CALENDAR_DAYS as 
with 
  attr_status_date as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'Status Date' and bal.BAL_ID = ba.BAL_ID)),
  attr_status_age_in_cal_days as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'Status Age in Calendar Days' and bal.BAL_ID = ba.BAL_ID))
select
  vdsd.BI_ID,
  attr_status_age_in_cal_days.BAL_ID,
  attr_status_age_in_cal_days.BA_ID,
  trunc(nvl(vdcd."Complete Date",sysdate)) - trunc(vdsd."Status Date") "Status Age in Calendar Days"
from
  V_D_STATUS_DATE vdsd,
  V_D_COMPLETE_DATE vdcd,
  attr_status_date,
  attr_status_age_in_cal_days
where
  vdsd.BI_ID = vdcd.BI_ID (+)
  and vdsd.d_date = trunc(sysdate)
  and vdsd.BA_ID = attr_status_date.BA_ID
  and attr_status_date.BEM_ID = attr_status_age_in_cal_days.BEM_ID;