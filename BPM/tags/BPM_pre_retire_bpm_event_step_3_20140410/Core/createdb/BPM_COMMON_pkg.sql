alter session set plsql_code_type = native;

create or replace package BPM_COMMON as

  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  DATE_FMT varchar2(21) := 'YYYY-MM-DD HH24:MI:SS';
  MAX_DATE date := to_date('2077-07-07 00:00:00',DATE_FMT);
  
  LOG_LEVEL_SEVERE  varchar2(6) := 'SEVERE';
  LOG_LEVEL_WARNING varchar2(7) := 'WARNING';
  LOG_LEVEL_INFO    varchar2(4) := 'INFO';
  LOG_LEVEL_CONFIG  varchar2(6) := 'CONFIG';
  LOG_LEVEL_FINE    varchar2(4) := 'FINE';
  LOG_LEVEL_FINER   varchar2(5) := 'FINER';
  LOG_LEVEL_FINEST  varchar2(6) := 'FINEST';
  
  function BUS_DAYS_BETWEEN
    (p_start_date in date,
     p_end_date in date)
    return integer;
     
  function CLEAN_PARAMETER
    (p_parameter_value in varchar2)
    return varchar2;

  function GET_DATE_FMT return varchar2;
     
  function GET_MAX_DATE return date;
   
  function GET_WEEKDAY
    (p_start_date in date, 
     p_days2add in number := 0) 
    return date;
     
  function GET_BUS_DATE
    (p_start_date in date,
     p_number_days in number := 0)
    return date;
    
  procedure LOGGER
    (p_log_level in varchar2,
     p_pbqj_id in number,
     p_run_data_object in varchar2,
     p_bsl_id in number,
     p_bil_id in number,
     p_identifier in varchar2,
     p_bi_id in number,
     p_log_message in clob,
     p_error_number in number);
     
  procedure LOGGER
    (p_log_level in varchar2,
     p_pbqj_id in number,
     p_run_data_object in varchar2,
     p_bsl_id in number,
     p_bil_id in number,
     p_identifier in varchar2,
     p_bi_id in number,
     p_ba_id in number,
     p_log_message in clob,
     p_error_number in number);
     
  procedure VALIDATE_CREATE_COMPLETE_DATE
    (p_create_date in date,
     p_complete_date in date);
     
  procedure WARN_CREATE_COMPLETE_DATE
    (p_create_date in date,
     p_complete_date in date,
     p_bsl_id in number,
     p_bil_id in number,
     p_identifier in varchar2);  
  
end;
/


