ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

update cc_a_list_lkup
set out_var = '5092,5093,5004,5005,5090,5091,5074,5075,5086,5087,5084,5085,5083,5082,5010,5011,5004,5005,5006,5007,5008,5009,5014,5015,5021,5022,5019,5020,5023,5024,5033,5034,5016,5017,5035,5036,5025,5026,5027,5028,5029,5030,5031,5032,5037,5038,5039,5040,5042,5043,5050,5051,5048,5049,5044,5045,5052,5053,5012,5013,5054,5055,5056,5057,5065,5066,5071,5072,5061,5062,5076,5077,5073,5080,5081'
where name = 'Desk_settings_ids';

commit;

update cc_c_unit_of_work
set acd = 0, ivr = 1
where unit_of_work_name = 'MI Bridges IVR';

update cc_d_unit_of_work
set acd = 0, ivr = 1
where unit_of_work_name = 'MI Bridges IVR';					
										
commit;		
	
	
delete cc_c_ivr_dnis where destination_dnis = 4203 and uow_id in (select d.uow_id from CC_D_UNIT_OF_WORK d where d.unit_of_work_name = 'MI Bridges IVR');

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
4203,
(select d.uow_id from CC_D_UNIT_OF_WORK d where d.unit_of_work_name = 'MI Bridges IVR' )
);	

insert into cc_a_list_lkup (name, list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments)
values ('IVR_DATA_FILE_NAMES','IVR_APP_NAME','MAXMIBSHD','MIEB','Multiple – MI Bridges', null, trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),'Global control to fetch the Project name using the Application Name from data file.'); 

commit;