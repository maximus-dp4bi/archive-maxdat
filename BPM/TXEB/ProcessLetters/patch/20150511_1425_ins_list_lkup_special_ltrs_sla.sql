      
Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','EXCLUDED_LETTERS','Checkup Due Dental Letter','Checkup Due Letter',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Letters that have special SLA calculations',SYSDATE,SYSDATE);      

update corp_etl_list_lkup
set value = 'Checkup Due Medical Letter'
where cell_id = 1089;

Insert into CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (Seq_cell_Id.Nextval,'ProcLetters_SpecialSLA_Letters','EXCLUDED_LETTERS','Checkup Reminder Dental Letter','Checkup Reminder Letter',null,null,SYSDATE,to_date('07-JUL-77','DD-MON-RR'),'Letters that have special SLA calculations',SYSDATE,SYSDATE);      

update corp_etl_list_lkup
set value = 'Checkup Reminder Medical Letter'
where cell_id = 1090;

commit;
