alter session set current_schema = MAXDAT;

UPDATE  "CORP_ETL_CONTROL" 
set value =  5236255
where name = 'MAX_DCN_DETAIL_ID'
commit;