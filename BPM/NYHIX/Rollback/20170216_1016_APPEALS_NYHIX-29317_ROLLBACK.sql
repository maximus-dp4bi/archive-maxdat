delete from MAXDAT.CORP_ETL_LIST_LKUP WHERE name = 'PA_UPD20_70';

commit;

INSERT INTO MAXDAT.CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS) VALUES ('PA_UPD20_70','APPEAL_STATUS','Various incident status for UPD20_70','''Appeal Closed''',null,null,sysdate,null,null);

commit;
