-- Project lookup for EB STAR PLUS Skill groups

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5184','TX Enrollment Broker');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROJECT','5194','TX Enrollment Broker');
												 
INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 			 
VALUES ('0.2.0','105','105_STARPLUS_ACD_SKILLSET_PROJECT_TO_CC_C_LOOKUP');

commit;
