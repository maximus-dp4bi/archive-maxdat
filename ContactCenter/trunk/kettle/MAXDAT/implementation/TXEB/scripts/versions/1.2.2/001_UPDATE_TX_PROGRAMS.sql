-- this script updates the TX programs to include the new 'Multiple - EB/THS/CHIP' entry

---
--- cc_d_program
---

-- insert the new record
insert into cc_d_program (program_id, program_name)
values (5, 'Multiple - EB/THS/CHIP');

---
--- cc_c_lookup
---

-- update program name
update cc_c_lookup
set lookup_value = 'Multiple - EB/THS/CHIP'
where lookup_type IN('WFM_ORG_PROGRAM', 'ACD_SKILLSET_PROGRAM')
	and lookup_value <> 'ES';
	
---
--- cc_c_project_config
---

-- insert the new record
insert into cc_c_project_config (project_config_id, project_name, program_name, region_name, state_name, province_name, district_name, country_name)
values (5, 'TX Enrollment Broker', 'Multiple - EB/THS/CHIP', 'Central', 'Texas', 'Unknown', 'Unknown', 'USA');


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.2.2','001','001_UPDATE_TX_PROGRAMS');

COMMIT;