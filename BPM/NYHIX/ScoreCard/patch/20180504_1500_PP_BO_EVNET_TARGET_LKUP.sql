update MAXDAT.PP_BO_EVENT_TARGET_LKUP 
set scorecard_flag = 'N'
where event_id = 1070
and end_date is null;

commit;
