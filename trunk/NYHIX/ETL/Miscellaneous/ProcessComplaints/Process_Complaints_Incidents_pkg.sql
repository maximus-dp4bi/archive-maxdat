alter session set plsql_code_type = native;

create or replace package PROCESS_COMPLAINTS_INCIDENTS as

  procedure CALC_DCMPLCUR;

  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number;

  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number;

  function GET_JEOPARDY_STATUS
    (p_create_dt in date,
     p_complete_dt in date,
     p_identifier_type in varchar2
 )
    return varchar2;

  function GET_TIMELINESS_STATUS
    (p_create_dt in date,
     p_complete_dt in date,
     p_forwarded in varchar2 default 'N',
     p_assd_reslv_inci_doh in date,
     p_identifier_type in varchar2
)
    return varchar2;
    
  function GET_SLA_JEOPARDY_DATE
    (p_create_dt in date,
     p_identifier_type in varchar2
 )
  return date;
  
  function GET_FWDING_TARGET
      (p_forwarded_to in varchar2,
       p_identifier_type in varchar2
   )
    return number;
    
  function GET_FWDING_TIMELINESS_STATUS
        (p_forwarded_to in varchar2,
         p_assd_reslv_inci_doh in date,
         p_ased_reslv_inci_doh in date,
         p_identifier_type in varchar2
    )
      return varchar2;
  /*
  select '     '|| 'NECI_ID varchar2(100),' attr_element from dual
  union
  select '     '|| 'STG_LAST_UPDATE_DATE varchar2(19),' attr_element from dual
  union
  select
    case
      when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
      when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
      else '     ' || atc.COLUMN_NAME || ' varchar2(100),'
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where
    bast.BSL_ID = 22
    and atc.TABLE_NAME = 'NYHX_ETL_COMPLAINTS_INCIDENTS'
  order by attr_element asc;
  */
  type T_INS_PD_XML is record
    (
     ABOUT_PLAN_CODE varchar2(32),
     ABOUT_PROVIDER_ID varchar2(100),
     ACTION_COMMENTS varchar2(100),
     ACTION_TYPE varchar2(64),
     ASED_PERFORM_FOLLOWUP varchar2(19),
     ASED_RESOLVE_INCIDENT_DOH varchar2(19),
     ASED_RESOLVE_INCIDENT_EES_CSS varchar2(19),
     ASED_RESOLVE_INCIDENT_SUP varchar2(19),
     ASED_WITHDRAW_INCIDENT varchar2(19),
     ASF_PERFORM_FOLLOWUP varchar2(1),
     ASF_RESOLVE_INCIDENT_DOH varchar2(1),
     ASF_RESOLVE_INCIDENT_EES_CSS varchar2(1),
     ASF_RESOLVE_INCIDENT_SUP varchar2(1),
     ASF_WITHDRAW_INCIDENT varchar2(1),
     ASSD_PERFORM_FOLLOWUP varchar2(19),
     ASSD_RESOLVE_INCIDENT_DOH varchar2(19),
     ASSD_RESOLVE_INCIDENT_EES_CSS varchar2(19),
     ASSD_RESOLVE_INCIDENT_SUP varchar2(19),
     ASSD_WITHDRAW_INCIDENT varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(40),
     CANCEL_REASON varchar2(40),
     CASE_ID varchar2(100),
     CHANNEL varchar2(80),
     CLIENT_ID varchar2(100),
     CREATED_BY_GROUP varchar2(80),
     CREATED_BY_NAME varchar2(100),
     CREATE_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     DE_TASK_ID varchar2(100),
     ENROLLMENT_STATUS varchar2(32),
     FORWARDED varchar2(1),
     FORWARDED_TO varchar2(50),
     GWF_FOLLOWUP_REQ varchar2(1),
     GWF_RESOLVED_EES_CSS varchar2(30),
     GWF_RESOLVED_SUP varchar2(1),
     GWF_RETURN_TO_STATE varchar2(1),
     INCIDENT_ABOUT varchar2(80),
     INCIDENT_DESCRIPTION varchar2(4000),
     INCIDENT_ID varchar2(100),
     INCIDENT_REASON varchar2(80),
     INCIDENT_STATUS varchar2(80),
     INCIDENT_STATUS_DT varchar2(19),
     INCIDENT_TYPE varchar2(80),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(100),
     NECI_ID varchar2(100),
     OTHER_PARTY_NAME varchar2(64),
     PRIORITY varchar2(256),
     REPORTED_BY varchar2(80),
     REPORTER_RELATIONSHIP varchar2(64),
     RESOLUTION_DESCRIPTION varchar2(4000),
     RESOLUTION_TYPE varchar2(64),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRACKING_NUMBER varchar2(32),
     UPDATED_BY varchar2(80)
    );
    
  /*
  select '     '|| 'STG_LAST_UPDATE_DATE varchar2(19),' attr_element from dual
  union
  select
    case
      when atc.DATA_TYPE = 'DATE' then '     ' || atc.COLUMN_NAME || ' varchar2(19),'
      when atc.DATA_TYPE = 'VARCHAR2' then '     ' || atc.COLUMN_NAME || ' varchar2(' || atc.DATA_LENGTH || '),'
      else '     ' || atc.COLUMN_NAME || ' varchar2(100),'
      end attr_element
  from BPM_ATTRIBUTE_STAGING_TABLE bast
  inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
  where
     bast.BSL_ID = 22
     and atc.TABLE_NAME = 'NYHX_ETL_COMPLAINTS_INCIDENTS'
  order by attr_element asc;
  */
  type T_UPD_PD_XML is record
    (
          ABOUT_PLAN_CODE varchar2(32),
     ABOUT_PROVIDER_ID varchar2(100),
     ACTION_COMMENTS varchar2(100),
     ACTION_TYPE varchar2(64),
     ASED_PERFORM_FOLLOWUP varchar2(19),
     ASED_RESOLVE_INCIDENT_DOH varchar2(19),
     ASED_RESOLVE_INCIDENT_EES_CSS varchar2(19),
     ASED_RESOLVE_INCIDENT_SUP varchar2(19),
     ASED_WITHDRAW_INCIDENT varchar2(19),
     ASF_PERFORM_FOLLOWUP varchar2(1),
     ASF_RESOLVE_INCIDENT_DOH varchar2(1),
     ASF_RESOLVE_INCIDENT_EES_CSS varchar2(1),
     ASF_RESOLVE_INCIDENT_SUP varchar2(1),
     ASF_WITHDRAW_INCIDENT varchar2(1),
     ASSD_PERFORM_FOLLOWUP varchar2(19),
     ASSD_RESOLVE_INCIDENT_DOH varchar2(19),
     ASSD_RESOLVE_INCIDENT_EES_CSS varchar2(19),
     ASSD_RESOLVE_INCIDENT_SUP varchar2(19),
     ASSD_WITHDRAW_INCIDENT varchar2(19),
     CANCEL_BY varchar2(80),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(40),
     CANCEL_REASON varchar2(40),
     CASE_ID varchar2(100),
     CHANNEL varchar2(80),
     CLIENT_ID varchar2(100),
     CREATED_BY_GROUP varchar2(80),
     CREATED_BY_NAME varchar2(100),
     CREATE_DT varchar2(19),
     CURRENT_TASK_ID varchar2(100),
     DE_TASK_ID varchar2(100),
     ENROLLMENT_STATUS varchar2(32),
     FORWARDED varchar2(1),
     FORWARDED_TO varchar2(50),
     GWF_FOLLOWUP_REQ varchar2(1),
     GWF_RESOLVED_EES_CSS varchar2(30),
     GWF_RESOLVED_SUP varchar2(1),
     GWF_RETURN_TO_STATE varchar2(1),
     INCIDENT_ABOUT varchar2(80),
     INCIDENT_DESCRIPTION varchar2(4000),
     INCIDENT_ID varchar2(100),
     INCIDENT_REASON varchar2(80),
     INCIDENT_STATUS varchar2(80),
     INCIDENT_STATUS_DT varchar2(19),
     INCIDENT_TYPE varchar2(80),
     INSTANCE_COMPLETE_DT varchar2(19),
     INSTANCE_STATUS varchar2(10),
     LAST_UPDATE_BY_DT varchar2(19),
     LAST_UPDATE_BY_NAME varchar2(100),
     OTHER_PARTY_NAME varchar2(64),
     PRIORITY varchar2(256),
     REPORTED_BY varchar2(80),
     REPORTER_RELATIONSHIP varchar2(64),
     RESOLUTION_DESCRIPTION varchar2(4000),
     RESOLUTION_TYPE varchar2(64),
     STG_LAST_UPDATE_DATE varchar2(19),
     TRACKING_NUMBER varchar2(32),
     UPDATED_BY varchar2(80)
    );
  procedure INSERT_BPM_EVENT
    (p_data_version in number,
     p_new_data_xml in xmltype,
     p_bue_id out number);
  procedure INSERT_BPM_SEMANTIC
    (p_data_version in number,
     p_new_data_xml in xmltype);
  procedure UPDATE_BPM_EVENT
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype,
     p_bue_id out number);
  procedure UPDATE_BPM_SEMANTIC
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype);
end;
/


