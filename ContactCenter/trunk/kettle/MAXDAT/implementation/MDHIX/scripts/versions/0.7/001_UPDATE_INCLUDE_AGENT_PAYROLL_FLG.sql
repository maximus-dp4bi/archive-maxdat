update cc_d_group
set include_agent_payroll_flg = 'N'
where group_name != 'CSR';

commit;