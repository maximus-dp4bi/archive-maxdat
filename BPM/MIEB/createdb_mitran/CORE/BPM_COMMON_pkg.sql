alter session set plsql_code_type = native;

create or replace package BPM_COMMON as

  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/Core/createdb/BPM_COMMON_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 17631 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2016-06-30 14:46:37 -0700 (Thu, 30 Jun 2016) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: rk50472 $';

  DATE_FMT varchar2(21) := 'YYYY-MM-DD HH24:MI:SS';
  MIN_GDATE date := to_date('0001-01-01 00:00:00',DATE_FMT);
  MAX_GDATE date := to_date('9999-12-31 00:00:00',DATE_FMT);

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
    return integer parallel_enable;
     
  function CLEAN_PARAMETER
    (p_parameter_value in varchar2)
    return varchar2 parallel_enable;

  function GET_DATE_FMT return varchar2 parallel_enable;
     
  function GET_MAX_DATE return date parallel_enable;
   
  function GET_WEEKDAY
    (p_start_date in date, 
     p_days2add in number := 0) 
    return date parallel_enable;
     
  function GET_BUS_DATE
    (p_start_date in date,
     p_number_days in number := 0)
    return date parallel_enable;
    
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
    return integer parallel_enable
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
  
  -- Deprecated
  -- Output log message to BPM_LOGGING table and dbms_output with BA_ID.
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
    v_error_number number := null;
    v_log_message clob := null;
  begin
  
  
    LOGGER(p_log_level,p_pbqj_id,p_run_data_object,p_bsl_id,p_bil_id,p_identifier,p_bi_id,p_log_message,p_error_number);
    
    v_log_message := 'Called the deprecated BPM_COMMON.LOGGER procedure that uses the obsolete BA_ID parameter.   Please update the calling code to use the non-deprecated BPM_COMMON.LOGGER procedure.';
    v_error_number := -20070;
    LOGGER(LOG_LEVEL_WARNING,p_pbqj_id,p_run_data_object,p_bsl_id,p_bil_id,p_identifier,p_bi_id,v_log_message,v_error_number);

  end;


  -- Clean parameter to avoid SQL injection.
  function CLEAN_PARAMETER
    (p_parameter_value in varchar2)
    return varchar2 parallel_enable
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
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      raise;
  end;
  

  -- Get standard data format.
  function GET_DATE_FMT return varchar2 parallel_enable
  as
  begin
    return DATE_FMT;
  end;


  -- Get maximum date for BPM Event data.
  function GET_MAX_DATE return date parallel_enable
  as
  begin
    return MAX_DATE;
  end;


  -- Get weekday.
  function GET_WEEKDAY
    (p_start_date in date, 
     p_days2add in number) 
    return date parallel_enable
  as
  begin
    return ETL_COMMON.GET_WEEKDAY(p_start_date,p_days2add);
  end;


  -- Get business date.
  function GET_BUS_DATE
    (p_start_date in date,
     p_number_days in number)
    return date parallel_enable
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
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,p_bsl_id,p_bil_id,p_identifier,null,v_log_message,v_sql_code);       
      else
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
      end if;

  end;

end;
/

alter session set plsql_code_type = interpreted;