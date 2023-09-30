alter session set current_schema = CISCO_ENTERPRISE_CC;

insert into cc_c_filter(filter_type, value) values ('ACD_DESKSETTING_INC', '5014');
insert into cc_c_filter(filter_type, value) values ('ACD_DESKSETTING_INC', '5015');


insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5014', 'KS CH');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5015', 'KS CH');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5014', 'KS CH');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5015', 'KS CH');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5014', 'Topeka');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5015', 'Topeka');

commit;

update cc_a_list_lkup
set out_var = '5010,5011,5004,5005,5006,5007,5008,5009,5014,5015'
where name = 'Desk_settings_ids';

commit;

