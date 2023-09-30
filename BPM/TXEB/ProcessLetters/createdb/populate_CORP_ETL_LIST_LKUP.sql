
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'LETTER_ERR_TASK','INLIST','Letter Request Creation Error',null,'STEP_DEFINITION_ID',22,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'LETTER_ERR_TASK','INLIST','Letter Generation Error',null,'STEP_DEFINITION_ID',26,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'LETTER_ERR_TASK','INLIST','Letter Voided Error',null,'STEP_DEFINITION_ID',27,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'LETTER_ERR_UPD10_10','INLIST','Letter Request Creation Error',null,'STEP_DEFINITION_ID',22,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'LETTER_ERR_UPD10_20','INLIST','Letter Generation Error',null,'STEP_DEFINITION_ID',26,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Medicaid Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','CHIP Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Other Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Medicaid Letter','B','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','CHIP Letter','B','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Other Letter','B','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Medicaid Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','CHIP Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Other Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Medicaid Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','CHIP Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Other Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'MEDICAID','ORDER LIST','STARPDUAL','MEDICAL','CLIENT_ELIG_STATUS',1,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'MEDICAID','ORDER LIST','STARHDUAL','MEDICAL','CLIENT_ELIG_STATUS',2,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'MEDICAID','ORDER LIST','STARPLUS','MEDICAL','CLIENT_ELIG_STATUS',3,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'MEDICAID','ORDER LIST','STARH','MEDICAL','CLIENT_ELIG_STATUS',4,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'MEDICAID','ORDER LIST','STAR','MEDICAL','CLIENT_ELIG_STATUS',5,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'MEDICAID','ORDER LIST','NS','BEHAVIORAL','CLIENT_ELIG_STATUS',1,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CHIP','ORDER LIST','CHIP','MEDICAL','CLIENT_ELIG_STATUS',1,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'CHIP','ORDER LIST','CHIP-PERI','MEDICAL','CLIENT_ELIG_STATUS',2,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),null,SYSDATE,SYSDATE);

/*
Added below two global controls by Raj A. on 10/23/2014. For performance improvement of TX PL. Intially checking processing (three letter types) saturday only.
*/
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_TYPE_EXCLUDE_DAYS','LETTER_TYPE_EXCLUSION','7',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Exclude processing this letter type this day of the week. 1 for Sunday; 7 for Saturday.',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_TYPES_TO_EXCLUDE','LETTER_TYPE_EXCLUSION','Checkup Due Letter,Checkup Reminder Letter,Enrollment Reminder',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Exclude processing these letter types specific day/s of the week. 1 for Sunday; 7 for Saturday.',SYSDATE,SYSDATE);
commit;  

/*
Created by Raj A. on 12/08/2014.
Description: Created for Dual Eligibility (Dual Demo) Project. TXEB-4137
Added below 11 DMLS (NAME = ProcLetters_SpecialSLA_Letters) and 4 DMLs (VALUE = 'Dual Eligibility Letter')
*/
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP PE Intro Letter','Dual Eligibility Letter','MMP1',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Opt Out Letter','Dual Eligibility Letter','MMP10',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Opt In Letter','Dual Eligibility Letter','MMP11',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP PE Enrollment Letter','Dual Eligibility Letter','MMP2',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP PE Reminder Letter','Dual Eligibility Letter','MMP3',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Enrollment Request Form','Dual Eligibility Letter','MMP4',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Enrollment Confirmation Letter','Dual Eligibility Letter','MMP5',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Employer or Union Coverage Letter','Dual Eligibility Letter','MMP6',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Denial of Enrollment Letter','Dual Eligibility Letter','MMP7',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Opt In Cancellation Letter','Dual Eligibility Letter','MMP8',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Out of Service Area Disenrollment Letter','Dual Eligibility Letter','MMP9',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP STAR+PLUS Re-enrollment Letter','Dual Eligibility Letter','MMP12',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Unauthorized Disenrollment Request Letter','Dual Eligibility Letter','MMP13',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','DUAL_DEMO','MMP Loss of Medicare Eligibility Letter','Dual Eligibility Letter','MMP14',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'These Letter types are grouped into Dual Eligbility (Dual Demo) Letter type.',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days','TASK_TYPE','Dual Eligibility Letter','16','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days after which the letter request is determined to be processed untimely.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Days_Type','TASK_TYPE','Dual Eligibility Letter','C','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Indicates if the SLA DAYS should be measured in Business Days or Calendar Days.',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Jeopardy_Days','TASK_TYPE','Dual Eligibility Letter','15','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Age at which time the letter request is determined to be in jeopardy of becoming untimely',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'ProcLetters_SLA_Target_Days','TASK_TYPE','Dual Eligibility Letter','1','LETTER_TYPE',null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'The number of days in which the letter request should be completed, as defined by the project',SYSDATE,SYSDATE);


commit;


--Letter Statuses
 Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_REQ','LETTER_STATUS','''Requested''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Requested Letter status - used in update rules',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_ERR','LETTER_STATUS','''Errored''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Error Letter status - used in update rules',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_SENT','LETTER_STATUS','''Sent''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Sent Letter status - used in update rules',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_REJ','LETTER_STATUS','''Rejected by Mailhouse''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Rejected Letter status - used in update rules',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_CANC','LETTER_STATUS','''Canceled''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Canceled Letter status - used in update rules',SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTER_STATUS_OTHR','LETTER_STATUS','''Voided'',''Combined Similar Requests'',''Overcome by Events'',''Canceled''',null,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Other Letter statuses for canceling letter requests - used in update rules',SYSDATE,SYSDATE);

--Rejection Reasons
Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTERS_REJECT_REASON','REJECT_REASON','Not Sent-Forwarding Address Available',1100,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Letter Reject reasons',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTERS_REJECT_REASON','REJECT_REASON','Address - Incomplete Street',1201,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Letter Reject reasons',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTERS_REJECT_REASON','REJECT_REASON','NCOA: Moved Left No Forwarding Address',1002,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Letter Reject reasons',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTERS_REJECT_REASON','REJECT_REASON','NCOA: PO BOX Closed No Forwarding Address',1003,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Letter Reject reasons',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTERS_REJECT_REASON','REJECT_REASON','NCOA: Foreign Move',1001,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Letter Reject reasons',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTERS_REJECT_REASON','REJECT_REASON','Customer request to pull record and NOT mail',9004,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Letter Reject reasons',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTERS_REJECT_REASON','REJECT_REASON','New address is out of state',1101,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Letter Reject reasons',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTERS_REJECT_REASON','REJECT_REASON','Address - Missing City and Zip',1202,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Letter Reject reasons',SYSDATE,SYSDATE);


Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTERS_REJECT_REASON','REJECT_REASON','Address Line is Missing',5110,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Letter Reject reasons',SYSDATE,SYSDATE);


commit;  