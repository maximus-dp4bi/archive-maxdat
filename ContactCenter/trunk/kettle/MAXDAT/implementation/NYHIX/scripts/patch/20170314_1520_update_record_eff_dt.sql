alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

update cc_s_agent_supervisor
set record_eff_dt = '21-OCT-14'
where agent_id = 3301
and supervisor_agent_id = 992;

update cc_s_agent_supervisor
set record_eff_dt = '16-AUG-16'
where agent_id = 12406
and supervisor_agent_id = 11782;

update cc_s_agent_supervisor
set record_eff_dt = '27-SEP-16'
where agent_id = 13414
and supervisor_agent_id = 11775;

update cc_s_agent_supervisor
set record_eff_dt = '10-JAN-17'
where agent_id = 15425
and supervisor_agent_id = 13791;

update cc_s_agent_supervisor
set record_eff_dt = '13-OCT-16'
where agent_id = 13828
and supervisor_agent_id = 806;

commit;