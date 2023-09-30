--TX final work task type expected for doc type
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'CHIP Medical Enrollment'
  ,'CHIP Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'CHIP Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type CHIP Medical Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'CHIP Dental Enrollment'
  ,'CHIP Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'CHIP Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type CHIP Dental Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'STAR Enrollment'
  ,'STAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR Enrollment Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type STAR Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'STAR and NorthSTAR Enrollment'
  ,'NorthSTAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'NorthSTAR Enrollment Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type STAR and NorthSTAR Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'NorthSTAR Enrollment'
  ,'NorthSTAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'NorthSTAR Enrollment Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type NorthSTAR Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'STAR+PLUS Dual Eligible and NorthSTAR Enrollment'
  ,'NorthSTAR Enrollment  Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'NorthSTAR Enrollment  Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type STAR+PLUS Dual Eligible and NorthSTAR Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'STAR+PLUS Dual Eligible Enrollment'
  ,'STAR+PLUS Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR+PLUS Enrollment Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type STAR+PLUS Dual Eligible Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Mandatory STAR+PLUS Enrollment'
  ,'STAR+PLUS Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR+PLUS Enrollment Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Mandatory STAR+PLUS Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Mandatory STAR+PLUS and NorthSTAR Enrollment'
  ,'NorthSTAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'NorthSTAR Enrollment Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Mandatory STAR+PLUS and NorthSTAR Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'TP40 STAR Enrollment'
  ,'TP40 Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'TP40 Enrollment Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type TP40 STAR Enrollment'
  ,sysdate
  ,sysdate);  , 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'TP40 STAR and NorthSTAR Enrollment'
  ,'TP40 Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'TP40 Enrollment Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type TP40 STAR and NorthSTAR Enrollment'
  ,sysdate
  ,sysdate);  ,

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Medicaid Dental Enrollment'
  ,'STAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR Enrollment Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Medicaid Dental Enrollment'
  ,sysdate
  ,sysdate);   

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Medicaid Enrollment Missing Information'
  ,'Medicaid Enrollment MI'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Medicaid Enrollment MI' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Medicaid Enrollment Missing Information'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'CHIP Enrollment Missing Information'
  ,'CHIP Enrollment MI'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'CHIP Enrollment MI' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type CHIP Enrollment Missing Information'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Extra Effort Referral Form (Form H1093)'
  ,'Outreach Req Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Outreach Req Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Extra Effort Referral Form (Form H1093)'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Checkup verifications (Form H1087)'
  ,'Outreach Req Data Entry Task'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Outreach Req Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Checkup verifications (Form H1087)'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Missed Appointment Referral'
  ,'Outreach Req Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Outreach Req Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Missed Appointment Referral'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Other provider referral'
  ,'Outreach Req Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Outreach Req Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Other provider referral'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'High Lead Level Referrals'
  ,'Outreach Req Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Outreach Req Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type High Lead Level Referrals'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Case Management Informing Referrals'
  ,'Outreach Req Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Outreach Req Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Case Management Informing Referrals'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Complaint Document'
  ,'Complaint Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Complaint Data Entry' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Complaint Document'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Medical Payment Form'
  ,'Medical Payment Form'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Medical Payment Form' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Medical Payment Form'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Demographic Change'
  ,'Demo Change'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Demo Change' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Demographic Change'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'CHIP Disenrollment Request'
  ,'Disenrollment'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Disenrollment' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type CHIP Disenrollment Request'
  ,sysdate
  ,sysdate);  

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Medicaid Disenrollment Request'
  ,'Disenrollment'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Disenrollment' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Medicaid Disenrollment Request'
  ,sysdate
  ,sysdate);
 
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'General Correspondence'
  ,'General Correspondence Data Entry Task'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'General Correspondence Data Entry Task' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type General Correspondence'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Unidentifiable'
  ,'UNKNOWN'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'UNKNOWN' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Unidentifiable'
  ,sysdate
  ,sysdate); 


insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'UNKNOWN'
  ,'UNKNOWN'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'UNKNOWN' and STEP_TYPE_CD in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE'
  ,'Enrollment'
  ,'CHIP Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);
  ,    

