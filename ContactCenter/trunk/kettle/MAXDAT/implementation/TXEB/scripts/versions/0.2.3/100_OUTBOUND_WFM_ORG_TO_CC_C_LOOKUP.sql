insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROJECT','TEXAS','TX Enrollment Broker');

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','TEXAS','EB');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','TEXAS','THS');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','TEXAS','CHIP');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
values ('0.2.3','100','100_OUTBOUND_WFM_ORG_TO_CC_C_LOOKUP');

commit;