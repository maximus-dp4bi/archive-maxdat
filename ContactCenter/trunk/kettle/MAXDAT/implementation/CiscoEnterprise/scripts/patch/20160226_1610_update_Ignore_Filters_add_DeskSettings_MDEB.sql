/* MAXDAT-3241 */

alter session set current_schema = CISCO_ENTERPRISE_CC;

update cc_a_list_lkup
set out_var = out_var || ',5019,5020'
where list_type = 'DESK_SETTINGS';

commit;