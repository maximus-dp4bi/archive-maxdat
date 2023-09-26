--MAXDAT-8296

alter session set current_schema = maxdat_dchix;

select * from cc_d_agent_temp_dchix
where login_id in ('18501', '18559', 'xxxxx');

update cc_d_agent_temp_dchix
set first_name = 'La Shae'
where login_id = '18501';

update cc_d_agent_temp_dchix
set first_name = 'Denneca'
where login_id = '18559';


commit;