insert into corp_etl_list_lkup (	cell_id
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
			values (	seq_cell_id.NEXTVAL
          ,'CLIENT_INQUIRY_MANUAL_ACTION'
					,'LIST'
					,'CHIP_TO_MEDICAID_LETTER'
					,null
					,'PROGRAM_INFO'
					,null
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'New manual call action - CHIP_TO_MEDICAID'
					,SYSDATE
					,SYSDATE);
          
commit;