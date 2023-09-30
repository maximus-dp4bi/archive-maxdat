Update MAXDAT.PP_BO_EVENT_TARGET_LKUP
set scorecard_group = 'VLP'
where event_id = 1345
and start_date = to_date('01-JAN-16 00:00:00','dd-MON-yy hh24:mi:ss')
and end_date is null;

Update MAXDAT.PP_BO_EVENT_TARGET_LKUP
set scorecard_group = 'Other Research'
where event_id = 1099
and start_date = to_date('01-JAN-16 00:00:00','dd-MON-yy hh24:mi:ss')
and end_date is null;

commit;
