alter session set current_schema = maxdat_cc;

Insert into CC_A_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('ACTIVITY_NAME_FOR_LUNCH_TIME','ACTIVITY_TYPE_NAME','ACTIVITY_TYPE_NAME','Lunch Time',null,1,to_date('19-SEP-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Activity type name for Lunch',to_date('19-SEP-16','DD-MON-RR'),to_date('21-SEP-16','DD-MON-RR'));
Insert into CC_A_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('ACTIVITY_NAME_FOR_LUNCH_CES','ACTIVITY_TYPE_NAME','ACTIVITY_TYPE_NAME','Lunch_CES',null,1,to_date('19-SEP-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Activity type name for Lunch',to_date('19-SEP-16','DD-MON-RR'),to_date('21-SEP-16','DD-MON-RR'));
Insert into CC_A_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('ACTIVITY_NAME_FOR_LUNCH_CT','ACTIVITY_TYPE_NAME','ACTIVITY_TYPE_NAME','Lunch - CT',null,1,to_date('19-SEP-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Activity type name for Lunch',to_date('19-SEP-16','DD-MON-RR'),to_date('21-SEP-16','DD-MON-RR'));

Insert into CC_A_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('Agent_Program','AGENT_PROGRAM','IEB','Independent Enrollment Broker',null,1,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Program mapping for Agent',to_date('21-SEP-16','DD-MON-RR'),to_date('28-SEP-16','DD-MON-RR'));
Insert into CC_A_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('Agent_Project','AGENT_PROJECT','IEB','PA IEB',null,1,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Project mapping for Agent',to_date('19-APR-16','DD-MON-RR'),to_date('20-SEP-16','DD-MON-RR'));

Insert into CC_A_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('Agent_Program','AGENT_PROGRAM','PA','Independent Enrollment Broker',null,null,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Program mapping for Agent',to_date('12-OCT-16','DD-MON-RR'),to_date('12-OCT-16','DD-MON-RR'));
Insert into CC_A_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('Agent_Program','AGENT_PROGRAM','Call Center - PA','Independent Enrollment Broker',null,null,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Program mapping for Agent',to_date('12-OCT-16','DD-MON-RR'),to_date('12-OCT-16','DD-MON-RR'));
Insert into CC_A_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('Agent_Project','AGENT_PROJECT','PA','PA IEB',null,null,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Project mapping for Agent',to_date('12-OCT-16','DD-MON-RR'),to_date('12-OCT-16','DD-MON-RR'));
Insert into CC_A_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values ('Agent_Project','AGENT_PROJECT','Call Center - PA','PA IEB',null,null,to_date('19-APR-16','DD-MON-RR'),to_date('07-JUL-77','DD-MON-RR'),'Project mapping for Agent',to_date('12-OCT-16','DD-MON-RR'),to_date('12-OCT-16','DD-MON-RR'));

commit;
