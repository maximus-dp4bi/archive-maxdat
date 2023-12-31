alter session set plsql_code_type = native;

create or replace 
package OUTBOUND_CALLS as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  g_timeliness_days number;
  g_time_days_type varchar2(10);
  g_time_days number;
  g_jeop_days_type varchar2(10);
  g_jeop_days number;
  g_jeopardy_days number;
  g_jeopardy_days_type varchar2(10);
  g_target_days number;

  procedure CALC_DOBCCUR;

  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable;
     
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable;

  function GET_TIMELINESS_DAYS
    return number result_cache parallel_enable;
    
  function GET_TIMELINESS_DAYS_TYPE
    return varchar2 result_cache parallel_enable;
    
  function GET_TIMELINE_STATUS
    (p_create_date   in date,
     p_complete_date in date)
    return varchar2 parallel_enable;

  function GET_JEOPARDY_DAYS
    return number result_cache parallel_enable;
  
  function GET_JEOPARDY_DAYS_TYPE
    return varchar2 result_cache parallel_enable;
    
  function GET_JEOPARDY_FLAG
    (p_create_date   in date,
     p_complete_date in date)
    return varchar2 parallel_enable;
   
  function GET_JEOPARDY_DATE
    (p_create_date in date)
    return varchar2 parallel_enable;
    
  function GET_TARGET_DAYS
    return number result_cache parallel_enable;
  
  /* 
  Include: 
    CEPOC_ID    
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    JEOPARDY_FLAG
    TIMELINESS_STATUS
    DAYS_UNTIL_TIMEOUT
  */
  type T_INS_OBC_XML is record 
    (
     ASED_PROCESS_OUTCOME varchar2(19),
     ASED_TRANSMIT_TO_DIALER varchar2(19),
     ASF_PROCESS_OUTCOME varchar2(1),
     ASF_TRANSMIT_TO_DIALER varchar2(1),
     ASSD_PROCESS_OUTCOME varchar2(19),
     ASSD_TRANSMIT_TO_DIALER varchar2(19),
     ATTEMPTS_MADE varchar2(100),
     ATTEMPTS_REQUIRED varchar2(100),
     CAMPAIGN_ID varchar2(32),
     CAMPAIGN_INDICATOR varchar2(32),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(32),
     CANCEL_REASON varchar2(32),
     CASE_CIN varchar2(32),
     CASE_ID varchar2(100),
     CEPOC_ID varchar2(100),
     CLIENT_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATE_DT varchar2(19),
     DIAL_CYCLE_OUTCOME varchar2(32),
     ERROR_COUNT varchar2(100),
     ERROR_TEXT varchar2(2000),
     INSTANCE_STATUS varchar2(10),
     JOB_END_DT varchar2(19),
     JOB_ID varchar2(100),
     LANGUAGE varchar2(32),
     LETTER_REQUEST_ID varchar2(100),
     PHONE_NUMBERS_PROVIDED varchar2(100),
     PROGRAM varchar2(32),
     ROW_ID varchar2(100),
     STG_LAST_UPDATE_DATE varchar2(19),
     SUBPROGRAM varchar2(32)
    );
      
    /* 
  Include:     
    STG_LAST_UPDATE_DATE
  Exclude:
    AGE_IN_BUSINESS_DAYS
    AGE_IN_CALENDAR_DAYS
    APP_CYCLE_BUS_DAYS
    APP_CYCLE_CAL_DAYS
    JEOPARDY_FLAG
    TIMELINESS_STATUS
    DAYS_UNTIL_TIMEOUT
  */
  type T_UPD_OBC_XML is record
    (
     ASED_PROCESS_OUTCOME varchar2(19),
     ASED_TRANSMIT_TO_DIALER varchar2(19),
     ASF_PROCESS_OUTCOME varchar2(1),
     ASF_TRANSMIT_TO_DIALER varchar2(1),
     ASSD_PROCESS_OUTCOME varchar2(19),
     ASSD_TRANSMIT_TO_DIALER varchar2(19),
     ATTEMPTS_MADE varchar2(100),
     ATTEMPTS_REQUIRED varchar2(100),
     CAMPAIGN_ID varchar2(32),
     CAMPAIGN_INDICATOR varchar2(32),
     CANCEL_DT varchar2(19),
     CANCEL_METHOD varchar2(32),
     CANCEL_REASON varchar2(32),
     CASE_CIN varchar2(32),
     CASE_ID varchar2(100),
     CEPOC_ID varchar2(100),
     CLIENT_ID varchar2(100),
     COMPLETE_DT varchar2(19),
     CREATE_DT varchar2(19),
     DIAL_CYCLE_OUTCOME varchar2(32),
     ERROR_COUNT varchar2(100),
     ERROR_TEXT varchar2(2000),
     INSTANCE_STATUS varchar2(10),
     JOB_END_DT varchar2(19),
     JOB_ID varchar2(100),
     LANGUAGE varchar2(32),
     LETTER_REQUEST_ID varchar2(100),
     PHONE_NUMBERS_PROVIDED varchar2(100),
     PROGRAM varchar2(32),
     ROW_ID varchar2(100),
     STG_LAST_UPDATE_DATE varchar2(19),
     SUBPROGRAM varchar2(32)
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


create or replace 
package body OUTBOUND_CALLS as

  v_bem_id number := 20; -- 'Outbound Calls'
  v_bil_id number := 20; -- 'CEPOC ID'
  v_bsl_id number := 20; -- 'CORP_ETL_PROC_OUTBND_CALL'
  v_butl_id number := 1; -- 'ETL'
  v_date_bucket_fmt varchar2(21) := 'YYYY-MM-DD';
  
  v_calc_dobccur_job_name varchar2(30) := 'CALC_DOBCCUR';
  
  
  function GET_AGE_IN_BUSINESS_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
     return BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,coalesce(p_complete_date,sysdate));
  end;
  
     
  function GET_AGE_IN_CALENDAR_DAYS
    (p_create_date in date,
     p_complete_date in date)
    return number parallel_enable
  as
  begin
    return trunc(coalesce(p_complete_date,sysdate)) - trunc(p_create_date);
  end;
 
 
  function GET_TIMELINESS_DAYS
    return number result_cache parallel_enable
  as
  begin
  
    if g_timeliness_days is null then
    
      select OUT_VAR
      into g_timeliness_days
      from CORP_ETL_LIST_LKUP
      where NAME = 'OUTBND_CALL_Timeline_Days';
       
    end if;
    
    return g_timeliness_days;

  end;
  
  
  function GET_TIMELINESS_DAYS_TYPE
    return varchar2 result_cache parallel_enable
  as
  begin
  
    if g_time_days_type is null then
    
      select OUT_VAR 
      into g_time_days_type
      from CORP_ETL_LIST_LKUP
      where NAME = 'OUTBND_CALL_Timeline_Days_Type';
       
    end if;
    
    return g_time_days_type;
  
  end;
  
 
  function GET_TIMELINE_STATUS
    (p_create_date   in date,
     p_complete_date in date)
    return varchar2 parallel_enable
  as
  begin
  
    if g_time_days is null then
      g_time_days := GET_TIMELINESS_DAYS();     
    end if;
    
    if g_time_days_type is null then
      g_time_days_type := GET_TIMELINESS_DAYS_TYPE;
    end if;
    
    if g_time_days_type = 'B' and BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,coalesce(p_complete_date,sysdate)) <= g_time_days then
      return 'Timely';
    elsif g_time_days_type =  'C' and trunc(coalesce(p_complete_date,sysdate)) - trunc(p_create_date) <= g_time_days then
      return 'Timely';
    else
      return 'Untimely';
    end if;
    
  end;
  
  
    function GET_JEOPARDY_DAYS
    return number result_cache parallel_enable
  as
  begin
  
    if g_jeopardy_days is null then
    
      select OUT_VAR 
      into g_jeopardy_days 
      from CORP_ETL_LIST_LKUP
      where NAME = 'OUTBND_CALL_Jeopardy_Days';
       
    end if;
    
    return g_jeopardy_days;
  
  end;
  
  
  function GET_JEOPARDY_DAYS_TYPE
    return varchar2 result_cache parallel_enable
  as
    v_jeopardy_days_type varchar(10);
  begin
  
    if g_jeopardy_days_type is null then
    
      select out_var 
      into g_jeopardy_days_type
      from CORP_ETL_LIST_LKUP
      where NAME = 'OUTBND_CALL_Jeopardy_Days_Type';
        
    end if; 
    
    return g_jeopardy_days_type;
  
  end;
  
  
  function GET_JEOPARDY_FLAG
    (p_create_date   in date,
     p_complete_date in date)
    return varchar2 parallel_enable
  as
  begin
  
    if g_jeop_days is null then
      g_jeop_days := GET_JEOPARDY_DAYS();   
    end if;
    
    if g_jeop_days_type is null then
      g_jeop_days_type := GET_JEOPARDY_DAYS_TYPE(); 
    end if;
    
    if p_complete_date is null and g_jeop_days_type = 'B' and BPM_COMMON.BUS_DAYS_BETWEEN(p_create_date,coalesce(p_complete_date,sysdate)) > g_jeop_days then
      return 'Y';
    elsif p_complete_date is null and g_jeop_days_type =  'C' and trunc(coalesce(p_complete_date,sysdate)) - trunc(p_create_date) > g_jeop_days then
      return 'Y';
    else
      return 'N';
    end if;
    
  end;
  
  
  function GET_JEOPARDY_DATE
    (p_create_date in date)
    return varchar2 parallel_enable
  as
  begin
  
    if g_jeop_days is null then
      g_jeop_days := GET_JEOPARDY_DAYS;
    end if;
    
    if g_jeop_days_type is null then
      g_jeop_days_type := GET_JEOPARDY_DAYS_TYPE();
    end if;
    
    if  g_jeop_days_type = 'B' then 
      return BPM_COMMON.GET_BUS_DATE(p_create_date,g_jeop_days)       ;
    elsif g_jeop_days_type =  'C' then 
      return p_create_date + g_jeop_days;
    end if;
    
  end;


  function GET_TARGET_DAYS
    return number result_cache parallel_enable
  is
  begin
  
    if g_target_days is null then
    
      select OUT_VAR 
      into g_target_days
      from CORP_ETL_LIST_LKUP
      where NAME = 'OUTBND_CALL_Target_Days';
        
    end if;
    
   return g_target_days;
  
  end;
 

  -- Calculate column values in BPM Semantic table D_OBC_CURRENT.
  procedure CALC_DOBCCUR
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CALC_DOBCCUR';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_rows_updated number := null;
  begin
  
    update D_OBC_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DATE),
      AGE_IN_CALENDAR_DAYS = GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,COMPLETE_DATE),
      TIMELINESS_STATUS = GET_TIMELINE_STATUS(CREATE_DATE,COMPLETE_DATE),
      TIMELINESS_DAYS = GET_TIMELINESS_DAYS(),
      TIMELINESS_DAYS_TYPE = GET_TIMELINESS_DAYS_TYPE(),
      JEOPARDY_FLAG = GET_JEOPARDY_FLAG(CREATE_DATE,COMPLETE_DATE),
      JEOPARDY_DATE = GET_JEOPARDY_DATE(CREATE_DATE),
      JEOPARDY_DAYS = GET_JEOPARDY_DAYS(),
      JEOPARDY_DAYS_TYPE = GET_JEOPARDY_DAYS_TYPE(),
      TARGET_DAYS = GET_TARGET_DAYS()
    where 
      COMPLETE_DATE is null 
      and CANCEL_DATE is null;
    
    v_num_rows_updated := sql%rowcount;
    
    commit;

    v_log_message := v_num_rows_updated  || ' D_OBC_CURRENT rows updated with calculated attributes by CALC_DOBCCUR.';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,null);
    
  exception
  
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);

  end;
  
    
  -- Get record for outbound Calls insert XML.
  procedure GET_INS_OBC_XML
    (p_data_xml in xmltype,
     p_data_record out T_INS_OBC_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_INS_OBC_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    select
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_OUTCOME') "ASED_PROCESS_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_TRANSMIT_TO_DIALER') "ASED_TRANSMIT_TO_DIALER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_OUTCOME') "ASF_PROCESS_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_TRANSMIT_TO_DIALER') "ASF_TRANSMIT_TO_DIALER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_OUTCOME') "ASSD_PROCESS_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_TRANSMIT_TO_DIALER') "ASSD_TRANSMIT_TO_DIALER",
      extractValue(p_data_xml,'/ROWSET/ROW/ATTEMPTS_MADE') "ATTEMPTS_MADE",
      extractValue(p_data_xml,'/ROWSET/ROW/ATTEMPTS_REQUIRED') "ATTEMPTS_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/CAMPAIGN_ID') "CAMPAIGN_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CAMPAIGN_INDICATOR') "CAMPAIGN_INDICATOR",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_CIN') "CASE_CIN",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CEPOC_ID') "CEPOC_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/DIAL_CYCLE_OUTCOME') "DIAL_CYCLE_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ERROR_COUNT') "ERROR_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/ERROR_TEXT') "ERROR_TEXT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_END_DT') "JOB_END_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_ID') "JOB_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGE') "LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_REQUEST_ID') "LETTER_REQUEST_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/PHONE_NUMBERS_PROVIDED') "PHONE_NUMBERS_PROVIDED",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM') "PROGRAM",
      extractValue(p_data_xml,'/ROWSET/ROW/ROW_ID') "ROW_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SUBPROGRAM') "SUBPROGRAM"
    into p_data_record
    from dual;
  
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise; 
      
  end;
    
    
  -- Get record for Client Outreach update XML. 
  procedure GET_UPD_OBC_XML
    (p_data_xml in xmltype,
     p_data_record out T_UPD_OBC_XML)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_UPD_OBC_XML';
    v_sql_code number := null;
    v_log_message clob := null;
  begin 
  
    select
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_PROCESS_OUTCOME') "ASED_PROCESS_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASED_TRANSMIT_TO_DIALER') "ASED_TRANSMIT_TO_DIALER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_PROCESS_OUTCOME') "ASF_PROCESS_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASF_TRANSMIT_TO_DIALER') "ASF_TRANSMIT_TO_DIALER",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_PROCESS_OUTCOME') "ASSD_PROCESS_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ASSD_TRANSMIT_TO_DIALER') "ASSD_TRANSMIT_TO_DIALER",
      extractValue(p_data_xml,'/ROWSET/ROW/ATTEMPTS_MADE') "ATTEMPTS_MADE",
      extractValue(p_data_xml,'/ROWSET/ROW/ATTEMPTS_REQUIRED') "ATTEMPTS_REQUIRED",
      extractValue(p_data_xml,'/ROWSET/ROW/CAMPAIGN_ID') "CAMPAIGN_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CAMPAIGN_INDICATOR') "CAMPAIGN_INDICATOR",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_DT') "CANCEL_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_METHOD') "CANCEL_METHOD",
      extractValue(p_data_xml,'/ROWSET/ROW/CANCEL_REASON') "CANCEL_REASON",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_CIN') "CASE_CIN",
      extractValue(p_data_xml,'/ROWSET/ROW/CASE_ID') "CASE_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CEPOC_ID') "CEPOC_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/CLIENT_ID') "CLIENT_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/COMPLETE_DT') "COMPLETE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/CREATE_DT') "CREATE_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/DIAL_CYCLE_OUTCOME') "DIAL_CYCLE_OUTCOME",
      extractValue(p_data_xml,'/ROWSET/ROW/ERROR_COUNT') "ERROR_COUNT",
      extractValue(p_data_xml,'/ROWSET/ROW/ERROR_TEXT') "ERROR_TEXT",
      extractValue(p_data_xml,'/ROWSET/ROW/INSTANCE_STATUS') "INSTANCE_STATUS",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_END_DT') "JOB_END_DT",
      extractValue(p_data_xml,'/ROWSET/ROW/JOB_ID') "JOB_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/LANGUAGE') "LANGUAGE",
      extractValue(p_data_xml,'/ROWSET/ROW/LETTER_REQUEST_ID') "LETTER_REQUEST_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/PHONE_NUMBERS_PROVIDED') "PHONE_NUMBERS_PROVIDED",
      extractValue(p_data_xml,'/ROWSET/ROW/PROGRAM') "PROGRAM",
      extractValue(p_data_xml,'/ROWSET/ROW/ROW_ID') "ROW_ID",
      extractValue(p_data_xml,'/ROWSET/ROW/STG_LAST_UPDATE_DATE') "STG_LAST_UPDATE_DATE",
      extractValue(p_data_xml,'/ROWSET/ROW/SUBPROGRAM') "SUBPROGRAM"
    into p_data_record
    from dual;

  exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_log_message,v_sql_code);
      raise;
  
  end;
  
  
  -- Insert fact for BPM Semantic model - Client Outreach process. 
    procedure INS_FOBCBD
      (p_identifier in varchar2,
       p_start_date in date,
       p_end_date in date,
       p_bi_id in number,
       p_fobcbd_id out number) 
    as
      v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INS_FOBCBD';
      v_sql_code number := null;
      v_log_message clob := null;
      v_bucket_start_date date := null;
      v_bucket_end_date date := null;

    begin
    
      p_fobcbd_id := SEQ_FOBCBD_ID.nextval;
      
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
      
      insert into F_OBC_BY_DATE
        (FOBCBD_ID,
         D_DATE,
         BUCKET_START_DATE,
         BUCKET_END_DATE,
         OBC_BI_ID,
         CREATION_COUNT,
         INVENTORY_COUNT,
         COMPLETION_COUNT)
      values
        (p_fobcbd_id,
         p_start_date,
         v_bucket_start_date,
         v_bucket_end_date,
         p_bi_id,
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
  
  
  -- Insert or update dimension for BPM Semantic model - Process Letters process - Current.
  procedure SET_DOBCCUR
    (p_set_type in varchar2,
     p_identifier  in varchar2,
     p_bi_id in number,
     p_outbound_call_identifier	in number,
     p_job_id	in number,
     p_row_id	in number,
     p_case_cin	in varchar2,
     p_campaign_id	in varchar2,
     p_campaign_indicator	in varchar2,
     p_create_date	in varchar2,
     p_case_id	in number,
     p_client_id	in number,
     p_program	in varchar2,
     p_subprogram	in varchar2,
     p_language	in varchar2,
     p_error_count	in number,
     p_error_text	in varchar2,
     p_job_processing_end_time	in varchar2,
     p_phone_numbers_provided	in number,
     p_letter_materials_request_id	in number,
     p_number_of_attempts_required	in number,
     p_number_of_attempts_made	in number,
     p_dial_cycle_outcome	in varchar2,
     p_transmit_dialer_start_date	in varchar2,
     p_transmit_dialer_end_date	in varchar2,
     p_transmit_to_dialer_flag	in varchar2,
     p_process_outcome_start_date	in varchar2,
     p_process_outcome_end_date	in varchar2,
     p_process_outcome_flag	in varchar2,
     p_complete_date	in varchar2,
     p_cancel_date	in varchar2,
     p_cancel_reason	in varchar2,
     p_cancel_method	in varchar2,
     p_instance_status	in varchar2
    )
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_DOBCCUR';
    v_sql_code number := null;
    v_log_message clob := null;
    r_dobccur D_OBC_CURRENT%rowtype := null;
    --v_jeopardy_flag varchar2(1) := null; 
  begin
    r_dobccur.OBC_BI_ID := p_bi_id;
    r_dobccur.OUTBOUND_CALL_IDENTIFIER := p_outbound_call_identifier;
    r_dobccur.JOB_ID := p_job_id;
    r_dobccur.ROW_ID := p_row_id;
    r_dobccur.CASE_CIN := p_case_cin;
    r_dobccur.CAMPAIGN_ID := p_campaign_id;
    r_dobccur.CAMPAIGN_INDICATOR := p_campaign_indicator;
    r_dobccur.CREATE_DATE := to_date(p_create_date,BPM_COMMON.DATE_FMT);
    r_dobccur.CASE_ID := p_case_id;
    r_dobccur.CLIENT_ID := p_client_id;
    r_dobccur.PROGRAM := p_program;
    r_dobccur.SUBPROGRAM := p_subprogram;
    r_dobccur.LANGUAGE := p_language;
    r_dobccur.ERROR_COUNT := p_error_count;
    r_dobccur.ERROR_TEXT := p_error_text;
    r_dobccur.JOB_PROCESSING_END_TIME := to_date(p_job_processing_end_time,BPM_COMMON.DATE_FMT);
    r_dobccur.PHONE_NUMBERS_PROVIDED := p_phone_numbers_provided;
    r_dobccur.LETTER_MATERIALS_REQUEST_ID := p_letter_materials_request_id;
    r_dobccur.NUMBER_OF_ATTEMPTS_REQUIRED := p_number_of_attempts_required;
    r_dobccur.NUMBER_OF_ATTEMPTS_MADE := p_number_of_attempts_made;
    r_dobccur.DIAL_CYCLE_OUTCOME := p_dial_cycle_outcome;
    r_dobccur.TRANSMIT_TO_DIALER_START_DATE := to_date(p_transmit_dialer_start_date,BPM_COMMON.DATE_FMT);
    r_dobccur.TRANSMIT_TO_DIALER_END_DATE := to_date(p_transmit_dialer_end_date,BPM_COMMON.DATE_FMT);
    r_dobccur.TRANSMIT_TO_DIALER_FLAG := p_transmit_to_dialer_flag;
    r_dobccur.PROCESS_OUTCOME_START_DATE := to_date(p_process_outcome_start_date,BPM_COMMON.DATE_FMT);
    r_dobccur.PROCESS_OUTCOME_END_DATE := to_date(p_process_outcome_end_date,BPM_COMMON.DATE_FMT);
    r_dobccur.PROCESS_OUTCOME_FLAG := p_process_outcome_flag;
    r_dobccur.COMPLETE_DATE := to_date(p_complete_date,BPM_COMMON.DATE_FMT);
    r_dobccur.CANCEL_DATE := to_date(p_cancel_date,BPM_COMMON.DATE_FMT);
    r_dobccur.CANCEL_REASON := p_cancel_reason;
    r_dobccur.CANCEL_METHOD := p_cancel_method;
    r_dobccur.INSTANCE_STATUS := p_instance_status;
    r_dobccur.AGE_IN_BUSINESS_DAYS := GET_AGE_IN_BUSINESS_DAYS(r_dobccur.CREATE_DATE,r_dobccur.COMPLETE_DATE);
    r_dobccur.AGE_IN_CALENDAR_DAYS := GET_AGE_IN_CALENDAR_DAYS(r_dobccur.CREATE_DATE,r_dobccur.COMPLETE_DATE);
    r_dobccur.TIMELINESS_STATUS := GET_TIMELINE_STATUS(r_dobccur.CREATE_DATE,r_dobccur.COMPLETE_DATE);
    r_dobccur.TIMELINESS_DAYS := GET_TIMELINESS_DAYS();
    r_dobccur.TIMELINESS_DAYS_TYPE := GET_TIMELINESS_DAYS_TYPE();
    r_dobccur.JEOPARDY_FLAG := GET_JEOPARDY_FLAG(r_dobccur.CREATE_DATE,r_dobccur.COMPLETE_DATE);
    r_dobccur.JEOPARDY_DATE := GET_JEOPARDY_DATE(r_dobccur.CREATE_DATE);
    r_dobccur.JEOPARDY_DAYS := GET_JEOPARDY_DAYS();
    r_dobccur.JEOPARDY_DAYS_TYPE := GET_JEOPARDY_DAYS_TYPE();
    r_dobccur.TARGET_DAYS := GET_TARGET_DAYS();
    
    if p_set_type = 'INSERT' then
      insert into D_OBC_CURRENT
      values r_dobccur;
    elsif p_set_type = 'UPDATE' then
      begin
        update D_OBC_CURRENT
        set row = r_dobccur
        where OBC_BI_ID = p_bi_id;
      end;
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
      
    v_new_data T_INS_OBC_XML := null;
      
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
    v_fobcbd_id number := null;   
  begin
  
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for  Outbound Calls in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_INS_OBC_XML(p_new_data_xml,v_new_data);

    v_identifier := v_new_data.CEPOC_ID;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);
    v_bi_id := SEQ_BI_ID.nextval;
       
    -- Insert current dimension and fact as a single transaction.
    begin
          
      commit;
         
      SET_DOBCCUR
        ('INSERT',
        v_identifier,
        v_bi_id,
        v_new_data.CEPOC_ID,
        v_new_data.JOB_ID,
        v_new_data.ROW_ID,
        v_new_data.CASE_CIN,
        v_new_data.CAMPAIGN_ID,
        v_new_data.CAMPAIGN_INDICATOR,
        v_new_data.CREATE_DT,
        v_new_data.CASE_ID,
        v_new_data.CLIENT_ID,
        v_new_data.PROGRAM,
        v_new_data.SUBPROGRAM,
        v_new_data.LANGUAGE,
        v_new_data.ERROR_COUNT,
        v_new_data.ERROR_TEXT,
        v_new_data.JOB_END_DT,
        v_new_data.PHONE_NUMBERS_PROVIDED,
        v_new_data.LETTER_REQUEST_ID,
        v_new_data.ATTEMPTS_REQUIRED,
        v_new_data.ATTEMPTS_MADE,
        v_new_data.DIAL_CYCLE_OUTCOME,
        v_new_data.ASSD_TRANSMIT_TO_DIALER,
        v_new_data.ASED_TRANSMIT_TO_DIALER,
        v_new_data.ASF_TRANSMIT_TO_DIALER,
        v_new_data.ASSD_PROCESS_OUTCOME,
        v_new_data.ASED_PROCESS_OUTCOME,
        v_new_data.ASF_PROCESS_OUTCOME,
        v_new_data.COMPLETE_DT,
        v_new_data.CANCEL_DT,
        v_new_data.CANCEL_REASON,
        v_new_data.CANCEL_METHOD,
        v_new_data.INSTANCE_STATUS); 
        
      INS_FOBCBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,v_fobcbd_id);
      
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
  
   
  -- Update fact for BPM Semantic model -  Client Outreach process. 
  procedure UPD_FOBCBD
    (p_identifier in varchar2,
     p_start_date in date,
     p_end_date in date,
     p_bi_id in number,
     p_stg_last_update_date in varchar2,
     p_fobcbd_id out number) 
     
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPD_FOBCBD';
    v_sql_code number := null;
    v_log_message clob := null;
      
    v_fobcbd_id_old number := null;
    v_d_date_old date := null;
    v_stg_last_update_date date := null;
    v_receipt_date date := null;
    v_creation_count_old number := null;
    v_completion_count_old number := null;
    v_max_d_date date := null;
    --v_outreach_request_status_date date := null;
    v_event_date date := null;
    
    v_fobcbd_id number := null;

    r_fobcbd F_OBC_BY_DATE%rowtype := null;
  begin

    v_stg_last_update_date := to_date(p_stg_last_update_date,BPM_COMMON.DATE_FMT);
    v_event_date := v_stg_last_update_date;
    v_fobcbd_id := p_fobcbd_id;
    
    with most_recent_fact_bi_id as
      (select 
         max(FOBCBD_ID) max_fobcbd_id,
         max(D_DATE) max_d_date
       from F_OBC_BY_DATE
       where OBC_BI_ID = p_bi_id) 
    select 
      fOBCbd.FOBCBD_ID,
      fOBCbd.D_DATE,
      fOBCbd.CREATION_COUNT,
      fOBCbd.COMPLETION_COUNT,
      most_recent_fact_bi_id.max_d_date
    into 
      v_fOBCbd_id_old,
      v_d_date_old,
      v_creation_count_old,
      v_completion_count_old,
      v_max_d_date
    from 
      F_OBC_BY_DATE fOBCbd,
      most_recent_fact_bi_id 
    where
      fOBCbd.FOBCBD_ID = max_fOBCbd_id
      and fOBCbd.D_DATE = most_recent_fact_bi_id.max_d_date;
      
    -- Do not modify fact table further once an instance has completed ever before.
    if v_completion_count_old >= 1 then
      return;
    end if;
        
    -- Handle case where update to staging table inOBCrectly has older LAST_UPDATE_DATE. 
    if v_stg_last_update_date < v_max_d_date then
      v_stg_last_update_date := v_max_d_date;
    end if;
      
    if p_end_date is null then
      r_fOBCbd.D_DATE := v_event_date;
      r_fOBCbd.BUCKET_START_DATE := to_date(to_char(v_event_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fOBCbd.BUCKET_END_DATE := to_date(to_char(BPM_COMMON.MAX_DATE,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fOBCbd.INVENTORY_COUNT := 1;
      r_fOBCbd.COMPLETION_COUNT := 0;
    else
      
      -- Handle case with retroactive complete date by removing facts that have occurred since the complete date.
      if to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt) < to_date(to_char(v_max_d_date,v_date_bucket_fmt),v_date_bucket_fmt) then
      
        delete from F_OBC_BY_DATE
        where 
          OBC_BI_ID = p_bi_id
          and BUCKET_START_DATE > to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
          
        with most_recent_fact_bi_id as
          (select 
             max(FOBCBD_ID) max_fOBCbd_id,
             max(D_DATE) max_d_date
           from F_OBC_BY_DATE
           where OBC_BI_ID = p_bi_id) 
        select 
          fOBCbd.FOBCBD_ID,
          fOBCbd.D_DATE,
          fOBCbd.CREATION_COUNT,
          fOBCbd.COMPLETION_COUNT,
          most_recent_fact_bi_id.max_d_date
        into 
          v_fOBCbd_id_old,
          v_d_date_old,
          v_creation_count_old,
          v_completion_count_old,
          v_max_d_date 
        from 
          F_OBC_BY_DATE fOBCbd,
          most_recent_fact_bi_id 
        where
          fOBCbd.FOBCBD_ID = max_fOBCbd_id
          and fOBCbd.D_DATE = most_recent_fact_bi_id.max_d_date;
            
      end if;
      
      r_fOBCbd.D_DATE := p_end_date;
      r_fOBCbd.BUCKET_START_DATE := to_date(to_char(p_end_date,v_date_bucket_fmt),v_date_bucket_fmt);
      r_fOBCbd.BUCKET_END_DATE := r_fOBCbd.BUCKET_START_DATE;
      r_fOBCbd.INVENTORY_COUNT := 0;
      r_fOBCbd.COMPLETION_COUNT := 1;
      
    end if;
  
    p_fOBCbd_id := SEQ_FOBCBD_ID.nextval;
    r_fOBCbd.FOBCBD_ID := p_fOBCbd_id;
    r_fOBCbd.OBC_BI_ID := p_bi_id;
    r_fOBCbd.CREATION_COUNT := 0;
    
    
    -- Validate fact date ranges.
    if r_fOBCbd.D_DATE < r_fOBCbd.BUCKET_START_DATE
      or to_date(to_char(r_fOBCbd.D_DATE,v_date_bucket_fmt),v_date_bucket_fmt) > r_fOBCbd.BUCKET_END_DATE
      or r_fOBCbd.BUCKET_START_DATE > r_fOBCbd.BUCKET_END_DATE
      or r_fOBCbd.BUCKET_END_DATE < r_fOBCbd.BUCKET_START_DATE
    then
      v_sql_code := -20030;
      v_log_message := 'Attempted to insert invalid fact date range.  ' || 
        'D_DATE = ' || r_fOBCbd.D_DATE || 
        ' BUCKET_START_DATE = ' || to_char(r_fOBCbd.BUCKET_START_DATE,v_date_bucket_fmt) ||
        ' BUCKET_END_DATE = ' || to_char(r_fOBCbd.BUCKET_END_DATE,v_date_bucket_fmt);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,p_identifier,p_bi_id,v_log_message,v_sql_code);
      RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
    end if;
   
    if to_date(to_char(v_d_date_old,v_date_bucket_fmt),v_date_bucket_fmt) = r_fOBCbd.BUCKET_START_DATE then
    
      -- Same bucket time.
      
      if v_creation_count_old = 1 then
        r_fOBCbd.CREATION_COUNT := v_creation_count_old;
      end if;
      
      update F_OBC_BY_DATE
      set row = r_fOBCbd
      where FOBCBD_ID = v_fOBCbd_id_old;
        
    else
    
      -- Different bucket time.
    
      update F_OBC_BY_DATE
      set BUCKET_END_DATE = r_fOBCbd.BUCKET_START_DATE
      where FOBCBD_ID = v_fOBCbd_id_old;
        
      insert into F_OBC_BY_DATE
      values r_fOBCbd;
      
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
      
    v_old_data T_UPD_OBC_XML := null;
    v_new_data T_UPD_OBC_XML := null;
    
    v_bi_id number := null;
    v_identifier varchar2(100) := null;
      
    v_start_date date := null;
    v_end_date date := null;
      
   
    v_fobcbd_id number := null;
      
   
      
  begin
   
    if p_data_version != 1 then
      v_log_message := 'Unsupported BPM_UPDATE_EVENT_QUEUE.DATA_VERSION value "' || p_data_version || '" for Outbound Calls in procedure ' || v_procedure_name || '.';
      RAISE_APPLICATION_ERROR(-20011,v_log_message);        
    end if;
      
    GET_UPD_OBC_XML(p_old_data_xml,v_old_data);
    GET_UPD_OBC_XML(p_new_data_xml,v_new_data);
    
    v_identifier := v_new_data.CEPOC_ID;
    v_start_date := to_date(v_new_data.CREATE_DT,BPM_COMMON.DATE_FMT);
    v_end_date := to_date(coalesce(v_new_data.COMPLETE_DT,v_new_data.CANCEL_DT),BPM_COMMON.DATE_FMT);
    BPM_COMMON.WARN_CREATE_COMPLETE_DATE(v_start_date,v_end_date,v_bsl_id,v_bil_id,v_identifier);

    select OBC_BI_ID 
    into v_bi_id
    from D_OBC_CURRENT
    where OUTBOUND_CALL_IDENTIFIER = v_identifier;
    
    -- Update current dimension and fact as a single transaction.
    begin
             
      commit;
         
      SET_DOBCCUR
        ('UPDATE',v_identifier,v_bi_id,
                  v_new_data.CEPOC_ID,
                  v_new_data.JOB_ID,
                  v_new_data.ROW_ID,
                  v_new_data.CASE_CIN,
                  v_new_data.CAMPAIGN_ID,
                  v_new_data.CAMPAIGN_INDICATOR,
                  v_new_data.CREATE_DT,
                  v_new_data.CASE_ID,
                  v_new_data.CLIENT_ID,
                  v_new_data.PROGRAM,
                  v_new_data.SUBPROGRAM,
                  v_new_data.LANGUAGE,
                  v_new_data.ERROR_COUNT,
                  v_new_data.ERROR_TEXT,
                  v_new_data.JOB_END_DT,
                  v_new_data.PHONE_NUMBERS_PROVIDED,
                  v_new_data.LETTER_REQUEST_ID,
                  v_new_data.ATTEMPTS_REQUIRED,
                  v_new_data.ATTEMPTS_MADE,
                  v_new_data.DIAL_CYCLE_OUTCOME,
                  v_new_data.ASSD_TRANSMIT_TO_DIALER,
                  v_new_data.ASED_TRANSMIT_TO_DIALER,
                  v_new_data.ASF_TRANSMIT_TO_DIALER,
                  v_new_data.ASSD_PROCESS_OUTCOME,
                  v_new_data.ASED_PROCESS_OUTCOME,
                  v_new_data.ASF_PROCESS_OUTCOME,
                  v_new_data.COMPLETE_DT,
                  v_new_data.CANCEL_DT,
                  v_new_data.CANCEL_REASON,
                  v_new_data.CANCEL_METHOD,
                  v_new_data.INSTANCE_STATUS);
        
      UPD_FOBCBD
        (v_identifier,v_start_date,v_end_date,v_bi_id,v_new_data.stg_last_update_date, v_fobcbd_id);
      
      commit;
            
    exception
          
      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
        v_log_message := 'Rolled back latest current dimension and fact changes.'  || SQLERRM;
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
