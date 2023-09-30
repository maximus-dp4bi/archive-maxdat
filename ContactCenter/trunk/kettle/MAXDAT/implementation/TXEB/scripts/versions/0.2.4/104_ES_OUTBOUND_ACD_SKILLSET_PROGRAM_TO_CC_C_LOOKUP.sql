--- Program lookup Outbound calls Skill groups 

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5040','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5734','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('ACD_SKILLSET_PROGRAM','5735','ES');


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.4','104','104_ES_OUTBOUND_ACD_SKILLSET_PROGRAM_TO_CC_C_LOOKUP');

commit;