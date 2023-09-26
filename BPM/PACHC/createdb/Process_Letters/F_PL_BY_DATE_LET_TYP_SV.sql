CREATE OR REPLACE VIEW MAXDAT_SUPPORT.F_PL_BY_DATE_LET_TYP_SV
AS
SELECT
	D_DATE,
	LETTER_TYPE,
	SUM(REQUEST_COUNT) AS REQUEST_COUNT, 	
	SUM(SENT_COUNT) AS SENT_COUNT, 
	SUM(OUTCOME_SUCCESSFUL_COUNT) AS OUTCOME_SUCCESSFUL_COUNT, 
	SUM(OUTCOME_UNSUCCESSFUL_COUNT) AS OUTCOME_UNSUCCESSFUL_COUNT,
	SUM(PROCESSED_TIMELY_COUNT)  AS PROCESSED_TIMELY_COUNT, 
	SUM(PROCESSED_UNTIMELY_COUNT)  AS PROCESSED_UNTIMELY_COUNT
--The above code creates an aggregate record at the AGGREGATE DATE, DISTRIBUTION_METHOD, LETTER_TYPE level
FROM
--REQUEST_DATE subquery
(SELECT 
	TRUNC(REQUEST_DATE) AS D_DATE, 
	LETTER_TYPE,
 	SUM(1) AS REQUEST_COUNT,
	0 AS SENT_COUNT,
	sum(case when DOCUMENT_OUTCOME_FLAG='S' then 1 else 0 END) AS OUTCOME_SUCCESSFUL_COUNT, 
	sum(case when DOCUMENT_OUTCOME_FLAG='F' then 1 else 0 END) AS OUTCOME_UNSUCCESSFUL_COUNT,
	0 AS PROCESSED_TIMELY_COUNT, 
	0 AS PROCESSED_UNTIMELY_COUNT
 FROM D_PL_CURRENT_SV
	GROUP BY TRUNC(REQUEST_DATE), LETTER_TYPE
UNION ALL
--SENT_DATE subquery
SELECT 
 	TRUNC(SENT_DATE) AS D_DATE, 
	LETTER_TYPE,
	0 AS REQUEST_COUNT, 
	SUM(1) AS SENT_COUNT,
	0 AS OUTCOME_SUCCESSFUL_COUNT, 
	0 AS OUTCOME_UNSUCCESSFUL_COUNT,
	sum(case when (TRUNC(SENT_DATE) - TRUNC(REQUEST_DATE)) <=3 then 1 else 0 end) AS PROCESSED_TIMELY_COUNT,
	sum(case when (TRUNC(SENT_DATE) - TRUNC(REQUEST_DATE)) >3 then 1 else 0 end) AS PROCESSED_UNTIMELY_COUNT
FROM D_PL_CURRENT_SV 
  	WHERE SENT_DATE IS NOT NULL
 	GROUP BY TRUNC(SENT_DATE), LETTER_TYPE)
  	GROUP BY D_DATE, LETTER_TYPE;

GRANT SELECT ON MAXDAT_SUPPORT.F_PL_BY_DATE_LET_TYP_SV TO MAXDAT_SUPPORT_READ_ONLY; 
GRANT SELECT ON MAXDAT_SUPPORT.F_PL_BY_DATE_LET_TYP_SV TO MAXDAT_REPORTS; 