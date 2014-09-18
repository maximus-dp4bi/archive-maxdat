--Document jeopardy threshold
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'CHIP Medical Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type CHIP Medical Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'CHIP Dental Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type CHIP Dental Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'STAR Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type STAR Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'STAR and NorthSTAR Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type STAR and NorthSTAR Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'NorthSTAR Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type NorthSTAR Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'STAR+PLUS Dual Eligible and NorthSTAR Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type STAR+PLUS Dual Eligible and NorthSTAR Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'STAR+PLUS Dual Eligible Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type STAR+PLUS Dual Eligible Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Mandatory STAR+PLUS Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Mandatory STAR+PLUS Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Mandatory STAR+PLUS and NorthSTAR Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Mandatory STAR+PLUS and NorthSTAR Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'TP40 STAR Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type TP40 STAR Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'TP40 STAR and NorthSTAR Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type TP40 STAR and NorthSTAR Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Medicaid Dental Enrollment'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Medicaid Dental Enrollment in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Medicaid Enrollment Missing Information'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Medicaid Enrollment Missing Information in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'CHIP Enrollment Missing Information'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type CHIP Enrollment Missing Information in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Extra Effort Referral Form (Form H1093)'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Extra Effort Referral Form (Form H1093) in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Checkup verifications (Form H1087)'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Checkup verifications (Form H1087) in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Missed Appointment Referral'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Missed Appointment Referral in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Other provider referral'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Other provider referral in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'High Lead Level Referrals'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type High Lead Level Referrals in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Case Management Informing Referrals'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Case Management Informing Referrals in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Complaint Document'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Complaint Document in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Medical Payment Form'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Medical Payment Form in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Demographic Change'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Demographic Change in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'CHIP Disenrollment Request'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type CHIP Disenrollment Request in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Medicaid Disenrollment Request'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Medicaid Disenrollment Request in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'General Correspondence'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type General Correspondence in business hours'
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
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Unidentifiable'
					,'6'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX jeopardy threshold for doc type Unidentifiable in business hours'
					,SYSDATE
					,SYSDATE);          
          
          
--Document Timeliness threshold

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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'CHIP Medical Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type CHIP Medical Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'CHIP Dental Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type CHIP Dental Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'STAR Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type STAR Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'STAR and NorthSTAR Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type STAR and NorthSTAR Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'NorthSTAR Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type NorthSTAR Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'STAR+PLUS Dual Eligible and NorthSTAR Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type STAR+PLUS Dual Eligible and NorthSTAR Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'STAR+PLUS Dual Eligible Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type STAR+PLUS Dual Eligible Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Mandatory STAR+PLUS Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Mandatory STAR+PLUS Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Mandatory STAR+PLUS and NorthSTAR Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Mandatory STAR+PLUS and NorthSTAR Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'TP40 STAR Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type TP40 STAR Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'TP40 STAR and NorthSTAR Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type TP40 STAR and NorthSTAR Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Medicaid Dental Enrollment'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Medicaid Dental Enrollment in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Medicaid Enrollment Missing Information'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Medicaid Enrollment Missing Information in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'CHIP Enrollment Missing Information'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type CHIP Enrollment Missing Information in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Extra Effort Referral Form (Form H1093)'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Extra Effort Referral Form (Form H1093) in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Checkup verifications (Form H1087)'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Checkup verifications (Form H1087) in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Missed Appointment Referral'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Missed Appointment Referral in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Other provider referral'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Other provider referral in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'High Lead Level Referrals'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type High Lead Level Referrals in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Case Management Informing Referrals'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Case Management Informing Referrals in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Complaint Document'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Complaint Document in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Medical Payment Form'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Medical Payment Form in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Demographic Change'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Demographic Change in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'CHIP Disenrollment Request'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type CHIP Disenrollment Request in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Medicaid Disenrollment Request'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Medicaid Disenrollment Request in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'General Correspondence'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type General Correspondence in business hours'
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
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Unidentifiable'
					,'24'
					,null   --ref_type
					,null   --ref_id
					,trunc(SYSDATE)
					,'7-JUL-7777'
					,'TX Timeliness threshold for doc type Unidentifiable in business hours'
					,SYSDATE
					,SYSDATE);   
commit;