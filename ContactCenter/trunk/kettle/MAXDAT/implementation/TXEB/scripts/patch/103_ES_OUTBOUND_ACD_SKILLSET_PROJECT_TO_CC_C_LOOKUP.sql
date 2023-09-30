-- Project lookup for Outbound calls Skill groups

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5040','TX Eligibility Support');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5734','TX Eligibility Support');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5735','TX Eligibility Support');


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 			 
VALUES ('0.2.4','103','103_ES_OUTBOUND_ACD_SKILLSET_PROJECT_TO_CC_C_LOOKUP');

commit;
