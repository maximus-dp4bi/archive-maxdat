create or replace view PUBLIC.MIO_D_CVIU_EXPARTE_RENWAL_REPORT_SV(
	REPORTING_MONTH,
	COUNTY,
	FILENAME,
	CASE_NUMBER,
	CLIENT_NAME,
	PRIMARY_WORKER_ID,
	AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED,
	RENEWAL_SUCCESSFUL,
	EXCEPTION_REASON,
	EX_PARTE_PROCESS,
	AID_CATEGORY_PRIOR_TO_EX_PARTE,
	CURRENT_RENEWAL_DATE,
	NEW_RENEWAL_DATE,
	DISPOSITION,
	UNIT,
	CASE_TYPE,
	"EX PARTE SCHEDULED",
	"PASSED EX PARTE",
	"FAILED EX PARTE",
	"NON - ATTEMPT EX PARTE",
	"FAILED / NON - ATTEMPT EX PARTE CASES ASSIGNED TO LDSS",
	"FAILED / NON - ATTEMPT EX PARTE CASES ASSIGNED TO CVA",
	"TOTAL RENEWALS TO BE PROCESSED",
	"TOTAL RENEWALS DETERMINED",
	"TOTAL RENEWALS PENDING DETERMINATION",
    exparte_attempted,
    packet_sent_notsent,
    count_successful,
    count_unsuccessful,
    count_blank,
    count_packet_sent_successful,
    count_packet_sent_unsuccessful,
    count_packet_sent_blank,
    count_packet_not_sent_successful,
    count_packet_not_sent_unsuccessful,
    count_packet_not_sent_blank,
    reporting_month_date
) COPY GRANTS as
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
UNION ALL
SELECT county,
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
QUALIFY ROW_NUMBER() OVER(PARTITION BY case_number ORDER BY exparte_data_id) = 1
)

SELECT DISTINCT TO_CHAR(CONCAT (MONTHNAME(FL.FILE_DATE),'-',YEAR(FL.FILE_DATE))) AS REPORTING_MONTH
,COUNTY AS COUNTY
,EX.FILENAME AS FILENAME
,EX.CASE_NUMBER AS CASE_NUMBER
,CLIENT_NAME AS CLIENT_NAME
,PRIMARY_WORKER_ID AS PRIMARY_WORKER_ID
,AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED AS AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED
,RENEWAL_SUCCESSFUL
,EXCEPTION_REASON
,EX_PARTE_PROCESS
,AID_CATEGORY_PRIOR_TO_EX_PARTE
,CURRENT_RENEWAL_DATE
,NEW_RENEWAL_DATE
,task_status DISPOSITION
,UNIT
,CASE_TYPE
,CASE WHEN (AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED IN ('F','N','Y')) AND (AID_CATEGORY_PRIOR_TO_EX_PARTE IN (108,109))
OR (AID_CATEGORY_PRIOR_TO_EX_PARTE IN (112,113) AND CONTAINS (PRIMARY_WORKER_ID,'900')) THEN 1 ELSE 0 END AS "EX PARTE SCHEDULED"

,CASE WHEN (AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED = 'Y') AND (RENEWAL_SUCCESSFUL = 'Y') AND (AID_CATEGORY_PRIOR_TO_EX_PARTE IN (108,109) OR 
(AID_CATEGORY_PRIOR_TO_EX_PARTE IN (112,113)AND CONTAINS (PRIMARY_WORKER_ID,'900'))) THEN 1 ELSE 0 END AS "PASSED EX PARTE"

,CASE WHEN (AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED = 'Y') AND (RENEWAL_SUCCESSFUL = 'N') AND (AID_CATEGORY_PRIOR_TO_EX_PARTE IN (108,109) OR 
(AID_CATEGORY_PRIOR_TO_EX_PARTE IN (112,113)AND CONTAINS (PRIMARY_WORKER_ID,'900'))) THEN 1 ELSE 0 END AS "FAILED EX PARTE"

,CASE WHEN (AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED IN ('F','N')) AND  COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ' AND (AID_CATEGORY_PRIOR_TO_EX_PARTE IN (108,109) OR 
(AID_CATEGORY_PRIOR_TO_EX_PARTE IN (112,113)AND CONTAINS (PRIMARY_WORKER_ID,'900'))) THEN 1 ELSE 0 END AS "NON-ATTEMPT EX PARTE"

,CASE WHEN (AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED IN ('F','N','Y')) AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ') AND (AID_CATEGORY_PRIOR_TO_EX_PARTE IN (108,109)
AND NOT CONTAINS (PRIMARY_WORKER_ID,'900')) THEN 1 ELSE 0 END AS "FAILED/NON-ATTEMPT EX PARTE CASES ASSIGNED TO LDSS"

,CASE WHEN (AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED IN ('F','N','Y')) AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ')
AND (AID_CATEGORY_PRIOR_TO_EX_PARTE IN (108,109,112,113) AND CONTAINS (PRIMARY_WORKER_ID,'900')) THEN 1 ELSE 0 END AS "FAILED/NON-ATTEMPT EX PARTE CASES ASSIGNED TO CVA"

,CASE WHEN (AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED IN ('F','N','Y')) AND (RENEWAL_SUCCESSFUL IN ('N') OR COALESCE(RENEWAL_SUCCESSFUL,' ') = ' ')
AND (AID_CATEGORY_PRIOR_TO_EX_PARTE IN (108,109,112,113) AND CONTAINS (PRIMARY_WORKER_ID,'900')) THEN 1 ELSE 0 END AS "TOTAL RENEWALS TO BE PROCESSED"

