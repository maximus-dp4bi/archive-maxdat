create or replace function GET_BUS_DATE
    (p_start_date in date,
     p_number_days in number)
    return date parallel_enable
  as
  begin
    return ETL_COMMON.GET_BUS_DATE(p_start_date,p_number_days);
  end;
/
grant execute on GET_BUS_DATE to MAXDAT_MIEB_PFP_E;
grant execute on GET_BUS_DATE to MAXDAT_MITRAN_READ_ONLY;


