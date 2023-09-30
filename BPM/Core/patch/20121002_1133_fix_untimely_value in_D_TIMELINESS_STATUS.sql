-- Corrected view that fixes spelling of Untimely when vdsdt."SLA Days Type" = 'B' .

create or replace view D_TIMELINESS_STATUS as 
with 
  attr_sla_days_type as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'SLA Days Type' and bal.BAL_ID = ba.BAL_ID)),
  attr_timeliness_status as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'Timeliness Status' and bal.BAL_ID = ba.BAL_ID))
select 
  vdsdt.BI_ID,
  attr_timeliness_status.BAL_ID,
  attr_timeliness_status.BA_ID,
  case
    when nvl(dcf."Complete Flag",'N') ='N' then 'Not Complete'
    when vdsd."SLA Days" is null then 'Not Required'
    when 
      vdsdt."SLA Days Type" = 'B' 
      and vdaibd."Age in Business Days" > vdsd."SLA Days" then 'Untimely'
    when
      vdsdt."SLA Days Type" = 'C' 
      and daicd."Age in Calendar Days" > vdsd."SLA Days" then 'Untimely'
    else 'Timely' 
  end "Timeliness Status"
from
  V_D_SLA_DAYS_TYPE vdsdt,
  V_D_SLA_DAYS vdsd,
  V_D_AGE_IN_BUSINESS_DAYS vdaibd,
  D_AGE_IN_CALENDAR_DAYS daicd,
  D_COMPLETE_FLAG dcf,
  attr_sla_days_type,
  attr_timeliness_status
where
  vdsdt.BI_ID = vdsd.BI_ID (+)
  and vdsdt.BI_ID = vdaibd.BI_ID (+)
  and vdsdt.BI_ID = daicd.BI_ID (+)
  and vdsdt.BI_ID = dcf.BI_ID (+)
  and vdsdt.BA_ID = attr_sla_days_type.BA_ID
  and attr_sla_days_type.BEM_ID = attr_timeliness_status.BEM_ID;