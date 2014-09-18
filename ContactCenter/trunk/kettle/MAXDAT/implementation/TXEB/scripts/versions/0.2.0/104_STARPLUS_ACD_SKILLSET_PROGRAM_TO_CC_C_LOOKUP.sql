--- Program lookup EB STAR PLUS Skill groups 

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5184','EB');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5194','EB');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.0','104','104_STARPLUS_ACD_SKILLSET_PROGRAM_TO_CC_C_LOOKUP');

commit;