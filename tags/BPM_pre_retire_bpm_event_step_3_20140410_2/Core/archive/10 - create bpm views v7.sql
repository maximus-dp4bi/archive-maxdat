/*Code no longer in use. As per Randall B kolb 02/20/13*/

create or replace view F_BPM_INSTANCE_BY_DATE as
select * from V_F_BPM_INSTANCE_BY_DATE;

create or replace view f_bpm_instance_cmplt_by_date as 
select d_date
, bem_id
, bi_id
, identifier
, bil_id
, bsl_id
, start_date
, end_date
, source_id
, cmplt_count
from v_f_bpm_instance_by_date
where cmplt_count > 0;

create or replace view f_bpm_instance_create_by_date as 
select d_date
, bem_id
, bi_id
, identifier
, bil_id
, bsl_id
, start_date
, end_date
, source_id
, create_count
from v_f_bpm_instance_by_date
where create_count > 0;

create or replace view f_bpm_instance_inv_by_date as 
select d_date
, bem_id
, bi_id
, identifier
, bil_id
, bsl_id
, start_date
, end_date
, source_id
, inv_count
from v_f_bpm_instance_by_date v
where inv_count > 0 and cmplt_count = 0;

CREATE OR REPLACE VIEW F_BPM_INSTANCE_CURRENT
AS
    SELECT TRUNC(SYSDATE) AS d_date ,
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
      WHEN TRUNC(SYSDATE) BETWEEN TRUNC(bi.start_date) AND bi.end_date
      THEN 1
      ELSE 0
    END AS inv_count ,
    CASE
      WHEN bi.bi_id IS NULL
      THEN 0
      WHEN TRUNC(SYSDATE) = TRUNC(bi.start_date)
      THEN 1
      ELSE 0
    END AS arrv_count ,
    CASE
      WHEN bi.bi_id IS NULL
      THEN 0
      WHEN TRUNC(SYSDATE) = TRUNC(bi.start_date)
      THEN 1
      ELSE 0
    END AS create_count ,
    CASE
      WHEN bi.bi_id IS NULL
      THEN 0
      WHEN TRUNC(SYSDATE) = TRUNC(bi.end_date)
      THEN 1
      ELSE 0
    END AS cmplt_count ,
    1   AS instance_count
  FROM bpm_instance bi
    ;

create or replace view d_dates as
select d.*
,  case when trunc(d_date) = trunc(sysdate) then 'Y' else 'N' end as today
, case when trunc(d_date) = trunc(sysdate-1) then 'Y' else 'N' end as yesterday
, case when to_char(sysdate,'D') = '1' and trunc(d_date) = trunc(sysdate-2) then 'Y'
       when to_char(sysdate,'D') = '2' and trunc(d_date) = trunc(sysdate-3) then 'Y'
       when to_char(sysdate,'D') not in('1','2') and trunc(d_date) = trunc(sysdate-1) then 'Y'
       else 'N' end as last_weekday
, case when to_char(d_date, 'YYYYIW') = to_char(sysdate, 'YYYYIW') then 'Y' else 'N' end as this_week
, case when to_char(d_date, 'YYYYIW') = to_char(sysdate-7, 'YYYYIW') then 'Y' else 'N' end as last_week
from bpm_d_dates d;

create or replace view d_bpm as
select brl.brl_id
, brl.name region_name
, bprj.bprj_id
, bprj.name project_name
, bprg.bprg_id
, bprg.name program_name
, bprol.bprol_id
, bprol.name process_name
, bem.bem_id
, bem.name business_process_name
from bpm_event_master bem
inner join bpm_region_lkup brl on bem.brl_id = brl.brl_id
inner join bpm_project_lkup bprj on bem.bprj_id = bprj.bprj_id
inner join bpm_program_lkup bprg on bem.bprg_id = bprg.bprg_id
inner join bpm_process_lkup bprol on bem.bprol_id = bprol.bprol_id;

create or replace view d_identifier_type as
select bitl.bil_id
, bitl.name as identifier_type_name
from bpm_identifier_type_lkup bitl;

create or replace view d_source_type as
select bstl.bstl_id
, bstl.name source_type_name
, bsl.bsl_id
, bsl.name source_name
from bpm_source_lkup bsl
inner join bpm_source_type_lkup bstl on bsl.bstl_id = bstl.bstl_id;

create or replace view d_created_by_name as
select * from v_d_created_by_name;

create or replace view d_task_id as
select * from v_d_task_id;

create or replace view d_cancel_work_date as
select * from v_d_cancel_work_date;

create or replace view d_complete_date as
select * from v_d_complete_date;

create or replace view d_create_date as
select * from v_d_create_date;

create or replace view d_age_in_calendar_days as
select * from v_d_age_in_calendar_days;

create or replace view d_age_in_business_days as
select * from v_d_age_in_business_days;

create or replace view d_cancel_work_flag as
select * from v_d_cancel_work_flag;

create or replace view d_complete_flag as
select * from v_d_complete_flag;

create or replace view d_escalated_flag as
select * from v_d_escalated_flag;

create or replace view d_forwarded_flag as
select * from v_d_forwarded_flag;

create or replace view d_jeopardy_flag as
select * from v_d_jeopardy_flag;

create or replace view d_Escalated_To_Name as
select * from v_d_Escalated_To_Name;

create or replace view d_Forwarded_By_Name as
select * from v_d_Forwarded_By_Name;

create or replace view d_Group_Name as
select * from v_d_Group_Name;

create or replace view d_Group_Parent_Name as
select * from v_d_Group_Parent_Name;

create or replace view d_Group_Supervisor_Name as
select * from v_d_Group_Supervisor_Name;

create or replace view d_Last_Update_By_Name as
select * from v_d_Last_Update_By_Name;

create or replace view d_Last_Update_Date as
select * from v_d_Last_Update_Date;

create or replace view d_Owner_Name as
select * from v_d_Owner_Name;

create or replace view d_SLA_Days as
select * from v_d_SLA_Days;

create or replace view d_SLA_Days_Type as
select * from v_d_SLA_Days_Type;

create or replace view d_SLA_Jeopardy_Days as
select * from v_d_SLA_Jeopardy_Days;

create or replace view d_SLA_Target_Days as
select * from v_d_SLA_Target_Days;

create or replace view d_Source_Reference_ID as
select * from v_d_Source_Reference_ID;

create or replace view d_Source_Reference_Type as
select * from v_d_Source_Reference_Type;

create or replace view d_Status_Age_in_Business_Days as
select * from v_d_Status_Age_in_Bus_Days;

create or replace view d_Status_Age_in_Calendar_Days as
select * from v_d_Status_Age_in_Cal_Days;

create or replace view d_Status_Date as
select * from v_d_Status_Date;

create or replace view d_Task_Status as
select * from v_d_Task_Status;

create or replace view d_Task_Type as
select * from v_d_Task_Type;

create or replace view d_Team_Name as
select * from v_d_Team_Name;

create or replace view d_Team_Parent_Name as
select * from v_d_Team_Parent_Name;

create or replace view d_Team_Supervisor_Name as
select * from v_d_Team_Supervisor_Name;

create or replace view d_Timeliness_Status as
select * from v_d_Timeliness_Status;

create or replace view d_Unit_of_Work as
select * from v_d_Unit_of_Work;
