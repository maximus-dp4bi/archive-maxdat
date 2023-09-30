alter session set current_schema = cisco_enterprise_cc;

update cc_c_ivr_menu_group
set ivr_menu_group_name = 'FLG_HealthChoice Helpline', project_name = 'MD HBE', program_name = 'CSC'
where ivr_menu_name like 'MDHIX_ENT%'
and ivr_sub_menu_name like 'FLG%Helpline';

commit;