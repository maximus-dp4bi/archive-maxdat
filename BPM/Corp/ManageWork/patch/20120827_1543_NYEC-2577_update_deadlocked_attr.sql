create or replace procedure TPRC_BPM_ETL_BIA_UPD
  (p_attr_update_method in varchar2,
   p_source_id in varchar2, 
   p_bi_id in number, 
   p_ba_id in number,  
   p_value_number in number,
   p_value_date in date,
   p_value_char in varchar2,
   p_bue_id in number,
   p_current_sysdate in date) as
   
  v_bia_id number := null;
  v_be_id  number := null;
   
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
  v_sql_code number := null;
  v_error_message varchar2(500) := null;

begin

  v_bia_id := SEQ_BIA_ID.nextval;
  
  if p_attr_update_method = 'INSERT' then
    
    update BPM_INSTANCE_ATTRIBUTE
    set END_DATE = p_current_sysdate
    where 
      BI_ID = p_bi_id
      and BA_ID = p_ba_id
      and END_DATE = v_max_date;

    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (v_bia_id,p_bi_id,p_ba_id,p_value_number,p_value_date,
       p_value_char,p_current_sysdate,v_max_date,p_bue_id);
       
  elsif p_attr_update_method = 'UPDATE' then
  
    update BPM_INSTANCE_ATTRIBUTE
    set  
      VALUE_NUMBER = p_value_number,
      VALUE_DATE = p_value_date,
      VALUE_CHAR = p_value_char
    where 
      BI_ID = p_bi_id
      and BA_ID = p_ba_id
      and END_DATE = v_max_date;
      
  else
    
    v_error_message := 'Unsupported p_attr_update_method "' || p_attr_update_method || '".';
    v_be_id := SEQ_BE_ID.nextval;
    
    insert into BPM_ERRORS 
      (BE_ID,ERROR_DATE,RUN_DATA_OBJECT,SOURCE_ID,BI_ID,BIA_ID,
       ERROR_NUMBER,ERROR_MESSAGE) 
    values 
      (v_be_id,sysdate,$$PLSQL_UNIT,p_source_id,p_bi_id,v_bia_id,
       null,v_error_message);
    
    dbms_output.put_line('Exception: ' || v_error_message || ' See BPM_ERRORS.BE_ID = ' || v_be_id || ' for more details.');
  
  end if;
  
end;
/

create or replace procedure TPRC_BPM_ETL_BIA_UPD_NUM
  (p_attr_update_method in varchar2,
   p_source_id in varchar2, 
   p_bi_id in number,
   p_ba_id in number,
   p_new_value in number,
   p_bue_id in number,
   p_current_sysdate in date) as
   
   v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
   v_old_value number := null;

begin

  begin
    select VALUE_NUMBER
    into v_old_value
    from BPM_INSTANCE_ATTRIBUTE
    where 
      BI_ID = p_bi_id
      and BA_ID = p_ba_id
      and END_DATE = v_max_date;
   exception
     when NO_DATA_FOUND then
       v_old_value := null;
   end;

  if   (v_old_value is null and p_new_value is not null)
    or (v_old_value is not null and p_new_value is null)
    or  v_old_value != p_new_value then
    
    TPRC_BPM_ETL_BIA_UPD(p_attr_update_method,p_source_id,p_bi_id,p_ba_id,p_new_value,null,null,p_bue_id,p_current_sysdate);
       
  end if;

end;
/

create or replace procedure TPRC_BPM_ETL_BIA_UPD_DATE
  (p_attr_update_method in varchar2,
   p_source_id in varchar2, 
   p_bi_id in number,
   p_ba_id in number,
   p_new_value in date,
   p_bue_id in number,
   p_current_sysdate in date) as

   v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
   v_old_value date := null;

