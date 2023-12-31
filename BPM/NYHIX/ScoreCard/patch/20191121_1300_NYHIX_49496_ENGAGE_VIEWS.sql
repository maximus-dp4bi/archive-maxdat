CREATE OR REPLACE FORCE EDITIONABLE VIEW DP_SCORECARD.ENGAGE_ACTUALS_SV 
(EVALUATION_REFERENCE_ID, EVALUATION_REFERENCE, AGENT_ID, EVALUATOR_ID, 
SCORE_TOTAL, EVALUATION_DATE_TIME, EVALUATION_FORM, CALL_DATE, 
CREATE_BY, CREATE_DATETIME, LAST_UPDATE_DATE, LAST_UPDATED_BY, DELETED_FLAG, 
CUSTOMER_SERVICE_QC_SCORE, CONTENT_QC_SCORE) AS 
  SELECT 
	EVALUATION_REFERENCE_ID
	,EVALUATION_REFERENCE
	,AGENT_ID
	,EVALUATOR_ID
	,SCORE_TOTAL
	,EVALUATION_DATE_TIME 
	,EVALUATION_FORM
	,CALL_DATE
	,CREATE_BY
	,CREATE_DATETIME
	,LAST_UPDATE_DATE 
	,LAST_UPDATED_BY
	,DELETED_FLAG 
	,CUSTOMER_SERVICE_QC_SCORE
	,CONTENT_QC_SCORE
FROM ENGAGE_ACTUALS 
WHERE DELETED_FLAG != 'Y'
OR DELETED_FLAG IS NULL
WITH READ ONLY;

GRANT SELECT ON DP_SCORECARD.ENGAGE_ACTUALS_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.ENGAGE_ACTUALS_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.ENGAGE_ACTUALS_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.ENGAGE_ACTUALS_SV TO DP_SCORECARD_READ_ONLY;

		
		

CREATE OR REPLACE FORCE EDITIONABLE VIEW DP_SCORECARD.SCORECARD_QUALITY_SV 
(STAFF_STAFF_ID, STAFF_STAFF_NAME, STAFF_NATID, SCORECARD_SCORE_TYPE, SCORE_TOTAL, 
EVAL_DATE, EVALUATION_REFERENCE, EVALUATOR_ID, EVALUATOR, EVALUATION_DATE_TIME, CALL_DATE, 
CUSTOMER_SERVICE_QC_SCORE, CONTENT_QC_SCORE) AS 
  SELECT -- Modified for NYSOH - Scorecard - CR 1662 - QC Table Update
	-- Modified for NYHIX-42454 CR 1822- Scorecard Quality tab Evaluation date
	S.STAFF_STAFF_ID,
	S.STAFF_STAFF_NAME,
	S.STAFF_NATID,
	F.SCORECARD_SCORE_TYPE,
	E.SCORE_TOTAL,
	CASE 
		WHEN (E.CALL_DATE IS NULL
		OR E.CALL_DATE = TO_DATE('1/1/1753','MM/DD/YYYY'))
		THEN 
			E.EVALUATION_DATE_TIME
		ELSE 
			E.CALL_DATE 
	END 
		AS EVAL_DATE,
	E.EVALUATION_REFERENCE,
	E.EVALUATOR_ID,
	ST.LAST_NAME||', '||ST.FIRST_NAME 
		EVALUATOR,
	E.EVALUATION_DATE_TIME,
	E.CALL_DATE,
	CUSTOMER_SERVICE_QC_SCORE,
	CONTENT_QC_SCORE
FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV S
JOIN DP_SCORECARD.ENGAGE_ACTUALS_SV E
	ON S.STAFF_NATID = E.AGENT_ID
JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F
	ON E.EVALUATION_FORM = F.EVALUATION_FORM
LEFT JOIN 
	( SELECT DISTINCT NATIONAL_ID, LAST_NAME, FIRST_NAME
        FROM MAXDAT.PP_WFM_STAFF
        WHERE DELETE_DATE IS NULL
        AND (NATIONAL_ID, LAST_UPDATE_DT) IN 
			( SELECT NATIONAL_ID, MAX(LAST_UPDATE_DT)
            FROM MAXDAT.PP_WFM_STAFF
            WHERE DELETE_DATE IS NULL
            GROUP BY NATIONAL_ID ) ) ST
	ON ST.NATIONAL_ID = E.EVALUATOR_ID
