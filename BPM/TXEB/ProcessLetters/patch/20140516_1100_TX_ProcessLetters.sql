update corp_etl_list_lkup set out_var = '5' where name in ( 'ProcLetters_SLA_Jeopardy_Days','ProcLetters_SLA_Days');

--check with Ann to see if 'ProcLetters_SLA_Target_Days' for all letters can be set to 5. 
--previous ones are 1 and new ones set to 5 at the end of this script
delete from corp_etl_list_lkup where name in ('ProcLetters_SLA_Days_Type','ProcLetters_SLA_Jeopardy_Days','ProcLetters_SLA_Days','ProcLetters_SLA_Target_Days')
and list_type = 'TASK_TYPE' and value in ('Checkup Due Letter','Checkup Reminder Letter','Enrollment Reminder','STAR+PLUS Manadatory Reminder letter');

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Checkup Due Letter','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days for letter H10.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Checkup Reminder Letter','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days for letter H11.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Enrollment Reminder','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days for letter E1R.',SYSDATE,SYSDATE);


Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Checkup Due Letter','60','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Checkup Reminder Letter','60','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Enrollment Reminder','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Checkup Due Letter','10','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely after create month',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Checkup Reminder Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number month after which the letter request is determined to be processed untimely after create month',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Enrollment Reminder','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely after mailing of Enrollment packet EPM',SYSDATE,SYSDATE);


Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Checkup Due Letter','5','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Checkup Reminder Letter','5','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Enrollment Reminder','5','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);


commit;