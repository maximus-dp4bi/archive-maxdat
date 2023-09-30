truncate table cc_c_project_config;
truncate table CC_C_UNIT_OF_WORK;
truncate table cc_s_acd_interval_period;

alter table cc_s_agent add site_description varchar2(200) null;
alter table cc_s_agent modify site_description not null;

commit;
