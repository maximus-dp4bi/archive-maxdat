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
					,'5038,5039,5036'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Desk settings for various projects on cisco enterprise'
					,SYSDATE
					,SYSDATE);
					
commit;		