WHERE F.SCORECARD_SCORE_TYPE = 'QC'
--AND TRUNC(EVALUATION_DATE_TIME) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
AND CASE 
	WHEN (E.CALL_DATE IS NULL
		OR E.CALL_DATE = TO_DATE('1/1/1753','MM/DD/YYYY'))
		THEN 
			E.EVALUATION_DATE_TIME
		ELSE 
			E.CALL_DATE 
		END >= 
			TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM');

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_SV TO DP_SCORECARD_READ_ONLY;
			

CREATE OR REPLACE FORCE EDITIONABLE VIEW DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV 
  (STAFF_STAFF_ID, STAFF_STAFF_NAME, STAFF_NATID, DATES_MONTH_NUM, DATES_YEAR, 
  AVG_QC_SCORE, QCS_PERFORMED, AUDITS, AUDITS_SUP_EVALED, QC_SCORE, SUP_SCORE, DEVIATION_SCORE, 
  QC_EVALS, QC_EVALS_SCORE, DISPUTES, NON_DISPUTE_SCORE, 
  CUSTOMER_SERVICE_QC_SCORE_TOTAL, CUSTOMER_SERVICE_QC_SCORE_COUNT, AVG_CUSTOMER_SERVICE_QC_SCORE, 
  CONTENT_QC_SCORE_TOTAL, CONTENT_QC_SCORE_COUNT, AVG_CONTENT_QC_SCORE
  ) AS 
  WITH JUST_MONTHS AS
	(
	SELECT
		TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*LEVEL -1), 'MM/DD/YYYY') AS DATES,
		TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*LEVEL -1), 'MONTH') AS DATES_MONTH,
		TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*LEVEL -1), 'YYYYMM') AS DATES_MONTH_NUM,
		TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*LEVEL -1), 'MONTH YYYY') AS DATES_YEAR,
		0 	AS 	AVG_QC_SCORE,
		0  	AS 	QCS_PERFORMED,
        0 	AS	CUSTOMER_SERVICE_QC_SCORE_TOTAL,  	-- Numerator
        0	AS	CUSTOMER_SERVICE_QC_SCORE_COUNT,		-- Denominator
		0	AS	AVG_CUSTOMER_SERVICE_QC_SCORE,
        0	AS CONTENT_QC_SCORE_TOTAL,			-- Numerator
        0	AS	CONTENT_QC_SCORE_COUNT,			-- Denominator
		0	AS	AVG_CONTENT_QC_SCORE
	FROM DUAL
		CONNECT BY LEVEL <= MONTHS_BETWEEN(TRUNC(SYSDATE), TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM')) + 1
	),
QUALITY_BY_MONTH AS
	(
	SELECT DISTINCT STAFF_STAFF_ID,
		STAFF_STAFF_NAME,
		STAFF_NATID,
		TO_CHAR(TRUNC(EVAL_DATE), 'YYYYMM') 	AS DATES_MONTH_NUM,
		TO_CHAR(TRUNC(EVAL_DATE), 'MONTH YYYY') AS DATES_YEAR,
		AVG(SCORE_TOTAL) 						AS AVG_QC_SCORE,	
		COUNT(*)  								AS QCS_PERFORMED, 
        --
        SUM(CUSTOMER_SERVICE_QC_SCORE)          				AS CUSTOMER_SERVICE_QC_SCORE_TOTAL,  -- Numerator
        SUM(CASE WHEN CUSTOMER_SERVICE_QC_SCORE IS NOT NULL 
			THEN 1 ELSE 0 END) 									AS CUSTOMER_SERVICE_QC_SCORE_COUNT, -- Denominator
        AVG(CUSTOMER_SERVICE_QC_SCORE)							AS AVG_CUSTOMER_SERVICE_QC_SCORE,
        --
        SUM(CONTENT_QC_SCORE)                   				AS CONTENT_QC_SCORE_TOTAL,			-- Numerator
        SUM( CASE WHEN CONTENT_QC_SCORE IS NOT NULL 
		THEN 1 ELSE 0 END )  									AS CONTENT_QC_SCORE_COUNT,			-- Denominator
		AVG(CONTENT_QC_SCORE)									AS AVG_CONTENT_QC_SCORE
	FROM DP_SCORECARD.SCORECARD_QUALITY_SV
	GROUP BY STAFF_STAFF_ID, STAFF_NATID, STAFF_STAFF_NAME, TO_CHAR(TRUNC(EVAL_DATE), 'YYYYMM'), TO_CHAR(TRUNC(EVAL_DATE), 'MONTH YYYY')
	),
