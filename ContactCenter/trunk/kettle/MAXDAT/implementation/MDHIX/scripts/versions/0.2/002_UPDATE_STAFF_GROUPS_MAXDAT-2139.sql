delete from cc_c_filter
where filter_type =  'WFM_STAFF_GROUP_INC' ;

delete from cc_c_lookup
where lookup_type = 'WFM_GROUP_PROJECT';

delete from cc_c_lookup
where lookup_type = 'WFM_GROUP_PROGRAM';

commit;

insert into cc_c_filter(filter_type, value) values ('WFM_STAFF_GROUP_INC', '1001');
insert into cc_c_filter(filter_type, value) values ('WFM_STAFF_GROUP_INC', '1002');
insert into cc_c_filter(filter_type, value) values ('WFM_STAFF_GROUP_INC', '1003');
insert into cc_c_filter(filter_type, value) values ('WFM_STAFF_GROUP_INC', '1004');
insert into cc_c_filter(filter_type, value) values ('WFM_STAFF_GROUP_INC', '1005');
insert into cc_c_filter(filter_type, value) values ('WFM_STAFF_GROUP_INC', '1006');

commit;

insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROJECT', '1001', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROJECT', '1002', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROJECT', '1003', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROJECT', '1004', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROJECT', '1005', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROJECT', '1006', 'MD HIX');


insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROGRAM', '1001', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROGRAM', '1002', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROGRAM', '1003', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROGRAM', '1004', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROGRAM', '1005', 'MD HIX');
insert into cc_c_lookup(lookup_type, lookup_key, lookup_value) values ('WFM_GROUP_PROGRAM', '1006', 'MD HIX');

commit;



