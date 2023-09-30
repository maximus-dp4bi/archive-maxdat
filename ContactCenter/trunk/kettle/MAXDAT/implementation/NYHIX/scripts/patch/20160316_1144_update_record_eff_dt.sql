alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

update cc_s_agent_supervisor
set record_eff_dt = '15-DEC-14'
where agent_id = 3175
and supervisor_agent_id = 3449;

update cc_s_agent_supervisor
set record_eff_dt = '01-NOV-13'
where agent_id = 3515
and supervisor_agent_id = 5141;

update cc_s_agent_supervisor
set record_eff_dt = '01-DEC-15'
where agent_id = 6902
and supervisor_agent_id = 1032;

commit;