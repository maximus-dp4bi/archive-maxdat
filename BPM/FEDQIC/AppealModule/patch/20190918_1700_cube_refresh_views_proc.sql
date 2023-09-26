CREATE OR REPLACE PROCEDURE refresh_appeal_cube_material_views
AS
BEGIN
  dbms_mview.refresh('APPEAL_DETAILS_BY_DAY_MV','?');
  dbms_mview.refresh('APPEAL_TASKS_BY_DAY_MV','?');
  dbms_mview.refresh('APPEAL_STAFF_PERFORMANCE_BY_DAY_MV','?');
END;

commit;
