Insert into CORP_ETL_LIST_LKUP 
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'LETTERS_REJECT_REASON','REJECT_REASON','Address Line is missing',5110,null,null,SYSDATE,to_date('07-JUL-7777','DD-MON-YYYY'),'Letter Reject reasons',SYSDATE,SYSDATE);

commit;