--Document jeopardy threshold
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'CHIP Medical Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type CHIP Medical Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'CHIP Dental Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type CHIP Dental Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'STAR Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type STAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'STAR and NorthSTAR Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type STAR and NorthSTAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'NorthSTAR Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type NorthSTAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'STAR+PLUS Dual Eligible and NorthSTAR Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type STAR+PLUS Dual Eligible and NorthSTAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'STAR+PLUS Dual Eligible Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type STAR+PLUS Dual Eligible Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Mandatory STAR+PLUS Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Mandatory STAR+PLUS Enrollment in business hours'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Mandatory STAR+PLUS and NorthSTAR Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Mandatory STAR+PLUS and NorthSTAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'TP40 STAR Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type TP40 STAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'TP40 STAR and NorthSTAR Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type TP40 STAR and NorthSTAR Enrollment in business hours'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Medicaid Dental Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Medicaid Dental Enrollment in business hours'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Medicaid Enrollment Missing Information'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Medicaid Enrollment Missing Information in business hours'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'CHIP Enrollment Missing Information'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type CHIP Enrollment Missing Information in business hours'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Extra Effort Referral Form (Form H1093)'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Extra Effort Referral Form (Form H1093) in business hours'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Checkup verifications (Form H1087)'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Checkup verifications (Form H1087) in business hours'
  ,sysdate
  ,sysdate); 
 
 
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Missed Appointment Referral'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Missed Appointment Referral in business hours'
  ,sysdate
  ,sysdate);
 
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Other provider referral'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Other provider referral in business hours'
  ,sysdate
  ,sysdate);
 
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'High Lead Level Referrals'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type High Lead Level Referrals in business hours'
  ,sysdate
  ,sysdate); 
 
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Case Management Informing Referrals'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Case Management Informing Referrals in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Complaint Document'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Complaint Document in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Medical Payment Form'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Medical Payment Form in business hours'
  ,sysdate
  ,sysdate);  

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Demographic Change'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Demographic Change in business hours'
  ,sysdate
  ,sysdate); 
 
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'CHIP Disenrollment Request'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type CHIP Disenrollment Request in business hours'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Medicaid Disenrollment Request'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Medicaid Disenrollment Request in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'General Correspondence'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type General Correspondence in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Unidentifiable'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Unidentifiable in business hours'
  ,sysdate
  ,sysdate);  

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'UNKNOWN'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type UNKNOWN in business hours'
  ,sysdate
  ,sysdate);  

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_jeop_threshold'
  ,'DOC_TYPE'
  ,'Enrollment'
  ,'6'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX jeopardy threshold for doc type Enrollment in business hours'
  ,sysdate
  ,sysdate); 


--Document Timeliness threshold
--***************************************************************************************
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'CHIP Medical Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type CHIP Medical Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'CHIP Dental Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type CHIP Dental Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'STAR Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type STAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'STAR and NorthSTAR Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type STAR and NorthSTAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'NorthSTAR Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type NorthSTAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'STAR+PLUS Dual Eligible and NorthSTAR Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type STAR+PLUS Dual Eligible and NorthSTAR Enrollment in business hours'
  ,sysdate
  ,sysdate);  ,    

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'STAR+PLUS Dual Eligible Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type STAR+PLUS Dual Eligible Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Mandatory STAR+PLUS Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Mandatory STAR+PLUS Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Mandatory STAR+PLUS and NorthSTAR Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Mandatory STAR+PLUS and NorthSTAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'TP40 STAR Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type TP40 STAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'TP40 STAR and NorthSTAR Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type TP40 STAR and NorthSTAR Enrollment in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Medicaid Dental Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Medicaid Dental Enrollment in business hours'
  ,sysdate
  ,sysdate);  ,    

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Medicaid Enrollment Missing Information'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Medicaid Enrollment Missing Information in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'CHIP Enrollment Missing Information'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type CHIP Enrollment Missing Information in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Extra Effort Referral Form (Form H1093)'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Extra Effort Referral Form (Form H1093) in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Checkup verifications (Form H1087)'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Checkup verifications (Form H1087) in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Missed Appointment Referral'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Missed Appointment Referral in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Other provider referral'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Other provider referral in business hours'
  ,sysdate
  ,sysdate);  ,    

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'High Lead Level Referrals'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type High Lead Level Referrals in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Case Management Informing Referrals'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Case Management Informing Referrals in business hours'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Complaint Document'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Complaint Document in business hours'
  ,sysdate
  ,sysdate);  ,    

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Medical Payment Form'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Medical Payment Form in business hours'
  ,sysdate
  ,sysdate);   

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Demographic Change'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Demographic Change in business hours'
  ,sysdate
  ,sysdate);   

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'CHIP Disenrollment Request'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type CHIP Disenrollment Request in business hours'
  ,sysdate
  ,sysdate);   

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Medicaid Disenrollment Request'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Medicaid Disenrollment Request in business hours'
  ,sysdate
  ,sysdate);   

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'General Correspondence'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type General Correspondence in business hours'
  ,sysdate
  ,sysdate);   

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Unidentifiable'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Unidentifiable in business hours'
  ,sysdate
  ,sysdate);  

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'UNKNOWN'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type UNKNOWN in business hours'
  ,sysdate
  ,sysdate); 

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_timeli_threshold'
  ,'DOC_TYPE'
  ,'Enrollment'
  ,'24'
  ,null   --ref_type
  ,null   --ref_id
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX Timeliness threshold for doc type Enrollment in business hours'
  ,sysdate
  ,sysdate);

