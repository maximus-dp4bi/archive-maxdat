-- insert call types to CC_C_FILTER, insert skill groups to CC_C_FILTER

insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5020);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5021);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5048);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5077);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5078);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5079);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5080);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5081);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5082);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5241);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5245);



insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5020);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5021);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5048);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5077);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5078);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5079);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5080);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5081);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5082);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5241);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5245);


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.3','102','102_ADD_OUTBOUND_CALLTYPES_SKILLGRPS_TO_CC_C_FILTER');

commit;