update file_load_lkup
set select_fields = 'metric,filename,record_id,task_name,CASE WHEN REGEXP_INSTR(review_completion_date,''/'') = 0 THEN DATEADD(DAYS, review_completion_date,CAST(''12/30/1899'' AS DATE)) ELSE TRY_CAST(regexp_replace(review_completion_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) END AS review_completion_date,
TRY_CAST(total_possible_earned AS NUMBER),TRY_CAST(maximum_possible_points AS NUMBER),
TRY_CAST(total_percentage_score AS FLOAT),TRY_CAST(e2e_deduction AS FLOAT),TRY_CAST(final_percentage_score AS FLOAT)'
,where_clause = ' WHERE record_id IS NOT NULL'
where filename_prefix = 'WMST_USER_QA_SCORES_';

--data fix
UPDATE INEO_WMST_USER_QA_SCORES_HISTORY q
SET q.review_completion_date = x.review_completion_date
FROM(
select record_id,CASE WHEN REGEXP_INSTR(review_completion_date,'/') = 0 THEN DATEADD(DAYS, review_completion_date,CAST('12/30/1899' AS DATE)) ELSE TRY_CAST(regexp_replace(review_completion_date,'[^A-Za-z0-9 -:/*]','') AS DATE) END AS review_completion_date
from "MARS_DP4BI_PROD"."INEO"."WMST0114B_USER_QA_SCORES_05012023104000"
) x
WHERE q.record_id = x.record_id
AND upper(q.filename) = 'WMST0114_USER_QA_SCORES_05012023093756'
AND q.review_completion_date IS NULL;

UPDATE INEO_WMST_USER_QA_SCORES_HISTORY q
SET q.review_completion_date = x.review_completion_date
FROM(
select record_id,CASE WHEN REGEXP_INSTR(review_completion_date,'/') = 0 THEN DATEADD(DAYS, review_completion_date,CAST('12/30/1899' AS DATE)) ELSE TRY_CAST(regexp_replace(review_completion_date,'[^A-Za-z0-9 -:/*]','') AS DATE) END AS review_completion_date
from "MARS_DP4BI_PROD"."INEO"."WMST0114B_USER_QA_SCORES_05052023104000"
) x
WHERE q.record_id = x.record_id
AND upper(q.filename) = 'WMST0114_USER_QA_SCORES_05052023095737'
AND q.review_completion_date IS NULL;

DROP TABLE WMST0114B_USER_QA_SCORES_05052023104000;
DROP TABLE WMST0114B_USER_QA_SCORES_05012023104000;