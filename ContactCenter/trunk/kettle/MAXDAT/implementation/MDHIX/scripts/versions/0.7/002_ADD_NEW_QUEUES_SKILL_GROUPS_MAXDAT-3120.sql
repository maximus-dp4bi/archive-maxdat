insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '5030');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '5056');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '5057');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '5058');
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', '5059');


insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '5414');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '5415');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '5416');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '5417');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '5420');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '5421');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '5422');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '5423');

commit;


insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '5030', 'MD HIX');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '5056', 'MD HIX');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '5057', 'MD HIX');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '5058', 'MD HIX');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '5059', 'MD HIX');


insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '5030', 'MD HIX');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '5056', 'MD HIX');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '5057', 'MD HIX');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '5058', 'MD HIX');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '5059', 'MD HIX');

commit;



Insert into CC_C_CONTACT_QUEUE (QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,UNIT_OF_WORK_NAME,PROJECT_NAME,PROGRAM_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT,INTERVAL_MINUTES) values (5414,'COGD_SHSE_8572_1095B_ENG_XFER','Transfer',0,60,'SPECIALTY','MD HIX','MD HIX','Eastern','Maryland','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),15);
Insert into CC_C_CONTACT_QUEUE (QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,UNIT_OF_WORK_NAME,PROJECT_NAME,PROGRAM_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT,INTERVAL_MINUTES) values (5415,'COGD_SHSE_8572_1095B_PQOvFlw_ENG','Inbound',0,60,'SPECIALTY','MD HIX','MD HIX','Eastern','Maryland','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),15);
Insert into CC_C_CONTACT_QUEUE (QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,UNIT_OF_WORK_NAME,PROJECT_NAME,PROGRAM_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT,INTERVAL_MINUTES) values (5416,'COGD_SHSE_8572_1095B_PQOvFlw_SPA','Inbound',0,60,'SPECIALTY','MD HIX','MD HIX','Eastern','Maryland','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),15);
Insert into CC_C_CONTACT_QUEUE (QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,UNIT_OF_WORK_NAME,PROJECT_NAME,PROGRAM_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT,INTERVAL_MINUTES) values (5417,'COGD_SHSE_8572_1095B_SPA_XFER','Transfer',0,60,'SPECIALTY','MD HIX','MD HIX','Eastern','Maryland','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),15);
Insert into CC_C_CONTACT_QUEUE (QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,UNIT_OF_WORK_NAME,PROJECT_NAME,PROGRAM_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT,INTERVAL_MINUTES) values (5420,'MDLB_MHBE_8572_1095B_ENG','Inbound',0,60,'SPECIALTY','MD HIX','MD HIX','Eastern','Maryland','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),15);
Insert into CC_C_CONTACT_QUEUE (QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,UNIT_OF_WORK_NAME,PROJECT_NAME,PROGRAM_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT,INTERVAL_MINUTES) values (5421,'MDLB_MHBE_8572_1095B_ENG_XFER','Transfer',0,60,'SPECIALTY','MD HIX','MD HIX','Eastern','Maryland','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),15);
Insert into CC_C_CONTACT_QUEUE (QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,UNIT_OF_WORK_NAME,PROJECT_NAME,PROGRAM_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT,INTERVAL_MINUTES) values (5422,'MDLB_MHBE_8572_1095B_SPA','Inbound',0,60,'SPECIALTY','MD HIX','MD HIX','Eastern','Maryland','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),15);
Insert into CC_C_CONTACT_QUEUE (QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,UNIT_OF_WORK_NAME,PROJECT_NAME,PROGRAM_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT,INTERVAL_MINUTES) values (5423,'MDLB_MHBE_8572_1095B_SPA_XFER','Transfer',0,60,'SPECIALTY','MD HIX','MD HIX','Eastern','Maryland','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),15);

commit;
