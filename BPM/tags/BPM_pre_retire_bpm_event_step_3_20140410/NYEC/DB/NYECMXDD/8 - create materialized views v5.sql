drop MATERIALIZED VIEW LOG ON bpm_d_dates;
drop MATERIALIZED VIEW LOG ON bpm_instance_attribute;
drop MATERIALIZED VIEW LOG ON bpm_attribute;
drop MATERIALIZED VIEW LOG ON bpm_attribute_lkup;
drop materialized view log on bpm_instance;

drop materialized view V_F_BPM_INSTANCE_BY_DATE;
drop materialized view V_D_AGE_IN_BUSINESS_DAYS;
drop materialized view V_D_AGE_IN_CALENDAR_DAYS;
drop materialized view V_D_CANCEL_WORK_DATE;
drop materialized view V_D_CANCEL_WORK_FLAG;
drop materialized view V_D_COMPLETE_DATE;
drop materialized view V_D_COMPLETE_FLAG;
drop materialized view V_D_CREATE_DATE;
drop materialized view V_D_CREATED_BY_NAME;
drop materialized view V_D_ESCALATED_FLAG;
drop materialized view V_D_ESCALATED_TO_NAME;
drop materialized view V_D_FORWARDED_BY_NAME;
drop materialized view V_D_FORWARDED_FLAG;
drop materialized view V_D_GROUP_NAME;
drop materialized view V_D_GROUP_PARENT_NAME;
drop materialized view V_D_GROUP_SUPERVISOR_NAME;
drop materialized view V_D_JEOPARDY_FLAG;
drop materialized view V_D_LAST_UPDATE_BY_NAME;
drop materialized view V_D_LAST_UPDATE_DATE;
drop materialized view V_D_OWNER_NAME;
drop materialized view V_D_SLA_DAYS;
drop materialized view V_D_SLA_DAYS_TYPE;
drop materialized view V_D_SLA_JEOPARDY_DAYS;
drop materialized view V_D_SLA_TARGET_DAYS;
drop materialized view V_D_SOURCE_REFERENCE_ID;
drop materialized view V_D_SOURCE_REFERENCE_TYPE;
drop materialized view V_D_STATUS_AGE_IN_BUS_DAYS;
drop materialized view V_D_STATUS_AGE_IN_CAL_DAYS;
drop materialized view V_D_STATUS_DATE;
drop materialized view V_D_TASK_ID;
drop materialized view V_D_TASK_STATUS;
drop materialized view V_D_TASK_TYPE;
drop materialized view V_D_TEAM_NAME;
drop materialized view V_D_TEAM_PARENT_NAME;
drop materialized view V_D_TEAM_SUPERVISOR_NAME;
drop materialized view V_D_TIMELINESS_STATUS;
drop materialized view V_D_UNIT_OF_WORK;

CREATE MATERIALIZED VIEW LOG ON bpm_d_dates WITH ROWID, sequence including new values;
CREATE MATERIALIZED VIEW LOG ON bpm_instance_attribute WITH ROWID, sequence including new values;
CREATE MATERIALIZED VIEW LOG ON bpm_attribute WITH ROWID, sequence including new values;
CREATE MATERIALIZED VIEW LOG ON bpm_attribute_lkup WITH ROWID, sequence including new values;
create materialized view log on bpm_instance with rowid, sequence including new values;

CREATE MATERIALIZED VIEW V_F_BPM_INSTANCE_BY_DATE
TABLESPACE "MAXDAT_DATA" 
BUILD IMMEDIATE
USING INDEX
REFRESH FAST ON DEMAND
AS
SELECT d_dates.d_date ,
    bi.bem_id ,
    bi.bi_id ,
    bi.identifier ,
    bi.bil_id ,
    bi.bsl_id ,
    bi.start_date ,
    bi.end_date ,
    bi.source_id ,
    CASE
      WHEN bi.bi_id IS NULL
      THEN 0
      WHEN d_date BETWEEN TRUNC(bi.start_date) AND bi.end_date
      THEN 1
      ELSE 0
    END AS inv_count ,
    CASE
      WHEN bi.bi_id IS NULL
      THEN 0
      WHEN d_date = TRUNC(bi.start_date)
      THEN 1
      ELSE 0
    END AS arrv_count ,
    CASE
      WHEN bi.bi_id IS NULL
      THEN 0
      WHEN d_date = TRUNC(bi.start_date)
      THEN 1
      ELSE 0
    END AS create_count ,
    CASE
      WHEN bi.bi_id IS NULL
      THEN 0
      WHEN d_date = TRUNC(bi.end_date)
      THEN 1
      ELSE 0
    END AS cmplt_count,
    d_dates.rowid d_dates_rowid,
    bi.rowid bi_rowid
  FROM bpm_d_dates d_dates,  BPM_INSTANCE BI
  where D_DATES.D_DATE >= TRUNC(BI.START_DATE(+)) 
  AND D_DATES.D_DATE <= TRUNC(BI.END_DATE(+)) ;

