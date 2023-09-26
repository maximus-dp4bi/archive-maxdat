
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