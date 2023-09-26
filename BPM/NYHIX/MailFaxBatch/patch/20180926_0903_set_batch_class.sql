update maxdat.corp_etl_control 
set value = '01-SEP-18', updated_ts=current_date 
where name in ('MFB_REMOTE_LAST_UPDATE_DATE','MFB_CENTRAL_LAST_UPDATE_DATE','MFB_ARS_LAST_UPDATE_DATE');

commit;

Insert into MAXDAT.CORP_ETL_LIST_LKUP (CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values (CELL_HISTORY_SEQ.nextval,
'MFB_BATCH_CLASS_LIST10',
'MFB_BATCH_CLASS_LIST',
'These are the NYHIX PROD Batch Classes',
'NYSOH-INT-FAX',
null,
null,
sysdate,
to_date('31-DEC-2022 12:00:00','DD-MON-YYYY HH:MI:SS'),
null,
sysdate,
sysdate);
commit;