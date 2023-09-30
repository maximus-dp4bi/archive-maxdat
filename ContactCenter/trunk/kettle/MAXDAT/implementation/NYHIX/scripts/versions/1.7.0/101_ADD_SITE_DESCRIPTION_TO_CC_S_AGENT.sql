alter table cc_s_agent add site_description varchar2(200) null;

update cc_f_agent_by_date set d_site_id=0 where d_site_id<>0;
update cc_f_agent_activity_by_date set d_site_id=0 where d_site_id<>0;
update cc_s_agent set site_name='Unknown', site_description='Unknown';
delete from cc_d_site where d_site_id<>0;
delete from cc_c_lookup where lookup_type='WFM_OFFICE_SITE';
commit;

alter table cc_s_agent modify site_description not null;
