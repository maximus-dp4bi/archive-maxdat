UPDATE CORP_ETL_MFB_BATCH_STG
SET batch_description = regexp_replace(batch_description, '[^[:print:]]', '') 
WHERE batch_guid in('{bb30b35b-87fc-4e68-8a8d-84d6a4b4c3b9}','{9c30fc38-5ad8-45f4-bd80-310d53a4e6df}');

COMMIT;