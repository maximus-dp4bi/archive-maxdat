insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROJECT','EB STAR+PLUS Austin','TX Enrollment Broker');

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','EB STAR+PLUS Austin','EB');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
values ('0.2.0','106','106_STARPLUS_WFM_ORG_TO_CC_C_LOOKUP');

commit;