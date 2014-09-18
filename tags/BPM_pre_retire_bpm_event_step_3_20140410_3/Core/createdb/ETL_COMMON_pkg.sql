alter session set plsql_code_type = native;

create or replace package ETL_COMMON as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  function BUS_DAYS_BETWEEN
    (p_start_date in date,
     p_end_date in date)
    return integer;
   
  function GET_WEEKDAY
    (p_start_date in date, 
     p_days2add in number) 
    return date;
     
  function GET_BUS_DATE
    (p_start_date in date,
     p_number_days in number)
    return date;
    
  function GET_INLIST_STR2
    (p_task_type in varchar2,
     p_list_type in varchar2)
    return varchar2 result_cache;
    
  function GET_INLIST_STR3
    (p_name in varchar2,
     p_list_type in varchar2)
    return varchar2 result_cache;
  
end;
/


create or replace package body ETL_COMMON as
 
  -- Calculates the age in business days.
  function BUS_DAYS_BETWEEN
    (p_start_date in date,
     p_end_date in date)
    return integer
  as
    v_num_days integer := 0;
    v_from_date date := null;
    v_to_date date := null; 
  begin
  
    v_from_date := trunc(p_start_date);
    v_to_date := trunc(p_end_date);
  
    with date_tab as
      (select v_from_date + level - 1 business_date
       from dual
       connect by level <= v_to_date - v_from_date + 1)
    select /*+ RESULT_CACHE +*/ count(business_date) - 1 
    into v_num_days
    from date_tab
    where
      to_char(business_date,'DY') not in ('SAT','SUN')
      and business_date not in 
        (select HOLIDAY_DATE 
         from HOLIDAYS 
         where HOLIDAY_DATE between v_from_date and v_to_date);
  
    if v_num_days < 0 then
      v_num_days := 0;
    end if;
    
    return v_num_days;
    
  end;


  -- Get weekday.
  function GET_WEEKDAY
    (p_start_date in date, 
     p_days2add in number) 
    return date 
  as
    v_counter      natural := 0;
    v_curdate      date := p_start_date;
    v_daynum       positive;
    v_skipcntr     natural := 0;
    v_direction    integer := 1; -- days after start_date
    v_businessdays number := p_days2add;
  begin

    if p_days2add < 0 then
      v_direction    := -1; -- days before start_date
      v_businessdays := (-1) * v_businessdays;
    end if;

    while v_counter < v_businessdays
    loop
      v_curdate := v_curdate + v_direction;
      v_daynum  := to_char(v_curdate,'D');
      if v_daynum between 2 and 6 then
        v_counter := v_counter + 1;
      else
        v_skipcntr := v_skipcntr + 1;
      end if;
    end loop;

    return p_start_date + (v_direction * (v_counter + v_skipcntr));
    
  end;


  -- Get business date.
  function GET_BUS_DATE
    (p_start_date in date,
     p_number_days in number)
    return date
  as
    v_weekdate date := null;
   -- v_loop number := 0;
    v_holiday number := null;
    --v_holiday_flag number := 1;
    v_counter      natural := 0;
    v_curdate      date ;
    v_daynum       positive;
    v_skipcntr     natural := 0;
    v_direction    integer := 1; -- days after start_date
    v_businessdays number := p_number_days;
  begin
     v_curdate := TRUNC(p_start_date);
     
      select /*+ RESULT_CACHE +*/ count(1)
      into v_holiday
      from HOLIDAYS
      where HOLIDAY_DATE = v_curdate;
      
      if (to_char(v_curdate,'D') IN(1,7) OR v_holiday != 0) and p_number_days = 0  then      
        v_businessdays := 1;        
      end if;
  
     if p_number_days < 0 then
      v_direction    := -1; -- days before start_date
      v_businessdays := (-1) * v_businessdays;
     end if;
      
    while v_counter < v_businessdays
    loop
         
       v_curdate := v_curdate + v_direction;
       v_holiday := 0;
       select /*+ RESULT_CACHE +*/ count(1)
       into v_holiday
       from HOLIDAYS
       where HOLIDAY_DATE = v_curdate;
   
       v_daynum  := to_char(v_curdate,'D');
       if (v_daynum between 2 and 6) AND v_holiday = 0 then
          v_counter := v_counter + 1;
       else
         v_skipcntr := v_skipcntr + 1;
       end if;
    end loop;

    v_weekdate := p_start_date + (v_direction * (v_counter + v_skipcntr));
    
    RETURN TRUNC(v_weekdate);
  
  end;
  
  function GET_INLIST_STR2
    (p_task_type in varchar2,
     p_list_type in varchar2)
    return varchar2 result_cache
  as
    v_list varchar2(4000) := null;
    v_first varchar2(1) := 'Y';
  begin
  
    for i in (select *
              from CORP_ETL_LIST_LKUP
              where 
                NAME = 'TASK_MONITOR_TYPE'
                and OUT_VAR = p_task_type)
    loop
      if p_list_type = 'S' then
        if v_first = 'Y' then
          v_list := '''' || i.REF_ID || '''';
          v_first := 'N';
        else
          v_list := v_list || ',' || '''' || i.REF_ID || '''';
        end if;
      elsif p_list_type = 'N' then
        if v_first = 'Y' then
          v_list := i.REF_ID;
          v_first := 'N';
        else
          v_list := v_list || ',' || i.REF_ID;
        end if;
      else
        v_list := 'BAD_STRING';
      end if;
    end loop;

    return v_list;
    
  end;
  
  
  function GET_INLIST_STR3
    (p_name in varchar2,
     p_list_type in varchar2)
    return varchar2 result_cache
  as
    v_list varchar2(4000) := null;
    v_first varchar2(1) := 'Y';
  begin
  
    for i in (select *
              from CORP_ETL_LIST_LKUP
              where name = p_name)
    loop
      if p_list_type = 'S' then
        if v_first = 'Y' then
          v_list := '''' || i.REF_ID || '''';
          v_first := 'N';
        else
          v_list := v_list || ',' || '''' || i.REF_ID || '''';
        end if;
      elsif p_list_type = 'N' then
        if v_first = 'Y' then
          v_list := i.REF_ID;
          v_first := 'N';
        else
          v_list := v_list || ',' || i.REF_ID;
        end if;
      else
        v_list := 'BAD_STRING';
      end if;
    end loop;

    return v_list;
    
  end;
end;
/


grant execute on ETL_COMMON to MAXDAT_READ_ONLY;

alter session set plsql_code_type = interpreted;