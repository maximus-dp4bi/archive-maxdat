update corp_etl_proc_letters a
set account_id = (select case_cin from cases_stg b where b.case_id = a.case_id)
WHERE LETTER_TYPE LIKE 'Notice of Invalid%'
AND TRUNC(MAILED_DT) IS NOT NULL
AND ACCOUNT_ID IS NULL
and exists (select case_cin from cases_stg b where b.case_id = a.case_id);

commit;
