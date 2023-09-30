MERGE INTO control.paieb_awsdms_tables_list tgt
USING(SELECT source_table_name,primary_key_column, CASE WHEN primary_key_column = 'APP_CASE_LINK_ID' THEN 529636
        WHEN primary_key_column = 'APP_DOC_DATA_ID' THEN 2116834
        WHEN primary_key_column = 'APP_ELIG_OUTCOME_ID' THEN 198256
        WHEN primary_key_column = 'APPLICATION_ID' THEN 500000
        WHEN primary_key_column = 'APP_HEADER_EXT_ID' THEN 506978
        WHEN primary_key_column = 'APP_INDIVIDUAL_ID' THEN 539987
        WHEN primary_key_column = 'MISSING_INFO_ID' THEN 1230000
        WHEN primary_key_column = 'APP_STATUS_HISTORY_ID' THEN 2897106
        WHEN primary_key_column = 'CLNT_CLIENT_ID' THEN 10103
        --WHEN primary_key_column = 'DOCUMENT_SET_ID'	--for DOC_FLEX_FIELD - is this needed in prod?
        WHEN primary_key_column = 'DOC_LINK_ID' THEN 4178713
        WHEN primary_key_column = 'DOCUMENT_ID' THEN 4199625
        WHEN primary_key_column = 'DOCUMENT_Set_id' THEN 2036773
        WHEN primary_key_column = 'LMREQ_ID' THEN 12297930
        WHEN primary_key_column = 'LMLINK_ID' THEN 14547443
        WHEN primary_key_column = 'NOTIFICATION_REQUEST_ID' THEN 1303324
        WHEN primary_key_column = 'STEP_INSTANCE_ID' THEN 19385890
        WHEN primary_key_column = 'ADDR_ID' THEN 18370259
        WHEN primary_key_column = 'PHON_ID' THEN 8523626
        WHEN primary_key_column = 'ASSESSMENT_ID' THEN 343218
        WHEN primary_key_column = 'APP_ADV_PLAN_ID' THEN 71506
        WHEN primary_key_column = 'CALENDAR_ITEM_ID' THEN 128280
        WHEN primary_key_column = 'SELECTION_TXN_ID' THEN 16652013
        WHEN primary_key_column = 'SELECTION_SEGMENT_ID' THEN 7617123
        WHEN primary_key_column = 'ASSESSMENT_HIST_ID' THEN 464509
        ELSE 0 END pk_limit
FROM CONTROL.PAIEB_AWSDMS_TABLES_LIST) src ON (tgt.source_table_name = src.source_table_name)
WHEN MATCHED THEN UPDATE
SET primary_key_limit = pk_limit;  