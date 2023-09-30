Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (1,'EMAIL_SMS_SOURCE_REFERENCE','SOURCE_REFERENCE','Email and SMS Source','SALESFORCE',null,null,trunc(sysdate),to_date('07-JUL-77','DD-MON-RR'),'Third Party vendor for Email and SMS',sysdate,sysdate);

commit;