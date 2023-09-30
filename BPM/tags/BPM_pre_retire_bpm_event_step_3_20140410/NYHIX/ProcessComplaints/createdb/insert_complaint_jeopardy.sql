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
					,'ProcessComp_jeop_threshold'
					,'COMPLAINT'
					,'COMPLAINT'
					,'7'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','dd-mon-yyyy')
					,'NYHIX jeopardy threshold for Complaint Incident in business days'
					,SYSDATE
					,SYSDATE);


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
					,'ProcessComp_timeli_threshold'
					,'COMPLAINT'
					,'COMPLAINT'
					,'10'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','dd-mon-yyyy')
					,'NYHIX timeliness threshold for complaint incident in business days'
					,SYSDATE
					,SYSDATE);   
         
commit;