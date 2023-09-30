/* Update Stage Done Date to Null */

BEGIN
update nyec_etl_process_app_mi set Stage_done_date = null where stage_done_date is not null ;
Commit;
END;
/
