-- Backfill ACCOUNT_ID column in CORP_ETL_PROC_LETTERS where letter_type in ('Authorized Representative Notice','Notice of Invalid Document','N503 - Notice of Call Us to Review Your App') - nyhix-19425

update corp_etl_proc_letters L
set account_id = (SELECT DISTINCT C.CASE_CIN FROM CASES_STG C where L.CASE_ID = C.CASE_ID)
WHERE L.LETTER_TYPE IN ('Authorized Representative Notice','Notice of Invalid Document','N503 - Notice of Call Us to Review Your App')
AND L.CREATE_DT > TO_DATE('12/03/2015 23:59:59','MM/DD/YYYY HH24:MI:SS')
AND ACCOUNT_ID IS NULL
;

commit;
