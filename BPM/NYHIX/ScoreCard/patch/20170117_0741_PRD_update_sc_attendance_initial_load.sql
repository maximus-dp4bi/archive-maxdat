--- NYHIX-28304 - NYSOH - Scorecard - Starting Balance Update 12.13.16
Update SC_ATTENDANCE_INITIAL_SCORE SET ATTENDANCE_POINTS = 27, INCENTIVE_POINTS = null ,START_DATE = to_date('09/26/2016', 'mm/dd/yyyy') where staff_id = 3346;
Update SC_ATTENDANCE_INITIAL_SCORE SET ATTENDANCE_POINTS = 29, INCENTIVE_POINTS = null ,START_DATE = to_date('09/26/2016', 'mm/dd/yyyy') where staff_id = 1406;
Update SC_ATTENDANCE_INITIAL_SCORE SET ATTENDANCE_POINTS = 17, INCENTIVE_POINTS = null ,START_DATE = to_date('09/26/2016', 'mm/dd/yyyy') where staff_id = 4878;
Update SC_ATTENDANCE_INITIAL_SCORE SET ATTENDANCE_POINTS = 15, INCENTIVE_POINTS = null ,START_DATE = to_date('09/26/2016', 'mm/dd/yyyy') where staff_id = 4555;
Update SC_ATTENDANCE_INITIAL_SCORE SET ATTENDANCE_POINTS = 27, INCENTIVE_POINTS = null ,START_DATE = to_date('09/26/2016', 'mm/dd/yyyy') where staff_id = 6265;
INSERT INTO SC_ATTENDANCE_INITIAL_SCORE (STAFF_ID, ATTENDANCE_POINTS, INCENTIVE_POINTS, START_DATE) VALUES (4200,7,null,to_date('9/26/2016', 'mm/dd/yyyy'));

commit;
