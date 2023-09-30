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
					,'ADD_HOURS'
					,'ADD_HOURS'
					,'ADD_HOURS'
					,'2'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Hours to add for Mountain to EST conversion'
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
					,'LOOK_BACK_HOURS'
					,'LOOK_BACK_HOURS'
					,'LOOK_BACK_HOURS'
					,'5'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Look back hours for scheduled run'
					,SYSDATE
					,SYSDATE);
					
commit;		