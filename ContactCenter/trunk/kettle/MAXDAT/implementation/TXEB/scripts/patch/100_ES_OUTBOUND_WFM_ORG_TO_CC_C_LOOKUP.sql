insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROJECT','ES Outbound','TX Eligibility Support');

insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES Outbound','ES');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
values ('0.2.4','100','100_ES_OUTBOUND_WFM_ORG_TO_CC_C_LOOKUP');

commit;