-- Insert lookup values for default skill groups

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
					,'FLHK_Default_Skill_Groups'
					,'SKILLGROUP'
					,'FLHK_Default_Skill_Groups'
					,'5000'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Defualt Skill Groups list for FLHK Contact Center'
					,SYSDATE
					,SYSDATE);
					
commit;					