--worktask for addtional doc types for TX

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
					,'Outreach Req Data Entry'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'Outreach Req Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  --ref_id
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
					,'Outreach Req Data Entry'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'Outreach Req Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
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
					,'Outreach Req Data Entry'
					,'STEP_DEFINITION_ID'    
					,(select step_definition_id from step_definition_stg where name = 'Outreach Req Data Entry' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK')  ) --ref_id
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

--jeopardy and timeliness for additional doc types for TX

--Document jeopardy threshold
insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Case Maintenance'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type Case Maintenance in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Client Request for Home Visit'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type Client Request for Home Visit in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'EBSSP Online Disenrollment'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type EBSSP Online Disenrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'EBSSP Online Enrollment'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type EBSSP Online Enrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'EBSSP Online MPF'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type EBSSP Online MPF in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'General Correspondence Letter'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type General Correspondence Letter in business hours'
					,SYSDATE
					,SYSDATE);
          
insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'IVR Online Enrollment'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type IVR Online Enrollment in business hours'
					,SYSDATE
					,SYSDATE);          

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Outreach Request'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type Outreach Request in business hours'
					,SYSDATE
					,SYSDATE);           

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'Provider Outreach Referral'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type Provider Outreach Referral in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_jeop_threshold'
					,'DOC_TYPE'
					,'STAR RSA Enrollment'
					,'6'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX jeopardy threshold for doc type STAR RSA Enrollment in business hours'
					,SYSDATE
					,SYSDATE);


          
--Document Timeliness threshold

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Case Maintenance'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type Case Maintenance in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Client Request for Home Visit'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type Client Request for Home Visit in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'EBSSP Online Disenrollment'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type EBSSP Online Disenrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'EBSSP Online Enrollment'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type EBSSP Online Enrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'EBSSP Online MPF'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type EBSSP Online MPF in business hours'
					,SYSDATE
					,SYSDATE);
          
 insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'General Correspondence Letter'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type General Correspondence Letter in business hours'
					,SYSDATE
					,SYSDATE);         

insert into corp_etl_list_lkup(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'IVR Online Enrollment'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type IVR Online Enrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Outreach Request'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type Outreach Request in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'Provider Outreach Referral'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type Provider Outreach Referral in business hours'
					,SYSDATE
					,SYSDATE);

insert into corp_etl_list_lkup (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
			values (	seq_cell_id.NEXTVAL
					,'ProcessMail_timeli_threshold'
					,'DOC_TYPE'
					,'STAR RSA Enrollment'
					,'24'
					,null    
					,null    
					,trunc(SYSDATE)
					,to_date('7777-07-07','YYYY-MM-DD')
					,'TX Timeliness threshold for doc type STAR RSA Enrollment in business hours'
					,SYSDATE
					,SYSDATE);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE1'
  ,'Case Maintenance'
  ,'Medical Payment Form'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Medical Payment Form' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Case Maintenance'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE1'
  ,'Enrollment'
  ,'CHIP Enrollment MI'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'CHIP Enrollment MI' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);
  
  insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE2'
  ,'Enrollment'
  ,'Medicaid Enrollment MI'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Medicaid Enrollment MI' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);
  
    insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE3'
  ,'Enrollment'
  ,'NorthSTAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'NorthSTAR Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);
  
    insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE4'
  ,'Enrollment'
  ,'STAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);
  
      insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE5'
  ,'Enrollment'
  ,'STAR+PLUS Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR+PLUS Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE6'
  ,'Enrollment'
  ,'TP40 STAR Enrollment'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'TP40 STAR Enrollment' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Enrollment'
  ,sysdate
  ,sysdate);

