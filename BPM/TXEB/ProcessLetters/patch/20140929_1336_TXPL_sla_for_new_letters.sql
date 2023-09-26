UPDATE corp_etl_list_lkup
SET out_var= '21'
WHERE value = 'StarPlus Expansion Reminder Letter'
and name = 'ProcLetters_SLA_Jeopardy_Days';

UPDATE corp_etl_list_lkup
SET out_var= '21'
WHERE value = 'StarPlus Expansion Reminder Letter'
and name = 'ProcLetters_SLA_Days';

UPDATE corp_etl_list_lkup
SET out_var= '21'
WHERE value = 'StarPlus Expansion Reminder Letter'
and name = 'ProcLetters_SLA_Target_Days';


Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Medical Voluntary Enrollment Letter','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days for letter VLM.',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Medical Voluntary Enrollment Letter','16','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);


Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Medical Voluntary Enrollment Letter','16','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Medical Voluntary Enrollment Letter','16','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);


Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Medical Mandatory Enrollment Packet','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days for letter IAM.',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Medical Mandatory Enrollment Packet','16','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);


Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Medical Mandatory Enrollment Packet','16','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Medical Mandatory Enrollment Packet','16','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);


Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','EXCLUDED_LETTERS','Checkup Due Letter','Checkup Due Letter',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Letters that have special SLA calculations',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','EXCLUDED_LETTERS','Checkup Reminder Letter','Checkup Reminder Letter',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Letters that have special SLA calculations',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','EXCLUDED_LETTERS','Enrollment Reminder','Enrollment Reminder',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Letters that have special SLA calculations',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','EXCLUDED_LETTERS','StarPlus Expansion Reminder Letter','StarPlus Expansion Reminder Letter',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Letters that have special SLA calculations',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','EXCLUDED_LETTERS','Medical Voluntary Enrollment Letter','Medical Voluntary Enrollment Letter',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Letters that have special SLA calculations',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','EXCLUDED_LETTERS','Medical Mandatory Enrollment Packet','Medical Mandatory Enrollment Packet',SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Letters that have special SLA calculations',SYSDATE,SYSDATE);


commit;