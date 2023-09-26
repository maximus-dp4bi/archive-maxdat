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
					,'Desk_settings_ids'
					,'DESK_SETTINGS'
					,'Desk_settings_ids'
					,'5010,5011,5004,5005,5006,5007,5008,5009'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Desk settings for various projects on cisco enterprise'
					,SYSDATE
					,SYSDATE);
					
commit;		


update cc_a_list_lkup
set name = 'Default_Skill_Groups'
, value = 'Default_Skill_Groups'
, comments = 'Defualt Skill Groups list for Cisco Enterprise Contact Center'
where name = 'MDHIX_Default_Skill_Groups';

commit;