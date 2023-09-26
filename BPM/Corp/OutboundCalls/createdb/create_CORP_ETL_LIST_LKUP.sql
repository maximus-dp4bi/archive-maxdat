/*
Created by Brian Thai Originally. Raj is backfilling comments on 05/07/2015.
Raj A. 05/07/2015 Added CSN subprogram_type.
*/
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','Illinois Health Connect','P','SUBPROGRAM',null,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','Integrated Care Program','I','SUBPROGRAM',null,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','MMAI','M','SUBPROGRAM',null,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','LTSS','L','SUBPROGRAM',null,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','R1','3','OUTBND_CAMPAIGN',1,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','R2','3','OUTBND_CAMPAIGN',2,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','Voluntary Managed Care','V','SUBPROGRAM',null,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL_RESULT','LIST','Busy Signal','B','PLACED',4,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL_RESULT','LIST','Call Not Attempted','X','FAILURE',9,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL_RESULT','LIST','Error','E','FAILURE',3,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL_RESULT','LIST','Fax','F','FAILURE',5,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL_RESULT','LIST','Invalid Number','I','FAILURE',7,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL_RESULT','LIST','Live caller reached, hang up before transfer','H','FAILURE',6,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL_RESULT','LIST','Live caller reached, transfer to call center','T','SUCCESS',2,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL_RESULT','LIST','Ring No Answer','N','PLACED',8,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBOUND_CALL_RESULT','LIST','Voicemail','V','SUCCESS',1,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBND_CALL_Timeline_Days','TASK_TYPE','Timeline Days','2','OUTBOUND_CALL',null,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBND_CALL_Timeline_Days_Type','TASK_TYPE','Timeline Days Type','B','OUTBOUND_CALL',null,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBND_CALL_Jeopardy_Days','TASK_TYPE','Jeopardy Days','1','OUTBOUND_CALL',null,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBND_CALL_Jeopardy_Days_Type','TASK_TYPE','Jeopardy Days Type','B','OUTBOUND_CALL',null,null,null,null,SYSDATE,SYSDATE);
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) values (Seq_cell_Id.Nextval,'OUTBND_CALL_Target_Days','TASK_TYPE','Target Days','1','OUTBOUND_CALL',null,null,null,null,SYSDATE,SYSDATE);

-- ILEB-3488
insert into corp_etl_list_lkup (NAME, LIST_TYPE, VALUE, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS) values ('OUTBOUND_CALL', 'LIST', 'R3', '3', 'OUTBND_CAMPAIGN', 2, null, null, null, SYSDATE, SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'OUTBOUND_CALL','LIST','CSN','C','SUBPROGRAM',null,null,null,null,SYSDATE,SYSDATE);

commit;