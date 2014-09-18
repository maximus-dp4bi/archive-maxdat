
delete from  corp_etl_proc_letters_chd where letter_request_id in 
 (SELECT letter_request_id FROM 
CORP_ETL_PROC_LETTERS  A where trunc(request_dt)>= to_date('01-jan-2014 00:00:00','dd-mon-yyyy hh24:mi:ss'));

--678183 rows in prd in child table will be deleted
--644919 rows in uat in child table will be deleted

commit;