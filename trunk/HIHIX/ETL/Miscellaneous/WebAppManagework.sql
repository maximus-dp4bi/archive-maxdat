create or replace procedure addCORP_ETL_MANAGE_WORK
(
v_task_id OUT NUMBER,
v_asf_cancel_work varchar2,
v_asf_complete_work varchar2,
v_age_in_business_days NUMBER,
v_age_in_calendar_days NUMBER,
v_cancel_work_date date,
v_cancel_work_flag varchar2,
v_complete_date date,
v_complete_flag varchar2,
v_create_date date,
v_created_by_name varchar2,
v_escalated_flag varchar2,
v_escalated_to_name varchar2,
v_forwarded_by_name varchar2,
v_forwarded_flag varchar2,
v_group_name varchar2,
v_group_parent_name varchar2,
v_group_supervisor_name varchar2,
v_jeopardy_flag varchar2,
v_last_update_by_name varchar2,
v_last_update_date date,
v_owner_name varchar2,
v_sla_days NUMBER,
v_sla_days_type varchar2,
v_sla_jeopardy_days NUMBER,
v_sla_target_days NUMBER,
v_source_reference_id NUMBER,
v_source_reference_type varchar2,
v_status_age_in_bus_days NUMBER,
v_status_age_in_cal_days NUMBER,
v_status_date date,
v_task_status varchar2,
v_task_type varchar2,
v_team_name varchar2,
v_team_parent_name varchar2,
v_team_supervisor_name varchar2,
v_timeliness_status varchar2,
v_unit_of_work varchar2,
v_stg_extract_date date,
v_stg_last_update_date date,
v_stage_done_date date,
v_date_today date,
v_case_id NUMBER,
v_client_id NUMBER,
v_cancel_method varchar2,
v_cancel_reason varchar2,
v_cancel_by varchar2,
v_task_priority varchar2
)
IS
v_cemw_id NUMBER;

BEGIN
    
    SELECT Seq_cemw_Id.Nextval INTO v_cemw_Id FROM Dual;

    insert into CORP_ETL_MANAGE_WORK(cemw_Id, task_id, asf_cancel_work,asf_complete_work,age_in_business_days,age_in_calendar_days,cancel_work_date,cancel_work_flag,complete_date,complete_flag,create_date,created_by_name,escalated_flag,escalated_to_name,forwarded_by_name,forwarded_flag,group_name,group_parent_name,group_supervisor_name,jeopardy_flag,last_update_by_name,last_update_date,owner_name,sla_days,sla_days_type,sla_jeopardy_days,sla_target_days,source_reference_id,source_reference_type,status_age_in_bus_days,status_age_in_cal_days,status_date,task_status,task_type,team_name,team_parent_name,team_supervisor_name,timeliness_status,unit_of_work,stg_extract_date,stg_last_update_date,stage_done_date,date_today,case_id,client_id,cancel_method,cancel_reason,cancel_by,task_priority)
    values (v_cemw_Id, v_cemw_Id, v_asf_cancel_work,v_asf_complete_work,v_age_in_business_days,v_age_in_calendar_days,v_cancel_work_date,
            v_cancel_work_flag,v_complete_date,v_complete_flag,v_create_date,v_created_by_name,v_escalated_flag,
            v_escalated_to_name,v_forwarded_by_name,v_forwarded_flag,v_group_name,v_group_parent_name,v_group_supervisor_name,
            v_jeopardy_flag,v_last_update_by_name,v_last_update_date,v_owner_name,v_sla_days,v_sla_days_type,
            v_sla_jeopardy_days,v_sla_target_days,v_source_reference_id,v_source_reference_type,v_status_age_in_bus_days,
            v_status_age_in_cal_days,v_status_date,v_task_status,v_task_type,v_team_name,v_team_parent_name,
            v_team_supervisor_name,v_timeliness_status,v_unit_of_work,v_stg_extract_date,v_stg_last_update_date,
            v_stage_done_date,v_date_today,v_case_id,v_client_id,v_cancel_method,v_cancel_reason,v_cancel_by,v_task_priority);

    v_task_id := v_cemw_Id;
