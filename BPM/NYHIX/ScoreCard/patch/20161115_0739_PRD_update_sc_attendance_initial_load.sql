
Update SC_ATTENDANCE_INITIAL_SCORE SET ATTENDANCE_POINTS = 32, START_DATE = to_date('8/31/2016', 'mm/dd/yyyy') where staff_id = 2871;
INSERT INTO SC_ATTENDANCE_INITIAL_SCORE (STAFF_ID, ATTENDANCE_POINTS, INCENTIVE_POINTS, START_DATE) VALUES (11557,40,null,to_date('9/26/2016', 'mm/dd/yyyy'));
INSERT INTO SC_ATTENDANCE_INITIAL_SCORE (STAFF_ID, ATTENDANCE_POINTS, INCENTIVE_POINTS, START_DATE) VALUES (11558,40,null,to_date('9/26/2016', 'mm/dd/yyyy'));

commit;