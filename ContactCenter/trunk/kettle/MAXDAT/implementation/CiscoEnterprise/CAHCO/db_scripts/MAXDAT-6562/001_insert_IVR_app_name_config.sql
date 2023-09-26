-- insert IVR app name o list lkup

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
					,'CAHCO_IVR_APP_NAME'
					,'CAHCO_IVR_APP_NAME'
					,'CAHCO_IVR_APP_NAME'
					,''''||'CARC_CHCO_MENU_NEW_02_18'||''''
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'IVR app name for IVR aggregate file delivery ETL'
					,SYSDATE
					,SYSDATE);
					
commit;

