CREATE OR REPLACE VIEW PUBLIC.MIO_D_CVIU_RENEWAL_OUTCOMES_REPORT_SV (
DISPOSITION_DATE,
RENEWAL_DATE,
CASE_NUMBER,
DISPOSITION,
WHY,
PRIOR_DISPOSITION,
PRIOR_WHY,
RENEWAL_SUCCESSFUL
,AID_CATEGORY_PRIOR_TO_EX_PARTE
,PRIMARY_WORKER_ID
,"TOTAL RENEWALS",
"EX PARTE APPROVAL",
"ABD APPROVAL",
"MANUAL EX PARTE",
"CANCELLED COVERAGE",
"COVERAGE REINSTATED",
"PENDING REVIEW",
"PENDING CLOSURE",
"ABD MAILED",
"ABD RECEIVED",
"VCL SENT",
"SENT TO LDSS",
"RESEARCH COMPLETE NO ACTION TAKEN"
) COPY GRANTS AS 
WITH ex AS(
SELECT county,
filename,
case_number,
client_name,
primary_worker_id,
automated_ex_parte_renewal_attempted,
renewal_successful,
exception_reason,
ex_parte_process,
aid_category_prior_to_ex_parte,
aid_category_post_ex_parte,
automated_renewal_packet_generation,
current_renewal_date,
new_renewal_date
FROM COVERVA_DMAS.EXPARTE_RUN_FULL_LOAD
WHERE (aid_category_prior_to_ex_parte IN('108','109')
 OR (aid_category_prior_to_ex_parte IN('112','113') AND CONTAINS (PRIMARY_WORKER_ID,'900')) )
UNION ALL
SELECT *
FROM(SELECT county,
        filename,
        case_number,
        client_name,
        primary_worker_id,
        CASE WHEN case_entered_exparte_flow = 'Entered Ex Parte Flow' THEN 'Y' 
             WHEN case_entered_exparte_flow = 'Did not Enter Ex Parte Flow' THEN 'N'
         ELSE NULL END automated_ex_parte_renewal_attempted,
        CASE WHEN renewal_successful_for_case = 'Successful' THEN 'Y'
             WHEN renewal_successful_for_case = 'Unsuccessful' THEN 'N' 
         ELSE NULL END renewal_successful,
        exception_reason_for_case exception_reason,
        ex_parte_process,
        aid_category_prior_to_ex_parte,
        aid_category_post_ex_parte,
        automated_renewal_packet_gen_for_case automated_renewal_packet_generation,
        current_renewal_date,
        new_renewal_date
    FROM COVERVA_DMAS.EXPARTE_DATA_FULL_LOAD
    QUALIFY ROW_NUMBER() OVER(PARTITION BY case_number ORDER BY exparte_data_id) = 1)
WHERE (aid_category_prior_to_ex_parte IN('108','109')
 OR (aid_category_prior_to_ex_parte IN('112','113') AND CONTAINS (PRIMARY_WORKER_ID,'900')) )    
),
riva AS(
SELECT case_number,id,case_type,unit,date_dispositioned disposition_date,
        task_status disposition,
        why,
        LAG(task_status) OVER(PARTITION BY case_number ORDER BY date_dispositioned,id) prior_task_status,
        LAG(why) OVER(PARTITION BY case_number ORDER BY date_dispositioned,id) prior_why
       FROM coverva_mio.rpt_riva
      WHERE UPPER(case_type) NOT LIKE 'QA%'
QUALIFY ROW_NUMBER() OVER (PARTITION BY date_dispositioned,case_number ORDER BY id DESC) = 1 )
SELECT DISTINCT RE.DISPOSITION_DATE
,EX.CURRENT_RENEWAL_DATE  AS RENEWAL_DATE
,EX.CASE_NUMBER AS CASE_NUMBER 
,RE.DISPOSITION AS DISPOSITION
,RE.WHY AS WHY
,RE.prior_task_status AS PRIOR_DISPOSITION
,RE.prior_why AS PRIOR_WHY
,RENEWAL_SUCCESSFUL
,AID_CATEGORY_PRIOR_TO_EX_PARTE
,PRIMARY_WORKER_ID
,CASE WHEN (RENEWAL_SUCCESSFUL IN ('Y','N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ') THEN 1 ELSE 0 END AS "TOTAL RENEWALS"
,CASE WHEN RENEWAL_SUCCESSFUL IN ('Y') THEN 1 ELSE 0 END AS "EX PARTE APPROVAL"
,CASE WHEN DISPOSITION = 'ABD Approved' AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ') THEN 1 ELSE 0 END "ABD APPROVAL"
,CASE WHEN DISPOSITION IN('Manual Ex Parte','Non-Ex Parte Approved') AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ')  THEN 1 ELSE 0 END "MANUAL EX PARTE"
,CASE WHEN DISPOSITION = 'Cancelled Coverage' AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ')  THEN 1 ELSE 0 END "CANCELLED COVERAGE"
,CASE WHEN DISPOSITION = 'Coverage Reinstated' AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ') THEN 1 ELSE 0 END "COVERAGE REINSTATED"
,CASE WHEN (DISPOSITION = '' OR DISPOSITION IS NULL) AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ')  THEN 1 ELSE 0 END "PENDING REVIEW"
,CASE WHEN DISPOSITION = 'Pending Closure' AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ')  THEN 1 ELSE 0 END "PENDING CLOSURE"
,CASE WHEN DISPOSITION = 'ABD Mailed' AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ')  THEN 1 ELSE 0 END "ABD MAILED"
,CASE WHEN (RE.prior_task_status ='ABD Mailed' AND DISPOSITION IN ('ABD Approved','VCL Sent','Non-Ex Parte Approved','Coverage Reinstated')) AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ')  THEN 1 ELSE 0 END "ABD RECEIVED"
,CASE WHEN ( (DISPOSITION = 'Pending' AND RE.WHY IN ('2nd VCL Needed','Auto VCL','Manual VCL'))
    OR (DISPOSITION = 'Sent Manual Renewal Packet') 
    OR (DISPOSITION = 'Continued Pending' AND ((RE.prior_task_status = 'Pending' AND RE.prior_why IN ('2nd VCL Needed','Auto VCL','Manual VCL')) OR RE.prior_task_status = 'Sent Manual Renewal Packet') ) ) 
  THEN 1 ELSE 0 END AS "VCL SENT"
,CASE WHEN DISPOSITION IN ('Transferred to LDSS') AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ') THEN 1 ELSE 0 END "SENT TO LDSS"
,CASE WHEN DISPOSITION IN ('Research Complete No Action Taken','Research Completed No Action Taken') AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ')  THEN 1 ELSE 0 END "RESEARCH COMPLETE NO ACTION TAKEN"
FROM EX
LEFT JOIN riva RE ON EX.CASE_NUMBER = RE.CASE_NUMBER
--WHERE RE.case_type = 'R'
--AND RE.unit = 'CVIU'
;
