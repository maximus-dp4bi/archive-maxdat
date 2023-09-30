update cc_s_acd_interval
set calls_answered = contacts_handled;

commit;

update cc_s_acd_queue_interval
set calls_answered = contacts_handled;

commit;

update cc_f_actuals_queue_interval
set calls_answered = contacts_handled;

commit;

update cc_f_acd_queue_interval
set calls_answered = contacts_handled;

commit;