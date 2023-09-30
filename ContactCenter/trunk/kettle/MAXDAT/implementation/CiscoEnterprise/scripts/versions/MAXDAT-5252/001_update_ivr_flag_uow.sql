alter session set current_schema = cisco_enterprise_cc;

update cc_c_unit_of_work
set ivr =1, acd = 0
where unit_of_work_name in ('CCC PLUS IVR',
'CCC PLUS IVR TEST');

update cc_d_unit_of_work
set ivr =1, acd = 0
where unit_of_work_name in ('CCC PLUS IVR',
'CCC PLUS IVR TEST');

update cc_a_list_lkup
set out_var = '5010,5011,5004,5005,5006,5007,5008,5009,5014,5015,5021,5022,5019,5020,5023,5024,5033,5034,5016,5017,5035,5036,5025,5026,5027,5028,5029,5030,5031,5032,5037,5038,5039,5040,5042,5043,5050,5051,5048,5049,5044,5045,5052,5053,5012,5013,5054,5055,5056,5057,5065,5066,5071,5072,5061,5062,5076,5077,5073,5080,5081'
where name = 'Desk_settings_ids';

commit;