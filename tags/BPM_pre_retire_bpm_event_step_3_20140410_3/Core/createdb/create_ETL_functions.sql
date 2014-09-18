-- Provide backwards compatibility for programs that directly call functions.

alter session set plsql_code_type = native;

  -- Calculates the age in business days.
  create or replace function BUS_DAYS_BETWEEN
    (p_start_date in date,
     p_end_date in date)
    return integer
  as
  begin
    return ETL_COMMON.BUS_DAYS_BETWEEN(p_start_date,p_end_date);
  end;
  /
  
  grant execute on BUS_DAYS_BETWEEN to MAXDAT_READ_ONLY; 
  

  -- Get weekday.
  create or replace function GET_WEEKDAY
    (p_start_date in date, 
     p_days2add in number) 
    return date
  as
  begin
    return ETL_COMMON.GET_WEEKDAY(p_start_date,p_days2add);
  end;
  /
  
 grant execute on GET_WEEKDAY to MAXDAT_READ_ONLY;
 

  -- Get business date.
  create or replace function GET_BUS_DATE
    (p_start_date in date,
     p_number_days in number)
    return date
  as
  begin
    return ETL_COMMON.GET_BUS_DATE(p_start_date,p_number_days);
  end;
  /
  
  grant execute on GET_BUS_DATE to MAXDAT_READ_ONLY; 
  
  
  create or replace function GET_INLIST_STR2
    (p_task_type in varchar2,
     p_list_type in varchar2)
    return varchar2
  as
  begin
    return ETL_COMMON.GET_INLIST_STR2(p_task_type,p_list_type);
  end;
  /
  
  grant execute on GET_INLIST_STR2 to MAXDAT_READ_ONLY; 
  
  
  create or replace function GET_INLIST_STR3
    (p_name in varchar2,
     p_list_type in varchar2)
    return varchar2
  as
  begin
    return ETL_COMMON.GET_INLIST_STR3(p_name,p_list_type);
  end;
  /
  
  grant execute on GET_INLIST_STR3 to MAXDAT_READ_ONLY; 
  

commit;

alter session set plsql_code_type = interpreted;