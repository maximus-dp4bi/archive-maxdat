alter session set current_schema = cisco_enterprise_cc;

insert into cc_a_list_lkup (name, list_type, value, out_var, ref_id, start_date, end_date, comments)
values ('CALLBACK_Table_Name', 'CALLBACK_TABLE', 'CALLBACK_Table_Name', 'callback', 1, to_date('01/01/1900', 'mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'), 'Look into callback or callback_history depending on what date is loaded');

COMMIT;

	