create or replace package body PROCESS_COMPLAINTS_INCIDENTS as
  v_bem_id number := 22; -- 'PROCESS_COMPLAINTS_INCIDENTS'
  v_bil_id number := 10; -- 'Incident ID'
  v_bsl_id number := 22; -- ''
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  v_calc_DCMPLCUR_job_name varchar2(30) := 'CALC_DCMPLCUR';
  v_jeopardy_days number ;
  v_fwding_target number;
  v_bus_datewith_target date;
  v_bus_datewith_jeop date;
  v_timeliness_days number;
  v_step  varchar2(100);

  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number
  as
  begin
     return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,nvl(p_complete_date,sysdate));
  end;
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number
  as
  begin
    return trunc(nvl(p_complete_date,sysdate)) - trunc(p_create_date);
  end;
  
  
  function GET_JEOPARDY_STATUS
    (p_create_dt in date,
     p_complete_dt in date,
     p_identifier_type in varchar2
  )
    return varchar2
      as
  begin
  if p_identifier_type is not null then
  
    select  to_number(out_var)
    into    v_jeopardy_days
    from    corp_etl_list_lkup
    where   name = 'ProcessComp_jeop_threshold'
    and     list_type = 'COMPLAINT'
    and     value = p_identifier_type;
    
    if (ETL_COMMON.GET_BUS_DATE(p_create_dt,v_jeopardy_days) ) < nvl(p_complete_dt,SYSDATE ) then
       return 'N';
    else
       return 'Y';
     end if;
  else
       return 'N';
  end if;
  end;
  
  
  function GET_TIMELINESS_STATUS
    (p_create_dt in date,
     p_complete_dt in date,
     p_forwarded in varchar2 default 'N',
     p_assd_reslv_inci_doh in date,
     p_identifier_type in varchar2
)
    return varchar2
  as
  begin
 if p_identifier_type is not null then
    select  to_number(out_var)
    into    v_timeliness_days
    from    corp_etl_list_lkup
    where   name = 'ProcessComp_timeli_threshold'
    and     list_type = 'COMPLAINT'
    and     value = p_identifier_type;
    
    v_bus_datewith_jeop := ETL_COMMON.GET_BUS_DATE(p_create_dt,v_timeliness_days);
    
    if P_forwarded is not null and p_forwarded = 'N' then
      if v_bus_datewith_jeop < nvl(p_complete_dt,SYSDATE)  then
        return 'Processed Timely';
      else
        return 'Processed Untimely';
      end if;
    elsif P_forwarded is not null and p_forwarded = 'Y' then
       if v_bus_datewith_jeop < p_assd_reslv_inci_doh  then
        return 'Processed Timely';
      else
        return 'Processed Untimely';
      end if;
    end if;  
  else
      return 'Not Processed';
  end if;
  end;
  
    function GET_SLA_JEOPARDY_DATE
        (p_create_dt in date,
         p_identifier_type in varchar2
      )
        return date
          as
      begin
      if p_identifier_type is not null then
      
        select  to_number(out_var)
        into    v_jeopardy_days
        from    corp_etl_list_lkup
        where   name = 'ProcessComp_jeop_threshold'
        and     list_type = 'COMPLAINT'
        and     value = p_identifier_type;
        
       return  ETL_COMMON.GET_BUS_DATE(p_create_dt,v_jeopardy_days);
       
      end if;
  end;
  
  
    function GET_FWDING_TARGET
        (p_forwarded_to in varchar2,
         p_identifier_type in varchar2
      )
        return number
          as
      begin
      v_fwding_target := 0;
      
      if p_identifier_type is not null then
      
        select  to_number(out_var)
        into    v_fwding_target
        from    corp_etl_list_lkup
        where   name = 'ProcessComp_Fwding_Target'
        and     list_type = 'COMPLAINT'
        and 	list_type = p_identifier_type
        and     value = p_forwarded_to;
        
     end if;
    return  v_fwding_target;
    end;
  
  
  function GET_FWDING_TIMELINESS_STATUS
      (p_forwarded_to in varchar2,
       p_assd_reslv_inci_doh in date,
       p_ased_reslv_inci_doh in date,
       p_identifier_type in varchar2
  )
      return varchar2
    as
    begin
   if p_identifier_type is not null and p_forwarded_to is not null then
   
      v_fwding_target := GET_FWDING_TARGET(p_forwarded_to,p_identifier_type);
      
      v_bus_datewith_target := ETL_COMMON.GET_BUS_DATE(p_assd_reslv_inci_doh,v_fwding_target);
      
        if v_bus_datewith_jeop < p_ased_reslv_inci_doh  then
          return 'Processed Timely';
        else
          return 'Processed Untimely';
        end if;
     else
        return 'Not Processed';
    end if;
  end;
  
   -- Calculate column values in BPM Semantic table D_COMPLAINT_CURRENT.
  procedure CALC_DCMPLCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DCMPLCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
    update D_COMPLAINT_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,INSTANCE_COMPLETE_DATE),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,INSTANCE_COMPLETE_DATE),
      JEOPARDY_FLAG = GET_JEOPARDY_STATUS(CREATE_DATE,INSTANCE_COMPLETE_DATE,INCIDENT_TYPE),
      TIMELINESS_STATUS = GET_TIMELINESS_STATUS(CREATE_DATE,INSTANCE_COMPLETE_DATE,FORWARDED_FLAG,RESOLVE_INCIDENT_START,INCIDENT_TYPE),
      JEOPARDY_DAYS_TYPE = 'B',
      SLA_DAYS_TYPE = 'B',
      SLA_JEOPARDY_DATE = GET_SLA_JEOPARDY_DATE(CREATE_DATE,INCIDENT_TYPE),
      SLA_JEOPARDY_DAYS = 7,
      SLA_TARGET_DAYS = 10,
      INCIDENT_FWD_TIMELINESS_STATUS  = GET_FWDING_TIMELINESS_STATUS(FORWARDED_TO,RESOLVE_INCIDENT_START,RESOLVE_INCIDENT_END, INCIDENT_TYPE),
      INCIDENT_FORWARDING_TARGET = GET_FWDING_TARGET(FORWARDED_TO,INCIDENT_TYPE)
      where
     INSTANCE_COMPLETE_DATE is null ;
    --  and "Cancel Date" is null;
    v_num_rows_updated := sql%rowcount;
    commit;
    v_log_message := v_num_rows_updated  || ' D_COMPLAINT_CURRENT rows updated with calculated attributes by CALC_DCMPLCUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,null);
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
  end;
  
  
  -- Get dimension ID for BPM Semantic model - PROCESS_COMPLAINTS_INCIDENTS - Instance Status.
  procedure GET_DCMPLIN_ID
     (p_identifier in varchar2,
      p_bi_id in number,
      p_ins_status in varchar2,
      p_dcmplin_id out number)
   as
     v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLIN_ID';
     v_sql_code number := null;
     v_log_message clob := null;
   begin
     select DCMPLIN_ID into p_dcmplin_id
     from D_COMPLAINT_INSTANCE_STATUS
     where
       INSTANCE_STATUS = p_ins_status
       or (INSTANCE_STATUS is null and p_ins_status is null);
   exception
     when NO_DATA_FOUND then
       p_dcmplin_id := SEQ_DCMPLIN_ID.nextval;
       begin
         insert into D_COMPLAINT_INSTANCE_STATUS (DCMPLIN_ID,INSTANCE_STATUS)
         values (p_dcmplin_id,p_ins_status);
         commit;
       exception
         when DUP_VAL_ON_INDEX then
           select DCMPLIN_ID into p_dcmplin_id
           from D_COMPLAINT_INSTANCE_STATUS
           where
             INSTANCE_STATUS = p_ins_status
             or (INSTANCE_STATUS is null and p_ins_status is null);
         when OTHERS then
           v_sql_code := SQLCODE;
           v_log_message := SQLERRM;
           BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
           raise;
       end;
     when OTHERS then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
       raise;
  end;
  
  
  -- Get dimension ID for BPM Semantic model - PROCESS_COMPLAINTS_INCIDENTS - Incident Status.
  procedure GET_DCMPLIS_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_status in varchar2,
     p_dcmplis_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLIS_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLIS_ID into p_dcmplis_id
    from D_COMPLAINT_INCIDENT_STATUS
    where
      INCIDENT_STATUS = p_status
      or (INCIDENT_STATUS is null and p_status is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplis_id := SEQ_DCMPLIS_ID.nextval;
      begin
        insert into D_COMPLAINT_INCIDENT_STATUS (DCMPLIS_ID,INCIDENT_STATUS)
        values (p_dcmplis_id,p_status);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLIS_ID into p_dcmplis_id
          from D_COMPLAINT_INCIDENT_STATUS
          where
            INCIDENT_STATUS = p_status
            or (INCIDENT_STATUS is null and p_status is null);
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
          raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
  
  
  -- Get dimension ID for BPM Semantic model - PROCESS_COMPLAINTS_INCIDENTS  - Enrollment Status
  procedure GET_DCMPLES_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_enrollment_status in varchar2,
     p_dcmples_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLES_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLES_ID into p_dcmples_id
    from D_COMPLAINT_ENROLLMENT_STATUS
    where
      ENROLLMENT_STATUS = p_enrollment_status
      or (ENROLLMENT_STATUS is null and p_enrollment_status is null);
  exception
    when NO_DATA_FOUND then
      p_dcmples_id := SEQ_DCMPLES_ID.nextval;
      begin
        insert into D_COMPLAINT_ENROLLMENT_STATUS (DCMPLES_ID,ENROLLMENT_STATUS)
        values (p_dcmples_id,p_enrollment_status);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLES_ID into p_dcmples_id
          from D_COMPLAINT_ENROLLMENT_STATUS
          where
            ENROLLMENT_STATUS = p_enrollment_status
            or (ENROLLMENT_STATUS is null and p_enrollment_status is null);
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
          raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process Complaints Incidents - action comments
  procedure GET_DCMPLAC_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_action_comments in varchar2,
     p_dcmplac_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLAC_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
      select DCMPLAC_ID into p_dcmplac_id
      from D_COMPLAINT_ACTION_COMMENTS
      where ACTION_COMMENTS  = p_action_comments
         or (ACTION_COMMENTS  is null and p_action_comments is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplac_id := SEQ_DCMPLAC_ID.nextval;
      begin
        insert into D_COMPLAINT_ACTION_COMMENTS
          (DCMPLAC_ID,ACTION_COMMENTS)
        values
          (p_dcmplac_id,p_action_comments);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
        select DCMPLAC_ID into p_dcmplac_id
        from D_COMPLAINT_ACTION_COMMENTS
        where ACTION_COMMENTS  = p_action_comments
         or (ACTION_COMMENTS  is null and p_action_comments is null);
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
          raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process Complaints Incidents -Incident About
  procedure GET_DCMPLIA_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_incident_about in varchar2,
     p_dcmplia_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLIA_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLIA_ID into p_dcmplia_id
    from D_COMPLAINT_INCIDENT_ABOUT
    where
      INCIDENT_ABOUT  = p_incident_about
      or (INCIDENT_ABOUT  is null and p_incident_about is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplia_id := SEQ_DCMPLIA_ID.nextval;
      begin
        insert into D_COMPLAINT_INCIDENT_ABOUT (DCMPLIA_ID,INCIDENT_ABOUT )
        values (p_dcmplia_id,p_incident_about);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLIA_ID into p_dcmplia_id
          from D_COMPLAINT_INCIDENT_ABOUT
          where
            INCIDENT_ABOUT  = p_incident_about
            or (INCIDENT_ABOUT  is null and p_incident_about is null);
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
          raise;
      end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
  
  
  -- Get dimension ID for BPM Semantic model - Process Complaints Incidents - Incident_Description
  procedure GET_DCMPLID_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_incident_description in varchar2,
     p_dcmplid_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLID_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLID_ID into p_dcmplid_id
    from D_COMPLAINT_INCIDENT_DESC
    where
     INCIDENT_DESCRIPTION = p_incident_description
      or (INCIDENT_DESCRIPTION is null and p_incident_description is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplid_id := SEQ_DCMPLID_ID.nextval;
      begin
        insert into D_COMPLAINT_INCIDENT_DESC  (DCMPLID_ID,INCIDENT_DESCRIPTION)
        values (p_dcmplid_id,p_incident_description);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLID_ID into p_dcmplid_id
          from D_COMPLAINT_INCIDENT_DESC
          where
            INCIDENT_DESCRIPTION = p_incident_description
            or (INCIDENT_DESCRIPTION is null and p_incident_description is null);
          when OTHERS then
            v_sql_code := SQLCODE;
            v_log_message := SQLERRM;
            BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
            raise;
          end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
  
  -- Get dimension ID for BPM Semantic model - Process Complaints Incidents - Incident_Reason
  procedure GET_DCMPLIR_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_incident_reason in varchar2,
     p_dcmplir_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLIR_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLIR_ID into p_dcmplir_id
    from D_COMPLAINT_INCIDENT_REASON
    where
     INCIDENT_REASON = p_incident_reason
      or (INCIDENT_REASON is null and p_incident_reason is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplir_id := SEQ_DCMPLIR_ID.nextval;
      begin
        insert into D_COMPLAINT_INCIDENT_REASON  (DCMPLIR_ID,INCIDENT_REASON)
        values (p_dcmplir_id,p_incident_reason);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLIR_ID into p_dcmplir_id
          from D_COMPLAINT_INCIDENT_REASON
          where
            INCIDENT_REASON = p_incident_reason
            or (INCIDENT_REASON is null and p_incident_reason is null);
          when OTHERS then
            v_sql_code := SQLCODE;
            v_log_message := SQLERRM;
            BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
            raise;
          end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
  
  -- Get dimension ID for BPM Semantic model - Process Complaints Incidents - Resolution_Description
  procedure GET_DCMPLRD_ID
    (p_identifier in varchar2,
     p_bi_id in number,
     p_resolution_description in varchar2,
     p_dcmplrd_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DCMPLRD_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    select DCMPLRD_ID into p_dcmplrd_id
    from D_COMPLAINT_RESOLUTION_DESC
    where
     RESOLUTION_DESCRIPTION = p_resolution_description
      or (RESOLUTION_DESCRIPTION is null and p_resolution_description is null);
  exception
    when NO_DATA_FOUND then
      p_dcmplrd_id := SEQ_DCMPLRD_ID.nextval;
      begin
        insert into D_COMPLAINT_RESOLUTION_DESC  (DCMPLRD_ID,RESOLUTION_DESCRIPTION)
        values (p_dcmplrd_id,p_resolution_description);
        commit;
      exception
        when DUP_VAL_ON_INDEX then
          select DCMPLRD_ID into p_dcmplrd_id
          from D_COMPLAINT_RESOLUTION_DESC
          where
            RESOLUTION_DESCRIPTION = p_resolution_description
            or (RESOLUTION_DESCRIPTION is null and p_resolution_description is null);
          when OTHERS then
            v_sql_code := SQLCODE;
            v_log_message := SQLERRM;
            BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
            raise;
          end;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
  
  -- Get record for Process Document insert XML.
  procedure GET_INS_PD_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_PD_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_PD_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    /*
    select '      extractValue(p_data_xml,''/ROWSET/ROW/NECI_ID'') "' || 'NECI_ID'|| '",' attr_element from dual
    union
    select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
    union
    select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where
      bast.BSL_ID = 22
      and atc.TABLE_NAME = 'NYHX_ETL_COMPLAINTS_INCIDENTS'
    order by attr_element asc;
    */
    select
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_CODE') "ABOUT_PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_ID') "ABOUT_PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_COMMENTS') "ACTION_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE') "ACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_FOLLOWUP') "ASED_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_DOH') "ASED_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_EES_CSS') "ASED_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_SUP') "ASED_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_WITHDRAW_INCIDENT') "ASED_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_FOLLOWUP') "ASF_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_DOH') "ASF_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_EES_CSS') "ASF_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_SUP') "ASF_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_WITHDRAW_INCIDENT') "ASF_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_FOLLOWUP') "ASSD_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_DOH') "ASSD_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_EES_CSS') "ASSD_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_SUP') "ASSD_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_WITHDRAW_INCIDENT') "ASSD_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_GROUP') "CREATED_BY_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/DE_TASK_ID') "DE_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLMENT_STATUS') "ENROLLMENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED') "FORWARDED",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_TO') "FORWARDED_TO",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_FOLLOWUP_REQ') "GWF_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESOLVED_EES_CSS') "GWF_RESOLVED_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESOLVED_SUP') "GWF_RESOLVED_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RETURN_TO_STATE') "GWF_RETURN_TO_STATE",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ABOUT') "INCIDENT_ABOUT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_DESCRIPTION') "INCIDENT_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID') "INCIDENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_REASON') "INCIDENT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS') "INCIDENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS_DT') "INCIDENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_TYPE') "INCIDENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/NECI_ID') "NECI_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_PARTY_NAME') "OTHER_PARTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTED_BY') "REPORTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_RELATIONSHIP') "REPORTER_RELATIONSHIP",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_DESCRIPTION') "RESOLUTION_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_TYPE') "RESOLUTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER",
      extractValue(p_data_xml,'/ROWSET/ROW/UPDATED_BY') "UPDATED_BY"
    into p_data_record
    from dual;
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
      raise;
  end;
  
  
  -- Get record for Process Document update XML.
  procedure GET_UPD_PD_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_PD_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_PD_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    /*
    select '      extractValue(p_data_xml,''/ROWSET/ROW/STG_LAST_UPDATE_DATE'') "' || 'STG_LAST_UPDATE_DATE'|| '",' attr_element from dual
    union
    select '      extractValue(p_data_xml,''/ROWSET/ROW/' || atc.COLUMN_NAME || ''') "' || atc.COLUMN_NAME || '",' attr_element
    from BPM_ATTRIBUTE_STAGING_TABLE bast
    inner join ALL_TAB_COLUMNS atc on (bast.STAGING_TABLE_COLUMN = atc.COLUMN_NAME)
    where
      bast.BSL_ID = 22
      and atc.TABLE_NAME = 'NYHX_ETL_COMPLAINTS_INCIDENTS'
    order by attr_element asc;
    */
    select
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PLAN_CODE') "ABOUT_PLAN_CODE",
      extractValue(p_data_xml,'/ROWSET/ROW/ABOUT_PROVIDER_ID') "ABOUT_PROVIDER_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_COMMENTS') "ACTION_COMMENTS",
      extractValue(p_data_xml,'/ROWSET/ROW/ACTION_TYPE') "ACTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PERFORM_FOLLOWUP') "ASED_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_DOH') "ASED_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_EES_CSS') "ASED_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_RESOLVE_INCIDENT_SUP') "ASED_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_WITHDRAW_INCIDENT') "ASED_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PERFORM_FOLLOWUP') "ASF_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_DOH') "ASF_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_EES_CSS') "ASF_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_RESOLVE_INCIDENT_SUP') "ASF_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_WITHDRAW_INCIDENT') "ASF_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PERFORM_FOLLOWUP') "ASSD_PERFORM_FOLLOWUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_DOH') "ASSD_RESOLVE_INCIDENT_DOH",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_EES_CSS') "ASSD_RESOLVE_INCIDENT_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_RESOLVE_INCIDENT_SUP') "ASSD_RESOLVE_INCIDENT_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_WITHDRAW_INCIDENT') "ASSD_WITHDRAW_INCIDENT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_BY') "CANCEL_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CHANNEL') "CHANNEL",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_GROUP') "CREATED_BY_GROUP",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATED_BY_NAME') "CREATED_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CURRENT_TASK_ID') "CURRENT_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/DE_TASK_ID') "DE_TASK_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/ENROLLMENT_STATUS') "ENROLLMENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED') "FORWARDED",
      extractValue(p_data_xml,'/ROWSET/ROW/FORWARDED_TO') "FORWARDED_TO",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_FOLLOWUP_REQ') "GWF_FOLLOWUP_REQ",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESOLVED_EES_CSS') "GWF_RESOLVED_EES_CSS",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RESOLVED_SUP') "GWF_RESOLVED_SUP",
      extractValue(p_data_xml,'/ROWSET/ROW/GWF_RETURN_TO_STATE') "GWF_RETURN_TO_STATE",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ABOUT') "INCIDENT_ABOUT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_DESCRIPTION') "INCIDENT_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_ID') "INCIDENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_REASON') "INCIDENT_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS') "INCIDENT_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_STATUS_DT') "INCIDENT_STATUS_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INCIDENT_TYPE') "INCIDENT_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_COMPLETE_DT') "INSTANCE_COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_DT') "LAST_UPDATE_BY_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/LAST_UPDATE_BY_NAME') "LAST_UPDATE_BY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/OTHER_PARTY_NAME') "OTHER_PARTY_NAME",
      extractValue(p_data_xml,'/ROWSET/ROW/PRIORITY') "PRIORITY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTED_BY') "REPORTED_BY",
      extractValue(p_data_xml,'/ROWSET/ROW/REPORTER_RELATIONSHIP') "REPORTER_RELATIONSHIP",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_DESCRIPTION') "RESOLUTION_DESCRIPTION",
      extractValue(p_data_xml,'/ROWSET/ROW/RESOLUTION_TYPE') "RESOLUTION_TYPE",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/TRACKING_NUMBER') "TRACKING_NUMBER",
      extractValue(p_data_xml,'/ROWSET/ROW/UPDATED_BY') "UPDATED_BY"
      into p_data_record
    from dual;
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
      raise;
  end;
  
  
  -- Insert fact for BPM Semantic model - ProcessComplaint Incident.
    procedure INS_FPDBD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_current_task_id in number,
       p_dcmplac_id in number,
       p_dcmples_id in number,
       p_dcmplia_id in number,
       p_dcmplid_id in number,
       p_dcmplir_id in number,
       p_dcmplis_id in number,
       p_dcmplin_id in number,
       p_dcmplrd_id in number,
       p_incident_status_date in varchar2,
       p_last_update_date varchar2,
       p_fcmplbd_id out number  )
 
     as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FPDBD';
      v_sql_code number := null;
      v_log_message clob := null;
      v_bucket_start_date date := null;
      v_bucket_end_date date := null;
      v_stg_last_update_date date := null;
    --  v_receipt_date date := null;
      v_invoiceable_date date := null;
    --  v_document_status_dt date := null;
      v_jeopardy_status_dt date := null;
    begin
      v_stg_last_update_date := to_date(p_last_update_date,BPM_COMMON.DATE_FMT);
     -- v_document_status_dt := to_date(p_document_status_dt,BPM_COMMON.DATE_FMT);
      v_jeopardy_status_dt := sysdate;
      p_fcmplbd_id := SEQ_FCMPLBD_ID.nextval;
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
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
      end if;
      
      insert into F_COMPLAINT_BY_DATE
        (FCMPLBD_ID ,
          D_DATE , 
          BUCKET_START_DATE , 
          BUCKET_END_DATE ,
          CMPL_BI_ID ,
          DCMPLAC_ID ,
          CURRENT_TASK_ID ,
          DCMPLES_ID ,
          DCMPLIA_ID ,
          DCMPLID_ID ,
          DCMPLIR_ID ,
          DCMPLIS_ID ,
          DCMPLIN_ID ,
          DCMPLRD_ID ,
          INCIDENT_STATUS_DATE,
          LAST_UPDATE_DATE ,
          CREATION_COUNT ,
          INVENTORY_COUNT ,
          COMPLETION_COUNT 
          )
      values
        (p_fcmplbd_id,
         p_start_date,
         v_bucket_start_date,
         v_bucket_end_date,
         p_bi_id,
         p_dcmplac_id,
         p_current_task_id ,
         p_dcmples_id ,
         p_dcmplia_id ,
         p_dcmplid_id ,
         p_dcmplir_id ,
         p_dcmplis_id ,
         p_dcmplin_id ,
         p_dcmplrd_id ,
         p_incident_status_date,
         p_last_update_date,
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
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
  
  
  -- Insert BPM Event model data.
  procedure INSERT_BPM_EVENT
    (p_data_version in number,
     p_new_data_xml in xmltype,
     p_bue_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_EVENT';
    v_sql_code number := null;
    v_log_message clob := null;
    v_bi_id number := null;
    v_bue_id number := null;
    v_identifier varchar2(35) := null;
    v_start_date date := null;
    v_end_date date := null;
    v_new_data T_INS_PD_XML := null;
  begin
    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for ILEB process mail fax doc in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;
    GET_INS_PD_XML(p_new_data_xml,v_new_data);
    v_bi_id := SEQ_BI_ID.nextval;
    v_step := 'In bpm insert '|| v_bi_id;
    v_identifier := v_new_data.INCIDENT_ID;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    insert into BPM_INSTANCE
      (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
       START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
    values
      (v_bi_id,v_bem_id,v_identifier,v_bil_id,v_bsl_id,
       v_start_date,v_end_date,to_char(v_new_data.NECI_ID),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT));
    commit;
    v_bue_id := SEQ_BUE_ID.nextval;
    insert into BPM_UPDATE_EVENT
      (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values
      (v_bue_id,v_bi_id,v_butl_id,to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT),'N');
      
 /*   select 'BPM_EVENT.INSERT_BIA(v_bi_id, '||b.ba_id || ','||bl.bdl_id || ',v_new_data.'|| stg.staging_table_column || ',v_start_date,v_bue_id);'
      from bpm_attribute b, bpm_attribute_lkup bl,MAXDAT.bpm_attribute_staging_table stg
      where b.bal_id = bl.bal_id
      and stg.ba_id = b.ba_id
      and b.when_populated in ('CREATE','BOTH')
      and b.bem_id = 22
      and bsl_id = 22
      order by b.ba_id*/
      
    BPM_EVENT.INSERT_BIA(v_bi_id, 2410,2,v_new_data.CHANNEL,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2411,2,v_new_data.CREATED_BY_GROUP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2412,2,v_new_data.CREATED_BY_NAME,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2413,1,v_new_data.INCIDENT_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2414,1,v_new_data.TRACKING_NUMBER,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2415,3,v_new_data.CREATE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2416,3,v_new_data.ASED_RESOLVE_INCIDENT_EES_CSS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2417,3,v_new_data.ASSD_RESOLVE_INCIDENT_EES_CSS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2418,3,v_new_data.ASED_RESOLVE_INCIDENT_SUP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2419,3,v_new_data.ASSD_RESOLVE_INCIDENT_SUP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2420,3,v_new_data.ASED_RESOLVE_INCIDENT_DOH,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2421,3,v_new_data.ASSD_RESOLVE_INCIDENT_DOH,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2422,3,v_new_data.ASED_WITHDRAW_INCIDENT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2423,3,v_new_data.ASSD_WITHDRAW_INCIDENT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2424,3,v_new_data.ASED_PERFORM_FOLLOWUP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2425,3,v_new_data.ASSD_PERFORM_FOLLOWUP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2426,2,v_new_data.ABOUT_PLAN_CODE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2427,1,v_new_data.ABOUT_PROVIDER_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2428,2,v_new_data.ACTION_COMMENTS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2429,2,v_new_data.ACTION_TYPE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2430,2,v_new_data.CANCEL_BY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2431,3,v_new_data.CANCEL_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2432,2,v_new_data.CANCEL_METHOD,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2433,2,v_new_data.CANCEL_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2434,1,v_new_data.CURRENT_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2435,1,v_new_data.DE_TASK_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2436,2,v_new_data.ENROLLMENT_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2437,2,v_new_data.INCIDENT_ABOUT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2438,2,v_new_data.INCIDENT_DESCRIPTION,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2439,2,v_new_data.INCIDENT_REASON,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2440,2,v_new_data.INCIDENT_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2441,3,v_new_data.INCIDENT_STATUS_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2442,3,v_new_data.INSTANCE_COMPLETE_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2443,2,v_new_data.INSTANCE_STATUS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2444,2,v_new_data.LAST_UPDATE_BY_NAME,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2445,3,v_new_data.LAST_UPDATE_BY_DT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2446,2,v_new_data.UPDATED_BY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2447,1,v_new_data.CLIENT_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2448,2,v_new_data.OTHER_PARTY_NAME,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2449,1,v_new_data.PRIORITY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2450,2,v_new_data.REPORTED_BY,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2451,2,v_new_data.REPORTER_RELATIONSHIP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2452,2,v_new_data.RESOLUTION_DESCRIPTION,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2453,2,v_new_data.RESOLUTION_TYPE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2454,1,v_new_data.CASE_ID,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2455,2,v_new_data.FORWARDED,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2456,2,v_new_data.INCIDENT_TYPE,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2457,2,v_new_data.FORWARDED_TO,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2462,2,v_new_data.ASF_RESOLVE_INCIDENT_EES_CSS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2463,2,v_new_data.ASF_RESOLVE_INCIDENT_SUP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2464,2,v_new_data.ASF_RESOLVE_INCIDENT_DOH,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2465,2,v_new_data.ASF_PERFORM_FOLLOWUP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2466,2,v_new_data.ASF_WITHDRAW_INCIDENT,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2467,2,v_new_data.GWF_RESOLVED_EES_CSS,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2468,2,v_new_data.GWF_RESOLVED_SUP,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2469,2,v_new_data.GWF_FOLLOWUP_REQ,v_start_date,v_bue_id);
    BPM_EVENT.INSERT_BIA(v_bi_id, 2470,2,v_new_data.GWF_RETURN_TO_STATE,v_start_date,v_bue_id);
    commit;
    p_bue_id := v_bue_id;
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM || v_step;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
  end;
  
  
  -- Insert or update dimension for BPM Semantic model - Process Complaint Incident - Current.
  procedure SET_DPCCUR
    (p_set_type                         in  varchar2,
    p_identifier                        in  varchar2,
    p_bi_id                             in  number,
    p_channel                           in  varchar2,
    p_created_by_group                  in  varchar2,
    p_created_by_name                   in  varchar2,
    p_incident_id                       in  number,
    p_tracking_number                   in  varchar2,
    p_create_date                       in  varchar2  ,                 
    p_res_incident_end                  in  varchar2 ,            
    p_res_incident_start                in  varchar2 ,
    p_res_incident_supv_end             in  varchar2 ,
    p_res_incident_supv_st              in  varchar2 ,
    p_resolve_incident_end              in  varchar2 ,
    p_resolve_incident_start            in  varchar2 ,
    p_withdraw_incident_end             in  varchar2 ,
    p_withdraw_incident_start           in  varchar2 ,
    p_followup_actions_end              in  varchar2 ,
    p_followup_actions_start            in  varchar2 ,
    p_about_plan_code                   in  varchar2,
    p_about_provider_id                 in  number,
    p_cur_action_comments               in  varchar2,
    p_action_type                       in  varchar2, 
    p_cancel_by                         in  varchar2,
    p_cancel_date                       in  varchar2,
    p_cancel_method                     in  varchar2,
    p_cancel_reason                     in  varchar2,
    p_cur_current_task_id               in  number,
    p_data_entry_task_id                in  number,
    p_cur_enrollment_status             in  varchar2,
    p_cur_incident_about                in  varchar2,
    p_cur_incident_description          in  varchar2,
    p_cur_incident_reason               in  varchar2,
    p_cur_incident_status               in  varchar2,
    p_cur_incident_status_date          in  varchar2,
    p_instance_complete_date            in  varchar2,
    p_cur_instance_status               in  varchar2,
    p_cur_last_update_by_name           in  varchar2,
    p_cur_last_update_date              in  varchar2 ,
    p_last_updated_by                   in  varchar2,
    p_client_id                         in  number,
    p_other_party_name                  in  varchar2,
    p_priority                          in  varchar2,
    p_reported_by                       in  varchar2,
    p_reporter_relationship             in  varchar2,
    p_cur_resolution_description        in  varchar2,
    p_resolution_type                   in  varchar2,
    p_case_id                           in  number,
    p_forwarded_flag                    in  varchar2,
    p_incident_type                     in  varchar2,
    p_forwarded_to                      in  varchar2
  --  p_sla_days_type                     in  varchar2,
  --  p_sla_jeopardy_date                 in  varchar2,       
 --   p_sla_jeopardy_days                 in  number,
--    p_sla_target_days                   in  number,
--    p_age_in_business_days              in  number,            
--    p_age_in_calendar_days              in  number,
--    p_jeopardy_days_type                in  varchar2,
 --   p_jeopardy_flag                     in  varchar2,
 --   p_timeliness_status                 in  varchar2,
 --   p_fwd_timeliness_status             in  varchar2,
  --  p_incident_forwarding_target        in  varchar2
     )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DPCCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dpccur D_COMPLAINT_CURRENT%rowtype := null;
    v_jeopardy_flag varchar2(1) := null;
  begin
  
      
  r_dpccur.CMPL_BI_ID := p_bi_id;
  r_dpccur.	CHANNEL                         :=   p_channel                              	;
	r_dpccur.CREATED_BY_GROUP                     	:=   p_created_by_group                     	;
	r_dpccur.CREATED_BY_NAME                      	:=   p_created_by_name                      	;
	r_dpccur.INCIDENT_ID                          	:=   p_incident_id                          	;
	r_dpccur.INCIDENT_TRACKING_NUMBER               :=   p_tracking_number             	;
	r_dpccur.CREATE_DATE                            :=   to_date( p_create_date    ,    BPM_COMMON.DATE_FMT)             	;
	r_dpccur.ATMPT_TO_RES_INCIDENT_END              :=   to_date(p_res_incident_end     ,  BPM_COMMON.DATE_FMT)            ;
	r_dpccur.ATMPT_TO_RES_INCIDENT_START           	:=   to_date(p_res_incident_start    ,  BPM_COMMON.DATE_FMT)         	;
	r_dpccur.ATMPT_TO_RES_INCIDENT_SUPV_END        	:=   to_date(p_res_incident_supv_end ,   BPM_COMMON.DATE_FMT)        	;
	r_dpccur.ATMPT_TO_RES_INCIDENT_SUPV_ST         	:=   to_date( p_res_incident_supv_st  ,   BPM_COMMON.DATE_FMT)        	;
	r_dpccur.RESOLVE_INCIDENT_END                  	:=   to_date( p_resolve_incident_end  ,   BPM_COMMON.DATE_FMT)         ;
	r_dpccur.RESOLVE_INCIDENT_START               	:=   to_date(p_resolve_incident_start ,      BPM_COMMON.DATE_FMT)      ;
	r_dpccur.WITHDRAW_INCIDENT_END                 	:=   to_date(  p_withdraw_incident_end  ,    BPM_COMMON.DATE_FMT)      ;
	r_dpccur.WITHDRAW_INCIDENT_START               	:=   to_date(  p_withdraw_incident_start  ,    BPM_COMMON.DATE_FMT)    ;
	r_dpccur.PERFORM_FOLLOWUP_ACTIONS_END          	:=   to_date(p_followup_actions_end    ,  BPM_COMMON.DATE_FMT)    	;
	r_dpccur.PERFORM_FOLLOWUP_ACTIONS_START        	:=   to_date(p_followup_actions_start  ,    BPM_COMMON.DATE_FMT)  	;
	r_dpccur.ABOUT_PLAN_CODE                      	:=   p_about_plan_code                      	;
	r_dpccur.ABOUT_PROVIDER_ID                    	:=   p_about_provider_id                    	;
	r_dpccur.CUR_ACTION_COMMENTS                  	:=   p_cur_action_comments                 	;
	r_dpccur.ACTION_TYPE                           	:=   p_action_type                           	;
	r_dpccur.CANCEL_BY                            	:=   p_cancel_by                            	;
	r_dpccur.CANCEL_DATE                          	:=   to_date(   p_cancel_date      ,   BPM_COMMON.DATE_FMT)  ;
	r_dpccur.CANCEL_METHOD                        	:=   p_cancel_method                        	;
	r_dpccur.CANCEL_REASON                        	:=   p_cancel_reason                        	;
	r_dpccur.CUR_CURRENT_TASK_ID                  	:=   p_cur_current_task_id                  	;
	r_dpccur.DATA_ENTRY_TASK_ID                   	:=   p_data_entry_task_id                   	;
	r_dpccur.CUR_ENROLLMENT_STATUS                	:=   p_cur_enrollment_status                	;
	r_dpccur.CUR_INCIDENT_ABOUT                   	:=   p_cur_incident_about                   	;
	r_dpccur.CUR_INCIDENT_DESCRIPTION             	:=   p_cur_incident_description            	;
	r_dpccur.CUR_INCIDENT_REASON                  	:=   p_cur_incident_reason                  	;
	r_dpccur.CUR_INCIDENT_STATUS                  	:=   p_cur_incident_status                  	;
	r_dpccur.CUR_INCIDENT_STATUS_DATE             	:=   to_date(  p_cur_incident_status_date   ,     BPM_COMMON.DATE_FMT)          	;
	r_dpccur.INSTANCE_COMPLETE_DATE               	:=   to_date(   p_instance_complete_date     ,   BPM_COMMON.DATE_FMT)            	;
	r_dpccur.CUR_INSTANCE_STATUS                  	:=   p_cur_instance_status                  	;
	r_dpccur.CUR_LAST_UPDATE_BY_NAME              	:=   p_cur_last_update_by_name              	;
	r_dpccur.CUR_LAST_UPDATE_DATE                  	:=   to_date(    p_cur_last_update_date  ,   BPM_COMMON.DATE_FMT)                 	;
	r_dpccur.LAST_UPDATED_BY                      	:=   p_last_updated_by                      	;
	r_dpccur.CLIENT_ID                            	:=   p_client_id                            	;
	r_dpccur.OTHER_PARTY_NAME                     	:=   p_other_party_name                     	;
	r_dpccur.PRIORITY                             	:=   p_priority                             	;
	r_dpccur.REPORTED_BY                          	:=   p_reported_by                          	;
	r_dpccur.REPORTER_RELATIONSHIP                	:=   p_reporter_relationship                	;
	r_dpccur.CUR_RESOLUTION_DESCRIPTION           	:=   p_cur_resolution_description           	;
	r_dpccur.RESOLUTION_TYPE                      	:=   p_resolution_type                      	;
	r_dpccur.CASE_ID                              	:=   p_case_id                              	;
	r_dpccur.FORWARDED_FLAG                       	:=   p_forwarded_flag                       	;
	r_dpccur.INCIDENT_TYPE                        	:=   p_incident_type                        	;
	r_dpccur.FORWARDED_To                         	:=   p_forwarded_to                         	;
	--r_dpccur.SLA_DAYS_TYPE                        	:=   p_sla_days_type                        	;
	--r_dpccur.SLA_JEOPARDY_DATE                      :=   to_date(  p_sla_jeopardy_date    ,        BPM_COMMON.DATE_FMT)                    	;
	--r_dpccur.SLA_JEOPARDY_DAYS                    	:=   p_sla_jeopardy_days                    	;
	--r_dpccur.SLA_Target_DAYS                      	:=   p_sla_target_days                      	;
	--r_dpccur.Age_IN_BUSINESS_DAYS                   :=   GET_AGE_IN_BUSINESS_DAYS(to_date(p_create_date, BPM_COMMON.DATE_FMT), to_date( p_instance_complete_date, BPM_COMMON.DATE_FMT))	;
	--r_dpccur.Age_IN_CALENDAR_DAYS                 	:=   GET_AGE_IN_CALENDAR_DAYS(to_date(p_create_date, BPM_COMMON.DATE_FMT) ,to_date( p_instance_complete_date, BPM_COMMON.DATE_FMT))	;
	--r_dpccur.JEOPARDY_DAYS_TYPE                   	:=   p_jeopardy_days_type                   	;
--	r_dpccur.JEOPARDY_FLAG                        	:=   GET_JEOPARDY_STATUS(to_date(p_create_date, BPM_COMMON.DATE_FMT), to_date( p_instance_complete_date, BPM_COMMON.DATE_FMT), p_incident_type)	;
--	r_dpccur.TIMELINESS_STATUS                    	:=   GET_TIMELINESS_STATUS(to_date(p_create_date ,BPM_COMMON.DATE_FMT), to_date( p_instance_complete_date, BPM_COMMON.DATE_FMT),p_forwarded_flag,to_date(p_resolve_incident_start ,      BPM_COMMON.DATE_FMT), p_incident_type)	;
	--r_dpccur.INCIDENT_FWD_TIMELINESS_STATUS                	:=   p_fwd_timeliness_status       	;
	--r_dpccur.INCIDENT_FORWARDING_TARGET           	:=   p_incident_forwarding_target          	;


    
    if p_set_type = 'INSERT' then
      insert into D_COMPLAINT_CURRENT
      values r_dpccur;
    elsif p_set_type = 'UPDATE' then
      begin
        update D_COMPLAINT_CURRENT
        set row = r_dpccur
        where CMPL_BI_ID = p_bi_id;
      end;
    else
      v_log_message := 'Unexpected p_set_type value "' || p_set_type || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(-20001,v_log_message);
    end if;
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
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
    v_new_data T_INS_PD_XML := null;
    v_bi_id number := null;
    v_identifier varchar2(35) := null;
    v_start_date date := null;
    v_end_date date := null;
    v_dcmplin_id number := null;
    v_dcmplis_id number := null;
    v_dcmples_id number := null;
    v_dcmplac_id number := null;
    v_dcmplia_id number := null;
    v_dcmplid_id number := null;
    v_dcmplir_id number := null;
    v_dcmplrd_id number := null;
    v_fcmplbd_id number := null;
    v_current_task_id number := null;
     v_sla_days_type         varchar2(50) := null;
     v_sla_jeopardy_date     date := null;      
     v_sla_jeopardy_days     number := null;
     v_sla_target_days       number := null;                  
     v_age_in_business_days    number := null;          
     v_age_in_calendar_days    number := null;             
     v_jeopardy_days_type varchar2(50) := null;
    v_jeopardy_flag       varchar2(50) := null;                 
     v_timeliness_status   varchar2(50) := null;                 
     v_fwd_timeliness_status  varchar2(50) := null  ;   
     v_forwarding_target number := null;
  begin
    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Process Complaints Incidents in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;
    GET_INS_PD_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.incident_id;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    select BI_ID
    into v_bi_id
    from BPM_INSTANCE
    where
      IDENTIFIER = v_identifier
      and BEM_ID = v_bem_id
      and BSL_ID = v_bsl_id;
   
   GET_DCMPLIN_ID (v_identifier,v_bi_id,v_new_data.instance_status, v_dcmplin_id);
   GET_DCMPLIS_ID (v_identifier,v_bi_id,v_new_data.incident_status, v_dcmplis_id);
   GET_DCMPLES_ID (v_identifier,v_bi_id,v_new_data.enrollment_status, v_dcmples_id);
   GET_DCMPLAC_ID (v_identifier,v_bi_id,v_new_data.action_comments, v_dcmplac_id);
   GET_DCMPLIA_ID (v_identifier,v_bi_id,v_new_data.incident_about,  v_dcmplia_id);
   GET_DCMPLID_ID (v_identifier,v_bi_id,v_new_data.incident_description,  v_dcmplid_id);
   GET_DCMPLIR_ID (v_identifier,v_bi_id,v_new_data.incident_reason,  v_dcmplir_id);
   GET_DCMPLRD_ID (v_identifier,v_bi_id,v_new_data.resolution_description,  v_dcmplrd_id);

    -- Insert current dimension and fact as a single transaction.
    begin
      commit;
      SET_DPCCUR
        ('INSERT',v_identifier,v_bi_id
          ,v_new_data.channel                 ,             
     v_new_data.created_by_group         ,            
     v_new_data.created_by_name           ,           
     v_new_data.incident_id                ,          
     v_new_data.tracking_number    ,         
     v_new_data.create_dt                  ,                        
     v_new_data.ASED_RESOLVE_INCIDENT_EES_CSS     ,                   
     v_new_data.ASSD_RESOLVE_INCIDENT_EES_CSS    ,      
     v_new_data.ASED_RESOLVE_INCIDENT_SUP  ,     
     v_new_data.ASSD_RESOLVE_INCIDENT_SUP    ,    
     v_new_data.ASED_RESOLVE_INCIDENT_DOH             ,   
     v_new_data.ASSD_RESOLVE_INCIDENT_DOH            ,  
     v_new_data.ASED_WITHDRAW_INCIDENT               , 
     v_new_data.ASSD_WITHDRAW_INCIDENT              ,
     v_new_data.ASED_PERFORM_FOLLOWUP     ,
     v_new_data.ASSD_PERFORM_FOLLOWUP   ,
     v_new_data.about_plan_code                   ,   
     v_new_data.about_provider_id                  ,  
     v_new_data.action_comments                 ,
     v_new_data.action_type                          , 
     v_new_data.cancel_by                            ,
     v_new_data.cancel_dt                          ,
     v_new_data.cancel_method                        ,
     v_new_data.cancel_reason                        ,
     v_new_data.current_task_id                  ,
     v_new_data.de_task_id                   ,
     v_new_data.enrollment_status                ,
     v_new_data.incident_about                   ,
     v_new_data.incident_description             ,
     v_new_data.incident_reason                  ,
     v_new_data.incident_status                  ,
     v_new_data.incident_status_dt             ,
     v_new_data.instance_complete_dt              ,
     v_new_data.instance_status                  ,
     v_new_data.last_update_by_name              ,
     v_new_data.last_update_by_dt                 ,
     v_new_data.updated_by                      ,
     v_new_data.client_id                            ,
     v_new_data.other_party_name                     ,
     v_new_data.priority                             ,
     v_new_data.reported_by                          ,
     v_new_data.reporter_relationship                ,
     v_new_data.resolution_description           ,
     v_new_data.resolution_type                      ,
     v_new_data.case_id                              ,
     v_new_data.forwarded                       ,
     v_new_data.incident_type                        ,
     v_new_data.forwarded_to                         
 --    v_sla_days_type                        ,
  --   v_sla_jeopardy_date                    ,      
   --  v_sla_jeopardy_days                    ,
   --  v_sla_target_days                      ,
   --  v_age_in_business_days                 ,           
   --  v_age_in_calendar_days                 ,
   --  v_jeopardy_days_type                   ,
  --   v_jeopardy_flag                        ,
  --   v_timeliness_status                    ,
 --    v_fwd_timeliness_status       ,
  --   v_forwarding_target  
        );
      INS_FPDBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,
          v_current_task_id,
          v_dcmplac_id,
          v_dcmples_id,
          v_dcmplia_id,
          v_dcmplid_id,
          v_dcmplir_id,
          v_dcmplis_id,
          v_dcmplin_id,
          v_dcmplrd_id,
          v_new_data.incident_status_dt ,
          v_new_data.last_update_by_dt ,
          v_fcmplbd_id);
      commit;
    exception
      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
        v_log_message := 'Rolled back initial insert for current dimension and fact.  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
        raise;
    end;
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
  
  
  -- Update fact for BPM Semantic model -ILEB Process Complaints Incidents.
  procedure UPD_FPDBD
    (  p_identifier in varchar2,
       p_end_date in date,
       p_bi_id in number,
       p_current_task_id in number,
       p_dcmplac_id in number,
       p_dcmples_id in number,
       p_dcmplia_id in number,
       p_dcmplid_id in number,
       p_dcmplir_id in number,
       p_dcmplis_id in number,
       p_dcmplin_id in number,
       p_dcmplrd_id in number,
       p_incident_status_date in varchar2,
       p_stg_last_update_date in varchar2,
       p_fcmplbd_id out number 
 )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FPDBD';
    v_sql_code number := null;
    v_log_message clob := null;
    v_fcmplbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
   
    v_event_date date := null;
    v_dcmplin_id number := null;
    v_dcmplis_id number := null;
    v_dcmples_id number := null;
    v_dcmplac_id number := null;
    v_dcmplia_id number := null;
    v_dcmplid_id number := null;
    v_dcmplir_id number := null;
    v_dcmplrd_id number := null;
    v_incident_status_date date:= null;
    v_last_update_date date:= null;
    r_fnpdbd F_COMPLAINT_BY_DATE%rowtype := null;
  begin
    v_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := v_stg_last_update_date;
    v_incident_status_date := to_date(p_incident_status_date,BPM_COMMON.DATE_FMT);
    --v_document_jeop_status_dt := sysdate;
    v_dcmplin_id := p_dcmplin_id;
    v_dcmplis_id  := p_dcmplis_id;
    v_dcmples_id := p_dcmples_id;
    v_dcmplac_id := p_dcmplac_id;
    v_dcmplia_id := p_dcmplia_id;
    v_dcmplid_id := p_dcmplid_id;
    v_dcmplir_id := p_dcmplir_id;
    v_dcmplrd_id := p_dcmplrd_id;
    with most_recent_fact_bi_id as
      (select
         max(FCMPLBD_ID) max_fcmplbd_id,
         max(D_DATE) max_d_date
       from F_COMPLAINT_BY_DATE
       where CMPL_BI_ID = p_bi_id)
    select
      fnpdbd.FCMPLBD_ID,
      fnpdbd.D_DATE,
      fnpdbd.CREATION_COUNT,
      fnpdbd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into
      v_fcmplbd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_completion_count_old,
      v_max_d_date
    from
      F_COMPLAINT_BY_DATE fnpdbd,
      most_recent_fact_bi_id
    where
      fnpdbd.FCMPLBD_ID = max_fcmplbd_id
      and fnpdbd.D_DATE = most_recent_fact_bi_id.max_d_date;
    -- Do not modify fact table further once an instance has completed ever before.
    
    if v_completion_count_old >= 1 then
      return;
    end if;
    -- Handle case were update to staging table incorrectly has older LAST_UPDATE_DATE.
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
    if p_end_date is null then
      r_fnpdbd.D_DATE := v_event_date;
      r_fnpdbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpdbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpdbd.INVENTORY_COUNT := 1;
      r_fnpdbd.COMPLETION_COUNT := 0;
    else
      -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
      if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
        delete from F_COMPLAINT_BY_DATE
        where
          CMPL_BI_ID = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
    with most_recent_fact_bi_id as
      (select
         max(FCMPLBD_ID) max_fcmplbd_id,
         max(D_DATE) max_d_date
         from F_COMPLAINT_BY_DATE
         where CMPL_BI_ID = p_bi_id)
        select
          fnpdbd.FCMPLBD_ID,
          fnpdbd.D_DATE,
          fnpdbd.CREATION_COUNT,
          fnpdbd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date,
          fnpdbd.dcmplac_id,
          fnpdbd.dcmples_id,
          fnpdbd.dcmplia_id,
          fnpdbd.dcmplid_id,
          fnpdbd.dcmplir_id,
          fnpdbd.dcmplis_id,
          fnpdbd.dcmplin_id,
          fnpdbd.dcmplrd_id
          into
          v_fcmplbd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date,
          v_dcmplac_id,
          v_dcmples_id,
          v_dcmplia_id,
          v_dcmplid_id,
          v_dcmplir_id,
          v_dcmplis_id,
          v_dcmplin_id,
          v_dcmplrd_id
         from
          F_COMPLAINT_BY_DATE fnpdbd,
          most_recent_fact_bi_id
        where
          fnpdbd.FCMPLBD_ID = max_fcmplbd_id
          and fnpdbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      end if;
      r_fnpdbd.D_DATE := p_end_date;
      r_fnpdbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fnpdbd.BUCKET_END_DATE := r_fnpdbd.BUCKET_START_DATE;
      r_fnpdbd.INVENTORY_COUNT := 0;
      r_fnpdbd.COMPLETION_COUNT := 1;
    end if;


    p_fcmplbd_id := SEQ_FCMPLBD_ID.nextval;
    r_fnpdbd.FCMPLBD_ID := p_fcmplbd_id;
    r_fnpdbd.CMPL_BI_ID := p_bi_id;
    r_fnpdbd.DCMPLAC_ID := v_dcmplac_id;
    r_fnpdbd.DCMPLES_ID := v_dcmples_id;
    r_fnpdbd.DCMPLIA_ID := v_dcmplia_id;
    r_fnpdbd.DCMPLID_ID := v_dcmplid_id;
    r_fnpdbd.CREATION_COUNT := 0;
    r_fnpdbd.DCMPLIR_ID := v_dcmplir_id;
    r_fnpdbd.DCMPLIS_ID := v_dcmplis_id;
    r_fnpdbd.DCMPLIN_ID := v_dcmplin_id;
    r_fnpdbd.DCMPLRD_ID  := v_dcmplrd_id;
    r_fnpdbd.INCIDENT_STATUS_DATE := v_incident_status_date;
    r_fnpdbd.LAST_UPDATE_DATE := v_last_update_date;
    
      -- Validate fact date ranges.
    if r_fnpdbd.D_DATE < r_fnpdbd.BUCKET_START_DATE
      or to_date(to_char(r_fnpdbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fnpdbd.BUCKET_END_DATE
      or r_fnpdbd.BUCKET_START_DATE > r_fnpdbd.BUCKET_END_DATE
      or r_fnpdbd.BUCKET_END_DATE < r_fnpdbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fnpdbd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fnpdbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fnpdbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
    
    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fnpdbd.BUCKET_START_DATE then
      -- Same bucket time.
        if v_creation_count_old = 1 then
          r_fnpdbd.CREATION_COUNT := v_creation_count_old;
        end if;
        update F_COMPLAINT_BY_DATE
        set row = r_fnpdbd
        where FCMPLBD_ID = v_fcmplbd_id_old;
    else
      -- Different bucket time.

      update F_COMPLAINT_BY_DATE
      set BUCKET_END_DATE = r_fnpdbd.BUCKET_START_DATE
      where FCMPLBD_ID = v_fcmplbd_id_old;
      insert into F_COMPLAINT_BY_DATE
      values r_fnpdbd;
    end if;
  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
  
  
 -- Update BPM Event model data.
  procedure UPDATE_BPM_EVENT
    (p_data_version in number,
     p_old_data_xml in xmltype,
     p_new_data_xml in xmltype,
     p_bue_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_EVENT';
    v_sql_code number := null;
    v_log_message clob := null;
    v_be_id number := null;
    v_bi_id number := null;
    v_bue_id number := null;
    v_identifier varchar2(35) := null;
    v_start_date date := null;
    v_end_date date := null;
    v_stg_last_update_date date := null;
    v_old_data T_UPD_PD_XML := null;
    v_new_data T_UPD_PD_XML := null;
    
     v_sla_days_type         varchar2(50) := null;
     v_sla_jeopardy_date     date := null;      
     v_sla_jeopardy_days     number := null;
     v_sla_target_days       number := null;                  
     v_age_in_business_days    number := null;          
     v_age_in_calendar_days    number := null;             
    v_jeopardy_days_type      varchar2(50) := null;
    v_jeopardy_flag       varchar2(50) := null;                 
    v_timeliness_status   varchar2(50) := null;                 
    v_fwd_timeliness_status  varchar2(50) := null  ;   
    v_forwarding_target number := null;

  begin
    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" with NYHIX Process Complaints in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;
    GET_UPD_PD_XML(p_old_data_xml,v_old_data);
    GET_UPD_PD_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.incident_id;
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    v_stg_last_update_date := to_date(v_new_data.STG_LAST_UPDATE_DATE,BPM_COMMON.DATE_FMT);
    select BI_ID into v_bi_id
    from BPM_INSTANCE
    where
      IDENTIFIER = v_identifier
      and BEM_ID = v_bem_id
      and BSL_ID = v_bsl_id;
    if v_end_date is not null then
      update BPM_INSTANCE
      set
        END_DATE = v_end_date,
        LAST_UPDATE_DATE = v_stg_last_update_date
      where BI_ID = v_bi_id;
    else
      update BPM_INSTANCE
      set LAST_UPDATE_DATE = v_stg_last_update_date
      where BI_ID = v_bi_id;
    end if;
    commit;
    v_bue_id := SEQ_BUE_ID.nextval;
    insert into BPM_UPDATE_EVENT(BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
    values (v_bue_id,v_bi_id,v_butl_id,v_stg_last_update_date,'N');
    /*select 'BPM_EVENT.UPDATE_BIA(v_bi_id, ' ||b.ba_id || ','||bl.bdl_id || ','||''''||b.retain_history_flag||''''||',v_old_data.'|| stg.staging_table_column ||
        ',v_new_data.'|| stg.staging_table_column ||
      ','||'v_bue_id,v_stg_last_update_date);'
    from bpm_attribute b, bpm_attribute_lkup bl,MAXDAT.bpm_attribute_staging_table stg
    where b.bal_id = bl.bal_id
    and stg.ba_id = b.ba_id
    and b.when_populated in ('UPDATE','BOTH')
    and b.bem_id = 22
    and bsl_id = 22
    order by b.ba_id*/
	BPM_EVENT.UPDATE_BIA(v_bi_id, 2416,3,'N',v_old_data.ASED_RESOLVE_INCIDENT_EES_CSS,v_new_data.ASED_RESOLVE_INCIDENT_EES_CSS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2417,3,'Y',v_old_data.ASSD_RESOLVE_INCIDENT_EES_CSS,v_new_data.ASSD_RESOLVE_INCIDENT_EES_CSS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2418,3,'Y',v_old_data.ASED_RESOLVE_INCIDENT_SUP,v_new_data.ASED_RESOLVE_INCIDENT_SUP,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2419,3,'N',v_old_data.ASSD_RESOLVE_INCIDENT_SUP,v_new_data.ASSD_RESOLVE_INCIDENT_SUP,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2420,3,'N',v_old_data.ASED_RESOLVE_INCIDENT_DOH,v_new_data.ASED_RESOLVE_INCIDENT_DOH,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2421,3,'N',v_old_data.ASSD_RESOLVE_INCIDENT_DOH,v_new_data.ASSD_RESOLVE_INCIDENT_DOH,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2422,3,'N',v_old_data.ASED_WITHDRAW_INCIDENT,v_new_data.ASED_WITHDRAW_INCIDENT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2423,3,'N',v_old_data.ASSD_WITHDRAW_INCIDENT,v_new_data.ASSD_WITHDRAW_INCIDENT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2424,3,'N',v_old_data.ASED_PERFORM_FOLLOWUP,v_new_data.ASED_PERFORM_FOLLOWUP,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2425,3,'N',v_old_data.ASSD_PERFORM_FOLLOWUP,v_new_data.ASSD_PERFORM_FOLLOWUP,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2426,2,'N',v_old_data.ABOUT_PLAN_CODE,v_new_data.ABOUT_PLAN_CODE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2427,1,'N',v_old_data.ABOUT_PROVIDER_ID,v_new_data.ABOUT_PROVIDER_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2428,2,'Y',v_old_data.ACTION_COMMENTS,v_new_data.ACTION_COMMENTS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2429,2,'N',v_old_data.ACTION_TYPE,v_new_data.ACTION_TYPE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2430,2,'N',v_old_data.CANCEL_BY,v_new_data.CANCEL_BY,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2431,3,'N',v_old_data.CANCEL_DT,v_new_data.CANCEL_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2432,2,'N',v_old_data.CANCEL_METHOD,v_new_data.CANCEL_METHOD,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2433,2,'N',v_old_data.CANCEL_REASON,v_new_data.CANCEL_REASON,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2434,1,'Y',v_old_data.CURRENT_TASK_ID,v_new_data.CURRENT_TASK_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2435,1,'N',v_old_data.DE_TASK_ID,v_new_data.DE_TASK_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2436,2,'Y',v_old_data.ENROLLMENT_STATUS,v_new_data.ENROLLMENT_STATUS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2437,2,'Y',v_old_data.INCIDENT_ABOUT,v_new_data.INCIDENT_ABOUT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2438,2,'Y',v_old_data.INCIDENT_DESCRIPTION,v_new_data.INCIDENT_DESCRIPTION,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2439,2,'Y',v_old_data.INCIDENT_REASON,v_new_data.INCIDENT_REASON,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2440,2,'Y',v_old_data.INCIDENT_STATUS,v_new_data.INCIDENT_STATUS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2441,3,'Y',v_old_data.INCIDENT_STATUS_DT,v_new_data.INCIDENT_STATUS_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2442,3,'N',v_old_data.INSTANCE_COMPLETE_DT,v_new_data.INSTANCE_COMPLETE_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2443,2,'Y',v_old_data.INSTANCE_STATUS,v_new_data.INSTANCE_STATUS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2444,2,'Y',v_old_data.LAST_UPDATE_BY_NAME,v_new_data.LAST_UPDATE_BY_NAME,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2445,3,'Y',v_old_data.LAST_UPDATE_BY_DT,v_new_data.LAST_UPDATE_BY_DT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2446,2,'N',v_old_data.UPDATED_BY,v_new_data.UPDATED_BY,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2447,1,'N',v_old_data.CLIENT_ID,v_new_data.CLIENT_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2448,2,'N',v_old_data.OTHER_PARTY_NAME,v_new_data.OTHER_PARTY_NAME,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2449,1,'N',v_old_data.PRIORITY,v_new_data.PRIORITY,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2450,2,'N',v_old_data.REPORTED_BY,v_new_data.REPORTED_BY,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2451,2,'N',v_old_data.REPORTER_RELATIONSHIP,v_new_data.REPORTER_RELATIONSHIP,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2452,2,'Y',v_old_data.RESOLUTION_DESCRIPTION,v_new_data.RESOLUTION_DESCRIPTION,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2453,2,'N',v_old_data.RESOLUTION_TYPE,v_new_data.RESOLUTION_TYPE,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2454,1,'N',v_old_data.CASE_ID,v_new_data.CASE_ID,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2455,2,'N',v_old_data.FORWARDED,v_new_data.FORWARDED,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2457,2,'N',v_old_data.FORWARDED_TO,v_new_data.FORWARDED_TO,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2462,2,'N',v_old_data.ASF_RESOLVE_INCIDENT_EES_CSS,v_new_data.ASF_RESOLVE_INCIDENT_EES_CSS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2463,2,'N',v_old_data.ASF_RESOLVE_INCIDENT_SUP,v_new_data.ASF_RESOLVE_INCIDENT_SUP,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2464,2,'N',v_old_data.ASF_RESOLVE_INCIDENT_DOH,v_new_data.ASF_RESOLVE_INCIDENT_DOH,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2465,2,'N',v_old_data.ASF_PERFORM_FOLLOWUP,v_new_data.ASF_PERFORM_FOLLOWUP,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2466,2,'N',v_old_data.ASF_WITHDRAW_INCIDENT,v_new_data.ASF_WITHDRAW_INCIDENT,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2467,2,'N',v_old_data.GWF_RESOLVED_EES_CSS,v_new_data.GWF_RESOLVED_EES_CSS,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2468,2,'N',v_old_data.GWF_RESOLVED_SUP,v_new_data.GWF_RESOLVED_SUP,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2469,2,'N',v_old_data.GWF_FOLLOWUP_REQ,v_new_data.GWF_FOLLOWUP_REQ,v_bue_id,v_stg_last_update_date);
BPM_EVENT.UPDATE_BIA(v_bi_id, 2470,2,'N',v_old_data.GWF_RETURN_TO_STATE,v_new_data.GWF_RETURN_TO_STATE,v_bue_id,v_stg_last_update_date);
  
    commit;
    p_bue_id := v_bue_id;
  exception
    when NO_DATA_FOUND then
      v_sql_code := SQLCODE;
      v_log_message := 'No BPM_INSTANCE found.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
      raise;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
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
    v_old_data T_UPD_PD_XML := null;
    v_new_data T_UPD_PD_XML := null;
    v_bi_id number := null;
    v_identifier varchar2(35) := null;
    v_start_date date := null;
    v_end_date date := null;
   v_dcmplin_id number := null;
    v_dcmplis_id number := null;
    v_dcmples_id number := null;
    v_dcmplac_id number := null;
    v_dcmplia_id number := null;
    v_dcmplid_id number := null;
    v_dcmplir_id number := null;
    v_dcmplrd_id number := null;
    v_incident_status_date date:= null;
    v_last_update_date date:= null;
    v_fcmplbd_id number := null;
    
         v_sla_days_type         varchar2(50) := null;
     v_sla_jeopardy_date     date := null;      
     v_sla_jeopardy_days     number := null;
     v_sla_target_days       number := null;                  
     v_age_in_business_days    number := null;          
     v_age_in_calendar_days    number := null;             
     v_jeopardy_days_type varchar2(50) := null;
    v_jeopardy_flag       varchar2(50) := null;                 
     v_timeliness_status   varchar2(50) := null;                 
     v_fwd_timeliness_status  varchar2(50) := null  ;   
     v_forwarding_target number := null;
  begin
    if p_data_version > 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for NYHIX Process Complaints Incidents in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);
    end if;
    GET_UPD_PD_XML(p_old_data_xml,v_old_data);
    GET_UPD_PD_XML(p_new_data_xml,v_new_data);
    v_identifier := v_new_data.incident_id;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.INSTANCE_COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    select BI_ID into v_bi_id
    from BPM_INSTANCE
    where
      IDENTIFIER = v_identifier
      and BEM_ID = v_bem_id
      and BSL_ID = v_bsl_id;
      
   GET_DCMPLIN_ID (v_identifier,v_bi_id,v_new_data.instance_status, v_dcmplin_id);
   GET_DCMPLIS_ID (v_identifier,v_bi_id,v_new_data.incident_status, v_dcmplis_id);
   GET_DCMPLES_ID (v_identifier,v_bi_id,v_new_data.enrollment_status, v_dcmples_id);
   GET_DCMPLAC_ID (v_identifier,v_bi_id,v_new_data.action_comments, v_dcmplac_id);
   GET_DCMPLIA_ID (v_identifier,v_bi_id,v_new_data.incident_about,  v_dcmplia_id);
   GET_DCMPLID_ID (v_identifier,v_bi_id,v_new_data.incident_description,  v_dcmplid_id);
   GET_DCMPLIR_ID (v_identifier,v_bi_id,v_new_data.incident_reason,  v_dcmplir_id);
   GET_DCMPLRD_ID (v_identifier,v_bi_id,v_new_data.resolution_description,  v_dcmplrd_id);

    -- Update current dimension and fact as a single transaction.
    begin
      commit;
      SET_DPCCUR
        ('UPDATE',v_identifier,v_bi_id
         ,v_new_data.channel                 ,             
     v_new_data.created_by_group         ,            
     v_new_data.created_by_name           ,           
     v_new_data.incident_id                ,          
     v_new_data.tracking_number    ,         
     v_new_data.create_dt                  ,                        
     v_new_data.ASED_RESOLVE_INCIDENT_EES_CSS    ,                   
     v_new_data.ASSD_RESOLVE_INCIDENT_EES_CSS   ,      
     v_new_data.ASED_RESOLVE_INCIDENT_SUP  ,     
     v_new_data.ASSD_RESOLVE_INCIDENT_SUP    ,    
     v_new_data.ASED_RESOLVE_INCIDENT_DOH             ,   
     v_new_data.ASSD_RESOLVE_INCIDENT_DOH            ,  
     v_new_data.ASED_WITHDRAW_INCIDENT               , 
     v_new_data.ASSD_WITHDRAW_INCIDENT              ,
     v_new_data.ASED_PERFORM_FOLLOWUP     ,
     v_new_data.ASSD_PERFORM_FOLLOWUP   ,
     v_new_data.about_plan_code                   ,   
     v_new_data.about_provider_id                  ,  
     v_new_data.action_comments                 ,
     v_new_data.action_type                          , 
     v_new_data.cancel_by                            ,
     v_new_data.cancel_dt                          ,
     v_new_data.cancel_method                        ,
     v_new_data.cancel_reason                        ,
     v_new_data.current_task_id                  ,
     v_new_data.de_task_id                   ,
     v_new_data.enrollment_status                ,
     v_new_data.incident_about                   ,
     v_new_data.incident_description             ,
     v_new_data.incident_reason                  ,
     v_new_data.incident_status                  ,
     v_new_data.incident_status_dt             ,
     v_new_data.instance_complete_dt               ,
     v_new_data.instance_status                  ,
     v_new_data.last_update_by_name              ,
     v_new_data.last_update_by_dt                 ,
     v_new_data.updated_by                      ,
     v_new_data.client_id                            ,
     v_new_data.other_party_name                     ,
     v_new_data.priority                             ,
     v_new_data.reported_by                          ,
     v_new_data.reporter_relationship                ,
     v_new_data.resolution_description           ,
     v_new_data.resolution_type                      ,
     v_new_data.case_id                              ,
     v_new_data.forwarded                       ,
     v_new_data.incident_type                        ,
     v_new_data.forwarded_to                         
  --  v_sla_days_type                        ,
  --   v_sla_jeopardy_date                    ,      
   --  v_sla_jeopardy_days                    ,
  --   v_sla_target_days                      ,
   --  v_age_in_business_days                 ,           
   --  v_age_in_calendar_days                 ,
   --  v_jeopardy_days_type                   ,
   --  v_jeopardy_flag                        ,
    -- v_timeliness_status                    ,
   --  v_fwd_timeliness_status       ,
   --  v_forwarding_target  
         );
      UPD_FPDBD
        (v_identifier,v_end_date,v_bi_id, v_new_data.current_task_id ,
          v_dcmplac_id ,
          v_dcmples_id ,
          v_dcmplia_id ,
          v_dcmplid_id,
          v_dcmplir_id,
          v_dcmplis_id,
          v_dcmplin_id,
          v_dcmplrd_id,
          v_new_data.incident_status_dt ,
          v_new_data.last_update_by_dt ,
          v_fcmplbd_id);
      commit;
    exception
      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
        v_log_message := 'Rolled back latest current dimension and fact changes.'  || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
        raise;
    end;
  exception
    when NO_DATA_FOUND then
      v_sql_code := SQLCODE;
      v_log_message := 'No BPM_INSTANCE found.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
      raise;
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
      raise;
  end;
end;
/

alter session set plsql_code_type = interpreted;