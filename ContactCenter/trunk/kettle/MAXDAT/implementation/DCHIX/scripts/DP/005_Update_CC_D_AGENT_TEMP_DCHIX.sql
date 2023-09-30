--MAXDAT-8228

alter session set current_schema = maxdat_dchix;

select login_id, first_name, last_name, job_title, record_eff_dt, record_end_dt from cc_d_agent_temp_dchix
where login_id in ('18510', '18547');

update CC_D_AGENT_TEMP_DCHIX
set record_end_dt = to_date('23-OCT-2018', 'DD-MON-RR')
where login_id in ('18510', '18547');

commit;