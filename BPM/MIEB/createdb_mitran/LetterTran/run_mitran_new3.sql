set define off
spool run_mitran3.log

prompt =====================================
prompt create_d_tran_action_lkup.sql
prompt =====================================
@@create_d_tran_action_lkup.sql

prompt =====================================
prompt create_d_tran_action.sql
prompt =====================================
@@create_d_tran_action.sql

prompt =====================================
prompt insert_d_tran_action_lkup.sql
prompt =====================================
@@insert_d_tran_action_lkup.sql

prompt =====================================
prompt create_d_tran_event_lkup.sql
prompt =====================================
@@create_d_tran_event_lkup.sql

prompt =====================================
prompt create_d_tran_event.sql
prompt =====================================
@@create_d_tran_event.sql

prompt =====================================
prompt insert_d_tran_event_lkup.sql
prompt =====================================
@@insert_d_tran_event_lkup.sql

spool off
