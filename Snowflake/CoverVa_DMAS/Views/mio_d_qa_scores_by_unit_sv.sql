create or replace view MARS_DP4BI_PROD.PUBLIC.MIO_D_QA_SCORES_BY_UNIT_SV(
	SCORECARD_TYPE,
	EW_CASE_UNIT,
	CASE_TYPE,
	CARDTYPE,
	DECISION_DATE,
	MONTH_NAME,
	QA_PERCENTAGE,
	CASE_IDENTIFIER,
	QA_STATUS,
	QA_COMPLETE,
	DECISION_REASON,
	REPORT_TYPE,
	CPU_AUDIT,
	CPU_SCORE,
	CPU_SCORE_AUDIT,
	CPU_NESTING_AUDIT,
	CPU_NESTING_SCORE,
	CPU_NESTING_SCORE_AUDIT,
	CPU_RENEWAL_AUDIT,
	CPU_RENEWAL_SCORE,
	CPU_RENEWAL_SCORE_AUDIT,
	CPU_RENEWAL_NESTING_AUDIT,
	CPU_RENEWAL_NESTING_SCORE,
	CPU_RENEWAL_NESTING_SCORE_AUDIT,
	CVIU_E_AUDIT,
	CVIU_E_SCORE,
	CVIU_E_SCORE_AUDIT,
	CVIU_E_NESTING_AUDIT,
	CVIU_E_NESTING_SCORE,
	CVIU_E_NESTING_SCORE_AUDIT,
	CVIU_E_RENEWAL_AUDIT,
	CVIU_E_RENEWAL_SCORE,
	CVIU_E_RENEWAL_SCORE_AUDIT,
	CVIU_E_RENEWAL_NESTING_AUDIT,
	CVIU_E_RENEWAL_NESTING_SCORE,
	CVIU_E_RENEWAL_NESTING_SCORE_AUDIT,
	ALTERNATIVE_CASE_NUMBER,
	QA_STATUS_DATE_EST,
	POSSIBLE_POINTS
, MISSED_POINTS
) as
SELECT DISTINCT
INF.SCORECARD_TYPE AS SCORECARD_TYPE
,EW_CASE_UNIT AS EW_CASE_UNIT
,CASE_TYPE AS CASE_TYPE
,CARDTYPE AS CARDTYPE
,INF.DECISION_DATE AS DECISION_DATE
,CONCAT(MONTHNAME(DECISION_DATE),'-',YEAR(DECISION_DATE)) AS MONTH_NAME
,INF.QA_PERCENTAGE AS QA_PERCENTAGE
,INF.CASE_IDENTIFIER AS CASE_IDENTIFIER
,INF.QA_STATUS AS QA_STATUS
,QA_COMPLETE AS QA_COMPLETE
,DECISION_REASON AS DECISION_REASON
,CASE WHEN INF.SCORECARD_TYPE='CPU' AND CardType IN ('Production', 'Nesting 1', 'Nesting 2') THEN 'CPU'
 WHEN INF.SCORECARD_TYPE='CPU' AND CardType IN ('Nesting 1', 'Nesting 2') THEN 'CPU Nesting'
 WHEN INF.SCORECARD_TYPE='CPU Renewal' AND CardType IN ('Production', 'Nesting 1', 'Nesting 2') THEN 'CPU Renewal'
 WHEN INF.SCORECARD_TYPE='CPU Renewal' AND CardType IN ('Nesting 1', 'Nesting 2') THEN 'CPU Renewal Nesting'
 WHEN INF.SCORECARD_TYPE='CVIU Eligibility' AND CardType IN ('Production', 'Nesting 1', 'Nesting 2') THEN 'CVIU E'
 WHEN INF.SCORECARD_TYPE='CVIU Eligibility' AND CardType IN ('Nesting 1', 'Nesting 2') THEN 'CVIU E Nesting'
 WHEN INF.SCORECARD_TYPE='CVIU Renewal' AND CardType IN ('Production', 'Nesting 1', 'Nesting 2') THEN 'CVIU E Renewal'
 WHEN INF.SCORECARD_TYPE='CVIU Renewal' AND CardType IN ('Nesting 1', 'Nesting 2') THEN 'CVIU E Renewal Nesting'