update corp_etl_list_lkup set value = 'CHIP Disenrollment Requests'
where name in ( 'ProcessMail_jeop_threshold','ProcessMail_timeli_threshold')
and   list_type = 'DOC_TYPE'
and   value = 'CHIP Disenrollment Request';

update corp_etl_list_lkup set value = 'Complaint'
where name in ( 'ProcessMail_jeop_threshold','ProcessMail_timeli_threshold')
and   list_type = 'DOC_TYPE'
and   value = 'Complaint Document';

update corp_etl_list_lkup set value = 'Demographic Changes'
where name in ( 'ProcessMail_jeop_threshold','ProcessMail_timeli_threshold')
and   list_type = 'DOC_TYPE'
and   value = 'Demographic Change';

update corp_etl_list_lkup set value = 'Medicaid Disenrollment Requests'
where name in ( 'ProcessMail_jeop_threshold','ProcessMail_timeli_threshold')
and   list_type = 'DOC_TYPE'
and   value = 'Medicaid Disenrollment Request';


insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE1'
  ,'Outreach Request'
  ,'General Correspondence Data Entry Task'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'General Correspondence Data Entry Task' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Outreach Request'
  ,sysdate
  ,sysdate);
  
  insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE2'
  ,'Outreach Request'
  ,'STAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Outreach Request'
  ,sysdate
  ,sysdate);
  
  
 insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE1'
  ,'UNKNOWN'
  ,'CHIP Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'CHIP Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);
  
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE2'
  ,'UNKNOWN'
  ,'CHIP Enrollment MI'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'CHIP Enrollment MI' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);
  
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE3'
  ,'UNKNOWN'
  ,'Complaint Data entry Task'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Complaint Data entry Task' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);
  
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE4'
  ,'UNKNOWN'
  ,'Demo Change'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Demo Change' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);
  
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE5'
  ,'UNKNOWN'
  ,'Disenrollment'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Disenrollment' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);
  
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE6'
  ,'UNKNOWN'
  ,'General Correspondence Data Entry Task'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'General Correspondence Data Entry Task' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);
  
  insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE7'
  ,'UNKNOWN'
  ,'Medicaid Enrollment MI'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Medicaid Enrollment MI' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);
  
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE8'
  ,'UNKNOWN'
  ,'Medical Payment Form'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Medical Payment Form' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);  

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE9'
  ,'UNKNOWN'
  ,'NorthSTAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'NorthSTAR Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);  
  
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE10'
  ,'UNKNOWN'
  ,'Outreach Req Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'Outreach Req Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);  
 
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE11'
  ,'UNKNOWN'
  ,'STAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);   

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE12'
  ,'UNKNOWN'
  ,'STAR+PLUS Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR+PLUS Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate);  

insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE13'
  ,'UNKNOWN'
  ,'TP40 STAR Enrollment'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'TP40 STAR Enrollment' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type UNKNOWN'
  ,sysdate
  ,sysdate); 
  
insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE1'
  ,'Unidentifiable'
  ,'CHIP Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'CHIP Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Unidentifiable'
  ,sysdate
  ,sysdate);  
  
  insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE2'
  ,'Unidentifiable'
  ,'CHIP Enrollment MI'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'CHIP Enrollment MI' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Unidentifiable'
  ,sysdate
  ,sysdate);  

  insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE3'
  ,'Unidentifiable'
  ,'STAR Enrollment Data Entry'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'STAR Enrollment Data Entry' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Unidentifiable'
  ,sysdate
  ,sysdate); 

  insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS)
values (SEQ_CELL_ID.nextval
  ,'ProcessMail_work_expected'
  ,'DOC_TYPE4'
  ,'Unidentifiable'
  ,'TP40 STAR Enrollment'
  ,'STEP_DEFINITION_ID'
  ,(select STEP_DEFINITION_ID from STEP_DEFINITION_STG where NAME = 'TP40 STAR Enrollment' and STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK') )
  ,trunc(sysdate)
  ,to_date('7777-07-07','YYYY-MM-DD')
  ,'TX final work task type expected for doc type Unidentifiable'
  ,sysdate
  ,sysdate); 

commit;