-- insert call types to CC_C_FILTER

insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',7127);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',7131);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',7136);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',7140);


---insert skill groups to CC_C_FILTER

insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5184);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5194);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.0','100','100_ADD_STARPLUS_CALLTYPES_SKILLGRPS_TO_CC_C_FILTER');

commit;