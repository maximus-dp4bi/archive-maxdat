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
					,'CAHCO_Default_Skill_Groups'
					,'SKILLGROUP'
					,'CAHCO_Default_Skill_Groups'
					,'5000'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Defualt Skill Groups list for CAHCO Contact Center'
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
					,'CAHCO_Desk_settings_ids'
					,'CAHCO_DESK_SETTINGS'
					,'CAHCO_Desk_settings_ids'
					,'5052,5053'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Desk settings for CAHCO project on cisco enterprise'
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
					,'CAHCO_Skill_Groups'
					,'SKILLGROUP'
					,'CAHCO_Skill_Groups'
					,'5151,5152,5153,5154,5155,5156,5157,5158,5159,5160,5161,5162,5163,5164,5165,5166'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Skill Groups list for CAHCO Contact Center'
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
					,'CAHCO_abandoned_types'
					,'ABANDONTYPES'
					,'CAHCO_abandoned_types'
					,'1,2,3,4,5,6,7'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Abandoned types for CAHCO Contact Center'
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
					,'CAHCO_Inbound_call_types'
					,'CALLTYPES'
					,'CAHCO_call_types'
					,'6108,6109,6110,6111,6112,6113,6114,6115,6117,6118,6119,6120,6121,6122,6123,6124,6125,6132,6133'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Inbound Call types for CAHCO Contact Center'
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
					,'CAHCO_VM_call_types'
					,'VM_CALLTYPES'
					,'CAHCO_VM_call_types'
					,'6139,6140,6141,6142,6143,6144,6145,6146,6147,6148,6149,6150,6221,6222,6223,6224,6225'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'VM Call types for CAHCO Contact Center'
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
					,'CAHCO_IVR_call_types'
					,'IVR_CALLTYPES'
					,'CAHCO_IVR_call_types'
					,'6106,6107'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'IVR Call types for CAHCO Contact Center'
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
					,'CAHCO_DNIS_CODE'
					,'DNIS_CODE'
					,'CAHCO_DNIS_CODE'
					,''''||'777'||''''
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'DNIS code to ignore for CAHCO Contact Center'
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
					,'CAHCO_HANDLED_CALLS_DNIS_CODE'
					,'DNIS_CODE'
					,'CAHCO_HANDLED_CALLS_DNIS_CODE'
					,''''||'800'||''''||',''866'||''''||',''888'||''''
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Additional DNIS codes to ignore for CAHCO Contact Center'
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
					,'CAHCO_timezone'
					,'TIMEZONE'
					,'CAHCO_TIMEZONE'
					,'US/Pacific'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Timezone for CAHCO Contact Center'
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
					,'CAHCO_MAXCO26_FILENAME'
					,'FILENAME'
					,'CAHCO_MAXCO26_FILENAME'
					,'Maxco26_'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'File name for CAHCO Maxco 26 file'
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
					,'CAHCO_MAXCO30_FILENAME'
					,'FILENAME'
					,'CAHCO_MAXCO30_FILENAME'
					,'Maxco30_'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'File name for CAHCO Maxco 30 file'
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
					,'CAHCO_IVR_call_types_one_time'
					,'IVR_CALLTYPES'
					,'CAHCO_IVR_call_types'
					,'6107'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'IVR Call types for CAHCO Contact Center'
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
					,'CAHCO_Inbound_call_types_6106'
					,'CALLTYPES'
					,'CAHCO_call_types'
					,'6106'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Inbound Call type for CAHCO 6106 Contact Center'
					,SYSDATE
					,SYSDATE);					
					
commit;							
					

















