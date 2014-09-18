delete from corp_etl_list_lkup where value = 'Process_Incidents_RUN_ALL'
and list_type = 'PIVOT'
and name = 'LAST_ETL_COMP_PIVOT';

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
					,'LAST_ETL_COMP_PIVOT'
					,'PIVOT'
					,'Process_Complaints_RUN_ALL'
					,'22'
					,'BPM_EVENT_MASTER'
					,22
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID'
					,SYSDATE
					,SYSDATE);
          
commit;