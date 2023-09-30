-- insert call types to CC_C_FILTER, insert skill groups to CC_C_FILTER

insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5040);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5734);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5735);


insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5040);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5734);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5735);



INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.4','102','102_ES_OUTBOUND_CALLTYPES_SKILLGRPS_TO_CC_C_FILTER');

commit;