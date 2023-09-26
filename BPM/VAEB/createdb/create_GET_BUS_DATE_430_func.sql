---Usage: ApplySimple("maxdat_support.get_bus_date_430(sysdate,-1)",0)

 create or replace function GET_BUS_DATE_430
    (p_start_date in date,
     p_number_days in number)
    return date parallel_enable
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
      from d_HOLIDAYS
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
       from d_HOLIDAYS
       where HOLIDAY_DATE = v_curdate;
   
       v_daynum  := to_char(v_curdate,'D');
       if (v_daynum between 2 and 6) AND v_holiday = 0 then
          v_counter := v_counter + 1;
       else
         v_skipcntr := v_skipcntr + 1;
       end if;
    end loop;

    v_weekdate := p_start_date + (v_direction * (v_counter + v_skipcntr));
    
    RETURN TRUNC(v_weekdate)+16/24+(29/(24*60));
  
  end;
 /
 
 grant execute on get_bus_Date_430 to maxdat_reports;
 grant execute on get_bus_Date_430 to maxdatsupport_read_only;
 grant execute on get_bus_Date_430 to maxdatsupport_oltp_siud;
 grant execute on get_bus_Date_430 to maxdatreport_Read_only;
