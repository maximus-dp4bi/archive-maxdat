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

create or replace view D_CANCEL_WORK_FLAG as 
with 
  attr_cancel_work_date as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'Cancel Work Date' and bal.BAL_ID = ba.BAL_ID)),
  attr_cancel_work_flag as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'Cancel Work Flag' and bal.BAL_ID = ba.BAL_ID))
select
  vdcwd.BI_ID,
  attr_cancel_work_flag.BAL_ID,
  attr_cancel_work_flag.BA_ID,
  case
    when vdcwd."Cancel Work Date" is null then 'N'
    else 'Y'
  end "Cancel Work Flag"
from
  V_D_CANCEL_WORK_DATE vdcwd,
  attr_cancel_work_date,
  attr_cancel_work_flag
where
  vdcwd.BA_ID = attr_cancel_work_date.BA_ID
  and attr_cancel_work_date.BEM_ID = attr_cancel_work_flag.BEM_ID;
  
create or replace view D_COMPLETE_FLAG as 
with 
  attr_complete_date as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'Complete Date' and bal.BAL_ID = ba.BAL_ID)),
  attr_complete_flag as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'Complete Flag' and bal.BAL_ID = ba.BAL_ID))
select
  vdcd.BI_ID,
  attr_complete_flag.BAL_ID,
  attr_complete_flag.BA_ID,
  case
    when vdcd."Complete Date" is null then 'N'
    else 'Y'
  end "Complete Flag"
from
  V_D_COMPLETE_DATE vdcd,
  attr_complete_date,
  attr_complete_flag
where
  vdcd.BA_ID = attr_complete_date.BA_ID
  and attr_complete_date.BEM_ID = attr_complete_flag.BEM_ID;
  
create or replace view D_JEOPARDY_FLAG as 
with 
  attr_sla_days_type as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'SLA Days Type' and bal.BAL_ID = ba.BAL_ID)),
  attr_jeopardy_flag as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'Jeopardy Flag' and bal.BAL_ID = ba.BAL_ID))
select
  vdsdt.BI_ID,
  attr_jeopardy_flag.BAL_ID,
  attr_jeopardy_flag.BA_ID,
  case
    when 
      (vdsdt."SLA Days Type" = 'B' 
       and vdaibd."Age in Business Days" is not null
       and vdsjd."SLA Jeopardy Days" is not null
       and vdaibd."Age in Business Days" >= vdsjd."SLA Jeopardy Days")
      or
      (vdsdt."SLA Days Type" = 'C' 
       and daicd."Age in Calendar Days" is not null
       and vdsjd."SLA Jeopardy Days" is not null
       and daicd."Age in Calendar Days" >= vdsjd."SLA Jeopardy Days")
      then 'Y'
    else 'N' 
  end "Jeopardy Flag"
from
  V_D_SLA_DAYS_TYPE vdsdt,
  V_D_SLA_JEOPARDY_DAYS vdsjd,
  V_D_AGE_IN_BUSINESS_DAYS vdaibd,
  D_AGE_IN_CALENDAR_DAYS daicd,
  attr_sla_days_type,
  attr_jeopardy_flag
where
  vdsdt.BI_ID = vdsjd.BI_ID (+)
  and vdsdt.BI_ID = vdaibd.BI_ID (+)
  and vdsdt.BI_ID = daicd.BI_ID (+)
  and vdsdt.BA_ID = attr_sla_days_type.BA_ID
  and attr_sla_days_type.BEM_ID = attr_jeopardy_flag.BEM_ID;
  
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
      and vdaibd."Age in Business Days" > vdsd."SLA Days" then 'Untimey'
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
  
execute dbms_refresh.subtract(name => 'MANAGE_WORK',list => 'V_D_AGE_IN_CALENDAR_DAYS',lax => true);
execute dbms_refresh.subtract(name => 'MANAGE_WORK',list => 'V_D_STATUS_AGE_IN_CAL_DAYS',lax => true);
execute dbms_refresh.subtract(name => 'MANAGE_WORK',list => 'V_D_CANCEL_WORK_FLAG',lax => true);
execute dbms_refresh.subtract(name => 'MANAGE_WORK',list => 'V_D_COMPLETE_FLAG',lax => true);
execute dbms_refresh.subtract(name => 'MANAGE_WORK',list => 'V_D_JEOPARDY_FLAG',lax => true);
execute dbms_refresh.subtract(name => 'MANAGE_WORK',list => 'V_D_TIMELINESS_STATUS',lax => true);
  
drop materialized view V_D_AGE_IN_CALENDAR_DAYS;
drop materialized view V_D_STATUS_AGE_IN_CAL_DAYS;
drop materialized view V_D_CANCEL_WORK_FLAG;
drop materialized view V_D_COMPLETE_FLAG;
drop materialized view V_D_JEOPARDY_FLAG;
drop materialized view V_D_TIMELINESS_STATUS;

drop materialized view V_D_AGE_IN_BUSINESS_DAYS;

