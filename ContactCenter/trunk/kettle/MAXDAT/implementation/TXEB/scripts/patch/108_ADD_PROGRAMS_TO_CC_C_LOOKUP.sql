-- Project lookup for ES organizations
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','Austin','EB');

-- Program lookup for ES organizations
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES Training','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES Virtual Contact Center','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES QC Midland','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES QC Athens','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES Spanish Athens','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES English Edinburg','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES QC Edinburg','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES SEU Spanish Edinburg','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES Spanish Edinburg','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES SEU Spanish Athens','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES SEU Spanish Midland','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES English','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES Spanish','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES QC','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES English Midland','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES SEU Virtual Contact Center','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES SEU English','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES SEU Spanish','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES SEU English Midland','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES SEU English Edinburg','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES English Athens','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES Spanish Midland','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','ES SEU English Athens','ES');
insert into cc_c_lookup(lookup_type,lookup_key,lookup_value)values('WFM_ORG_PROGRAM','State of Texas','ES');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
values ('0.1.9','108','108_ADD_ES_PROGRAMS_TO_CC_C_LOOKUP');

commit;

