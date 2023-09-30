-- assigning ES Outbound calls queues to ES Outbound organization as per Ed's suggestion 06/16

insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES Outbound');

insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES Training');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES Virtual Contact Center');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES QC Midland');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES QC Athens');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES Spanish Athens');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES English Edinburg');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES QC Edinburg');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES SEU Spanish Edinburg');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES Spanish Edinburg');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES SEU Spanish Athens');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES SEU Spanish Midland');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES English');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES Spanish');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES QC');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES English Midland');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES SEU Virtual Contact Center');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES SEU English');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES SEU Spanish');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES SEU English Midland');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES SEU English Edinburg');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES English Athens');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES Spanish Midland');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','ES SEU English Athens');
insert into CC_C_FILTER (filter_type,value) values ('WFM_ORGANIZATION_INC','State of Texas');


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.4','101','101_ES_OUTBOUND_WFM_ORG_TO_CC_C_FILTER');

commit;