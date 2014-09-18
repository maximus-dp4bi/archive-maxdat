-- assigning ES Outbound calls queues to ES Outbound organization as per Ed's suggestion 06/16


insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC','5083');
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC','5099');
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC','7143');

insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC','5083');
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC','5099');
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC','7143');

insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC','5086');
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC','5138');
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC','5152');
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC','6792');
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC','6795');


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.6','101','101_EB_THS_IVR_ORG_TO_CC_C_FILTER');

commit;