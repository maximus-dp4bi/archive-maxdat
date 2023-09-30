create or replace function BUS_DAYS_BETWEEN
    (p_start_date in date,
     p_end_date in date)
    return integer parallel_enable
  as
  begin
    return ETL_COMMON.BUS_DAYS_BETWEEN(p_start_date,p_end_date);
  end;
/
grant execute on BUS_DAYS_BETWEEN to MAXDAT_MIEB_PFP_E;
grant execute on BUS_DAYS_BETWEEN to MAXDAT_MITRAN_READ_ONLY;


