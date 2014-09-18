-- Project lookup for Outbound calls Skill groups

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5020','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5021','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5048','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5077','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5078','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5079','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5080','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5081','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5082','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5241','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5245','TX Enrollment Broker');

												 
INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 			 
VALUES ('0.2.3','103','103_OUTBOUND_ACD_SKILLSET_PROJECT_TO_CC_C_LOOKUP');

commit;