begin

  begin
    select VALUE_DATE
    into v_old_value
    from BPM_INSTANCE_ATTRIBUTE
    where 
      BI_ID = p_bi_id
      and BA_ID = p_ba_id
      and END_DATE = v_max_date;
   exception
     when NO_DATA_FOUND then
       v_old_value := null;
   end;

  if   (v_old_value is null and p_new_value is not null)
    or (v_old_value is not null and p_new_value is null)
    or  v_old_value != p_new_value then
    
    TPRC_BPM_ETL_BIA_UPD(p_attr_update_method,p_source_id,p_bi_id,p_ba_id,null,p_new_value,null,p_bue_id,p_current_sysdate);
       
  end if;

end;
/

create or replace procedure TPRC_BPM_ETL_BIA_UPD_CHAR
  (p_attr_update_method in varchar2,
   p_source_id in varchar2,
   p_bi_id in number,
   p_ba_id in number,
   p_new_value in varchar2,
   p_bue_id in number,
   p_current_sysdate in date) as

   v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
   v_old_value varchar2(100) := null;

begin

  begin
    select VALUE_CHAR
    into v_old_value
    from BPM_INSTANCE_ATTRIBUTE
    where 
      BI_ID = p_bi_id
      and BA_ID = p_ba_id
      and END_DATE = v_max_date;
   exception
     when NO_DATA_FOUND then
       v_old_value := null;
   end;

  if   (v_old_value is null and p_new_value is not null)
    or (v_old_value is not null and p_new_value is null)
    or  v_old_value != p_new_value then
    
    TPRC_BPM_ETL_BIA_UPD(p_attr_update_method,p_source_id,p_bi_id,p_ba_id,null,null,p_new_value,p_bue_id,p_current_sysdate);
       
  end if;

end;
/

create or replace procedure TPRC_U_CORP_ETL_MANAGE_WORK as

  v_be_id number := null;
  v_bem_id number := 1; -- 'NYEC OPS Manage Work'
  v_bi_id number := null;
  v_bia_id number := null;
  v_bsl_id number := 1; -- 'CORP_ETL_MANAGE_WORK'
  v_bue_id number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_source_id varchar2(100) := null;
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
  v_sql_code number := null;
  v_error_message varchar2(500) := null;
  
  v_end_date date := null;
  v_current_date date := null;
  
  cursor c_bpm_errors is 
    select BI_ID,SOURCE_ID,ERROR_DATE
    from BPM_ERRORS
    where ERROR_NUMBER = -60
    order by ERROR_DATE asc;

  v_age_in_business_days number := null;
  v_cancel_work_date date := null;
  v_complete_date date := null;
  v_escalated_flag varchar(1) := null;
  v_escalated_to_name varchar2(100) := null;
  v_forwarded_by_name varchar2(100) := null;
  v_forwarded_flag varchar2(1) := null;
  v_group_name varchar2(100) := null;
  v_group_parent_name varchar2(100) := null;
  v_group_supervisor_name varchar2(100) := null;
  v_last_update_by_name varchar2(100) := null;
  v_last_update_date date := null;
  v_owner_name varchar2(100) := null;
  v_sla_days number := null;
  v_sla_days_type varchar2(1) := null;
  v_sla_jeopardy_days number := null;
  v_sla_target_days number := null;
  v_source_reference_id number := null;
  v_source_reference_type varchar2(30) := null;
  v_status_age_in_bus_days number := null;
  v_status_date date := null;
  v_task_status varchar2(50) := null;
  v_task_type varchar2(100) := null;
  v_team_name varchar2(100) := null;
  v_team_parent_name varchar2(100) := null;
  v_team_supervisor_name varchar2(100) := null;
  v_unit_of_work varchar2(30) := null;
  
