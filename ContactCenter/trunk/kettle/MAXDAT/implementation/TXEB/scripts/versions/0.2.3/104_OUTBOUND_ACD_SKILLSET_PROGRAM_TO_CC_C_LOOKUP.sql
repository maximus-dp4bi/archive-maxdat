--- Program lookup Outbound calls Skill groups 

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5020','EB');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5021','THS');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5048','CHIP');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5077','CHIP');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5078','CHIP');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5079','CHIP');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5080','CHIP');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5081','CHIP');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5082','CHIP');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5241','CHIP');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5245','CHIP');


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.3','104','104_OUTBOUND_ACD_SKILLSET_PROGRAM_TO_CC_C_LOOKUP');

commit;