insert into cc_c_filter(filter_type, value) values ('ACD_DESKSETTING_INC', '5038');
insert into cc_c_filter(filter_type, value) values ('ACD_DESKSETTING_INC', '5039');
insert into cc_c_filter(filter_type, value) values ('ACD_DESKSETTING_INC', '5036');


commit;

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5038', '');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5039', '');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5036', '');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5038', '');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5039', '');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5036', '');


insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5038', '');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5039', '');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5036', '');

commit;
