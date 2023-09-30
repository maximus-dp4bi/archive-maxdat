alter session set current_schema = maxdat_cc;

update cc_a_list_lkup
set out_var = 'PA - Multiple'
where name = 'Agent_Program'
and value in ('Call Center - PA', 'PA');

commit;