CREATE OR REPLACE PROCEDURE refresh_d_dates_views
AS
BEGIN
  dbms_mview.refresh('D_YEARS','?');
  dbms_mview.refresh('D_MONTHS','?');
  dbms_mview.refresh('D_WEEKS','?');
END;
/
grant execute on REFRESH_D_DATES_VIEWS to MAXDAT_MIEB_PFP_E;


