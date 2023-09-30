Update sc_attendance_absence_lkup
set end_date = to_date('7/7/2077','dd/mm/yyyy')
where sc_all_id in (181,201,202);

commit;
