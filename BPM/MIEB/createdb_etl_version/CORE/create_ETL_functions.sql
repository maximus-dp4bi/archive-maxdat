-- Provide backwards compatibility for programs that directly call functions.

alter session set plsql_code_type = native;

  -- Calculates the age in business days.
  create or replace function BUS_DAYS_BETWEEN
    (p_start_date in date,
     p_end_date in date)
    return integer parallel_enable
  as
  begin
    return ETL_COMMON.BUS_DAYS_BETWEEN(p_start_date,p_end_date);
  end;
  /
  
  grant execute on BUS_DAYS_BETWEEN to &role_name; 
  

  -- Get weekday.
  create or replace function GET_WEEKDAY
    (p_start_date in date, 
     p_days2add in number) 
    return date parallel_enable
  as
  begin
    return ETL_COMMON.GET_WEEKDAY(p_start_date,p_days2add);
  end;
  /
  
 grant execute on GET_WEEKDAY to &role_name;
 

  -- Get business date.
  create or replace function GET_BUS_DATE
    (p_start_date in date,
     p_number_days in number)
    return date parallel_enable
  as
  begin
    return ETL_COMMON.GET_BUS_DATE(p_start_date,p_number_days);
  end;
  /
  
  grant execute on GET_BUS_DATE to &role_name; 
  
  
  create or replace function GET_INLIST_STR2
    (p_task_type in varchar2,
     p_list_type in varchar2)
    return varchar2 parallel_enable
  as
  begin
    return ETL_COMMON.GET_INLIST_STR2(p_task_type,p_list_type);
  end;
  /
  
  grant execute on GET_INLIST_STR2 to &role_name; 
  
  
  create or replace function GET_INLIST_STR3
    (p_name in varchar2,
     p_list_type in varchar2)
    return varchar2 parallel_enable
  as
  begin
    return ETL_COMMON.GET_INLIST_STR3(p_name,p_list_type);
  end;
  /
  
  grant execute on GET_INLIST_STR3 to &role_name; 
  

commit;

alter session set plsql_code_type = interpreted;