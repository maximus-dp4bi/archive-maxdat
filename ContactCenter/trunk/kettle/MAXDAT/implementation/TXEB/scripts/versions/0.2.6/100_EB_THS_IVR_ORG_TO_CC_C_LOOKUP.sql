
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5083','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5099','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','7143','TX Enrollment Broker');

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5086','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5138','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5152','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','6792','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','6795','TX Enrollment Broker');

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5083','CHIP');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5099','CHIP');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','7143','EB');

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5086','THS');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5138','THS');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5152','EB');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','6792','EB');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','6795','EB');


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
values ('0.2.6','100','100_EB_THS_IVR_ORG_TO_CC_C_LOOKUP');

commit;