INSERT INTO MAXDAT_SUPPORT.CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE, CREATED_TS, UPDATED_TS)
  VALUES('INCIDENT_CANCELLED_STATUS', 'INCIDENTS', 'INCIDENT_CANCELLED_STATUS_1', 'WITHDRAWN', to_date('01/01/1900', 'mm/dd/yyyy'), NULL, sysdate,sysdate);
  
COMMIT;  
  
  
  