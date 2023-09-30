
--TX final work task type expected for additional doc type doc types in TX project - 9/20/2013

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'Case Maintenance'
					,'General Correspondence Data Entry Task'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'General Correspondence Data Entry Task' and step_type_cd in ( 'HUMAN_TASK','VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX final work task type expected for doc type Case Maintenance'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'Client Request for Home Visit'
					,'Outreach Request Data Entry Task'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'Outreach Request Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX final work task type expected for doc type Client Request for Home Visit'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'EBSSP Online Disenrollment'
					,'Disenrollment'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'Disenrollment' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX final work task type expected for doc type EBSSP Online Disenrollment'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'EBSSP Online Enrollment'
					,'Enrollment Data Entry Task'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'Enrollment Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX final work task type expected for doc type EBSSP Online Enrollment'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'EBSSP Online MPF'
					,'Medical Payment Form'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'Medical Payment Form' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX final work task type expected for doc type EBSSP Online MPF'
					,SYSDATE
					,SYSDATE);


insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'General Correspondence Letter'
					,'General Correspondence Data Entry Task'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'General Correspondence Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX final work task type expected for doc type General Correspondence Letter'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'IVR Online Enrollment'
					,'Enrollment Data Entry Task'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'Enrollment Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX final work task type expected for doc type IVR Online Enrollment'
					,SYSDATE
					,SYSDATE);
          
insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'Outreach Request'
					,'Outreach Request Data Entry Task'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'Outreach Request Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX final work task type expected for doc type Outreach Request'
					,SYSDATE
					,SYSDATE);
          
insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'Provider Outreach Referral'
					,'Outreach Request Data Entry Task'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'Outreach Request Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX final work task type expected for doc type Provider Outreach Referral'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_work_expected'
					,'DOC_TYPE'
					,'STAR RSA Enrollment'
					,'STAR Enrollment Data Entry'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'STAR Enrollment Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX final work task type expected for doc type STAR RSA Enrollment'
					,SYSDATE
					,SYSDATE);      
          
          
update corp_etl_list_lkup set value = 'CHIP Disenrollment Requests'
where name = 'ProcessMail_work_expected'
and   list_type = 'DOC_TYPE'
and   value = 'CHIP Disenrollment Request';

update corp_etl_list_lkup set value = 'Complaint', out_var = 'Complaint Data Entry Task'
where name = 'ProcessMail_work_expected'
and   list_type = 'DOC_TYPE'
and   value = 'Complaint Document';

update corp_etl_list_lkup set value = 'Demographic Changes'
where name = 'ProcessMail_work_expected'
and   list_type = 'DOC_TYPE'
and   value = 'Demographic Change';

update corp_etl_list_lkup set value = 'Medicaid Disenrollment Requests'
where name = 'ProcessMail_work_expected'
and   list_type = 'DOC_TYPE'
and   value = 'Medicaid Disenrollment Request';

commit;