,CASE WHEN (AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED IN ('F','N','Y')) AND (COALESCE(RENEWAL_SUCCESSFUL,'N') = 'N') AND AID_CATEGORY_PRIOR_TO_EX_PARTE IN (108,109,112,113) AND CONTAINS (PRIMARY_WORKER_ID,'900')
   AND RIVA.TASK_STATUS IN ('Approved','Denied','ABD Approved', 'Cancelled Coverage', 'Coverage Reinstated', 'Ex Parte', 'Manual Ex Parte','Non Ex Parte Approval', 'Transferred to LDSS',
                                'Research Completed No Action Taken','Research Complete No Action Taken','Changes Completed')
   THEN 1 ELSE 0 END AS "TOTAL RENEWALS DETERMINED"
,CASE WHEN (AUTOMATED_EX_PARTE_RENEWAL_ATTEMPTED IN ('F','N','Y')) AND (COALESCE(RENEWAL_SUCCESSFUL,'N') = 'N') AND (AID_CATEGORY_PRIOR_TO_EX_PARTE IN (108,109,112,113) AND CONTAINS (PRIMARY_WORKER_ID,'900'))
AND (RIVA.TASK_STATUS NOT IN ('Approved','Denied','ABD Approved', 'Cancelled Coverage', 'Coverage Reinstated', 'Ex Parte', 'Manual Ex Parte','Non Ex Parte Approval', 'Transferred to LDSS',
      'Research Completed No Action Taken','Research Complete No Action Taken','Changes Completed') 
  OR RIVA.TASK_STATUS IS NULL) THEN 1 ELSE 0 END AS "TOTAL RENEWALS PENDING DETERMINATION"
,CASE WHEN automated_ex_parte_renewal_attempted = 'F' THEN 'Failed'
      WHEN automated_ex_parte_renewal_attempted = 'Y' THEN 'Attempted'
   ELSE 'Not Attempted' END exparte_attempted
,CASE WHEN automated_renewal_packet_generation = 'Y' THEN 'Packet Sent' ELSE 'Packet Not Sent' END packet_sent_notsent
,CASE WHEN renewal_successful = 'Y' THEN 1 ELSE 0 END count_successful
,CASE WHEN renewal_successful = 'N' THEN 1 ELSE 0 END count_unsuccessful
,CASE WHEN COALESCE(renewal_successful,' ') = ' ' THEN 1 ELSE 0 END count_blank
,CASE WHEN renewal_successful = 'Y' AND automated_renewal_packet_generation = 'Y' THEN 1 ELSE 0 END count_packet_sent_successful
,CASE WHEN renewal_successful = 'N' AND automated_renewal_packet_generation = 'Y' THEN 1 ELSE 0 END count_packet_sent_unsuccessful
,CASE WHEN COALESCE(renewal_successful,' ') = ' ' AND automated_renewal_packet_generation = 'Y' THEN 1 ELSE 0 END count_packet_sent_blank
,CASE WHEN renewal_successful = 'Y' AND automated_renewal_packet_generation IS NULL THEN 1 ELSE 0 END count_packet_not_sent_successful
,CASE WHEN renewal_successful = 'N' AND automated_renewal_packet_generation IS NULL THEN 1 ELSE 0 END count_packet_not_sent_unsuccessful
,CASE WHEN COALESCE(renewal_successful,' ') = ' ' AND automated_renewal_packet_generation IS NULL THEN 1 ELSE 0 END count_packet_not_sent_blank
,DATE_TRUNC('MONTH',FL.FILE_DATE) reporting_month_date
FROM EX
 JOIN COVERVA_DMAS.DMAS_FILE_LOG FL ON UPPER(EX.FILENAME) = UPPER(FL.FILENAME)
--LEFT JOIN COVERVA_MIO.rpt_cviu_renewals RE ON EX.CASE_NUMBER = RE.CASE_NUMBER
LEFT JOIN (
SELECT CASE_NUMBER
,TASK_STATUS
,CASE_TYPE
,UNIT
,DATE_DISPOSITIONED
FROM (SELECT case_number,id,case_type,unit,date_dispositioned,
        CASE WHEN regexp_instr(disposition,'--',1,1) = 0 THEN disposition ELSE SUBSTR(disposition,1,regexp_instr(disposition,'--',1,1)-1)  END task_status
       FROM coverva_mio.rpt_riva
      WHERE case_type != 'QA'
     AND TASK_STATUS IN ('ABD Approved', 'Cancelled Coverage', 'Coverage Reinstated', 'Ex Parte', 'Manual Ex Parte','Non Ex Parte Approval', 'Transferred to LDSS',
              'ABD Mailed','Other','Other Transfer','Pending','Pending Closure','Sent Manual Renewal Packet','Approved','Denied','Research Completed No Action Taken',
              'Research Complete No Action Taken','Changes Completed')  ) cp
QUALIFY ROW_NUMBER() OVER (PARTITION BY cp.case_number ORDER BY id DESC) = 1
) RIVA ON EX.CASE_NUMBER = RIVA.CASE_NUMBER AND CAST(RIVA.DATE_DISPOSITIONED AS DATE) >= CAST(FL.FILE_DATE AS DATE);