create or replace package body BPM_COMMON as
 
  -- Calculates the age in business days.
  function BUS_DAYS_BETWEEN
    (p_start_date in date,
     p_end_date in date)
    return integer
  as
  begin
    return ETL_COMMON.BUS_DAYS_BETWEEN(p_start_date,p_end_date);
  end;
  
  
  -- Output log message to BPM_LOGGING table and dbms_output.
  procedure LOGGER
    (p_log_level in varchar2,
     p_pbqj_id in number,
     p_run_data_object in varchar2,
     p_bsl_id in number,
     p_bil_id in number,
     p_identifier in varchar2,
     p_bi_id in number,
     p_log_message in clob,
     p_error_number in number)
     
  as
  
    pragma autonomous_transaction;
     
  begin

    insert into BPM_LOGGING
      (BL_ID,LOG_DATE,LOG_LEVEL,PBQJ_ID,RUN_DATA_OBJECT,BSL_ID,BIL_ID,IDENTIFIER,BI_ID,MESSAGE,ERROR_NUMBER,BACKTRACE)
    values 
      (SEQ_BL_ID.nextval,sysdate,p_log_level,p_pbqj_id,p_run_data_object,p_bsl_id,p_bil_id,p_identifier,p_bi_id,
       p_log_message,p_error_number,dbms_utility.format_error_backtrace);

    commit;
    
    dbms_output.put_line(p_log_level || ': ' || p_log_message);
    
  end;
  
  
  -- Output log message to BPM_LOGGING table and dbms_output with BA_ID.
  -- TODO - Remove as part of Retire BPM Event - Step 4.
  procedure LOGGER
    (p_log_level in varchar2,
     p_pbqj_id in number,
     p_run_data_object in varchar2,
     p_bsl_id in number,
     p_bil_id in number,
     p_identifier in varchar2,
     p_bi_id in number,
     p_ba_id in number,
     p_log_message in clob,
     p_error_number in number)
     
  as
  
    pragma autonomous_transaction;
     
  begin
  
    LOGGER(p_log_level,p_pbqj_id,p_run_data_object,p_bsl_id,p_bil_id,p_identifier,p_bi_id,null,p_log_message,p_error_number);
    
  end;


  -- Clean parameter to avoid SQL injection.
  function CLEAN_PARAMETER
    (p_parameter_value in varchar2)
    return varchar2
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CLEAN_PARAMETER';
    v_sql_code number := null;
    v_log_message clob := null;
    v_parameter_value_clean varchar2(100) := null;
  begin
    
    if p_parameter_value is null then
       v_parameter_value_clean := p_parameter_value;
    else
      v_parameter_value_clean := regexp_replace(p_parameter_value,'[[:space:]]','');  -- Remove any spaces to avoid SQL injections  
      v_parameter_value_clean := regexp_replace(v_parameter_value_clean,'[;]','');  -- Remove any semicolon to avoid SQL injections
    end if;
    
    return v_parameter_value_clean;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to clean parameter value "' || p_parameter_value || '".  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,null,v_log_message,v_sql_code);
      raise;
  end;
  

  -- Get standard data format.
  function GET_DATE_FMT return varchar2
  as
  begin
    return DATE_FMT;
  end;


  -- Get maximum date for BPM Event data.
  function GET_MAX_DATE return date
  as
  begin
    return MAX_DATE;
  end;


  -- Get weekday.
  function GET_WEEKDAY
    (p_start_date in date, 
     p_days2add in number) 
    return date
  as
  begin
    return ETL_COMMON.GET_WEEKDAY(p_start_date,p_days2add);
  end;


  -- Get business date.
  function GET_BUS_DATE
    (p_start_date in date,
     p_number_days in number)
    return date
  as
  begin
    return ETL_COMMON.GET_BUS_DATE(p_start_date,p_number_days);
  end;
  
  
  -- Validate instance create and complete dates and raise exception.
  procedure VALIDATE_CREATE_COMPLETE_DATE
    (p_create_date in date,
     p_complete_date in date)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'VALIDATE_CREATE_COMPLETE_DATE';
    v_log_message clob := null;
    v_days_in_future_allowed number := (1/24);
  begin
     
    if p_complete_date is null or p_create_date is null then
      return;
    end if;
   
    if p_create_date > sysdate + v_days_in_future_allowed then
      v_log_message := 'Invalid create date.  ' || to_char(p_create_date,DATE_FMT) || ' is in the future.'; 
      RAISE_APPLICATION_ERROR(-20061,v_log_message);        
    end if;
    
    if p_complete_date != MAX_DATE and p_complete_date > sysdate + v_days_in_future_allowed then
      v_log_message := 'Invalid complete date.  ' || to_char(p_complete_date,DATE_FMT) || ' is in the future.';
      RAISE_APPLICATION_ERROR(-20062,v_log_message);        
    end if;
  
    if p_complete_date < p_create_date then
      v_log_message := 'Invalid date span.  Complete date ' || to_char(p_complete_date,DATE_FMT) || ' is before create date ' || to_char(p_create_date,DATE_FMT) || '.';
      RAISE_APPLICATION_ERROR(-20063,v_log_message);        
    end if;

  end;


  -- Log warning for invalid create and complete dates.
  procedure WARN_CREATE_COMPLETE_DATE
    (p_create_date in date,
     p_complete_date in date,
     p_bsl_id in number,
     p_bil_id in number,
     p_identifier in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'WARN_CREATE_COMPLETE_DATE';
    v_log_message clob := null;
    v_sql_code number := null;
  begin
    
    VALIDATE_CREATE_COMPLETE_DATE(p_create_date,p_complete_date);
    
  exception
  
    when OTHERS then
    
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      if v_sql_code in (-20061,-20062,-20063) then
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,p_bsl_id,p_bil_id,p_identifier,null,null,v_log_message,v_sql_code);       
      else
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
      end if;

  end;

end;
/

alter session set plsql_code_type = interpreted;