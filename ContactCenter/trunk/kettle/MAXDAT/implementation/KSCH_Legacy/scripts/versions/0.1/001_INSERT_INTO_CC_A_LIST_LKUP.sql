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
					,'5008,5009,5010,5011,5013,5014,5016,5022'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Desk settings for KS CH Legacy'
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
					,'Default_Skill_Groups'
					,'Default_Skill_Groups'
					,'Default_Skill_Groups'
					,'5000'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Default Skill Groups for KS CH Legacy'
					,SYSDATE
					,SYSDATE);					
					
commit;		


