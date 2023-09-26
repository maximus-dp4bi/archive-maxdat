MERGE INTO control.paieb_awsdms_tables_list tgt
USING(SELECT source_table_name,primary_key_column,CASE WHEN primary_key_column = 'APP_CASE_LINK_ID' THEN 449355
    WHEN primary_key_column = 'APP_DOC_DATA_ID' THEN 1673735
    WHEN primary_key_column = 'APP_ELIG_OUTCOME_ID' THEN 156077
    WHEN primary_key_column = 'APPLICATION_ID' THEN 419766
    WHEN primary_key_column = 'APP_HEADER_EXT_ID' THEN 426691
    WHEN primary_key_column = 'APP_INDIVIDUAL_ID' THEN 459753
    WHEN primary_key_column = 'MISSING_INFO_ID' THEN 911299
    WHEN primary_key_column = 'APP_STATUS_HISTORY_ID' THEN 2166419
    WHEN primary_key_column = 'CLNT_CLIENT_ID' THEN 10103
    WHEN primary_key_column = 'DOCUMENT_SET_ID' THEN 1369209
    WHEN primary_key_column = 'DOC_LINK_ID' THEN 2920738
    WHEN primary_key_column = 'DOCUMENT_ID' THEN 2935944
    WHEN primary_key_column = 'DOCUMENT_Set_id' THEN 1369209
    WHEN primary_key_column = 'LMREQ_ID' THEN 11469529
    WHEN primary_key_column = 'LMLINK_ID' THEN 13715452
    WHEN primary_key_column = 'NOTIFICATION_REQUEST_ID' THEN 839360
    WHEN primary_key_column = 'STEP_INSTANCE_ID' THEN 11850588
    WHEN primary_key_column = 'ADDR_ID' THEN 18370259
    WHEN primary_key_column = 'PHON_ID' THEN 8523626
    WHEN primary_key_column = 'ASSESSMENT_ID' THEN 231423
    WHEN primary_key_column = 'APP_ADV_PLAN_ID' THEN 231423
    WHEN primary_key_column = 'CALENDAR_ITEM_ID' THEN 128280
    WHEN primary_key_column = 'SELECTION_TXN_ID' THEN 16590286
    WHEN primary_key_column = 'SELECTION_SEGMENT_ID' THEN 7617123
    WHEN primary_key_column = 'ASSESSMENT_HIST_ID' THEN 0 --waiting for pk limit for assesment_hist table
  ELSE 0 END pk_limit  
FROM CONTROL.PAIEB_AWSDMS_TABLES_LIST) src ON (tgt.source_table_name = src.source_table_name)
WHEN MATCHED THEN UPDATE
SET primary_key_limit = pk_limit;  