set define off;
update pp_bo_event_target_lkup set end_date = to_date('31-Oct-16 00:00:00','dd-Mon-yy hh24:mi:ss') where event_id = 1124;

update pp_bo_event_target_lkup set end_date = to_date('31-Jul-16 00:00:00','dd-Mon-yy hh24:mi:ss') where event_id = 1317 AND start_date = to_date('01/01/2016','mm/dd/yyyy');
update pp_bo_event_target_lkup set end_date = NULL where event_id = 1317 AND start_date = to_date('08/01/2016','mm/dd/yyyy');


commit;
