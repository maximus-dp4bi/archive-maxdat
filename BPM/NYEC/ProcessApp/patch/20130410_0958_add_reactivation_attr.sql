-- Add reactivation attributes.

-- BPM_ATTRIBUTE_LKUP

update BPM_ATTRIBUTE_LKUP
set 
  NAME = 'Outcome Notification Required Gateway Flag',
  PURPOSE = 'Outcome Notification Required gateway flag.'
where BAL_ID = 80;

insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (397,2,'Stop Application Reason','The stop application reason is the reason research stopped processing the 
application');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (398,2,'Reactivation Reason','The reactivation reason is the reason the  application is  reactivated  on the 
case in Maxe');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (399,1,'Reactivation Indicator','The reactivation indicator identifies an application that has been 
externally reactivated and can only be set on Renewal Applications');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (400,1,'Reactivation Number','The reactivation number is the number of reactivations on an application. The 
initial application will always be null');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (401,2,'Workflow Reactivation Indicator','The workflow reactivation indicator determines if the application 
goes through the internal reactivation workflow');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (402,2,'Current Mode Code','The current mode code indicates the status of the application that has been 
reactivated in the workflow and determines the outcome of the reactivated application');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (403,2,'Current Mode Label','The current mode code label describes the status of the application in the 
workflow process');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (404,2,'Outcome Letter Type','Outcome letter type describes the type of letter being sent in this process. 
There are only two outcom letter types: Manuel Notice/Courtesy letter or Docs 30 Days after Auth letter');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (405,2,'Outcome Letter Status','Outcome letter status provides the condition of the letter to determine if a 
letter has been requested and sent');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (406,1,'Outcome Letter ID','The unique identifier associated to the letter');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (407,3,'Outcome Letter Create Date','The outcome letter create date is the day the letter was requested to 
be sent to the client');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (408,3,'Outcome Letter Send Date','The outcome letter send date is the day the letter is confirmed sent to 
the client');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (409,2,'Reactivated By','The person who reactivated the application');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (410,3,'Reactivation Date','The date the application was reactivated');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (411,2,'Outcome Notification Required Flag','The outcome notification required flag is set to Y when the 
outcome notification is required and set to N when it is not required. Outcome letters are only sent on applications stopped with stopped reasons: screened ineligible or HEART 
screening cancelled eligibility period expired');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (412,2,'QC Indicator','The QC indicator provides informationto the state to determine if tasks are in the 
state queues and are ready to work. It also determines if any of the state automated jobs are ready to run');

-- BPM_ATTRIBUTE
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (481,397,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (482,398,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (483,399,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (484,400,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (485,401,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (486,402,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (487,403,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (488,404,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (489,405,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (490,406,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (491,407,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (492,408,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (493,409,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (494,410,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (495,411,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (496,412,2,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');

-- BPM_ATTRIBUTE_STAGING_TABLE
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,481,2,'STOP_APP_REASON');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,482,2,'REACTIVATION_REASON');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,483,2,'REACTIVATION_IND');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,484,2,'REACTIVATION_NBR');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,485,2,'WORKFLOW_REACT_IND');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,486,2,'CURR_MODE_CD');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,487,2,'CURR_MODE_LABEL');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,488,2,'OUTCOME_LTR_TYPE');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,489,2,'OUTCOME_LTR_STATUS');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,490,2,'OUTCOME_LTR_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,491,2,'OUTCOME_LTR_CREATE_DT');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,492,2,'OUTCOME_LTR_SENT_DT');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,493,2,'REACTIVATED_BY');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,494,2,'REACTIVATION_DT');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,495,2,'OUTCOME_NOTIFY_RQRD_FLAG');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,496,2,'QC_IND ');

commit;
