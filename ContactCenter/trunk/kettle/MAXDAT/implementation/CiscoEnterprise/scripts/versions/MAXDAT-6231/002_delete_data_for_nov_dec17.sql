alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

alter session set current_schema = CISCO_ENTERPRISE_CC;

select count(*) from  cc_f_ivr_menu_group_date
where f_ivr_menu_group_id in (select f_ivr_menu_group_id from cc_f_ivr_menu_group_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-NOV-17' and '31-DEC-17');

delete from  cc_f_ivr_menu_group_date
where f_ivr_menu_group_id in (select f_ivr_menu_group_id from cc_f_ivr_menu_group_date f, cc_d_dates d
where f.d_date_id = d.d_date_id
and d.d_date between '01-NOV-17' and '31-DEC-17');

select count(*) from cc_s_ivr_menu_group_date
where trunc(call_date) between '01-NOV-17' and '31-DEC-17';

delete from cc_s_ivr_menu_group_date
where trunc(call_date) between '01-NOV-17' and '31-DEC-17';

commit;