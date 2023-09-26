update cc_d_group
set include_agent_payroll_flg = 'Y'
where group_name in
(
'CES Part Time Staff to be Scheduled'
, 'CES Staff to be scheduled'
, 'EEV Part Time Staff to be scheduled'
, 'EEV Staff to be scheduled'
);


update cc_d_group
set include_agent_payroll_flg = 'N'
where group_name not in
(
'CES Part Time Staff to be Scheduled'
, 'CES Staff to be scheduled'
, 'EEV Part Time Staff to be scheduled'
, 'EEV Staff to be scheduled'
);

commit;