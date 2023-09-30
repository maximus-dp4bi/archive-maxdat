--- NYHIX-27728 - NYSOH - Scorecard - Starting Balance Update 12.13.16
delete from SC_ATTENDANCE_INITIAL_SCORE where staff_id in (63669, 106461, 105427);
commit;
Update SC_ATTENDANCE_INITIAL_SCORE SET ATTENDANCE_POINTS = 40, INCENTIVE_POINTS = null ,START_DATE = to_date('09/26/2016', 'mm/dd/yyyy') where staff_id = 1593;
Update SC_ATTENDANCE_INITIAL_SCORE SET ATTENDANCE_POINTS = 10, INCENTIVE_POINTS = null ,START_DATE = to_date('09/26/2016', 'mm/dd/yyyy') where staff_id = 7102;
Update SC_ATTENDANCE_INITIAL_SCORE SET ATTENDANCE_POINTS = 9, INCENTIVE_POINTS = null ,START_DATE = to_date('09/26/2016', 'mm/dd/yyyy') where staff_id = 7145;

commit;
