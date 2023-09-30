Insert into CORP_CLNT_OUTREACH_PROC_LKUP (PROCESS,STEP1,STEP2,STEP3,STEP4,STEP5,STEP6) values ('OUTREACH_REQUEST_12','Letter','Delay1','Phone Call2','Delay2','Letter',null);
Insert into CORP_CLNT_OUTREACH_PROC_LKUP (PROCESS,STEP1,STEP2,STEP3,STEP4,STEP5,STEP6) values ('OUTREACH_REQUEST_13','Letter','Delay1','Phone Call3','Home Visit','Letter',null);


Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call2','Outreach Dialer Unsuccessful',null,'OR_TESTING_DIALER_NO_REACH',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call2','Basic Script Delivered',null,'BASIC_SCRIPT_DELIVERED',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call2','HCO Script Delivered',null,'HCO_SCRIPT_DELIVERED',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call2','Case Management Script Delivered', null,'CM_SCRIPT_DELIVERED',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call2','Outreach Request - Script Declined', null,'SCRIPT_DECLINED',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call2','Outreach Request - Client became 21 last month', null,'OUTREACH_CLIENT_REACHED_21',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call2','Lost Eligibility', null,'LOST_ELIGIBILITY',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call2','Eligibility Information Updated', null,'ELIG_INFO_UPDATED',null);

Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call3','Outreach Dialer Unsuccessful',null,'OR_TESTING_DIALER_NO_REACH',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call3','Basic Script Delivered',null,'BASIC_SCRIPT_DELIVERED',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call3','HCO Script Delivered',null,'HCO_SCRIPT_DELIVERED',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call3','Case Management Script Delivered', null,'CM_SCRIPT_DELIVERED',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call3','Outreach Request - Client became 21 last month', null,'OUTREACH_CLIENT_REACHED_21',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call3','Lost Eligibility', null,'LOST_ELIGIBILITY',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Phone Call3','Eligibility Information Updated', null,'ELIG_INFO_UPDATED',null);

Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Home Visit','Basic Script Delivered',null,'BASIC_SCRIPT_DELIVERED',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Home Visit','HCO Script Delivered',null,'HCO_SCRIPT_DELIVERED',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Home Visit','Case Management Script Delivered', null,'CM_SCRIPT_DELIVERED',null);

Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Home Visit','No One Home, Left Letter',null,'NOT_HOME_LEFT_LTR',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Home Visit','Outreach Request Home Visit Failure',null,'OR_HOME_VISIT_FAILURE',null);
Insert into CORP_ETL_CLNT_OR_ACTIVITY_LKUP (OUTREACH_STEP_TYPE,EVENT_TYPE,OUTREACH_TYPE,EVENT_TYPE_CD,OUTREACH_TYPE_CD) values ('Home Visit','Safety Issue - Do Not Return',null,'SAFETY_ISSUE',null);


UPDATE CORP_CLNT_OUTREACH_NOTIFY_LKUP
SET process = 13, outreach_activity = 'Letter',timeliness = 7
where outreach_type = 'NEW_SSI';
 
UPDATE CORP_CLNT_OUTREACH_NOTIFY_LKUP
SET process = 12, timeliness = 12, outreach_activity = 'Phone Call2'
where outreach_type = 'NEW_FC';
 

Insert into CORP_CLNT_OUTREACH_NOTIFY_LKUP (OUTREACH_CATEGORY,OUTREACH_CATEGORY_DESC,OUTREACH_TYPE,OUTREACH_TYPE_DESC,PROCESS,NOTIFY_INVALID,NOTIFY_OUTCOME,OUTREACH_ACTIVITY,JEOPARDY,TIMELINESS,TERMINATION_TIMEFRAME) values ('EXTERNAL_LIST','External List','NEW_SSI','Newly Certified SSI Children',13,'N','N','Home Visit',null,14,65);
Insert into CORP_CLNT_OUTREACH_NOTIFY_LKUP (OUTREACH_CATEGORY,OUTREACH_CATEGORY_DESC,OUTREACH_TYPE,OUTREACH_TYPE_DESC,PROCESS,NOTIFY_INVALID,NOTIFY_OUTCOME,OUTREACH_ACTIVITY,JEOPARDY,TIMELINESS,TERMINATION_TIMEFRAME) values ('EXTERNAL_LIST','External List','NEW_SSI','Newly Certified SSI Children',13,'N','N','Phone Call3',null,7,65);
Insert into CORP_CLNT_OUTREACH_NOTIFY_LKUP (OUTREACH_CATEGORY,OUTREACH_CATEGORY_DESC,OUTREACH_TYPE,OUTREACH_TYPE_DESC,PROCESS,NOTIFY_INVALID,NOTIFY_OUTCOME,OUTREACH_ACTIVITY,JEOPARDY,TIMELINESS,TERMINATION_TIMEFRAME) values ('EXTERNAL_LIST','External List','NEW_FC','Newly Certified Foster Care Children',12,'N','N','Letter',null,7,65);

COMMIT;