update cc_d_group
set include_agent_payroll_flg = 'Y'
where group_name = 'Default Back Office'
and d_project_id = 11;

commit;