END;
/


create or replace procedure updateCORP_ETL_MANAGE_WORK
(
v_task_id number,
v_asf_cancel_work varchar2,
v_asf_complete_work varchar2,
v_age_in_business_days number,
v_age_in_calendar_days number,
v_cancel_work_date date,
v_cancel_work_flag varchar2,
v_complete_date date,
v_complete_flag varchar2,
v_create_date date,
v_created_by_name varchar2,
v_escalated_flag varchar2,
v_escalated_to_name varchar2,
v_forwarded_by_name varchar2,
v_forwarded_flag varchar2,
v_group_name varchar2,
v_group_parent_name varchar2,
v_group_supervisor_name varchar2,
v_jeopardy_flag varchar2,
v_last_update_by_name varchar2,
v_last_update_date date,
v_owner_name varchar2,
v_sla_days number,
v_sla_days_type varchar2,
v_sla_jeopardy_days number,
v_sla_target_days number,
v_source_reference_id number,
v_source_reference_type varchar2,
v_status_age_in_bus_days number,
v_status_age_in_cal_days number,
v_status_date date,
v_task_status varchar2,
v_task_type varchar2,
v_team_name varchar2,
v_team_parent_name varchar2,
v_team_supervisor_name varchar2,
v_timeliness_status varchar2,
v_unit_of_work varchar2,
v_stg_extract_date date,
v_stg_last_update_date date,
v_stage_done_date date,
v_date_today date,
v_case_id number,
v_client_id number,
v_cancel_method varchar2,
v_cancel_reason varchar2,
v_cancel_by varchar2,
v_task_priority varchar2
)
is

BEGIN


update CORP_ETL_MANAGE_WORK

set 
asf_cancel_work = v_asf_cancel_work,
asf_complete_work = v_asf_complete_work,
age_in_business_days = v_age_in_business_days,
age_in_calendar_days = v_age_in_calendar_days,
cancel_work_date = v_cancel_work_date,
cancel_work_flag = v_cancel_work_flag,
complete_date = v_complete_date,
complete_flag = v_complete_flag,
create_date = v_create_date,
created_by_name = v_created_by_name,
escalated_flag = v_escalated_flag,
escalated_to_name = v_escalated_to_name,
forwarded_by_name = v_forwarded_by_name,
forwarded_flag = v_forwarded_flag,
--group_name = v_group_name,
--group_parent_name = v_group_parent_name,
--group_supervisor_name = v_group_supervisor_name,
jeopardy_flag = v_jeopardy_flag,
last_update_by_name = v_last_update_by_name,
last_update_date = v_last_update_date,
owner_name = v_owner_name,
--sla_days = v_sla_days,
--sla_days_type = v_sla_days_type,
--sla_jeopardy_days = v_sla_jeopardy_days,
--sla_target_days = v_sla_target_days,
source_reference_id = v_source_reference_id,
source_reference_type = v_source_reference_type,
status_age_in_bus_days = v_status_age_in_bus_days,
status_age_in_cal_days = v_status_age_in_cal_days,
status_date = v_status_date,
task_status = v_task_status,
task_type = v_task_type,
--team_name = v_team_name,
--team_parent_name = v_team_parent_name,
--team_supervisor_name = v_team_supervisor_name,
--timeliness_status = v_timeliness_status,
unit_of_work = v_unit_of_work,
stg_extract_date = v_stg_extract_date,
stg_last_update_date = v_stg_last_update_date,
stage_done_date = v_stage_done_date,
date_today = v_date_today,
case_id = v_case_id,
client_id = v_client_id,
cancel_method = v_cancel_method,
cancel_reason = v_cancel_reason,
cancel_by = v_cancel_by,
task_priority = v_task_priority
where  cemw_id = v_task_id; -- task_id is same as cemw_id

End;
/