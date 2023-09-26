insert into cc_c_filter (filter_type, value) values ('ACD_APPLICATION_ID_INC', '10012');
insert into cc_c_filter (filter_type, value) values ('ACD_APPLICATION_ID_INC', '10013');
insert into cc_c_filter (filter_type, value) values ('ACD_APPLICATION_ID_INC', '10021');
insert into cc_c_filter (filter_type, value) values ('ACD_APPLICATION_ID_INC', '10020');
insert into cc_c_filter (filter_type, value) values ('ACD_APPLICATION_ID_INC', '10014');
insert into cc_c_filter (filter_type, value) values ('ACD_APPLICATION_ID_INC', '10015');
commit;

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('0.3.1',112,'112_INSERT_EEV_ACD_FILTERS');
commit;