create materialized view V_D_CREATED_BY_NAME tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT 
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Created By Name",
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
  where a.bal_id   = al.bal_id
  and al.name = 'Created By Name' 
  and ia.ba_id = a.ba_id;

create materialized view v_d_task_id tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT 
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_number "Task ID",
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
  where a.bal_id   = al.bal_id
  and al.name = 'Task ID' 
  and ia.ba_id = a.ba_id;

create materialized view v_d_cancel_work_date tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT 
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_date "Cancel Work Date" ,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
  where a.bal_id   = al.bal_id
  and al.name = 'Cancel Work Date'
  and ia.ba_id = a.ba_id
  and ia.end_date = '07-Jul-2077';

create materialized view v_d_complete_date tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT 
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_date "Complete Date" ,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
  where a.bal_id   = al.bal_id
  and al.name = 'Complete Date'
  and ia.ba_id = a.ba_id
   and ia.end_date = '07-Jul-2077';

create materialized view V_D_CREATE_DATE tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT 
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_date "Create Date" ,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia
  where a.bal_id   = al.bal_id
  and al.name = 'Create Date'
  and ia.ba_id = a.ba_id;


create materialized view V_D_AGE_IN_CALENDAR_DAYS tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_number "Age in Calendar Days",
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Age in Calendar Days' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view v_d_age_in_business_days tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_number "Age in Business Days" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Age in Business Days' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view v_d_cancel_work_flag tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Cancel Work Flag" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Cancel Work Flag' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view v_d_complete_flag tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Complete Flag" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Complete Flag' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view v_d_escalated_flag tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Escalated Flag" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Escalated Flag' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view v_d_forwarded_flag tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Forwarded Flag" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Forwarded Flag' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view v_d_jeopardy_flag tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Jeopardy Flag" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Jeopardy Flag' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view v_d_escalated_to_name tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Escalated To Name" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Escalated To Name' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view v_d_forwarded_by_name tablespace maxdat_data build immediate using index refresh fast on demand as
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Forwarded By Name" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Forwarded By Name' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_GROUP_NAME tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Group Name" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Group Name' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_GROUP_PARENT_NAME tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Group Parent Name" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Group Parent Name' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_GROUP_SUPERVISOR_NAME tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Group Supervisor Name" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Group Supervisor Name' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_LAST_UPDATE_BY_NAME tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Last Update By Name" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Last Update By Name' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_LAST_UPDATE_DATE tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_date "Last Update Date" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Last Update Date' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_OWNER_NAME tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Owner Name" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Owner Name' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_SLA_DAYS tablespace maxdat_data build immediate using index refresh fast on demand as 
  SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_number "SLA Days" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'SLA Days' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_SLA_DAYS_TYPE tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "SLA Days Type" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'SLA Days Type' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_SLA_JEOPARDY_DAYS tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_number "SLA Jeopardy Days" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'SLA Jeopardy Days' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_SLA_TARGET_DAYS tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_number "SLA Target Days" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'SLA Target Days' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_SOURCE_REFERENCE_ID tablespace maxdat_data build immediate using index refresh fast on demand as 
  SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_number "Source Reference ID" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Source Reference ID' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_SOURCE_REFERENCE_TYPE tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Source Reference Type" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Source Reference Type' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_STATUS_AGE_IN_BUS_DAYS tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_number "Status Age in Business Days" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Status Age in Business Days' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_STATUS_AGE_IN_CAL_DAYS tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_number "Status Age in Calendar Days" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Status Age in Calendar Days' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_STATUS_DATE tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_date "Status Date" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Status Date' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_TASK_STATUS tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Task Status" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Task Status' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_TASK_TYPE tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Task Type" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Task Type' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_TEAM_NAME tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Team Name" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Team Name' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_TEAM_PARENT_NAME tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Team Parent Name" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Team Parent Name' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_TEAM_SUPERVISOR_NAME tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Team Supervisor Name" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Team Supervisor Name' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_TIMELINESS_STATUS tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Timeliness Status" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Timeliness Status' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create materialized view V_D_UNIT_OF_WORK tablespace maxdat_data build immediate using index refresh fast on demand as 
 SELECT d.d_date,
    ia.bi_id,
    al.bal_id,
    ia.ba_id,
    ia.value_char "Unit of Work" ,
    d.rowid d_dates_rowid,
    ia.rowid ia_rowid,
    a.rowid a_rowid,
    al.rowid al_rowid
  FROM   bpm_attribute a,
  bpm_attribute_lkup al,
  bpm_instance_attribute ia,
  bpm_d_dates d
  where a.bal_id   = al.bal_id
  and al.name = 'Unit of Work' 
  and ia.ba_id = a.ba_id
  and  d.d_date >= trunc(ia.start_date(+)) and d.d_date < trunc(ia.end_date(+));

