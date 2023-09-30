/*
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
*/  


-- Calculates the age in business days.
if OBJECT_ID ('MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN','FN') IS NOT NULL
begin
  drop function MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN;
end;
go

create function MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN
  (@p_start_date datetime,
   @p_end_date datetime)
  returns int
as
begin
  return MAXDAT.ETL_COMMON_BUS_DAYS_BETWEEN(@p_start_date,@p_end_date);
end;
go

grant execute on MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN to MAXDAT_READ_ONLY;
go


-- Calculates the age in calendar days.
if OBJECT_ID ('MAXDAT.BPM_COMMON_GET_AGE_IN_CALENDAR_DAYS','FN') IS NOT NULL
begin
  drop function MAXDAT.BPM_COMMON_GET_AGE_IN_CALENDAR_DAYS;
end;
go

create function MAXDAT.BPM_COMMON_GET_AGE_IN_CALENDAR_DAYS
  (@p_start_date datetime,
   @p_end_date datetime)
  returns int
as
begin
  return datediff(day,convert(date,@p_start_date),convert(date,(isnull(@p_end_date,getdate()))));
end;
go

grant execute on MAXDAT.BPM_COMMON_GET_AGE_IN_CALENDAR_DAYS to MAXDAT_READ_ONLY;
go


-- Output log message to BPM_LOGGING table and dbms_output.
if OBJECT_ID ('MAXDAT.BPM_COMMON_LOGGER','P') IS NOT NULL
begin
  drop procedure MAXDAT.BPM_COMMON_LOGGER;
end;
go

create procedure MAXDAT.BPM_COMMON_LOGGER
  (@p_log_level varchar(7),
   @p_pbqj_id int,
   @p_run_data_object varchar(61),
   @p_bsl_id int,
   @p_bil_id int,
   @p_identifier varchar(100),
   @p_bi_id int,
   @p_log_message varchar(MAX),
   @p_error_number int)   
as
     
begin

  -- TODO - Get value of @dbms_utility.format_error_backtrace for BACKTRACE column.

  insert into MAXDAT.BPM_LOGGING
    (BL_ID,LOG_DATE,LOG_LEVEL,PBQJ_ID,RUN_DATA_OBJECT,BSL_ID,BIL_ID,IDENTIFIER,BI_ID,MESSAGE,ERROR_NUMBER,BACKTRACE)
  values 
    (next value for MAXDAT.SEQ_BL_ID,getdate(),@p_log_level,@p_pbqj_id,@p_run_data_object,@p_bsl_id,@p_bil_id,@p_identifier,@p_bi_id,
     @p_log_message,@p_error_number,null);
    
  print @p_log_level + ': ' + @p_log_message;
    
end;
go



/*

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
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
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
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,p_bsl_id,p_bil_id,p_identifier,null,v_log_message,v_sql_code);       
      else
        RAISE_APPLICATION_ERROR(v_sql_code,v_log_message);
      end if;

  end;

end;
/

alter session set plsql_code_type = interpreted;

*/