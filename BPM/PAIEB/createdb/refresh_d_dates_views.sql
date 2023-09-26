CREATE OR REPLACE PROCEDURE refresh_d_dates_views
AS
BEGIN
  dbms_mview.refresh('D_YEARS','?');
  dbms_mview.refresh('D_MONTHS','?');
  dbms_mview.refresh('D_WEEKS','?');
  dbms_mview.refresh('D_QUARTERS','?');
END;
/