USE SCHEMA PUBLIC;
--pbi_trending_completed_open_cases_by_day
CREATE OR REPLACE VIEW mio_d_completed_open_cases_by_day_sv AS
SELECT case_status,
  case_type,
  unit, 
  disposition,
  specialty application_type,
  qty,
  date
FROM coverva_mio.rpt_trending_completed_open_cases_by_day 
--WHERE date > DATEADD(DAY,-30,current_date())