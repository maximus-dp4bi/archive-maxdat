alter session set current_schema = cisco_enterprise_cc;

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
					,'CAHCO_FOLSOM_IVR_call_types'
					,'IVR_CALLTYPES'
					,'CAHCO_FOLSOM_IVR_call_types'
					,'6126,6152'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'IVR Call types for CAHCO Contact Center'
					,SYSDATE
					,SYSDATE);
					
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value)
values ('CAHCO_LANGUAGE_CODE',6126,7);

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value)
values ('CAHCO_LANGUAGE_CODE',6152,1);					
					
COMMIT;					