COMBINED AS
	(
	SELECT 
		R.STAFF_STAFF_ID,
        R.STAFF_STAFF_NAME,
        R.STAFF_NATID,
        R.DATES_MONTH_NUM,
        R.DATES_YEAR,
        R.AVG_QC_SCORE,
        R.QCS_PERFORMED,
        R.CUSTOMER_SERVICE_QC_SCORE_TOTAL,  -- Numerator
        R.CUSTOMER_SERVICE_QC_SCORE_COUNT, -- Denominator
		R.AVG_CUSTOMER_SERVICE_QC_SCORE,
        R.CONTENT_QC_SCORE_TOTAL,			-- Numerator
        R.CONTENT_QC_SCORE_COUNT,			-- Denominator
		R.AVG_CONTENT_QC_SCORE
    FROM QUALITY_BY_MONTH R
	UNION
	SELECT 
		H.STAFF_STAFF_ID,
        H.STAFF_STAFF_NAME,
        H.STAFF_NATID,
        JM.DATES_MONTH_NUM,
        JM.DATES_YEAR,
        JM.AVG_QC_SCORE,
        JM.QCS_PERFORMED,
        JM.CUSTOMER_SERVICE_QC_SCORE_TOTAL,  -- Numerator
        JM.CUSTOMER_SERVICE_QC_SCORE_COUNT, -- Denominator
		JM.AVG_CUSTOMER_SERVICE_QC_SCORE,
        JM.CONTENT_QC_SCORE_TOTAL,			-- Numerator
        JM.CONTENT_QC_SCORE_COUNT,			-- Denominator
		JM.AVG_CONTENT_QC_SCORE
    --   FROM QUALITY_BY_MONTH R, JUST_MONTHS JM
    FROM 
		DP_SCORECARD.SCORECARD_HIERARCHY H, 
		JUST_MONTHS JM
    WHERE JM.DATES_MONTH_NUM BETWEEN TO_CHAR(H.HIRE_DATE,'YYYYMM') AND TO_CHAR(NVL(H.TERMINATION_DATE,SYSDATE),'YYYYMM')
	),
RANKED AS
	(
	SELECT 
		STAFF_STAFF_ID,
        STAFF_STAFF_NAME,
        STAFF_NATID,
        DATES_MONTH_NUM,
        DATES_YEAR,
        SUM( AVG_QC_SCORE) 						AS AVG_QC_SCORE,
        SUM( QCS_PERFORMED) 					AS QCS_PERFORMED,
        SUM(CUSTOMER_SERVICE_QC_SCORE_TOTAL)	AS CUSTOMER_SERVICE_QC_SCORE_TOTAL,  	-- Numerator
        SUM(CUSTOMER_SERVICE_QC_SCORE_COUNT) 	AS CUSTOMER_SERVICE_QC_SCORE_COUNT,		-- Denominator
		SUM(AVG_CUSTOMER_SERVICE_QC_SCORE)		AS AVG_CUSTOMER_SERVICE_QC_SCORE,
        SUM(CONTENT_QC_SCORE_TOTAL)				AS CONTENT_QC_SCORE_TOTAL,			-- Numerator
        SUM(CONTENT_QC_SCORE_COUNT)				AS CONTENT_QC_SCORE_COUNT,			-- Denominator
		SUM(AVG_CONTENT_QC_SCORE)				AS AVG_CONTENT_QC_SCORE
    FROM COMBINED 
	GROUP BY STAFF_STAFF_ID, STAFF_NATID, STAFF_STAFF_NAME, DATES_YEAR, DATES_MONTH_NUM 
	--ORDER BY STAFF_STAFF_ID, DATES_MONTH_NUM
	),
RANK_FILTER AS
	(
	SELECT 
		STAFF_STAFF_ID,
        STAFF_STAFF_NAME,
        STAFF_NATID,
        DATES_MONTH_NUM,
        DATES_YEAR,
        AVG_QC_SCORE,
        QCS_PERFORMED,
        CUSTOMER_SERVICE_QC_SCORE_TOTAL,  	-- Numerator
        CUSTOMER_SERVICE_QC_SCORE_COUNT,	-- Denominator
		AVG_CUSTOMER_SERVICE_QC_SCORE,
		CONTENT_QC_SCORE_TOTAL, 			-- Numerator
		CONTENT_QC_SCORE_COUNT,				-- Denominator
		AVG_CONTENT_QC_SCORE
    FROM RANKED --WHERE RNK=1
	), 
