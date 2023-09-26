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
					,'CAHCO_REFERRED_VM_THRESHOLD'
					,'VM_THRESHOLD'
					,'CA HCO'
					,'60'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Referred VM threshold for CA HCO'
					,SYSDATE
					,SYSDATE);
					
commit;	