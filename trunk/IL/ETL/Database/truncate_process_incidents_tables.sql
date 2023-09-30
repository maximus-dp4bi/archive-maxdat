truncate CORP_ETL_PROCESS_INCIDENTS;

delete from CORP_ETL_ERROR_LOG
where process_name='PROCESS INCIDENTS';

commit;