ALL_COLUMNS AS
	(
	SELECT
		H.STAFF_STAFF_ID,
		H.STAFF_NATID,
		H.STAFF_STAFF_NAME STAFF,
		F.SCORECARD_SCORE_TYPE,  ---THIS IS JUST THERE FOR TESTING PURPOSE
		CASE WHEN A.CALL_DATE IS NULL 
			THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') 
			ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') 
			END AS EVAL_MONTH, --ADD
		--TRUNC(TO_DATE(A.EVALUATION_DATE_TIME),'MONTH') EVAL_MONTH, -- REMOVE
		COUNT(DISTINCT A.EVALUATION_REFERENCE) AUDITS,
		COUNT(DISTINCT A1.EVALUATION_REFERENCE) AUDITS_SUP_EVALED, --CHANGE
		ROUND(AVG(A1.SCORE_TOTAL),2) QC_SCORE,
		--COUNT(DISTINCT S.EVALUATION_REFERENCE) SUP_AUDITS,--REMOVE
		ROUND(AVG(S.SCORE_TOTAL),2) SUP_SCORE,
		ROUND(AVG(S.SCORE_TOTAL),2) - ROUND(AVG(A1.SCORE_TOTAL),2) DEVIATION_SCORE,
		E.QC_EVALS,
		E.QC_EVALS_SCORE,
		X.QC_DISPUTES DISPUTES, --CHANGE
		ROUND(((COUNT(DISTINCT A.EVALUATION_REFERENCE)- X.QC_DISPUTES)/(COUNT(DISTINCT A.EVALUATION_REFERENCE))),2) NON_DISPUTE_SCORE
	FROM DP_SCORECARD.ENGAGE_ACTUALS_SV A
	JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F 
		ON A.EVALUATION_FORM = F.EVALUATION_FORM -- CHANGE
	JOIN DP_SCORECARD.SCORECARD_HIERARCHY H 
		ON A.EVALUATOR_ID = H.STAFF_NATID                    --<<<<< EVALUATOR
	LEFT JOIN DP_SCORECARD.ENGAGE_ACTUALS_SUP S 
		ON A.EVALUATION_REFERENCE = S.QC_EVALUATION_ID --CHANGEXX
	LEFT JOIN DP_SCORECARD.ENGAGE_ACTUALS_SV A1 
		ON A1.EVALUATION_REFERENCE = S.QC_EVALUATION_ID --CHANGEXX
	LEFT JOIN 
		(
		SELECT 
			TO_CHAR(EVALUATION_DATE_TIME,'YYYYMM') QC_MONTH,
			AGENT_ID,
			COUNT(EVALUATION_REFERENCE) QC_EVALS,
			ROUND(AVG(SCORE_TOTAL),2) QC_EVALS_SCORE
			FROM DP_SCORECARD.ENGAGE_ACTUALS_QC_EVAL
			GROUP BY TO_CHAR(EVALUATION_DATE_TIME,'YYYYMM'), AGENT_ID
		) E
			ON (A.EVALUATOR_ID = E.AGENT_ID 
			AND 
				CASE 
					WHEN A.CALL_DATE IS NULL 
						THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') 
					ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') 
				END = E.QC_MONTH) --CHANGEXX
	LEFT JOIN 
		(
		SELECT 
			TO_CHAR(PT_ENTRY_DATE,'YYYYMM') ENTRY_DATE,
			H.STAFF_NATID,
			COUNT(PT_ID) QC_DISPUTES
		FROM DP_SCORECARD.SC_PERFORMANCE_TRACKER T
		LEFT JOIN DP_SCORECARD.SCORECARD_HIERARCHY H 
			ON T.STAFF_ID = H.STAFF_STAFF_ID
		LEFT JOIN DP_SCORECARD.SC_DISCUSSION_LKUP L 
			ON L.DL_ID = T.DL_ID
		WHERE L.DISCUSSION_TOPIC = 'QC DISPUTE'
		GROUP BY TO_CHAR(PT_ENTRY_DATE,'YYYYMM'), H.STAFF_NATID
		) X
		ON (X.STAFF_NATID = A.EVALUATOR_ID 
		AND CASE 
			WHEN A.CALL_DATE IS NULL 
				THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') 
				ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') 
			END = X.ENTRY_DATE)  --CHANGE XX
	WHERE 1=1
	AND F.SCORECARD_SCORE_TYPE = 'QC'
	GROUP BY 
		H.STAFF_STAFF_ID,
		H.STAFF_NATID,
		H.STAFF_STAFF_NAME,
		F.SCORECARD_SCORE_TYPE,
		CASE WHEN A.CALL_DATE IS NULL 
			THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') 
			ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') 
			END, --ADD
		E.QC_EVALS,
		E.QC_EVALS_SCORE,
		X.QC_DISPUTES
	),
