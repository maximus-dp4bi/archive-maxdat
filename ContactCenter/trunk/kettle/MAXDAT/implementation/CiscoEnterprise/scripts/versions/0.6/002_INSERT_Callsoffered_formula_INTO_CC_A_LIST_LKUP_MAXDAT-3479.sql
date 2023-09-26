-- Insert formula for Calls Offered- CC_S_ACD_INTERVAL

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
					,'MDHIX_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'MD HIX'
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
					,'KSLW_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'KSLW'
					,'select (CONTACTS_OFFERED) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,2
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
					,'MIEB_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'MIEB'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - CALLS_ROUTED_NON_AGENT - INCOMPLETE_CALLS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,3
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
					,'KSCH_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'KS CH'
					,'select (CONTACTS_OFFERED) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,4
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
					,'WCHS_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'WC HS'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - CALLS_ROUTED_NON_AGENT - RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,5
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
					,'MDEB_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'MD EB'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,6
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



-- Insert formula for Calls Offered- CC_S_ACD_QUEUE_INTERVAL

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
					,'MDHIX_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'MD HIX'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - CALLS_ROUTED_NON_AGENT - RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
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
					,'KSLW_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'KSLW'
					,'select (CONTACTS_OFFERED) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,2
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
					,'MIEB_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'MIEB'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - CALLS_ROUTED_NON_AGENT - INCOMPLETE_CALLS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,3
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
					,'KSCH_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'KS CH'
					,'select (CONTACTS_OFFERED) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,4
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
					,'WCHS_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'WC HS'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - CALLS_ROUTED_NON_AGENT - RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,5
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
					,'MDEB_CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'MD EB'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,6
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
					
commit;					