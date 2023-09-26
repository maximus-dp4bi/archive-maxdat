update cc_s_agent
set site_name = 'Atlanta'
, site_description = 'Atlanta'
, project_config_id = (select project_config_id from cc_c_project_config where project_name = 'LA EB' and program_name = 'Medicaid')
where site_name!= 'Unknown';

update cc_d_agent
set site_name = 'Atlanta'
where site_name!= 'Unknown';

commit;

delete from cc_c_project_config
where project_name = 'LA EB'
and program_name = 'LA - Multiple';

commit;

update cc_a_list_lkup
set out_var = 'Medicaid'
where list_type = 'AGENT_PROGRAM';

commit;

insert into cc_d_site (d_site_id, site_name, site_description, version, record_eff_dt, record_end_dt)
values (SEQ_CC_D_SITE.nextval, 'Atlanta', 'Atlanta', 1, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

commit;

update cc_f_agent_by_date
set d_site_id = (select d_site_id from cc_d_site where site_name = 'Atlanta')
where d_site_id != (select d_site_id from cc_d_site where site_name = 'Unknown');

update cc_f_agent_by_date
set d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid')
where d_project_targets_id != (select d_project_targets_id from cc_d_project_targets t, cc_d_project p where t.project_id = p.project_id and p.project_name = 'Unknown')
and d_program_id!= (select program_id from cc_d_program where program_name = 'Unknown');


update cc_f_agent_activity_by_date
set d_site_id = (select d_site_id from cc_d_site where site_name = 'Atlanta')
where d_site_id != (select d_site_id from cc_d_site where site_name = 'Unknown');

update cc_f_agent_activity_by_date
set d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid')
where d_project_id != (select project_id from cc_d_project where project_name = 'Unknown')
and d_program_id!= (select program_id from cc_d_program where program_name = 'Unknown');


commit;

delete from cc_d_site
where site_name in ('BAYOU HEALTH', 'Bayou Health', 'HL', 'IT', 'LABH', 'LARA');


insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'Agent_Site'
					,'AGENT_SITE'
					,'GAAP1MLTL01GH'
					,'GAAP1MLTL01GH'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Site lookup for agent'
					,SYSDATE
					,SYSDATE);
					
commit;		