ALL_COLUMNS2 AS
	(
	SELECT
		STAFF_STAFF_ID,
		STAFF_NATID,
		SCORECARD_SCORE_TYPE,  ---THIS IS JUST THERE FOR TESTING PURPOSE
		EVAL_MONTH AS DATES_MONTH_NUM ,
		AUDITS,
		AUDITS_SUP_EVALED, --CHANGE
		QC_SCORE,
		SUP_SCORE,
		DEVIATION_SCORE,
		QC_EVALS,
		QC_EVALS_SCORE,
		DISPUTES, --CHANGE
		NON_DISPUTE_SCORE
	FROM ALL_COLUMNS
	),
FINAL_QRY AS 
	(  
	SELECT 
		R.STAFF_STAFF_ID,
        R.STAFF_STAFF_NAME,
        TO_NUMBER(GET_NUMERIC(R.STAFF_NATID)) AS STAFF_NATID,
        R.DATES_MONTH_NUM,
        R.DATES_YEAR,
        R.AVG_QC_SCORE,
        R.QCS_PERFORMED,
        R.CUSTOMER_SERVICE_QC_SCORE_TOTAL,  	-- Numerator
        R.CUSTOMER_SERVICE_QC_SCORE_COUNT,		-- Denominator
		R.AVG_CUSTOMER_SERVICE_QC_SCORE,
		R.CONTENT_QC_SCORE_TOTAL, 				-- Numerator
		R.CONTENT_QC_SCORE_COUNT,				-- Denominator
		R.AVG_CONTENT_QC_SCORE,
        AC.AUDITS, --NEW
        AC.AUDITS_SUP_EVALED, --NEW
        AC.QC_SCORE, --NEW
        AC.SUP_SCORE, --SAME
        AC.DEVIATION_SCORE, --SAME
        AC.QC_EVALS, --SAME
        AC.QC_EVALS_SCORE, --SAME
        AC.DISPUTES, --NEW
        AC.NON_DISPUTE_SCORE --SAME
        --NON_DISPUTES  --DELETED
    FROM RANK_FILTER R
    FULL OUTER JOIN ALL_COLUMNS2 AC 
		ON R.STAFF_STAFF_ID=AC.STAFF_STAFF_ID 
		AND R.DATES_MONTH_NUM=AC.DATES_MONTH_NUM
    )  
SELECT STAFF_STAFF_ID,STAFF_STAFF_NAME,STAFF_NATID,DATES_MONTH_NUM,DATES_YEAR,
	AVG_QC_SCORE,
    QCS_PERFORMED,
    AUDITS,AUDITS_SUP_EVALED,QC_SCORE,SUP_SCORE,DEVIATION_SCORE,
	QC_EVALS,QC_EVALS_SCORE,DISPUTES,NON_DISPUTE_SCORE,
    CUSTOMER_SERVICE_QC_SCORE_TOTAL,  	-- Numerator
    CUSTOMER_SERVICE_QC_SCORE_COUNT,	-- Denominator
	AVG_CUSTOMER_SERVICE_QC_SCORE,
	CONTENT_QC_SCORE_TOTAL, 			-- Numerator
	CONTENT_QC_SCORE_COUNT,				-- Denominator
	AVG_CONTENT_QC_SCORE
FROM FINAL_QRY
WHERE STAFF_STAFF_ID IS NOT NULL
AND DATES_MONTH_NUM IS NOT NULL;

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUALITY_MTHLY_SV TO DP_SCORECARD_READ_ONLY;
			

