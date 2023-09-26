alter session set plsql_code_type = native;

create or replace package MANAGE_WORK as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  -- XML File Data Version
  -- 1 - original (not supported)
  -- 2 - add CDATA wrapper around all values
  -- 3 - CDATA wrapper only around varchar2 values, add STG_LAST_UPDATE_DATE element
  
  procedure CALC_DMWCUR;

  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable;
     
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable;
  
  function GET_JEOPARDY_FLAG
    (p_sla_days_type in varchar,
     p_age_in_business_days in number,
     p_age_in_calendar_days in number,
     p_sla_jeopardy_days in number,
     p_jeopardy_flag in varchar2)
    return varchar2 parallel_enable;
    
  function GET_STATUS_AGE_IN_BUS_DAYS
    (p_status_date in date,
     p_complete_date in date)
    return number parallel_enable;
     
  function GET_STATUS_AGE_IN_CAL_DAYS
    (p_status_date in date,
     p_complete_date in date)
    return number parallel_enable;
     
  function GET_TIMELINESS_STATUS
    (p_complete_date in date,
     p_sla_days_type in varchar2,
     p_age_in_business_days in number,
     p_age_in_calendar_days in number,
     p_sla_days in number)
    return varchar2 parallel_enable;

  /* 
  Include: 
    CEMW_ID    
    STG_LAST_UPDATE_DATE
  */
  type T_INS_MW_XML is record
    (
     AGE_IN_BUSINESS_DAYS varchar2(100),
     AGE_IN_CALENDAR_DAYS varchar2(100),
     CANCEL_BY varchar2(50),
     CANCEL_METHOD varchar2(50),
     CANCEL_REASON varchar2(256),
     CANCEL_WORK_DATE varchar2(19),
     CANCEL_WORK_FLAG varchar2(1),
     CASE_ID varchar2(100),
     CEMW_ID varchar2(100),
     CLIENT_ID varchar2(100),
     COMPLETE_DATE varchar2(19),
     COMPLETE_FLAG varchar2(1),
     CREATED_BY_NAME varchar2(100),
     CREATE_DATE varchar2(19),
     ESCALATED_FLAG varchar2(1),
     ESCALATED_TO_NAME varchar2(100),
     FORWARDED_BY_NAME varchar2(100),
     FORWARDED_FLAG varchar2(1),
     GROUP_NAME varchar2(100),
     GROUP_PARENT_NAME varchar2(100),
     GROUP_SUPERVISOR_NAME varchar2(100),
     JEOPARDY_FLAG varchar2(1),
     LAST_UPDATE_BY_NAME varchar2(100),
     LAST_UPDATE_DATE varchar2(19),
     OWNER_NAME varchar2(100),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(1),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_TARGET_DAYS varchar2(100),     
     SOURCE_REFERENCE_ID varchar2(100),
     SOURCE_REFERENCE_TYPE varchar2(30),
     STATUS_AGE_IN_BUS_DAYS varchar2(100),
     STATUS_AGE_IN_CAL_DAYS varchar2(100),
     STATUS_DATE varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19),
     TASK_ID varchar2(100),
     TASK_PRIORITY varchar2(50),     
     TASK_STATUS varchar2(50),
     TASK_TYPE varchar2(100),
     TEAM_NAME varchar2(100),
     TEAM_PARENT_NAME varchar2(100),
     TEAM_SUPERVISOR_NAME varchar2(100),
     TIMELINESS_STATUS varchar2(20),
     UNIT_OF_WORK varchar2(30)
    );
      
  /* 
  Include:    
    STG_LAST_UPDATE_DATE
  */
  type T_UPD_MW_XML is record
    (
     AGE_IN_BUSINESS_DAYS varchar2(100),
     AGE_IN_CALENDAR_DAYS varchar2(100),
     CANCEL_BY varchar2(50),
     CANCEL_METHOD varchar2(50),
     CANCEL_REASON varchar2(256),
     CANCEL_WORK_DATE varchar2(19),
     CANCEL_WORK_FLAG varchar2(1),
     CASE_ID varchar2(100),
     CLIENT_ID varchar2(100),
     COMPLETE_DATE varchar2(19),
     COMPLETE_FLAG varchar2(1),
     CREATED_BY_NAME varchar2(100),
     CREATE_DATE varchar2(19),
     ESCALATED_FLAG varchar2(1),
     ESCALATED_TO_NAME varchar2(100),
     FORWARDED_BY_NAME varchar2(100),
     FORWARDED_FLAG varchar2(1),
     GROUP_NAME varchar2(100),
     GROUP_PARENT_NAME varchar2(100),
     GROUP_SUPERVISOR_NAME varchar2(100),
     JEOPARDY_FLAG varchar2(1),
     LAST_UPDATE_BY_NAME varchar2(100),
     LAST_UPDATE_DATE varchar2(19),
     OWNER_NAME varchar2(100),
     SLA_DAYS varchar2(100),
     SLA_DAYS_TYPE varchar2(1),
     SLA_JEOPARDY_DAYS varchar2(100),
     SLA_TARGET_DAYS varchar2(100),     
     SOURCE_REFERENCE_ID varchar2(100),
     SOURCE_REFERENCE_TYPE varchar2(30),
     STATUS_AGE_IN_BUS_DAYS varchar2(100),
     STATUS_AGE_IN_CAL_DAYS varchar2(100),
     STATUS_DATE varchar2(19),
     STG_LAST_UPDATE_DATE varchar2(19),
     TASK_ID varchar2(100),
     TASK_PRIORITY varchar2(50),     
     TASK_STATUS varchar2(50),
     TASK_TYPE varchar2(100),
     TEAM_NAME varchar2(100),
     TEAM_PARENT_NAME varchar2(100),
     TEAM_SUPERVISOR_NAME varchar2(100),
     TIMELINESS_STATUS varchar2(20),
     UNIT_OF_WORK varchar2(30)
    );
    
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);
    
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);
     
end;
/


