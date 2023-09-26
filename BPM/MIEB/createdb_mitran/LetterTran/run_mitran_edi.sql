spool run_mitranedi.log

prompt =====================================
prompt create_etl_l_letters_edi.sql
prompt =====================================
@@create_etl_l_letters_edi.sql

prompt =====================================
prompt alter_d_letter_definition.sql
prompt =====================================
@@alter_d_letter_definition.txt

prompt =====================================
prompt create_etl_l_tran_edi.sql
prompt =====================================
@@create_etl_l_tran_edi.sql

prompt =====================================
prompt proc_letters_edi.sql
prompt =====================================
@@proc_letters_edi.sql


prompt =====================================
prompt proc_tran_edi.sql
prompt =====================================
@@proc_tran_edi.sql


spool off
