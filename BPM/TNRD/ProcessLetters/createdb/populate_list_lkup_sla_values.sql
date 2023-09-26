alter session set current_schema = MAXDAT;

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','LTSS Initial Renewal Packet','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','LTSS Initial Renewal Packet','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','LTSS Initial Renewal Packet','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','LTSS Initial Renewal Packet','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Redetermination Approval for Medicaid','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Redetermination Approval for Medicaid','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Redetermination Approval for Medicaid','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Redetermination Approval for Medicaid','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Redetermination Approval for MSP only','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Redetermination Approval for MSP only','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Redetermination Approval for MSP only','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Redetermination Approval for MSP only','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Redetermination Approval for Standard','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Redetermination Approval for Standard','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Redetermination Approval for Standard','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Redetermination Approval for Standard','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Redetermination Approval for CoverKids','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Redetermination Approval for CoverKids','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Redetermination Approval for CoverKids','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Redetermination Approval for CoverKids','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Redetermination Approval for CoverKids during 90 day reconsideration','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Redetermination Approval for CoverKids during 90 day reconsideration','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Redetermination Approval for CoverKids during 90 day reconsideration','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Redetermination Approval for CoverKids during 90 day reconsideration','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Request for AI - Income','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Request for AI - Income','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Request for AI - Income','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Request for AI - Income','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Request for AI - Identity and Income','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Request for AI - Identity and Income','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Request for AI - Identity and Income','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Request for AI - Identity and Income','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Request for AI - Citizenship','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Request for AI - Citizenship','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Request for AI - Citizenship','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Request for AI - Citizenship','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Request for AI - Residency','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Request for AI - Residency','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Request for AI - Residency','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Request for AI - Residency','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Request for AI - SSN','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Request for AI - SSN','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Request for AI - SSN','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Request for AI - SSN','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Request for AI - Clarification for Transitional/Extended Medicaid','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Request for AI - Clarification for Transitional/Extended Medicaid','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Request for AI - Clarification for Transitional/Extended Medicaid','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Request for AI - Clarification for Transitional/Extended Medicaid','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Request for AI – Access to or Enrolled','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Request for AI – Access to or Enrolled','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Request for AI – Access to or Enrolled','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Request for AI – Access to or Enrolled','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Request for AI - Signature needed','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Request for AI - Signature needed','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Request for AI - Signature needed','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Request for AI - Signature needed','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Request for AI – Proof of Medical Eligibility','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Request for AI – Proof of Medical Eligibility','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Request for AI – Proof of Medical Eligibility','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Request for AI – Proof of Medical Eligibility','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Request for AI – Proof No Pregnancy Benefits','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Request for AI – Proof No Pregnancy Benefits','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Request for AI – Proof No Pregnancy Benefits','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Request for AI – Proof No Pregnancy Benefits','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Not Subject to Redetermination','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Not Subject to Redetermination','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Not Subject to Redetermination','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Not Subject to Redetermination','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Denial/Termination','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Denial/Termination','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Denial/Termination','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Denial/Termination','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Denial for 90 Day Period','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Denial for 90 Day Period','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Denial for 90 Day Period','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Denial for 90 Day Period','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Termination (Non-MAGI)','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Termination (Non-MAGI)','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Termination (Non-MAGI)','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Termination (Non-MAGI)','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Initial Renewal Packet (MAGI) Reprint','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Initial Renewal Packet (MAGI) Reprint','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Initial Renewal Packet (MAGI) Reprint','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Initial Renewal Packet (MAGI) Reprint','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','LTSS Initial Renewal Packet Reprint','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','LTSS Initial Renewal Packet Reprint','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','LTSS Initial Renewal Packet Reprint','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','LTSS Initial Renewal Packet Reprint','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Need to Re-apply','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Need to Re-apply','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Need to Re-apply','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Need to Re-apply','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Initial Renewal Packet (MAGI)','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Initial Renewal Packet (MAGI)','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Initial Renewal Packet (MAGI)','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Initial Renewal Packet (MAGI)','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Termination for Failure to Respond','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Termination for Failure to Respond','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Termination for Failure to Respond','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Termination for Failure to Respond','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Denial/Termination - Failure to Respond','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Denial/Termination - Failure to Respond','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Denial/Termination - Failure to Respond','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Denial/Termination - Failure to Respond','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Denial for 90 Day Period - Failure to Respond','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Denial for 90 Day Period - Failure to Respond','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Denial for 90 Day Period - Failure to Respond','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Denial for 90 Day Period - Failure to Respond','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);

commit;