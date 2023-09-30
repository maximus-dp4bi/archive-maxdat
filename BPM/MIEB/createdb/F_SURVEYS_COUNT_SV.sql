CREATE OR REPLACE VIEW F_SURVEYS_COUNT_SV AS
SELECT survey_date,
       survey_title,
       survey_status,
       SUM(survey_count) survey_count
FROM (       
SELECT TRUNC(s.status_date) survey_date,
t.title survey_title,
ss.report_label survey_status,
COUNT(s.survey_id) survey_count
FROM survey s 
 JOIN enum_survey_status ss ON ss.value = s.status_cd 
 JOIN survey_template t ON t.survey_template_id = s.survey_template_id
WHERE 1=1
AND 1 = (case when t.title like 'HRAU%Sur%' and ss.value = 'INITIATED' then 0 else 1 end)
--AND ss.value IN('COMPLETED','INITIATED','REFUSED','QUIT') 
AND s.created_by != '-999'
GROUP BY TRUNC(s.status_date),
t.title,
ss.report_label 
UNION
SELECT TRUNC(s.status_date) survey_date,
t.title survey_title,
ss.report_label || ' > 5' survey_status,
COUNT(s.survey_id) survey_count
FROM survey s 
 JOIN enum_survey_status ss ON ss.value = s.status_cd 
 JOIN survey_template t ON t.survey_template_id = s.survey_template_id
WHERE 1=1
AND t.title like 'HRAU%Sur%'
AND s.status_date < (sysdate - 5/(24*60))
AND ss.value = 'INITIATED'
--AND ss.value IN('COMPLETED','INITIATED','REFUSED','QUIT') 
AND s.created_by != '-999'
GROUP BY TRUNC(s.status_date),
t.title,
ss.report_label 
UNION
SELECT TRUNC(s.status_date) survey_date,
t.title survey_title,
ss.report_label || ' < 5' survey_status,
COUNT(s.survey_id) survey_count
FROM survey s 
 JOIN enum_survey_status ss ON ss.value = s.status_cd 
 JOIN survey_template t ON t.survey_template_id = s.survey_template_id
WHERE 1=1
AND t.title like 'HRAU%Sur%'
AND s.status_date > (sysdate - 5/(24*60))
AND ss.value = 'INITIATED'
--AND ss.value IN('COMPLETED','INITIATED','REFUSED','QUIT') 
AND s.created_by != '-999'
GROUP BY TRUNC(s.status_date),
t.title,
ss.report_label 
UNION
SELECT d_date survey_date,
 t.title survey_title,
 ss.report_label survey_status,
 0 survey_count
FROM maxdat_support.d_dates
  CROSS JOIN enum_survey_status ss
  CROSS JOIN survey_template t
WHERE 1=1
AND 1 = (case when t.title like 'HRAU%Sur%' and ss.value = 'INITIATED' then 0 else 1 end)
--WHERE ss.value IN('COMPLETED','INITIATED','REFUSED','QUIT') 
UNION
SELECT d_date survey_date,
 t.title survey_title,
 ss.report_label || ' > 5' survey_status,
 0 survey_count
FROM maxdat_support.d_dates
  CROSS JOIN enum_survey_status ss
  CROSS JOIN survey_template t
--WHERE ss.value IN('COMPLETED','INITIATED','REFUSED','QUIT') 
WHERE 1=1
AND t.title like 'HRAU%Sur%'
AND ss.value = 'INITIATED'
UNION
SELECT d_date survey_date,
 t.title survey_title,
 ss.report_label || ' < 5' survey_status,
 0 survey_count
FROM maxdat_support.d_dates
  CROSS JOIN enum_survey_status ss
  CROSS JOIN survey_template t
--WHERE ss.value IN('COMPLETED','INITIATED','REFUSED','QUIT') 
WHERE 1=1
AND t.title like 'HRAU%Sur%'
AND ss.value = 'INITIATED'
) sv
GROUP BY survey_date,
       survey_title,
       survey_status;
  
GRANT SELECT ON MAXDAT_SUPPORT.F_SURVEYS_COUNT_SV TO MAXDAT_REPORTS;  
