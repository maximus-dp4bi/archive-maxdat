ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', '5212');

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROJECT', '5212', 'Mass Health');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('ACD_PQ_PROGRAM', '5212', 'Customer Service Center');

COMMIT;