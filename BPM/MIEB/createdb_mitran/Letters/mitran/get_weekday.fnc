create or replace function GET_WEEKDAY
    (p_start_date in date, 
     p_days2add in number) 
    return date parallel_enable
  as
  begin
    return ETL_COMMON.GET_WEEKDAY(p_start_date,p_days2add);
  end;
/
grant execute on GET_WEEKDAY to MAXDAT_MIEB_PFP_E;
grant execute on GET_WEEKDAY to MAXDAT_MITRAN_READ_ONLY;