create materialized view v_d_age_in_business_days 
tablespace maxdat_data build immediate using index refresh fast on demand as
SELECT
  ia.bi_id,
  al.bal_id,
  ia.ba_id,
  ia.value_number "Age in Business Days" ,
  ia.rowid ia_rowid,
  a.rowid a_rowid,
  al.rowid al_rowid
FROM   
  bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
where 
  a.bal_id   = al.bal_id
  and al.name = 'Age in Business Days' 
  and ia.ba_id = a.ba_id
  and ia.end_date = to_date('2077-07-07','YYYY-MM-DD');
  
create unique index vdabd_uix1 on V_D_AGE_IN_BUSINESS_DAYS (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdabd_uix2 on V_D_AGE_IN_BUSINESS_DAYS ("Age in Business Days", BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create or replace view D_AGE_IN_BUSINESS_DAYS as
select  
  BI_ID,
  BAL_ID,
  BA_ID, 
  "Age in Business Days"  
from V_D_AGE_IN_BUSINESS_DAYS;

drop materialized view V_D_SLA_DAYS;

create materialized view V_D_SLA_DAYS 
tablespace maxdat_data build immediate using index refresh fast on demand as 
SELECT
  ia.bi_id,
  al.bal_id,
  ia.ba_id,
  ia.value_number "SLA Days",
  ia.rowid ia_rowid,
  a.rowid a_rowid,
  al.rowid al_rowid
FROM   
  bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
where 
  a.bal_id = al.bal_id
  and al.name = 'SLA Days' 
  and ia.ba_id = a.ba_id
  and ia.end_date = to_date('2077-07-07','YYYY-MM-DD');

create unique index vdsd_uix1 on V_D_SLA_DAYS (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdsd_uix2 on V_D_SLA_DAYS ("SLA Days",BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create or replace view D_SLA_DAYS as
select 
  BI_ID,
  BAL_ID,
  BA_ID, 
  "SLA Days"  
from V_D_SLA_DAYS;

drop materialized view V_D_SLA_DAYS_TYPE;

create materialized view V_D_SLA_DAYS_TYPE 
tablespace maxdat_data build immediate using index refresh fast on demand as 
SELECT
  ia.bi_id,
  al.bal_id,
  ia.ba_id,
  ia.value_char "SLA Days Type",
  ia.rowid ia_rowid,
  a.rowid a_rowid,
  al.rowid al_rowid
FROM   
  bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
where 
  a.bal_id = al.bal_id
  and al.name = 'SLA Days Type' 
  and ia.ba_id = a.ba_id
  and ia.end_date = to_date('2077-07-07','YYYY-MM-DD');

create unique index vdsdt_uix1 on V_D_SLA_DAYS_TYPE (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdsdt_uix2 on V_D_SLA_DAYS_TYPE ("SLA Days Type",BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create or replace view D_SLA_DAYS_TYPE as
select 
  BI_ID,
  BAL_ID,
  BA_ID, 
  "SLA Days Type"  
from V_D_SLA_DAYS_TYPE;

drop materialized view V_D_SLA_JEOPARDY_DAYS;

create materialized view V_D_SLA_JEOPARDY_DAYS 
tablespace maxdat_data build immediate using index refresh fast on demand as 
SELECT
  ia.bi_id,
  al.bal_id,
  ia.ba_id,
  ia.value_number "SLA Jeopardy Days",
  ia.rowid ia_rowid,
  a.rowid a_rowid,
  al.rowid al_rowid
FROM   
  bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
where 
  a.bal_id = al.bal_id
  and al.name = 'SLA Jeopardy Days' 
  and ia.ba_id = a.ba_id
  and ia.end_date = to_date('2077-07-07','YYYY-MM-DD');

create unique index vdsjd_uix1 on V_D_SLA_JEOPARDY_DAYS (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdsjd_uix2 on V_D_SLA_JEOPARDY_DAYS ("SLA Jeopardy Days",BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create or replace view D_SLA_JEOPARDY_DAYS as
select 
  BI_ID,
  BAL_ID,
  BA_ID, 
  "SLA Jeopardy Days"  
from V_D_SLA_JEOPARDY_DAYS;

drop materialized view V_D_SLA_TARGET_DAYS;

create materialized view V_D_SLA_TARGET_DAYS 
tablespace maxdat_data build immediate using index refresh fast on demand as 
SELECT
  ia.bi_id,
  al.bal_id,
  ia.ba_id,
  ia.value_number "SLA Target Days",
  ia.rowid ia_rowid,
  a.rowid a_rowid,
  al.rowid al_rowid
FROM   
  bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
where 
  a.bal_id = al.bal_id
  and al.name = 'SLA Target Days' 
  and ia.ba_id = a.ba_id
  and ia.end_date = to_date('2077-07-07','YYYY-MM-DD');

create unique index vdstd_uix1 on V_D_SLA_TARGET_DAYS (BI_ID) COMPUTE STATISTICS;
create unique index vdstd_uix2 on V_D_SLA_TARGET_DAYS ("SLA Target Days",BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create or replace view D_SLA_TARGET_DAYS as
select 
  BI_ID,
  BAL_ID,
  BA_ID, 
  "SLA Target Days"  
from V_D_SLA_TARGET_DAYS;

drop materialized view V_D_SOURCE_REFERENCE_ID;

create materialized view V_D_SOURCE_REFERENCE_ID 
tablespace maxdat_data build immediate using index refresh fast on demand as 
SELECT 
  ia.bi_id,
  al.bal_id,
  ia.ba_id,
  ia.value_number "Source Reference ID" ,
  ia.rowid ia_rowid,
  a.rowid a_rowid,
  al.rowid al_rowid
FROM   
  bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
where 
  a.bal_id = al.bal_id
  and al.name = 'Source Reference ID' 
  and ia.ba_id = a.ba_id
  and ia.end_date = to_date('2077-07-07','YYYY-MM-DD');

create unique index vdsrid_uix1 on V_D_SOURCE_REFERENCE_ID (BI_ID) COMPUTE STATISTICS;
create unique index vdsrid_uix2 on V_D_SOURCE_REFERENCE_ID ("Source Reference ID",BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create or replace view D_SOURCE_REFERENCE_ID as
select 
  BI_ID,
  BAL_ID,
  BA_ID, 
  "Source Reference ID"  
from V_D_SOURCE_REFERENCE_ID;

drop materialized view V_D_SOURCE_REFERENCE_TYPE;

create materialized view V_D_SOURCE_REFERENCE_TYPE 
tablespace maxdat_data build immediate using index refresh fast on demand as 
SELECT
  ia.bi_id,
  al.bal_id,
  ia.ba_id,
  ia.value_char "Source Reference Type" ,
  ia.rowid ia_rowid,
  a.rowid a_rowid,
  al.rowid al_rowid
FROM   
  bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
where 
  a.bal_id = al.bal_id
  and al.name = 'Source Reference Type' 
  and ia.ba_id = a.ba_id
  and ia.end_date = to_date('2077-07-07','YYYY-MM-DD');

create unique index vdsrt_uix1 on V_D_SOURCE_REFERENCE_TYPE (BI_ID) COMPUTE STATISTICS;
create unique index vdsrt_uix2 on V_D_SOURCE_REFERENCE_TYPE ("Source Reference Type",BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create or replace view D_SOURCE_REFERENCE_TYPE as
select 
  BI_ID,
  BAL_ID,
  BA_ID, 
  "Source Reference Type"  
from V_D_SOURCE_REFERENCE_TYPE;

drop materialized view V_D_STATUS_AGE_IN_BUS_DAYS;

create materialized view V_D_STATUS_AGE_IN_BUS_DAYS 
tablespace maxdat_data build immediate using index refresh fast on demand as 
SELECT
  ia.bi_id,
  al.bal_id,
  ia.ba_id,
  ia.value_number "Status Age in Business Days" ,
  ia.rowid ia_rowid,
  a.rowid a_rowid,
  al.rowid al_rowid
FROM   
  bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
where 
  a.bal_id = al.bal_id
  and al.name = 'Status Age in Business Days' 
  and ia.ba_id = a.ba_id
  and ia.end_date = to_date('2077-07-07','YYYY-MM-DD');

create unique index vdsaibd_uix1 on V_D_STATUS_AGE_IN_BUS_DAYS (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdsaibd_uix2 on V_D_STATUS_AGE_IN_BUS_DAYS ("Status Age in Business Days",BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create or replace view D_STATUS_AGE_IN_BUSINESS_DAYS as
select 
  BI_ID,
  BAL_ID,
  BA_ID, 
  "Status Age in Business Days"  
from V_D_STATUS_AGE_IN_BUS_DAYS;

drop materialized view V_D_UNIT_OF_WORK;

create materialized view V_D_UNIT_OF_WORK 
tablespace maxdat_data build immediate using index refresh fast on demand as 
SELECT
  ia.bi_id,
  al.bal_id,
  ia.ba_id,
  ia.value_char "Unit of Work" ,
  ia.rowid ia_rowid,
  a.rowid a_rowid,
  al.rowid al_rowid
FROM   
  bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
where 
  a.bal_id = al.bal_id
  and al.name = 'Unit of Work' 
  and ia.ba_id = a.ba_id
  and ia.end_date = to_date('2077-07-07','YYYY-MM-DD');

create unique index vdtuow_uix1 on V_D_UNIT_OF_WORK (BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;
create unique index vdtuow_uix2 on V_D_UNIT_OF_WORK ("Unit of Work",BI_ID) TABLESPACE MAXDAT_INDX COMPUTE STATISTICS;

create or replace view D_UNIT_OF_WORK as
select 
  BI_ID,
  BAL_ID,
  BA_ID, 
  "Unit of Work"  
from V_D_UNIT_OF_WORK;

create unique index vbi_ubk4 on BPM_INSTANCE (BEM_ID,BI_ID) tablespace MAXDAT_INDX compute statistics;

execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_AGE_IN_BUSINESS_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SLA_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SLA_DAYS_TYPE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SLA_JEOPARDY_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SLA_TARGET_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SOURCE_REFERENCE_ID');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SOURCE_REFERENCE_TYPE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_STATUS_AGE_IN_BUS_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_UNIT_OF_WORK');
