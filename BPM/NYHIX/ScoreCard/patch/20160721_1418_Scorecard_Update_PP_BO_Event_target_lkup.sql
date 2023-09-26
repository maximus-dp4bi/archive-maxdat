-- Update PP_BO_Event_target_lkup NYHIX-23560

update PP_BO_Event_target_lkup
set name = 'Retro Verification Document'
,TARGET = 7
,SCORECARD_FLAG = 'Y'
,start_date = to_date('01-Aug-16 00:00:00','dd-Mon-yy hh24:mi:ss')
where EVENT_ID = 1317
;
commit;

insert into PP_BO_Event_target_lkup (event_id, name, target, scorecard_flag, start_date, end_date, scorecard_group) values (1478, 'Building Evacuation', 0, 'N', to_date('25-Jul-16 00:00:00','dd-Mon-yy hh24:mi:ss'), null, 'NA');
insert into PP_BO_Event_target_lkup (event_id, name, target, scorecard_flag, start_date, end_date, scorecard_group) values (1477, 'Team Lead - Floor Support', 0, 'N', to_date('25-Jul-16 00:00:00','dd-Mon-yy hh24:mi:ss'), null, 'NA');

commit;