begin
  
  for r_bpm_errors in c_bpm_errors
  loop
  
    v_bi_id := r_bpm_errors.BI_ID;
    v_current_date := r_bpm_errors.ERROR_DATE;
  
    select
      AGE_IN_BUSINESS_DAYS,
      CANCEL_WORK_DATE,
      COMPLETE_DATE,
      ESCALATED_FLAG,
      ESCALATED_TO_NAME,
      FORWARDED_BY_NAME,
      FORWARDED_FLAG,
      GROUP_NAME,
      GROUP_PARENT_NAME,
      GROUP_SUPERVISOR_NAME,
      LAST_UPDATE_BY_NAME,
      LAST_UPDATE_DATE,
      OWNER_NAME,
      SLA_DAYS,
      SLA_DAYS_TYPE,
      SLA_JEOPARDY_DAYS,
      SLA_TARGET_DAYS,
      SOURCE_REFERENCE_ID,
      SOURCE_REFERENCE_TYPE,
      STATUS_AGE_IN_BUS_DAYS,
      STATUS_DATE,
      TASK_STATUS,
      TASK_TYPE,
      TEAM_NAME,
      TEAM_PARENT_NAME,
      TEAM_SUPERVISOR_NAME,
      UNIT_OF_WORK
    into
      v_age_in_business_days,
      v_cancel_work_date,
      v_complete_date,
      v_escalated_flag,
      v_escalated_to_name,
      v_forwarded_by_name,
      v_forwarded_flag,
      v_group_name,
      v_group_parent_name,
      v_group_supervisor_name,
      v_last_update_by_name,
      v_last_update_date,
      v_owner_name,
      v_sla_days,
      v_sla_days_type,
      v_sla_jeopardy_days,
      v_sla_target_days,
      v_source_reference_id,
      v_source_reference_type,
      v_status_age_in_bus_days,
      v_status_date,
      v_task_status,
      v_task_type,
      v_team_name,
      v_team_parent_name,
      v_team_supervisor_name,
      v_unit_of_work
    from CORP_ETL_MANAGE_WORK
    where CEMW_ID = r_bpm_errors.SOURCE_ID;
  
    v_end_date := coalesce(v_complete_date,v_cancel_work_date);
  
    if v_end_date is not null then
      update BPM_INSTANCE
      set
        END_DATE = v_end_date,
        LAST_UPDATE_DATE = v_current_date
      where BI_ID = v_bi_id;
    else
      update BPM_INSTANCE
      set LAST_UPDATE_DATE = v_current_date
      where BI_ID = v_bi_id;
    end if;
    
    commit;
  
    v_bue_id := SEQ_BUE_ID.nextval;
  
    insert into BPM_UPDATE_EVENT
      (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values
      (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');
  
    v_source_id := substr(to_char(r_bpm_errors.SOURCE_ID),1,100);
  
    TPRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,  1,v_age_in_business_days,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id,  3,v_cancel_work_date,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id,  5,v_complete_date,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id,  9,v_escalated_flag,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 10,v_escalated_to_name,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 11,v_forwarded_by_name,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 12,v_forwarded_flag,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 13,v_group_name,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 14,v_group_parent_name,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 15,v_group_supervisor_name,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 17,v_last_update_by_name,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id, 18,v_last_update_date,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 19,v_owner_name,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 20,v_sla_days,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 21,v_sla_days_type,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 22,v_sla_jeopardy_days,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 23,v_sla_target_days,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 24,v_source_reference_id,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 25,v_source_reference_type,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 26,v_status_age_in_bus_days,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id, 28,v_status_date,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 30,v_task_status,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 31,v_task_type,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 32,v_team_name,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 33,v_team_parent_name,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 34,v_team_supervisor_name,v_bue_id,v_current_date);
    TPRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 36,v_unit_of_work,v_bue_id,v_current_date);
    
   commit;
    
  end loop;
  
end;
/

commit;

execute TPRC_U_CORP_ETL_MANAGE_WORK;

drop procedure TPRC_U_CORP_ETL_MANAGE_WORK;
drop procedure TPRC_BPM_ETL_BIA_UPD_NUM;
drop procedure TPRC_BPM_ETL_BIA_UPD_DATE;
drop procedure TPRC_BPM_ETL_BIA_UPD_CHAR;
drop procedure TPRC_BPM_ETL_BIA_UPD;

commit;