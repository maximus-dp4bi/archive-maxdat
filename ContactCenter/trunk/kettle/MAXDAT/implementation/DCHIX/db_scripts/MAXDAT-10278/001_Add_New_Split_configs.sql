alter session set current_Schema = maxdat_dchix;

/*alter table cc_s_acd_agent_Activity
modify login_seconds null;

alter table cc_f_agent_by_date
modify login_seconds null;
*/

insert into cc_c_agent_rtg_grp (agent_routing_group_number, agent_routing_group_name, agent_routing_group_type, interval_minutes, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values (826, 'HBX-MA-ChamberOfCommerence', 'Split', 30, 'D.C. HBE', 'Massachusetts HIX', 'East', 'Washington D.C.', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

commit;