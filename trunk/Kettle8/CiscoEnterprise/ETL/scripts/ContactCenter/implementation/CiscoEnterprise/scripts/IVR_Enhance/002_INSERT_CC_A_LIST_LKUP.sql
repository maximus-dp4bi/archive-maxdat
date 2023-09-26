insert into cc_a_list_lkup (name, list_type, value, out_var, start_date, end_date, comments, created_ts, updated_ts)
values ('IVR_ENHANCE_RECALC_ALL_METRICS', 'IVR_ENHANCE_RECALC', 'ENABLED', 'N', trunc(sysdate), to_date('7777-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Setting to control whether ALL METRIC recalc is enabled', sysdate, sysdate);

commit;