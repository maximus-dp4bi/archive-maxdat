update maxdat.pp_bo_event_target_lkup set end_date = null where event_id = 1068 and end_date = to_date('30-Apr-17','dd-Mon-yy');
delete from maxdat.pp_bo_event_target_lkup where event_id = 1068 and start_date = to_date('1-May-17','dd-Mon-yy');

Update maxdat.pp_bo_event_target_lkup set target = 0, scorecard_flag = 'N' where event_id = 1404 and start_date = to_date('1-May-17','dd-Mon-yy');

Update maxdat.pp_bo_event_target_lkup set target = 0, scorecard_flag = 'N' where event_id = 1455 and start_date = to_date('1-May-17','dd-Mon-yy');

Update maxdat.pp_bo_event_target_lkup set target = 0, scorecard_flag = 'N' where event_id = 1485 and start_date = to_date('1-May-17','dd-Mon-yy');

Commit;