ELSE NULL END REPORT_TYPE
----CPU				
,CASE WHEN INF.SCORECARD_TYPE='CPU' AND CardType IN ('Production', 'Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CPU_AUDIT
,CASE WHEN INF.SCORECARD_TYPE='CPU' AND CardType IN ('Production')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then QA_PERCENTAGE else 0 END AS CPU_SCORE
,CASE WHEN INF.SCORECARD_TYPE='CPU' AND CardType IN ('Production')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CPU_SCORE_AUDIT
---CPU Nesting				
,CASE WHEN INF.SCORECARD_TYPE='CPU' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CPU_NESTING_AUDIT
,CASE WHEN INF.SCORECARD_TYPE='CPU' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then QA_PERCENTAGE else 0 END AS CPU_NESTING_SCORE
,CASE WHEN INF.SCORECARD_TYPE='CPU' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CPU_NESTING_SCORE_AUDIT
--CPU Renewal				
,CASE WHEN INF.SCORECARD_TYPE='CPU Renewal' AND CardType IN ('Production', 'Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CPU_RENEWAL_AUDIT
,CASE WHEN INF.SCORECARD_TYPE='CPU Renewal' AND CardType IN ('Production')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then QA_PERCENTAGE else 0 END AS CPU_RENEWAL_SCORE
,CASE WHEN INF.SCORECARD_TYPE='CPU Renewal' AND CardType IN ('Production')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CPU_RENEWAL_SCORE_AUDIT
--CPU Renewal Nesting
,CASE WHEN INF.SCORECARD_TYPE='CPU Renewal' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CPU_RENEWAL_NESTING_AUDIT
,CASE WHEN INF.SCORECARD_TYPE='CPU Renewal' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then QA_PERCENTAGE else 0 END AS CPU_RENEWAL_NESTING_SCORE
,CASE WHEN INF.SCORECARD_TYPE='CPU Renewal' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CPU_RENEWAL_NESTING_SCORE_AUDIT
----CVIU E			
,CASE WHEN INF.SCORECARD_TYPE='CVIU Eligibility' AND CardType IN ('Production', 'Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CVIU_E_AUDIT
,CASE WHEN INF.SCORECARD_TYPE='CVIU Eligibility' AND CardType IN ('Production')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then QA_PERCENTAGE else 0 END AS CVIU_E_SCORE
,CASE WHEN INF.SCORECARD_TYPE='CVIU Eligibility' AND CardType IN ('Production')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CVIU_E_SCORE_AUDIT
---CVIU_E Nesting				
,CASE WHEN INF.SCORECARD_TYPE='CVIU Eligibility' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CVIU_E_NESTING_AUDIT
,CASE WHEN INF.SCORECARD_TYPE='CVIU Eligibility' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then QA_PERCENTAGE else 0 END AS CVIU_E_NESTING_SCORE
,CASE WHEN INF.SCORECARD_TYPE='CVIU Eligibility' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CVIU_E_NESTING_SCORE_AUDIT
--CVIU Renewal				
,CASE WHEN INF.SCORECARD_TYPE='CVIU Renewal' AND CardType IN ('Production', 'Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CVIU_E_RENEWAL_AUDIT
,CASE WHEN INF.SCORECARD_TYPE='CVIU Renewal' AND CardType IN ('Production')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then QA_PERCENTAGE else 0 END AS CVIU_E_RENEWAL_SCORE
,CASE WHEN INF.SCORECARD_TYPE='CVIU Renewal' AND CardType IN ('Production')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CVIU_E_RENEWAL_SCORE_AUDIT
--CVIU Renewal Nesting
,CASE WHEN INF.SCORECARD_TYPE='CVIU Renewal' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CVIU_E_RENEWAL_NESTING_AUDIT
,CASE WHEN INF.SCORECARD_TYPE='CVIU Renewal' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then QA_PERCENTAGE else 0 END AS CVIU_E_RENEWAL_NESTING_SCORE
,CASE WHEN INF.SCORECARD_TYPE='CVIU Renewal' AND CardType IN ('Nesting 1', 'Nesting 2')
And QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute') then 1 else 0 END AS CVIU_E_RENEWAL_NESTING_SCORE_AUDIT
,ALTERNATIVE_CASE_NUMBER AS ALTERNATIVE_CASE_NUMBER
,QA_STATUS_DATE_EST AS QA_STATUS_DATE_EST
,POINTS.POSSIBLE_POINTS AS POSSIBLE_POINTS
,POINTS.MISSED_POINTS AS MISSED_POINTS
FROM COVERVA_MIO.QA_INFO INF
JOIN COVERVA_MIO.QA_SCORES SC
ON INF.ID=SC.QA_INFO_ID
JOIN 
(
SELECT INF.SCORECARD_TYPE AS SCORECARD_TYPE 
,INF.CASE_IDENTIFIER AS CASE_IDENTIFIER
,sum(POSSIBLE_POINTS) AS POSSIBLE_POINTS
,sum(MISSED_POINTS) AS MISSED_POINTS
FROM  COVERVA_MIO.QA_INFO INF
JOIN COVERVA_MIO.QA_SCORES SC
ON INF.ID=SC.QA_INFO_ID
where INF.dmas_ic_submission='N'
AND SCORECARD_TYPE IN ('CPU','CPU Renewal','CVIU Eligibility','CVIU Renewal')
AND QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute')
AND CardType IN ('Production', 'Nesting 1', 'Nesting 2')
AND INF.DECISION_DATE BETWEEN DATE_TRUNC(month, DATEADD(year, -2, sysdate())) AND sysdate()
GROUP BY  SCORECARD_TYPE
,INF.CASE_IDENTIFIER) POINTS
ON INF.CASE_IDENTIFIER=POINTS.CASE_IDENTIFIER
where INF.dmas_ic_submission='N'
AND INF.SCORECARD_TYPE IN ('CPU','CPU Renewal','CVIU Eligibility','CVIU Renewal')
AND QA_STATUS in ('Initial Review Complete', 'Worker Review', 'Updated', 'Post DMAS Audit','Dispute')
AND CardType IN ('Production', 'Nesting 1', 'Nesting 2')
AND INF.DECISION_DATE BETWEEN DATE_TRUNC(month, DATEADD(year, -2, sysdate())) AND sysdate();
GRANT SELECT ON VIEW MARS_DP4BI_PROD.PUBLIC.MIO_D_QA_SCORES_BY_UNIT_SV TO DATA_SUPPORT_ROLE;