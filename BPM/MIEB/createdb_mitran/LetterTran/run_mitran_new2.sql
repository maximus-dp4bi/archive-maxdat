spool run_mitran2.log

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
prompt tran_adjust_qa_fnc.sql
prompt =====================================
@@tran_adjust_qa_fnc.sql

spool off
