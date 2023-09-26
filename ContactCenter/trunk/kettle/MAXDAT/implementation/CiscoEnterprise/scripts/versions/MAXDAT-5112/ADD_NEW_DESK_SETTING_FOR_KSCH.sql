-- corp_etl_lkup
update cc_a_list_lkup
set out_var = '5010,5011,5004,5005,5006,5007,5008,5009,5014,5015,5021,5022,5019,5020,5023,5024,5033,5034,5016,5017,5035,5036,5025,5026,5027,5028,5029,5030,5031,5032,5037,5038,5039,5040,5042,5043,5050,5051,5048,5049,5044,5045,5052,5053,5012,5013,5054,5055,5056,5057,5065,5066,5071,5072,5073'
where name = 'Desk_settings_ids';

commit;

-- cc_c_lookup

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5073', 'Topeka');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5073', 'KS CH');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5073', 'KS CH');

commit;

-- cc_c_filter

insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5073');

commit;