create or replace package body MANAGE_WORK as

  v_bem_id number := 1; -- 'OPS Manage Work'
  v_bil_id number := 3; -- 'Task ID'
  v_bsl_id number := 1; -- 'CORP_ETL_MANAGE_WORK'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_calc_dnpacur_job_name varchar2(30) := 'CALC_DNPACUR';
  
  
  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
     return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,nvl(p_complete_date,sysdate));
  end;
  
     
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
    return trunc(nvl(p_complete_date,sysdate)) - trunc(p_create_date);
  end;
  
  
  function GET_JEOPARDY_FLAG
    (p_sla_days_type in varchar,
     p_age_in_business_days in number,
     p_age_in_calendar_days in number,
     p_sla_jeopardy_days in number,
     p_jeopardy_flag in varchar2)
    return varchar2 parallel_enable
  as
  begin    
    if (p_sla_days_type = 'B'
        and p_age_in_business_days is not null 
        and p_sla_jeopardy_days is not null 
        and p_age_in_business_days >= p_sla_jeopardy_days)
     or
       (p_sla_days_type = 'C'
        and p_age_in_calendar_days is not null 
        and p_sla_jeopardy_days is not null 
        and p_age_in_calendar_days >= p_sla_jeopardy_days) then
      return 'Y';
    else
      return 'N';
    end if;
  end;
  
  
  function GET_STATUS_AGE_IN_BUS_DAYS
    (p_status_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
     return BPM_COMMON.BUS_DAYS_BETWEEN(p_status_date,nvl(p_complete_date,sysdate));
  end;
  
     
  function GET_STATUS_AGE_IN_CAL_DAYS
    (p_status_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
    return trunc(nvl(p_complete_date,sysdate)) - trunc(p_status_date);
  end;


  function GET_TIMELINESS_STATUS
    (p_complete_date in date,
     p_sla_days_type in varchar2,
     p_age_in_business_days in number,
     p_age_in_calendar_days in number,
     p_sla_days in number)
    return varchar2 parallel_enable
  as
  begin  
    if p_complete_date is null then
      return 'Not Complete';
    elsif p_sla_days is null then
      return 'Not Required';
    elsif (p_sla_days_type = 'B' and p_age_in_business_days > p_sla_days)
          or
          (p_sla_days_type = 'C' and p_age_in_calendar_days > p_sla_days) then
      return 'Untimely';
    else
      return 'Timely';
    end if;
  end;
  
  
  -- Calculate column values in BPM Semantic table D_MW_CURRENT.
  procedure CALC_DMWCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DMWCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
  
    update D_MW_CURRENT
    set
      "Age in Business Days" = GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date"),
      "Age in Calendar Days" = GET_AGE_IN_CALENDAR_DAYS("Create Date","Complete Date"),
      "Jeopardy Flag" = GET_JEOPARDY_FLAG("SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Jeopardy Days","Jeopardy Flag"),
      "Status Age in Business Days" = GET_STATUS_AGE_IN_BUS_DAYS("Current Status Date","Complete Date"),
      "Status Age in Calendar Days" = GET_STATUS_AGE_IN_CAL_DAYS("Current Status Date","Complete Date"),
      "Timeliness Status" = GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days")
    where 
      "Complete Date" is null 
      and "Cancel Work Date" is null;
    
    v_num_rows_updated := sql%rowcount;
    
    commit;

    v_log_message := v_num_rows_updated  || ' D_MW_CURRENT rows updated with calculated attributes by CALC_DMWCUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
    
  exception
  
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);

  end;
 
  
  -- Get dimension ID for BPM Semantic model - Manage Work process - Escalated.
  procedure GET_DMWE_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_escalated_flag in varchar2,
     p_escalated_to_name varchar2,
     p_dmwe_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMWE_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DMWE_ID into p_dmwe_id
    from D_MW_ESCALATED
    where 
      ("Escalated Flag" = p_escalated_flag or ("Escalated Flag" is null and p_escalated_flag is null))
      and ("Escalated To Name" = p_escalated_to_name or ("Escalated To Name" is null and p_escalated_to_name is null));
  exception
    when NO_DATA_FOUND then
      p_dmwe_id := SEQ_DMWE_ID.nextval;
      begin
        insert into D_MW_ESCALATED (DMWE_ID,"Escalated Flag","Escalated To Name")
        values (p_dmwe_id,p_escalated_flag,p_escalated_to_name);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DMWE_ID into p_dmwe_id
          from D_MW_ESCALATED
          where 
            ("Escalated Flag" = p_escalated_flag or ("Escalated Flag" is null and p_escalated_flag is null))
            and ("Escalated To Name" = p_escalated_to_name or ("Escalated To Name" is null and p_escalated_to_name is null));
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
          raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
      raise;
  end;
  

  -- Get dimension ID for BPM Semantic model - Manage Work process - Forwarded.
  procedure GET_DMWF_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_forwarded_by_name in varchar2,
     p_forwarded_flag varchar2,
     p_dmwf_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMWF_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DMWF_ID into p_dmwf_id
    from D_MW_FORWARDED
    where 
      ("Forwarded By Name" = p_forwarded_by_name or ("Forwarded By Name" is null and p_forwarded_by_name is null))
      and ("Forwarded Flag" = p_forwarded_flag or ("Forwarded Flag" is null and p_forwarded_flag is null));
  exception
    when NO_DATA_FOUND then
      p_dmwf_id := SEQ_DMWF_ID.nextval;
      begin
        insert into D_MW_FORWARDED (DMWF_ID,"Forwarded By Name","Forwarded Flag")
        values (p_dmwf_id,p_forwarded_by_name,p_forwarded_flag);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DMWF_ID into p_dmwf_id
          from D_MW_FORWARDED
          where 
            ("Forwarded By Name" = p_forwarded_by_name or ("Forwarded By Name" is null and p_forwarded_by_name is null))
            and ("Forwarded Flag" = p_forwarded_flag or ("Forwarded Flag" is null and p_forwarded_flag is null));
       when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
         raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
      raise;
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Manage Work process - Last Update By Name.
  procedure GET_DMWLUBN_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_last_update_by_name in varchar2,
     p_dmwlubn_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMWLUBN_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DMWLUBN_ID into p_dmwlubn_id
    from D_MW_LAST_UPDATE_BY_NAME
    where "Last Update By Name" = p_last_update_by_name or ("Last Update By Name" is null and p_last_update_by_name is null);
  exception
    when NO_DATA_FOUND then
      p_dmwlubn_id := SEQ_DMWLUBN_ID.nextval;
      begin
        insert into D_MW_LAST_UPDATE_BY_NAME (DMWLUBN_ID,"Last Update By Name")
        values (p_dmwlubn_id,p_last_update_by_name);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DMWLUBN_ID into p_dmwlubn_id
          from D_MW_LAST_UPDATE_BY_NAME
          where "Last Update By Name" = p_last_update_by_name or ("Last Update By Name" is null and p_last_update_by_name is null);
       when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
        raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
      raise;
  end;

  
  -- Get dimension ID for BPM Semantic model - Manage Work process - Owner.
  procedure GET_DMWO_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_owner_name in varchar2,
     p_dmwo_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMWO_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DMWO_ID into p_dmwo_id
    from D_MW_OWNER
    where "Owner Name" = p_owner_name or ("Owner Name" is null and p_owner_name is null);
  exception
    when NO_DATA_FOUND then
      p_dmwo_id := SEQ_DMWO_ID.nextval;
      begin
        insert into D_MW_OWNER (DMWO_ID,"Owner Name")
        values (p_dmwo_id,p_owner_name);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DMWO_ID into p_dmwo_id
          from D_MW_OWNER
          where "Owner Name" = p_owner_name or ("Owner Name" is null and p_owner_name is null);
        when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
         raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
      raise;
  end;
  
  
  -- Get dimension ID for  BPM Semantic model - Manage Work process - Task Status. 
   procedure GET_DMWTS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_task_status in varchar2,
     p_dmwts_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMWTS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DMWTS_ID into p_dmwts_id
    from D_MW_TASK_STATUS
    where "Task Status" = p_task_status or ("Task Status" is null and p_task_status is null);
  exception
    when NO_DATA_FOUND then
      p_dmwts_id := SEQ_DMWTS_ID.nextval;
      begin
        insert into D_MW_TASK_STATUS (DMWTS_ID,"Task Status")
        values (p_dmwts_id,p_task_status);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DMWTS_ID into p_dmwts_id
          from D_MW_TASK_STATUS
          where "Task Status" = p_task_status or ("Task Status" is null and p_task_status is null);       
        when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
         raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
      raise;
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Manage Work process - Task Type
  procedure GET_DMWTT_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_group_name in varchar2,
     p_group_parent_name in varchar2,
     p_group_supervisor_name in varchar2,
     p_task_type in varchar2,
     p_team_name in varchar2,
     p_team_parent_name in varchar2,
     p_team_supervisor_name in varchar2,
     p_dmwtt_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DMWTT_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DMWTT_ID into p_dmwtt_id
    from D_MW_TASK_TYPE
    where 
      ("Group Name" = p_group_name or ("Group Name" is null and p_group_name is null))
      and ("Group Parent Name" = p_group_parent_name or ("Group Parent Name" is null and p_group_parent_name is null))
      and ("Group Supervisor Name" = p_group_supervisor_name or ("Group Supervisor Name" is null and p_group_supervisor_name is null))
      and ("Task Type" = p_task_type or ("Task Type" is null and p_task_type is null))
      and ("Team Name" = p_team_name or ("Team Name" is null and p_team_name is null))
      and ("Team Parent Name" = p_team_parent_name or ("Team Parent Name" is null and p_team_parent_name is null))
      and ("Team Supervisor Name" = p_team_supervisor_name or ("Team Supervisor Name" is null and p_team_supervisor_name is null));
  exception
    when NO_DATA_FOUND then
      p_dmwtt_id := SEQ_DMWTT_ID.nextval;
      begin
        insert into D_MW_TASK_TYPE 
          (DMWTT_ID,"Group Name","Group Parent Name","Group Supervisor Name",
           "Task Type","Team Name","Team Parent Name","Team Supervisor Name")
        values 
          (p_dmwtt_id,p_group_name,p_group_parent_name,p_group_supervisor_name,
           p_task_type,p_team_name,p_team_parent_name,p_team_supervisor_name);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DMWTT_ID into p_dmwtt_id
          from D_MW_TASK_TYPE
          where 
            ("Group Name" = p_group_name or ("Group Name" is null and p_group_name is null))
            and ("Group Parent Name" = p_group_parent_name or ("Group Parent Name" is null and p_group_parent_name is null))
            and ("Group Supervisor Name" = p_group_supervisor_name or ("Group Supervisor Name" is null and p_group_supervisor_name is null))
            and ("Task Type" = p_task_type or ("Task Type" is null and p_task_type is null))
            and ("Team Name" = p_team_name or ("Team Name" is null and p_team_name is null))
            and ("Team Parent Name" = p_team_parent_name or ("Team Parent Name" is null and p_team_parent_name is null))
            and ("Team Supervisor Name" = p_team_supervisor_name or ("Team Supervisor Name" is null and p_team_supervisor_name is null));
        when OTHERS then
         v_sql_code := SQLCODE;
         v_log_message := SQLERRM;
         BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
         raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
      raise;
  end;


  -- Get record for Manage Work insert data.
  procedure GET_INS_MW_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_MW_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_MW_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

   select
        extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_CALENDAR_DAYS') "AGE_IN_CALENDAR_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_WORK_DATE') "CANCEL_WORK_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_WORK_FLAG') "CANCEL_WORK_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/CEMW_ID') "CEMW_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DATE') "COMPLETE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_FLAG') "COMPLETE_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DATE') "CREATE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/ESCALATED_FLAG') "ESCALATED_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/ESCALATED_TO_NAME') "ESCALATED_TO_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_BY_NAME') "FORWARDED_BY_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_FLAG') "FORWARDED_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/GROUP_NAME') "GROUP_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/GROUP_PARENT_NAME') "GROUP_PARENT_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/GROUP_SUPERVISOR_NAME') "GROUP_SUPERVISOR_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/JEOPARDY_FLAG') "JEOPARDY_FLAG",
        extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_DATE') "LAST_UPDATE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/OWNER_NAME') "OWNER_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS') "SLA_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS_TYPE') "SLA_DAYS_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DAYS') "SLA_JEOPARDY_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/SLA_TARGET_DAYS') "SLA_TARGET_DAYS",        
        extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_REFERENCE_ID') "SOURCE_REFERENCE_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_REFERENCE_TYPE') "SOURCE_REFERENCE_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/STATUS_AGE_IN_BUS_DAYS') "STATUS_AGE_IN_BUS_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/STATUS_AGE_IN_CAL_DAYS') "STATUS_AGE_IN_CAL_DAYS",
        extractValue(p_data_xml,'/ROWSET/ROW/STATUS_DATE') "STATUS_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_ID') "TASK_ID",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_PRIORITY') "TASK_PRIORITY",        
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_STATUS') "TASK_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/TASK_TYPE') "TASK_TYPE",
        extractValue(p_data_xml,'/ROWSET/ROW/TEAM_NAME') "TEAM_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/TEAM_PARENT_NAME') "TEAM_PARENT_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/TEAM_SUPERVISOR_NAME') "TEAM_SUPERVISOR_NAME",
        extractValue(p_data_xml,'/ROWSET/ROW/TIMELINESS_STATUS') "TIMELINESS_STATUS",
        extractValue(p_data_xml,'/ROWSET/ROW/UNIT_OF_WORK') "UNIT_OF_WORK"
    into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
    
  end;
  

  -- Get record for Manage Work update data XML. 
  procedure GET_UPD_MW_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_MW_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_MW_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 

    select
      extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_BUSINESS_DAYS') "AGE_IN_BUSINESS_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/AGE_IN_CALENDAR_DAYS') "AGE_IN_CALENDAR_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_WORK_DATE') "CANCEL_WORK_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_WORK_FLAG') "CANCEL_WORK_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DATE') "COMPLETE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_FLAG') "COMPLETE_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DATE') "CREATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/ESCALATED_FLAG') "ESCALATED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/ESCALATED_TO_NAME') "ESCALATED_TO_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_BY_NAME') "FORWARDED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_FLAG') "FORWARDED_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/GROUP_NAME') "GROUP_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/GROUP_PARENT_NAME') "GROUP_PARENT_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/GROUP_SUPERVISOR_NAME') "GROUP_SUPERVISOR_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/JEOPARDY_FLAG') "JEOPARDY_FLAG",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_DATE') "LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/OWNER_NAME') "OWNER_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS') "SLA_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_DAYS_TYPE') "SLA_DAYS_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_JEOPARDY_DAYS') "SLA_JEOPARDY_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/SLA_TARGET_DAYS') "SLA_TARGET_DAYS",      
      extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_REFERENCE_ID') "SOURCE_REFERENCE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/SOURCE_REFERENCE_TYPE') "SOURCE_REFERENCE_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/STATUS_AGE_IN_BUS_DAYS') "STATUS_AGE_IN_BUS_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/STATUS_AGE_IN_CAL_DAYS') "STATUS_AGE_IN_CAL_DAYS",
      extractValue(p_data_xml,'/ROWSET/ROW/STATUS_DATE') "STATUS_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TASK_ID') "TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/TASK_PRIORITY') "TASK_PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/TASK_STATUS') "TASK_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/TASK_TYPE') "TASK_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/TEAM_NAME') "TEAM_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/TEAM_PARENT_NAME') "TEAM_PARENT_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/TEAM_SUPERVISOR_NAME') "TEAM_SUPERVISOR_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/TIMELINESS_STATUS') "TIMELINESS_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/UNIT_OF_WORK') "UNIT_OF_WORK"
     into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;
  

  -- Insert fact for BPM Semantic model - Manage Work process. 
  procedure INS_FMWBD
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_dmwtt_id in number,
     p_dmwe_id in number,
     p_dmwf_id in number,
     p_dmwo_id in number,
     p_dmwts_id in number,
     p_dmwlubn_id in number,
     p_last_update_date in varchar2,
     p_status_date in varchar2,
     p_fmwbd_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FMWBD';
    v_sql_code number := null;
    v_log_message clob := null;
    v_bucket_start_date date := null;
    v_bucket_end_date date := null;
    v_last_update_date date := null;
    v_status_date date := null;
  begin
    v_last_update_date := to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
    v_status_date := to_date(p_status_date,BPM_COMMON.DATE_FMT);
    p_fmwbd_id := SEQ_FMWBD_ID.nextval;
    
    v_bucket_start_date := to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt);
    if p_end_date is null then
      v_bucket_end_date := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
    else 
      v_bucket_end_date := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
    end if;
    
    -- Validate fact date ranges.
    if p_start_date < v_bucket_start_date
      or to_date(to_char(p_start_date,v_date_bucket_fmt),v_date_bucket_fmt) > v_bucket_end_date
      or v_bucket_start_date > v_bucket_end_date
      or v_bucket_end_date < v_bucket_start_date
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || p_start_date || 
        ' BUCKET_START_DATE = ' || to_char(v_bucket_start_date,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(v_bucket_end_date,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
      
    insert into F_MW_BY_DATE
      (FMWBD_ID,
       D_DATE,
       BUCKET_START_DATE,
       BUCKET_END_DATE,
       MW_BI_ID,
       DMWTT_ID,
       DMWE_ID,
       DMWF_ID,
       DMWO_ID,
       DMWTS_ID,
       DMWLUBN_ID,
       "Last Update Date",
       "Status Date",
       CREATION_COUNT,
       INVENTORY_COUNT,
       COMPLETION_COUNT)
    values
      (p_fmwbd_id,
       p_start_date,
       v_bucket_start_date,
       v_bucket_end_date,
       p_bi_id,
       p_dmwtt_id,
       p_dmwe_id,
       p_dmwf_id,
       p_dmwo_id,
       p_dmwts_id,
       p_dmwlubn_id,
       v_last_update_date,
       v_status_date,
       1,
       case 
         when p_end_date is null then 1
         else 0
         end,
       case 
         when p_end_date is null then 0
         else 1
         end
      );
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end; 
    
  -- Insert or update dimension for BPM Semantic model - Manage Work process - Current.
  procedure SET_DMWCUR
      (p_set_type in varchar2,
       p_identifier in varchar2,
       p_bi_id in number,
       p_task_id in varchar2,
       p_age_in_business_days in varchar2,
       p_create_date in varchar2,
       p_complete_date in varchar2,
       p_sla_days in varchar2,
       p_sla_days_type in varchar2,
       p_sla_jeopardy_days in varchar2,
       p_sla_target_days in varchar2,
       p_cancel_work_date in varchar2,
       p_created_by_name in varchar2,
       p_source_reference_id in varchar2,
       p_source_reference_type in varchar2,
       p_status_age_in_bus_days in varchar2,
       p_unit_of_work in varchar2,
       p_cur_escalated_flag in varchar2,
       p_cur_escalated_to_name in varchar2,
       p_cur_forwarded_by_name in varchar2,
       p_cur_forwarded_flag in varchar2,
       p_cur_group_name in varchar2,
       p_cur_group_parent_name in varchar2,
       p_cur_group_supervisor_name in varchar2,
       p_cur_last_update_by_name in varchar2,
       p_cur_owner_name in varchar2,
       p_cur_task_status in varchar2,
       p_cur_task_type in varchar2,
       p_cur_team_name in varchar2,
       p_cur_team_parent_name in varchar2,
       p_cur_team_supervisor_name in varchar2,
       p_cur_last_update_date in varchar2,
       p_cur_status_date in varchar2,
       p_cur_client_id in varchar2,
       p_cur_case_id in varchar2,
       p_cancel_method in varchar2,
       p_cancel_reason in varchar2,
       p_cancel_by in varchar2,
       p_task_priority in varchar2)
  as

    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DMWCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dmwcur D_MW_CURRENT%rowtype := null;
    v_dmwcur_rows number := null;
    
  begin
  
    r_dmwcur."Complete Date" := to_date(p_complete_date,BPM_COMMON.DATE_FMT);
    if r_dmwcur."Complete Date" is null then
      r_dmwcur."Complete Flag" := 'N';
    else
      r_dmwcur."Complete Flag" := 'Y';    
    end if;
    r_dmwcur."Create Date" := to_date(p_create_date,BPM_COMMON.DATE_FMT);
    r_dmwcur."Current Status Date" := to_date(p_cur_status_date,BPM_COMMON.DATE_FMT);
    r_dmwcur.MW_BI_ID := p_bi_id;
    r_dmwcur."Task ID" := p_task_id; 
    r_dmwcur."Age in Business Days" := GET_AGE_IN_BUSINESS_DAYS(r_dmwcur."Create Date",r_dmwcur."Complete Date");
    r_dmwcur."Age in Calendar Days" := GET_AGE_IN_CALENDAR_DAYS(r_dmwcur."Create Date",r_dmwcur."Complete Date");
    r_dmwcur."SLA Days Type" := p_sla_days_type;
    r_dmwcur."SLA Jeopardy Days" := p_sla_jeopardy_days;
    r_dmwcur."Jeopardy Flag" := GET_JEOPARDY_FLAG(r_dmwcur."SLA Days Type",r_dmwcur."Age in Business Days",r_dmwcur."Age in Calendar Days",r_dmwcur."SLA Jeopardy Days",r_dmwcur."Jeopardy Flag");
    r_dmwcur."SLA Days" := p_sla_days;
    r_dmwcur."SLA Target Days" := p_sla_target_days;
    r_dmwcur."Timeliness Status" := GET_TIMELINESS_STATUS(r_dmwcur."Complete Date",r_dmwcur."SLA Days Type",r_dmwcur."Age in Business Days",r_dmwcur."Age in Calendar Days",r_dmwcur."SLA Days");
    r_dmwcur."Cancel Work Date" := to_date(p_cancel_work_date,BPM_COMMON.DATE_FMT);
    if r_dmwcur."Cancel Work Date" is null then
      r_dmwcur."Cancel Work Flag" := 'N';
    else
      r_dmwcur."Cancel Work Flag" := 'Y';    
    end if;
    r_dmwcur."Created By Name" := p_created_by_name;
    r_dmwcur."Source Reference ID" := p_source_reference_id;
    r_dmwcur."Source Reference Type" := p_source_reference_type;
    r_dmwcur."Status Age in Business Days" := GET_STATUS_AGE_IN_BUS_DAYS(r_dmwcur."Current Status Date",r_dmwcur."Complete Date");
    r_dmwcur."Status Age in Calendar Days" := GET_STATUS_AGE_IN_CAL_DAYS(r_dmwcur."Current Status Date",r_dmwcur."Complete Date");
    r_dmwcur."Unit of Work" := p_unit_of_work;
    r_dmwcur."Current Escalated Flag" := p_cur_escalated_flag;
    r_dmwcur."Current Escalated To Name" := p_cur_escalated_to_name;
    r_dmwcur."Current Forwarded By Name" := p_cur_forwarded_by_name;
    r_dmwcur."Current Forwarded Flag" := p_cur_forwarded_flag;
    r_dmwcur."Current Group Name" := p_cur_group_name;
    r_dmwcur."Current Group Parent Name" := p_cur_group_parent_name;
    r_dmwcur."Current Group Supervisor Name" := p_cur_group_supervisor_name;
    r_dmwcur."Current Last Update By Name" := p_cur_last_update_by_name;
    r_dmwcur."Current Owner Name" := p_cur_owner_name;
    r_dmwcur."Current Task Status" := p_cur_task_status;
    r_dmwcur."Current Task Type" := p_cur_task_type;
    r_dmwcur."Current Team Name" := p_cur_team_name;
    r_dmwcur."Current Team Parent Name" := p_cur_team_parent_name;
    r_dmwcur."Current Team Supervisor Name" := p_cur_team_supervisor_name;
    r_dmwcur."Current Last Update Date" := to_date(p_cur_last_update_date,BPM_COMMON.DATE_FMT);
    r_dmwcur.CLIENT_ID := p_cur_client_id;  -- 8/28/13 B.Thai renamed from "Client_ID"
    r_dmwcur.CASE_ID := p_cur_case_id;      -- 8/28/13 B.Thai renamed from "Case_ID"
    r_dmwcur."Cancel Method"  := p_cancel_method;
    r_dmwcur."Cancel Reason"  := p_cancel_reason;
    r_dmwcur."Cancel By"      := p_cancel_by;
    r_dmwcur.TASK_PRIORITY    := p_task_priority;    
   
    if p_set_type = 'INSERT' then
      insert into D_MW_CURRENT
      values r_dmwcur;
    elsif p_set_type = 'UPDATE' then
      update D_MW_CURRENT
      set row = r_dmwcur
      where MW_BI_ID = p_bi_id;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(-20001,v_log_message);
    end if; 
    
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      raise;
  end;
  

  -- Insert BPM Semantic model data.
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype)
  as
  
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_sql_code number := null;
    v_log_message clob := null;
    
    v_new_data T_INS_MW_XML := null;
    
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
    
    v_start_date date := null;
    v_end_date date := null;
    
    v_dmwe_id number := null;
    v_dmwf_id number := null;
    v_dmwlubn_id number := null;
    v_dmwlud_id number := null;
    v_dmwo_id number := null;
    v_dmwts_id number := null;
    v_dmwtt_id number := null;
    v_fmwbd_id number := null;
    
  begin

    if p_data_version = 2 or p_data_version = 3 then  
      GET_INS_MW_XML(p_new_data_xml,v_new_data);
    else
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Manage Work in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;

    v_identifier := v_new_data.TASK_ID;
    v_start_date := to_date(v_new_data.CREATE_DATE,BPM_COMMON.DATE_FMT);
    --v_end_date := to_date(v_new_data.COMPLETE_DATE,BPM_COMMON.DATE_FMT);
    v_end_date   := to_date(coalesce(v_new_data.COMPLETE_DATE,v_new_data.CANCEL_WORK_DATE),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_bi_id := SEQ_BI_ID.nextval;

    GET_DMWE_ID(v_identifier,v_bi_id,v_new_data.ESCALATED_FLAG,v_new_data.ESCALATED_TO_NAME,v_dmwe_id);
    GET_DMWF_ID(v_identifier,v_bi_id,v_new_data.FORWARDED_BY_NAME,v_new_data.FORWARDED_FLAG,v_dmwf_id);
    GET_DMWLUBN_ID(v_identifier,v_bi_id,v_new_data.LAST_UPDATE_BY_NAME,v_dmwlubn_id);
    GET_DMWO_ID(v_identifier,v_bi_id,v_new_data.OWNER_NAME,v_dmwo_id);
    GET_DMWTS_ID(v_identifier,v_bi_id,v_new_data.TASK_STATUS,v_dmwts_id);
    GET_DMWTT_ID
      (v_identifier,v_bi_id,v_new_data.GROUP_NAME,v_new_data.GROUP_PARENT_NAME,v_new_data.GROUP_SUPERVISOR_NAME,
       v_new_data.TASK_TYPE,v_new_data.TEAM_NAME,v_new_data.TEAM_PARENT_NAME,v_new_data.TEAM_SUPERVISOR_NAME,v_dmwtt_id);
    
    -- Insert current dimension and fact as a single transaction.
    begin
    
      commit;
    
      SET_DMWCUR
        ('INSERT',v_identifier,v_bi_id,
         v_new_data.TASK_ID,v_new_data.AGE_IN_BUSINESS_DAYS,v_new_data.CREATE_DATE,v_new_data.COMPLETE_DATE,
         v_new_data.SLA_DAYS,v_new_data.SLA_DAYS_TYPE,v_new_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_TARGET_DAYS,
         v_new_data.CANCEL_WORK_DATE,v_new_data.CREATED_BY_NAME,
         v_new_data.SOURCE_REFERENCE_ID,v_new_data.SOURCE_REFERENCE_TYPE,v_new_data.STATUS_AGE_IN_BUS_DAYS,v_new_data.UNIT_OF_WORK,
         v_new_data.ESCALATED_FLAG,v_new_data.ESCALATED_TO_NAME,
         v_new_data.FORWARDED_BY_NAME,v_new_data.FORWARDED_FLAG,
         v_new_data.GROUP_NAME,v_new_data.GROUP_PARENT_NAME,v_new_data.GROUP_SUPERVISOR_NAME,
         v_new_data.LAST_UPDATE_BY_NAME,v_new_data.OWNER_NAME,v_new_data.TASK_STATUS,v_new_data.TASK_TYPE,
         v_new_data.TEAM_NAME,v_new_data.TEAM_PARENT_NAME,v_new_data.TEAM_SUPERVISOR_NAME,
         v_new_data.LAST_UPDATE_DATE,v_new_data.STATUS_DATE,v_new_data.CLIENT_ID,v_new_data.CASE_ID,
         v_new_data.CANCEL_METHOD,v_new_data.CANCEL_REASON,v_new_data.CANCEL_BY,v_new_data.TASK_PRIORITY);
      
      INS_FMWBD(v_identifier,v_start_date,v_end_date,v_bi_id,v_dmwtt_id,v_dmwe_id,v_dmwf_id,v_dmwo_id,v_dmwts_id,v_dmwlubn_id,v_new_data.LAST_UPDATE_DATE,v_new_data.STATUS_DATE,v_fmwbd_id);
     
      commit;
      
    exception
    
      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
	      v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code);  
        raise;

    end;
    
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code); 
      raise;
    
  end;
  
  
  -- Update fact for BPM Semantic model - Manage Work process. 
  procedure UPD_FMWBD
    (p_identifier in varchar2,
     p_end_date in date,
     p_bi_id in number,
     p_dmwtt_id in number,
     p_dmwe_id in number,
     p_dmwf_id in number,
     p_dmwo_id in number,
     p_dmwts_id in number,
     p_dmwlubn_id in number,
     p_last_update_date in varchar2,
     p_stg_last_update_date in varchar2,
     p_status_date in varchar2,
     p_fmwbd_id out number)
  as
  
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FMWBD';
    v_sql_code number := null;
    v_log_message clob := null;
    
    v_fmwbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_last_update_date date := null;
    v_event_date date := null;
    v_status_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;

    v_dmwtt_id   number := null;
    v_dmwe_id    number := null;
    v_dmwf_id    number := null;
    v_dmwo_id    number := null;
    v_dmwts_id   number := null;
    v_dmwlubn_id number := null;
    
    r_fmwbd F_MW_BY_DATE%rowtype := null;
    
  begin
    v_last_update_date := to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
    v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := coalesce(v_stg_last_update_date,v_last_update_date);
    v_status_date := to_date(p_status_date,BPM_COMMON.DATE_FMT);
    
    v_dmwtt_id   := p_dmwtt_id;
    v_dmwe_id    := p_dmwe_id;
    v_dmwf_id    := p_dmwf_id;
    v_dmwo_id    := p_dmwo_id;
    v_dmwts_id   := p_dmwts_id;
    v_dmwlubn_id := p_dmwlubn_id;
    
    with most_recent_fact_bi_id as
      (select 
         max(FMWBD_ID) max_fmwbd_id,
         max(D_DATE) max_d_date
       from F_MW_BY_DATE
       where MW_BI_ID = p_bi_id) 
    select 
      fmwbd.FMWBD_ID,
      fmwbd.D_DATE,
      fmwbd.CREATION_COUNT,
      fmwbd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into 
      v_fmwbd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_completion_count_old,
      v_max_d_date
    from 
      F_MW_BY_DATE fmwbd,
      most_recent_fact_bi_id 
    where
     fmwbd.FMWBD_ID = max_fmwbd_id
     and fmwbd.D_DATE = most_recent_fact_bi_id.max_d_date;
     
    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
    
    -- Handle case where update to staging table has older event date.
    if v_event_date < v_max_d_date then
      v_event_date := v_max_d_date;
    end if;
    
    if p_end_date is null then
      r_fmwbd.D_DATE := v_event_date;
      r_fmwbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fmwbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fmwbd.INVENTORY_COUNT := 1;
      r_fmwbd.COMPLETION_COUNT := 0;
    else
    -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
      if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
        delete from F_MW_BY_DATE
        where
          MW_BI_ID = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
    with most_recent_fact_bi_id as
      (select
         max(FMWBD_ID) max_fmwbd_id,
         max(D_DATE) max_d_date
         from F_MW_BY_DATE
         where MW_BI_ID = p_bi_id)
        select
          fmwbd.FMWBD_ID,
          fmwbd.D_DATE,
          fmwbd.CREATION_COUNT,
          fmwbd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date,
          fmwbd.DMWTT_ID,
          fmwbd.DMWE_ID,
          fmwbd.DMWF_ID,	
          fmwbd.DMWO_ID,
          fmwbd.DMWTS_ID,
          fmwbd.DMWLUBN_ID
          into
          v_fmwbd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date,
          v_dmwtt_id,
          v_dmwe_id,
          v_dmwf_id,
          v_dmwo_id,
          v_dmwts_id,
          v_dmwlubn_id
         from
          F_MW_BY_DATE fmwbd,
          most_recent_fact_bi_id
        where
          fmwbd.FMWBD_ID = max_fmwbd_id
          and fmwbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      end if;
    
      r_fmwbd.D_DATE := p_end_date;
      r_fmwbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fmwbd.BUCKET_END_DATE := r_fmwbd.BUCKET_START_DATE;
      r_fmwbd.INVENTORY_COUNT := 0;
      r_fmwbd.COMPLETION_COUNT := 1;
    end if;

    p_fmwbd_id := SEQ_FMWBD_ID.nextval;
    r_fmwbd.FMWBD_ID := p_fmwbd_id;
    r_fmwbd.MW_BI_ID := p_bi_id;
    r_fmwbd.DMWTT_ID := v_dmwtt_id;
    r_fmwbd.DMWE_ID := v_dmwe_id;
    r_fmwbd.DMWF_ID := v_dmwf_id;
    r_fmwbd.DMWO_ID := v_dmwo_id;
    r_fmwbd.DMWTS_ID := v_dmwts_id;
    r_fmwbd.DMWLUBN_ID := v_dmwlubn_id;
    r_fmwbd."Last Update Date" := v_last_update_date;
    r_fmwbd."Status Date" := v_status_date;
    r_fmwbd.CREATION_COUNT := 0;
    
    -- Validate fact date ranges.
    if r_fmwbd.D_DATE < r_fmwbd.BUCKET_START_DATE
      or to_date(to_char(r_fmwbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fmwbd.BUCKET_END_DATE
      or r_fmwbd.BUCKET_START_DATE > r_fmwbd.BUCKET_END_DATE
      or r_fmwbd.BUCKET_END_DATE < r_fmwbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fmwbd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fmwbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fmwbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   
    
    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fmwbd.BUCKET_START_DATE then
      -- Same bucket time.
      if v_creation_count_old = 1 then
        r_fmwbd.CREATION_COUNT := v_creation_count_old;
      end if;
      update F_MW_BY_DATE
      set row = r_fmwbd
      where FMWBD_ID = v_fmwbd_id_old;
    else
      -- Different bucket time.
      update F_MW_BY_DATE
      set BUCKET_END_DATE = r_fmwbd.BUCKET_START_DATE
      where FMWBD_ID = v_fmwbd_id_old;
      
      insert into F_MW_BY_DATE
      values r_fmwbd;
    end if;
  
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code); 
      raise;
  end; 

  -- Update BPM Semantic model data.
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype)
  as
  
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';   
    v_sql_code number := null;
    v_log_message clob := null;
    
    v_old_data T_UPD_MW_XML := null;
    v_new_data T_UPD_MW_XML := null;
  
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
    
    v_start_date date := null;
    v_end_date date := null;
    
    v_dmwe_id number := null;
    v_dmwf_id number := null;
    v_dmwlubn_id number := null;
    v_dmwlud_id number := null;
    v_dmwo_id number := null;
    v_dmwts_id number := null;
    v_dmwtt_id number := null;
    v_fmwbd_id number := null;
    
  begin
 
    if p_data_version = 2 or p_data_version = 3 then
      GET_UPD_MW_XML(p_old_data_xml,v_old_data);
      GET_UPD_MW_XML(p_new_data_xml,v_new_data);
    else
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Manage Work in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;   

    v_identifier := v_new_data.TASK_ID;
    v_start_date := to_date(v_new_data.CREATE_DATE,BPM_COMMON.DATE_FMT);
    --v_end_date := to_date(v_new_data.COMPLETE_DATE,BPM_COMMON.DATE_FMT);
    v_end_date   := to_date(coalesce(v_new_data.COMPLETE_DATE,v_new_data.CANCEL_WORK_DATE),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
  
    select MW_BI_ID 
    into v_bi_id
    from D_MW_CURRENT
    where "Task ID" = v_identifier;

    GET_DMWE_ID(v_identifier,v_bi_id,v_new_data.ESCALATED_FLAG,v_new_data.ESCALATED_TO_NAME,v_dmwe_id);
    GET_DMWF_ID(v_identifier,v_bi_id,v_new_data.FORWARDED_BY_NAME,v_new_data.FORWARDED_FLAG,v_dmwf_id);
    GET_DMWLUBN_ID(v_identifier,v_bi_id,v_new_data.LAST_UPDATE_BY_NAME,v_dmwlubn_id);
    GET_DMWO_ID(v_identifier,v_bi_id,v_new_data.OWNER_NAME,v_dmwo_id);
    GET_DMWTS_ID(v_identifier,v_bi_id,v_new_data.TASK_STATUS,v_dmwts_id);
    GET_DMWTT_ID
      (v_identifier,v_bi_id,v_new_data.GROUP_NAME,v_new_data.GROUP_PARENT_NAME,v_new_data.GROUP_SUPERVISOR_NAME,
       v_new_data.TASK_TYPE,v_new_data.TEAM_NAME,v_new_data.TEAM_PARENT_NAME,v_new_data.TEAM_SUPERVISOR_NAME,v_dmwtt_id);
       
    -- Update current dimension and fact as a single transaction.
    begin
       
      commit;
       
      SET_DMWCUR
        ('UPDATE',v_identifier,v_bi_id,
         v_new_data.TASK_ID,v_new_data.AGE_IN_BUSINESS_DAYS,v_new_data.CREATE_DATE,v_new_data.COMPLETE_DATE,
         v_new_data.SLA_DAYS,v_new_data.SLA_DAYS_TYPE,v_new_data.SLA_JEOPARDY_DAYS,v_new_data.SLA_TARGET_DAYS,
         v_new_data.CANCEL_WORK_DATE,v_new_data.CREATED_BY_NAME,
         v_new_data.SOURCE_REFERENCE_ID,v_new_data.SOURCE_REFERENCE_TYPE,v_new_data.STATUS_AGE_IN_BUS_DAYS,v_new_data.UNIT_OF_WORK,
         v_new_data.ESCALATED_FLAG,v_new_data.ESCALATED_TO_NAME,
         v_new_data.FORWARDED_BY_NAME,v_new_data.FORWARDED_FLAG,
         v_new_data.GROUP_NAME,v_new_data.GROUP_PARENT_NAME,v_new_data.GROUP_SUPERVISOR_NAME,
         v_new_data.LAST_UPDATE_BY_NAME,v_new_data.OWNER_NAME,v_new_data.TASK_STATUS,v_new_data.TASK_TYPE,
         v_new_data.TEAM_NAME,v_new_data.TEAM_PARENT_NAME,v_new_data.TEAM_SUPERVISOR_NAME,
         v_new_data.LAST_UPDATE_DATE,v_new_data.STATUS_DATE,v_new_data.CLIENT_ID,v_new_data.CASE_ID,
         v_new_data.CANCEL_METHOD,v_new_data.CANCEL_REASON,v_new_data.CANCEL_BY,v_new_data.TASK_PRIORITY);
      
      UPD_FMWBD(v_identifier,v_end_date,v_bi_id,v_dmwtt_id,v_dmwe_id,v_dmwf_id,v_dmwo_id,v_dmwts_id,v_dmwlubn_id,v_new_data.LAST_UPDATE_DATE,v_new_data.STG_LAST_UPDATE_DATE,v_new_data.STATUS_DATE,v_fmwbd_id);
    
      commit;
      
    exception
    
      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
        v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code); 
        raise;

    end;
    
  exception

    when NO_DATA_FOUND then
      v_sql_code := SQLCODE;
      v_log_message := 'No BPM_INSTANCE found.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code); 
      raise;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,v_log_message,v_sql_code); 
      raise;

  end;

end;
/

alter session set plsql_code_type = interpreted;