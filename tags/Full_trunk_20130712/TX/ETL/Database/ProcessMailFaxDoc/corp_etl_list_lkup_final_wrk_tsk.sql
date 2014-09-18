
--TX final work task type expected for doc type
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
					,'CHIP Medical Enrollment'
					,'CHIP Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'CHIP Enrollment Data Entry' and step_type_cd in ( 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type CHIP Medical Enrollment'
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
					,'CHIP Dental Enrollment'
					,'CHIP Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'CHIP Enrollment Data Entry' and step_type_cd in ( 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type CHIP Dental Enrollment'
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
					,'STAR Enrollment'
					,'STAR Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'STAR Enrollment Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type STAR Enrollment'
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
					,'STAR and NorthSTAR Enrollment'
					,'NorthSTAR Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'NorthSTAR Enrollment Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type STAR and NorthSTAR Enrollment'
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
					,'NorthSTAR Enrollment'
					,'NorthSTAR Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'NorthSTAR Enrollment Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type NorthSTAR Enrollment'
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
					,'STAR+PLUS Dual Eligible and NorthSTAR Enrollment'
					,'NorthSTAR Enrollment  Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'NorthSTAR Enrollment  Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type STAR+PLUS Dual Eligible and NorthSTAR Enrollment'
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
					,'STAR+PLUS Dual Eligible Enrollment'
					,'STAR+PLUS Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'STAR+PLUS Enrollment Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type STAR+PLUS Dual Eligible Enrollment'
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
					,'Mandatory STAR+PLUS Enrollment'
					,'STAR+PLUS Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'STAR+PLUS Enrollment Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Mandatory STAR+PLUS Enrollment'
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
					,'Mandatory STAR+PLUS and NorthSTAR Enrollment'
					,'NorthSTAR Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'NorthSTAR Enrollment Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Mandatory STAR+PLUS and NorthSTAR Enrollment'
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
					,'TP40 STAR Enrollment'
					,'TP40 Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'TP40 Enrollment Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type TP40 STAR Enrollment'
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
					,'TP40 STAR and NorthSTAR Enrollment'
					,'TP40 Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'TP40 Enrollment Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type TP40 STAR and NorthSTAR Enrollment'
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
					,'Medicaid Dental Enrollment'
					,'STAR Enrollment Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'STAR Enrollment Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Medicaid Dental Enrollment'
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
					,'Medicaid Enrollment Missing Information'
					,'Medicaid Enrollment MI'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Medicaid Enrollment MI' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Medicaid Enrollment Missing Information'
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
					,'CHIP Enrollment Missing Information'
					,'CHIP Enrollment MI'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'CHIP Enrollment MI' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type CHIP Enrollment Missing Information'
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
					,'Extra Effort Referral Form (Form H1093)'
					,'Outreach Request Data Entry Task'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Outreach Request Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Extra Effort Referral Form (Form H1093)'
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
					,'Checkup verifications (Form H1087)'
					,'Outreach Request Data Entry Task'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Outreach Request Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Checkup verifications (Form H1087)'
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
					,'Missed Appointment Referral'
					,'Outreach Request Data Entry Task'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Outreach Request Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Missed Appointment Referral'
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
					,'Other provider referral'
					,'Outreach Request Data Entry Task'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Outreach Request Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Other provider referral'
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
					,'High Lead Level Referrals'
					,'Outreach Request Data Entry Task'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Outreach Request Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type High Lead Level Referrals'
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
					,'Case Management Informing Referrals'
					,'Outreach Request Data Entry Task'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Outreach Request Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Case Management Informing Referrals'
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
					,'Complaint Document'
					,'Complaint Data Entry'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Complaint Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Complaint Document'
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
					,'Medical Payment Form'
					,'Medical Payment Form'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Medical Payment Form' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Medical Payment Form'
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
					,'Demographic Change'
					,'Demo Change'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Demo Change' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Demographic Change'
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
					,'CHIP Disenrollment Request'
					,'Disenrollment'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Disenrollment' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type CHIP Disenrollment Request'
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
					,'Medicaid Disenrollment Request'
					,'Disenrollment'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'Disenrollment' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Medicaid Disenrollment Request'
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
					,(select step_definition_id from step_definition_stg where name = 'General Correspondence Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type General Correspondence'
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
					,'Unidentifiable'
					,'UNKNOWN'
					,'STEP_DEFINITION_ID'   --ref_type
					,(select step_definition_id from step_definition_stg where name = 'UNKNOWN' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX final work task type expected for doc type Unidentifiable'
					,SYSDATE
					,SYSDATE); 
         
commit;