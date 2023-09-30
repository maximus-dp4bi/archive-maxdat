
delete from  corp_etl_proc_letters_chd where letter_request_id in 
 (SELECT letter_request_id FROM 
CORP_ETL_PROC_LETTERS  A where trunc(request_dt)>= to_date('01-jan-2014 00:00:00','dd-mon-yyyy hh24:mi:ss'));

delete from corp_etl_proc_letters_chd where client_id is null;

--814738 rows in prd in child table will be deleted
--782195 rows in uat in child table will be deleted

commit;