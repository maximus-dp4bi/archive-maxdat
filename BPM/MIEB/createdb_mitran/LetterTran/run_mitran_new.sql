set define off
spool run_mitran.log

prompt =====================================
prompt create_D_TRAN_LETTER_TYPE_SV.sql
prompt =====================================
@@create_D_TRAN_LETTER_TYPE_SV.sql

prompt =====================================
prompt create_d_tran_header_detail.sql
prompt =====================================
@@create_d_tran_header_detail.sql

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


prompt =====================================
prompt create_d_header_latest_events_sv.sql
prompt =====================================
@@create_d_header_latest_events_sv.sql

prompt =====================================
prompt proc_ins_tran_event.sql
prompt =====================================
@@proc_ins_tran_event.sql

prompt =====================================
prompt create_F_TRANSMITTAL_DETAILS_SV.sql
prompt =====================================
@@create_F_TRANSMITTAL_DETAILS_SV.sql

prompt =====================================
prompt create_F_TRANSMITTAL_DETAILS_ADHOC_SV.sql
prompt =====================================
@@create_F_TRANSMITTAL_DETAILS_ADHOC_SV.sql


prompt =====================================
prompt grant_tran_objects.sql
prompt =====================================
@@grant_tran_objects.sql

prompt =====================================
prompt alter_d_subprogram.sql
prompt =====================================
@@alter_d_subprogram.sql

prompt =====================================
prompt proc_validate_transmittal.sql
prompt =====================================
@@proc_validate_transmittal.sql

prompt =====================================
prompt mitran_tran_comm_form_insert.fnc.sql
prompt =====================================
@@mitran_tran_comm_form_insert.fnc.sql

prompt =====================================
prompt mitran_tran_adjust_form_insert.fnc.sql
prompt =====================================
@@mitran_tran_adjust_form_insert.fnc.sql

prompt =====================================
prompt create_F_TRAN_QA_PENDING_SV.sql
prompt =====================================
@@create_F_TRAN_QA_PENDING_SV.sql

prompt =====================================
prompt mitran_tran_adjust_form_qa_fnc.sql
prompt =====================================
@@mitran_tran_adjust_form_qa_fnc.sql

prompt =====================================
prompt proc_validate_transmittal_update.sql
prompt =====================================
@@proc_validate_transmittal_update.sql

prompt =====================================
prompt TRAN_ADJUST_UPDATE.prc
prompt =====================================
@@TRAN_ADJUST_UPDATE.prc



spool off
