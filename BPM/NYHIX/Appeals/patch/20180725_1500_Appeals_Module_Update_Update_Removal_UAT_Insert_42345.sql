SET DEFINE OFF;
---- NYHIX-42345 -> UAT version to insert row that should not have been deleted
Insert into MAXDAT.CORP_ETL_LIST_LKUP
(CELL_ID,NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS,CREATED_TS,UPDATED_TS) 
values
(1467,'PA_UPD20_70','APPEAL_STATUS','Various incident status for UPD20_70 - UPD20_120','''Appeal Closed''',
null,null,to_date('08-NOV-16','DD-MON-RR'),null,null,to_date('08-NOV-16','DD-MON-RR'),to_date('28-FEB-17','DD-MON-RR'));

commit;

SELECT *
FROM MAXDAT.corp_etl_list_lkup
WHERE list_type = 'APPEAL_STATUS'
AND NAME = 'PA_UPD20_70';
