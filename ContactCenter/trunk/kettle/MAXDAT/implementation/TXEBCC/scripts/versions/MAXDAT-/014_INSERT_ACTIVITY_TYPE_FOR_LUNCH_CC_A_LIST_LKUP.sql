ALTER SESSION SET CURRENT_SCHEMA = MAXDAT_CC;

--MAXDAT-3485

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
					,'ACTIVITY_NAME_FOR_LUNCH'
					,'ACTIVITY_TYPE_NAME'
					,'ACTIVITY_TYPE_NAME'
					,'''Lunch', 'Lunch - State Use ONLY'''
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Activity type name for Lunch'
					,SYSDATE
					,SYSDATE);
					
commit;					