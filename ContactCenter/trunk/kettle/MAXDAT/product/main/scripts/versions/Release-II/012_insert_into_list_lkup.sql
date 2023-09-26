insert into cc_a_list_lkup (name, list_type, value, out_var, ref_id, start_date, end_date, comments, created_ts, updated_ts)
values ('Transfer_Out_Disposition', 'DISPOSITION', 'TRANSFER_OUT_DISPOSITION','28,29', 1,trunc(SYSDATE),to_date('07-JUL-7777','DD-MON-YYYY'), 'Disposition Code for Transfer Out Calls', SYSDATE, SYSDATE );

insert into cc_a_list_lkup (name, list_type, value, out_var, ref_id, start_date, end_date, comments, created_ts, updated_ts)
values ('Handled_Inbound_call_types', 'CALLTYPES', 'Handled_Inbound_call_types',''''||'Inbound'||''''||',''INBOUND'||'''', 1,trunc(SYSDATE),to_date('07-JUL-7777','DD-MON-YYYY'), 'Handled Call Types', SYSDATE, SYSDATE );

insert into cc_a_list_lkup (name, list_type, value, out_var, ref_id, start_date, end_date, comments, created_ts, updated_ts)
values ('Handled_Outbound_call_types', 'CALLTYPES', 'Handled_Outbound_call_types',''''||'Outbound'||''''||',''OUTBOUND'||'''', 1,trunc(SYSDATE),to_date('07-JUL-7777','DD-MON-YYYY'), 'Handled Call Types', SYSDATE, SYSDATE );

insert into cc_a_list_lkup (name, list_type, value, out_var, ref_id, start_date, end_date, comments, created_ts, updated_ts)
values ('VM_call_types', 'CALLTYPES', 'VM_call_types',''''||'Voicemail'||'''', 1,trunc(SYSDATE),to_date('07-JUL-7777','DD-MON-YYYY'), 'VM Call Types', SYSDATE, SYSDATE );

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
					,'DNIS_CODE'
					,'DNIS_CODE'
					,'DNIS_CODE'
					,''''||'777'||''''
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'DNIS code to ignore for CAHCO Contact Center'
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
					,'HANDLED_CALLS_DNIS_CODE'
					,'DNIS_CODE'
					,'HANDLED_CALLS_DNIS_CODE'
					,''''||'800'||''''||',''866'||''''||',''888'||''''
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Additional DNIS codes to ignore for CAHCO Contact Center'
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
					,'timezone'
					,'TIMEZONE'
					,'TIMEZONE'
					,'US/Pacific'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Timezone for Contact Center'
					,SYSDATE
					,SYSDATE);

commit;