create or replace package BPM_EVENTS_MV as
  procedure ADD_TO_REFRESH_GROUP 
    (p_refresh_group_name in varchar2,
     p_materialized_view_name in varchar2);
  procedure REFRESH_GROUP (p_refresh_group_name in varchar2);
  procedure SET_REFRESH_GROUP_SCHEDULE 
    (p_refresh_group_name in varchar2,
     p_next_date in date,
     p_interval in varchar2);
end;
/

create or replace package body BPM_EVENTS_MV as

  procedure ADD_TO_REFRESH_GROUP
    (p_refresh_group_name in varchar2,
     p_materialized_view_name in varchar2) as
    begin
      DBMS_REFRESH.add 
        (name => p_refresh_group_name,
         list => p_materialized_view_name,
         lax => true);
    end;

  procedure REFRESH_GROUP (p_refresh_group_name in varchar2) as
    begin
      DBMS_REFRESH.REFRESH(name => p_refresh_group_name);
    end;
  
  procedure SET_REFRESH_GROUP_SCHEDULE 
    (p_refresh_group_name in varchar2,
     p_next_date in date,
     p_interval in varchar2) as
    begin
      DBMS_REFRESH.CHANGE
        (name => p_refresh_group_name,
         next_date => p_next_date,
         interval => p_interval);
    end;
  
end;
/

begin
  DBMS_REFRESH.MAKE 
    (name => 'MANAGE_WORK',
     list => '', 
     NEXT_DATE => trunc(sysdate + 1) + (125/1440), 
     interval => 'trunc(sysdate + 1) + (125/1440)',
     IMPLICIT_DESTROY => false, 
     ROLLBACK_SEG => '',
     PUSH_DEFERRED_RPC => true, 
     refresh_after_errors => false);
end;
/

execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_F_BPM_INSTANCE_BY_DATE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_AGE_IN_BUSINESS_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_AGE_IN_CALENDAR_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_CANCEL_WORK_DATE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_CANCEL_WORK_FLAG');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_COMPLETE_DATE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_COMPLETE_FLAG');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_CREATE_DATE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_CREATED_BY_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_ESCALATED_FLAG');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_ESCALATED_TO_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_FORWARDED_BY_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_FORWARDED_FLAG');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_GROUP_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_GROUP_PARENT_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_GROUP_SUPERVISOR_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_JEOPARDY_FLAG');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_LAST_UPDATE_BY_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_LAST_UPDATE_DATE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_OWNER_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SLA_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SLA_DAYS_TYPE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SLA_JEOPARDY_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SLA_TARGET_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SOURCE_REFERENCE_ID');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_SOURCE_REFERENCE_TYPE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_STATUS_AGE_IN_BUS_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_STATUS_AGE_IN_CAL_DAYS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_STATUS_DATE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_TASK_ID');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_TASK_STATUS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_TASK_TYPE');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_TEAM_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_TEAM_PARENT_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_TEAM_SUPERVISOR_NAME');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_TIMELINESS_STATUS');
execute BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('MANAGE_WORK','V_D_UNIT_OF_WORK');

create or replace view MV_REFRESH_GROUP as
select
  case
    when r.RNAME is null and s.REFRESH_MODE = 'COMMIT' then 'NA'
    when r.RNAME is not null then R.RNAME
    else 'UNKNOWN'
    end REFRESH_GROUP_NAME,
  s.NAME MV_NAME,
  s.REFRESH_MODE,
  to_char(s.LAST_REFRESH,'YYYY-MM-DD HH24:MI:SS' ) LAST_REFRESH,
  decode(r.NEXT_DATE,null,s.NEXT,to_char(r.NEXT_DATE,'YYYY-MM-DD HH24:MI:SS')) NEXT_REFRESH
from USER_SNAPSHOTS s
left outer join USER_REFRESH r on (s.REFRESH_GROUP = r.REFGROUP)
order by REFRESH_GROUP_NAME asc, MV_NAME asc;

execute BPM_EVENTS_MV.REFRESH_GROUP('MANAGE_WORK');
