alter session set current_schema = cisco_enterprise_cc;

insert into cc_a_list_lkup (name, list_type, value, out_var, ref_id, start_date, end_date, comments, created_ts, updated_ts)
values ('CAHCO_Completed_Event', 'CAHCO_CALLBACK', 'CAHCO_Completed_Event',24, 1,trunc(SYSDATE),to_date('07-JUL-7777','DD-MON-YYYY'), 'CAHCO_Completed_Event', SYSDATE, SYSDATE );

insert into cc_a_list_lkup (name, list_type, value, out_var, ref_id, start_date, end_date, comments, created_ts, updated_ts)
values ('CAHCO_Peripheral_CallType', 'CAHCO_CALLTYPE', 'CAHCO_Peripheral_CallType',2, 1,trunc(SYSDATE),to_date('07-JUL-7777','DD-MON-YYYY'), 'CAHCO_Peripheral_CallType', SYSDATE, SYSDATE );

insert into cc_a_list_lkup (name, list_type, value, out_var, ref_id, start_date, end_date, comments, created_ts, updated_ts)
values ('CAHCO_Enterprise_Name', 'CAHCO_QUEUE_NAME', 'CAHCO_Enterprise_Name','CAR%', 1,trunc(SYSDATE),to_date('07-JUL-7777','DD-MON-YYYY'), 'CAHCO_Enterprise_Name', SYSDATE, SYSDATE );

COMMIT;

	
