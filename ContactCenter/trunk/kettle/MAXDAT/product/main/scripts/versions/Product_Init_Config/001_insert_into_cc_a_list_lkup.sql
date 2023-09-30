-- Insert lookup values for default skill groups

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
					,'Default_Skill_Groups'
					,'SKILLGROUP'
					,'Default_Skill_Groups'
					,'5000,5001'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Defualt Skill Groups list for Contact Center'
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
					,'Desk_settings_ids'
					,'DESK_SETTINGS'
					,'Desk_settings_ids'
					,'5052,5053'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Desk settings for various projects on cisco enterprise'
					,SYSDATE
					,SYSDATE);					
					
					
										
commit;	



-- Calls offered formula

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
					,'CAHCO_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'CA HCO'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - CALLS_ROUTED_NON_AGENT - RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
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
					,'CAHCO_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'CA HCO'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - CALLS_ROUTED_NON_AGENT - RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);		
										

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
					,'UNKNOWN_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'Unknown'
					,'select (CONTACTS_OFFERED) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,7
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);					
					
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
					,'UNKNOWN_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'Unknown'
					,'select (CONTACTS_OFFERED) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,7
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);
					
