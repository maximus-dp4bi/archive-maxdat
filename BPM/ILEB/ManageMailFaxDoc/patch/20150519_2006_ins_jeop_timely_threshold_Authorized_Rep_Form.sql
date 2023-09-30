Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcessMail_timeli_threshold','DOC_TYPE','Authorized Rep Form',40,null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'IL Timeliness threshold for doc type Authorized Rep Form in business hours',SYSDATE,SYSDATE);

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcessMail_jeop_threshold','DOC_TYPE','Authorized Rep Form',16,null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'IL jeopardy threshold for doc type Authorized Rep Form in business hours',SYSDATE,SYSDATE);


commit;