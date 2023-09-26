insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 5353);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 5354);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 8323);

commit;


insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '5353', 'KSLW');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '5354', 'KSLW');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROJECT', '8323', 'WC HS');

commit;

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '5353', 'KSLW');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '5354', 'KSLW');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_SKILLSET_PROGRAM', '8323', 'WC HS');

commit;