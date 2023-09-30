-- Department SCSC

alter session set current_schema = FOLSOM_SHARED_CC;

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
					,'Agent_Project'
					,'AGENT_PROJECT'
					,'SCSC'
					,'CA HCO'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Project lookup for Agent by department'
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
					,'Agent_Program'
					,'AGENT_PROGRAM'
					,'SCSC'
					,'Medi-Cal'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Program lookup for Agent by department'
					,SYSDATE
					,SYSDATE);				
					
-- Department HCO_SCSC

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
					,'Agent_Project'
					,'AGENT_PROJECT'
					,'HCO_SCSC'
					,'CA HCO'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Project lookup for Agent by department'
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
					,'Agent_Program'
					,'AGENT_PROGRAM'
					,'HCO_SCSC'
					,'Medi-Cal'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Program lookup for Agent by department'
					,SYSDATE
					,SYSDATE);						
					
-- Department HCO

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
					,'Agent_Project'
					,'AGENT_PROJECT'
					,'HCO'
					,'CA HCO'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Project lookup for Agent by department'
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
					,'Agent_Program'
					,'AGENT_PROGRAM'
					,'HCO'
					,'Medi-Cal'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Program lookup for Agent by department'
					,SYSDATE
					,SYSDATE);					
					
-- Department HCO Overflow

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
					,'Agent_Project'
					,'AGENT_PROJECT'
					,'HCO Overflow'
					,'CA HCO'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Project lookup for Agent by department'
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
					,'Agent_Program'
					,'AGENT_PROGRAM'
					,'HCO Overflow'
					,'Medi-Cal'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Program lookup for Agent by department'
					,SYSDATE
					,SYSDATE);					
					
-- Department HCO_Escalations

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
					,'Agent_Project'
					,'AGENT_PROJECT'
					,'HCO_Escalations'
					,'CA HCO'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Project lookup for Agent by department'
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
					,'Agent_Program'
					,'AGENT_PROGRAM'
					,'HCO_Escalations'
					,'Medi-Cal'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Program lookup for Agent by department'
					,SYSDATE
					,SYSDATE);					
					
-- Department Training-HCO

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
					,'Agent_Project'
					,'AGENT_PROJECT'
					,'Training-HCO'
					,'CA HCO'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Project lookup for Agent by department'
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
					,'Agent_Program'
					,'AGENT_PROGRAM'
					,'Training-HCO'
					,'Medi-Cal'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Program lookup for Agent by department'
					,SYSDATE
					,SYSDATE);					
					
-- Department SCSC Folsom

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
					,'Agent_Project'
					,'AGENT_PROJECT'
					,'SCSC Folsom'
					,'CA HCO'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Project lookup for Agent by department'
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
					,'Agent_Program'
					,'AGENT_PROGRAM'
					,'SCSC Folsom'
					,'Medi-Cal'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Program lookup for Agent by department'
					,SYSDATE
					,SYSDATE);					
					
-- Department HCO-SCSC

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
					,'Agent_Project'
					,'AGENT_PROJECT'
					,'HCO-SCSC'
					,'CA HCO'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Project lookup for Agent by department'
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
					,'Agent_Program'
					,'AGENT_PROGRAM'
					,'HCO-SCSC'
					,'Medi-Cal'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Program lookup for Agent by department'
					,SYSDATE
					,SYSDATE);		
					
-- Department HCO_Overflow

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
					,'Agent_Project'
					,'AGENT_PROJECT'
					,'HCO_Overflow'
					,'CA HCO'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Project lookup for Agent by department'
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
					,'Agent_Program'
					,'AGENT_PROGRAM'
					,'HCO_Overflow'
					,'Medi-Cal'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Program lookup for Agent by department'
					,SYSDATE
					,SYSDATE);						
					
					
-- Department HCO Escalations

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
					,'Agent_Project'
					,'AGENT_PROJECT'
					,'HCO Escalations'
					,'CA HCO'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Project lookup for Agent by department'
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
					,'Agent_Program'
					,'AGENT_PROGRAM'
					,'HCO Escalations'
					,'Medi-Cal'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Program lookup for Agent by department'
					,SYSDATE
					,SYSDATE);								
					
commit;					