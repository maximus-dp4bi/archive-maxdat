update cc_c_filter
set filter_type = 'ACD_APPLICATION_ID_INC'
where value in (10114,10115,10116,10117,10118,10119,10120,10121,10122,10123);

commit;

insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 10131);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 10132);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 10133);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 10134);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 10135);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 10136);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 10137);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 10138);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 10139);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 10140);

COMMIT;