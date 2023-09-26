ALTER TABLE INEO_WMST_USER_QA_SCORES_HISTORY ADD (for_month_of DATE);

UPDATE file_load_lkup
SET insert_fields = 'metric,filename,record_id,task_name,review_completion_date,total_possible_earned,maximum_possible_points,total_percentage_score,e2e_deduction,final_percentage_score,for_month_of'
,select_fields = 'metric,filename,record_id,task_name,CASE WHEN REGEXP_INSTR(review_completion_date,''/'') = 0 THEN DATEADD(DAYS, review_completion_date,CAST(''12/30/1899'' AS DATE)) ELSE TRY_CAST(regexp_replace(review_completion_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) END AS review_completion_date,
TRY_CAST(total_possible_earned AS NUMBER),TRY_CAST(maximum_possible_points AS NUMBER),
TRY_CAST(total_percentage_score AS FLOAT),TRY_CAST(e2e_deduction AS FLOAT),TRY_CAST(final_percentage_score AS FLOAT),TRY_CAST(for_month_of AS DATE)'
,where_clause = ' WHERE record_id IS NOT NULL'
WHERE filename_prefix = 'WMST_USER_QA_SCORES_';

--reload the data
DELETE FROM file_load_log
WHERE filename_prefix = 'WMST_USER_QA_SCORES_';

TRUNCATE TABLE INEO_WMST_USER_QA_SCORES_HISTORY;