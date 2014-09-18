-- insert call types to CC_C_FILTER

insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5088);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5091);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5500);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5501);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',6707);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',6710);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',6713);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',6716);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5087);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5090);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5638);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5639);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5527);
insert into CC_C_FILTER (filter_type,value) values ('ACD_CALL_TYPE_ID_INC',5528);

---insert skill groups to CC_C_FILTER

insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5579);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5580);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5994);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',5995);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',6700);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',6701);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',6702);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',6703);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',7611);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',7612);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',9876);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',9877);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',10981);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',10982);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',10983);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',10984);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',11086);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',11087);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',11088);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',11089);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',13715);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',13716);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',14014);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',14015);

insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',13205);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',14012);
insert into CC_C_FILTER (filter_type,value) values ('ACD_SKILL_GROUP_INC',14013);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','100','100_ADD_ES_CALLTYPES_SKILLGRPS_TO_CC_C_FILTER');

commit;