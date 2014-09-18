
--IL final work task type expected for doc type
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
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'UNKNOWN'
					,null
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL final work task type expected for doc type Unknown'
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
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'Complaint'
					,'Complaint Data Entry Task'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Complaint Data Entry Task' and step_type_cd in ( 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL final work task type expected for doc type Complaint'
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
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'Enrollment'
					,'Enrollment Data Entry Task'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Enrollment Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL final work task type expected for doc type Enrollment'
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
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'General Correspondence'
					,'General Correspondence Data Entry Task'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'General Correspondence Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL final work task type expected for doc type General Correspondence'
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
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'Health Assessment Survey'
					,'Health Assessment Form Data Entry Task'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Health Assessment Form Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'IL final work task type expected for doc type Health Assessment Survey'
					,SYSDATE
					,SYSDATE);

commit;