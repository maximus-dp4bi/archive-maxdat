ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

update cc_a_list_lkup
set out_var = '5084,5085,5083,5082,5010,5011,5004,5005,5006,5007,5008,5009,5014,5015,5021,5022,5019,5020,5023,5024,5033,5034,5016,5017,5035,5036,5025,5026,5027,5028,5029,5030,5031,5032,5037,5038,5039,5040,5042,5043,5050,5051,5048,5049,5044,5045,5052,5053,5012,5013,5054,5055,5056,5057,5065,5066,5071,5072,5061,5062,5076,5077,5073,5080,5081'
where name = 'Desk_settings_ids';

commit;

insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'FLHK CS_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'Florida Healthy Kids'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);
					
insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'FLHK CS_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'Florida Healthy Kids'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);		
										
commit;		
										