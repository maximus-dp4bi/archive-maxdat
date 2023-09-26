insert into cc_c_project_config (project_config_id, project_name, program_name, region_name, state_name, province_name, district_name, country_name)
values (2, 'IL EEV', 'EEV', 'Central', 'Illinois', 'Unknown', 'Unknown', 'USA');
commit;

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('0.3.1',115,'115_INSERT_EEV_PROJECT_CONFIG');
commit;
