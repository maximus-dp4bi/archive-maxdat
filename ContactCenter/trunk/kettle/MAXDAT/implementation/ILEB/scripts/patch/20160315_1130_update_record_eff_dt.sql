alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

update cc_s_agent_supervisor
set record_eff_dt = '05-JAN-15'
where agent_id = 1402
and supervisor_agent_id = 194;

commit;