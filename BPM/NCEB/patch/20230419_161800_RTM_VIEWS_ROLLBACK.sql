DROP VIEW MAXDAT_SUPPORT.D_REQUEST_TO_MOVE_SV;
CREATE OR REPLACE VIEW D_REQUEST_TO_MOVE_SV AS
select
i.INCIDENT_HEADER_ID,
c.CLNT_CIN  as MEMBER_NUMBER,
c.CLNT_LNAME as LAST_NAME,
c.CLNT_FNAME as FIRST_NAME,
c.CLNT_DOB as BIRTH_DATE,
c.REPORT_LABEL as COUNTY,
sad.rtm_admit_date as ADMIT_DATE,
h.CREATE_TS as DECISION_DATE,
h.STATUS_CD as REVIEW_DECISION,
sdr.rtm_decision_reason as DECISION_REASON,
DT.SCAN_DATE,
CASE when h.STATUS_CD like '%DENIED%' THEN trunc(h.CREATE_TS) + 1 ELSE NULL end as DENIAL_MAIL_DATE,
DT.REPORT_LABEL                           as category,
CASE WHEN infoh.incident_header_stat_hist_id IS NOT NULL THEN
CASE WHEN infoh.next_create_ts IS NOT NULL THEN
(COALESCE(trunc(HC.CREATE_TS), trunc(h.CREATE_TS)) - trunc(i.RECEIVED_TS)) - (TRUNC(infoh.next_create_ts) - TRUNC(infoh.create_ts ))
ELSE NULL END
ELSE COALESCE(trunc(HC.CREATE_TS), trunc(h.CREATE_TS)) - trunc(i.RECEIVED_TS) END as TOTAL_TIME_IN_DAYS,
DOC_FORM_TYPE_CD                          as DOCUMENT_FOR_MCODE,
CASE when DOC_FORM_TYPE_CD in ( 'TP_SA_PRV' ) THEN 1 ELSE 0 end as SERVICE_ASSOC_PROVIDER_REQUESTS_COMPLETED_COUNT,
CASE when DOC_FORM_TYPE_CD in ( 'TP_NS_PRV'  ) THEN 1 ELSE 0 end as NON_SERVICE_ASSOC_PROVIDER_REQUESTS_COMPLETED_COUNT,
CASE when DOC_FORM_TYPE_CD in ( 'TP_NS_MEM' ) THEN 1 ELSE 0 end as BENEFICIARY_REQUESTS_COMPLETED_COUNT,
CASE when h.STATUS_CD in ( 'SARTM_APPROVED', 'APPROVED_NSARTM' ) THEN 1 ELSE 0 end as APPROVED_COUNT,
CASE when h.STATUS_CD in ( 'RTM_DENIED_CLINIC' ) THEN 1 ELSE 0 END as CLINICALLY_DENIED_COUNT,
CASE when h.STATUS_CD in ( 'RTM_DENIED_ADMIN' ) THEN 1 ELSE 0 END as ADMIN_DENIED_COUNT,
s.REPORT_LABEL as REVIEW_DECISION_DESCRIPTION
,i.STATUS_CD as CURRENT_SERVICE_REQUEST_STATUS
,HC.CREATE_TS as COMPLETED_DATE
,i.RECEIVED_TS as FORM_SUBMISSION_DATE
,i.CREATE_TS as EB_TASK_CREATE_DATE
FROM INCIDENT_HEADER i
left join client c on i.CLIENT_ID = c.CLNT_CLIENT_ID
left join (SELECT * FROM (SELECT INCIDENT_HEADER_ID,STATUS_CD,CREATE_TS,ROW_NUMBER() over(partition by h.INCIDENT_HEADER_ID order BY INCIDENT_HEADER_STAT_HIST_ID desc) RRN
          FROM INCIDENT_HEADER_STAT_HIST h WHERE ( STATUS_CD in ( 'SARTM_APPROVED', 'APPROVED_NSARTM', 'RTM_DENIED_CLINIC', 'RTM_DENIED_ADMIN' ) )
          ) WHERE RRN = 1) h on i.INCIDENT_HEADER_ID = h.INCIDENT_HEADER_ID
            left join (SELECT * FROM (SELECT INCIDENT_HEADER_ID,STATUS_CD,CREATE_TS,ROW_NUMBER() over(partition by h.INCIDENT_HEADER_ID order BY INCIDENT_HEADER_STAT_HIST_ID desc) RRN
           from INCIDENT_HEADER_STAT_HIST h WHERE ( STATUS_CD in ( 'RTM_COMPLETE' ) ))WHERE RRN = 1) HC on i.INCIDENT_HEADER_ID = HC.INCIDENT_HEADER_ID

left join(SELECT h.*,ROW_NUMBER() OVER(PARTITION BY incident_header_id ORDER BY incident_header_stat_hist_id DESC) rrn
FROM(SELECT incident_header_id,status_cd,create_ts, incident_header_stat_hist_id,
LEAD(create_ts) OVER (PARTITION BY h.incident_header_id ORDER BY h.incident_header_stat_hist_id) next_create_ts,
LEAD(status_cd) OVER (PARTITION BY h.incident_header_id ORDER BY h.incident_header_stat_hist_id) next_status_cd,
LAG(create_ts) OVER (PARTITION BY h.incident_header_id ORDER BY h.incident_header_stat_hist_id) prior_create_ts,
LAG(status_cd) OVER (PARTITION BY h.incident_header_id ORDER BY h.incident_header_stat_hist_id) prior_status_cd
FROM incident_header_stat_hist h ) h
WHERE status_cd = 'INFO_NSARTM') infoh ON i.incident_header_id = infoh.incident_header_id AND infoh.rrn = 1
join (SELECT * FROM EB.ENUM_AFFECTED_PARTY_TYPE WHERE EFFECTIVE_END_DATE is NULL and scope = 'OUTREACHREQUEST') APT on ( APT.value = i.AFFECTED_PARTY_TYPE_CD )
left join EB.ENUM_INCIDENT_HEADER_STATUS s on ( s.value = h.STATUS_CD )
LEFT JOIN (
	SELECT * FROM (SELECT dl.*,d.SCAN_DATE,T1.REPORT_LABEL,tt.value doc_form_type_cd,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY dl.doc_link_id DESC) rnum FROM doc_link dl
		JOIN document d ON dl.document_id = d.document_id
		JOIN enum_document_type t1 ON t1.value = d.doc_form_type
		JOIN enum_doc_code_to_type tt ON t1.value = tt.value
		WHERE tt.value IN ('TP_NS_PRV','TP_NS_MEM','TP_SA_PRV')
			AND link_type_cd = 'INCIDENT_HEADER') dd WHERE rnum = 1	) dt ON i.incident_header_id = dt.link_ref_id      
            
left join (SELECT ME.CLIENT_ID,ME.START_DATE,ME.END_DATE,ME.SEGMENT_DETAIL_VALUE_4,EC.REPORT_LABEL,ROW_NUMBER() OVER (PARTITION BY me.client_id,start_date,end_date ORDER BY elig_segment_and_details_id DESC) ern
  FROM ELIG_SEGMENT_AND_DETAILS ME join ENUM_COUNTY EC on ME.SEGMENT_DETAIL_VALUE_4 = EC.value WHERE ME.SEGMENT_TYPE_CD = 'ME') c on c.CLIENT_ID = i.CLIENT_ID
and i.CREATE_TS between c.START_DATE and c.END_DATE and ern = 1
LEFT JOIN(SELECT s.survey_id,s.client_id,qt.question_text,COALESCE(sr.answer_text,stt.answer_text) rtm_admit_date
FROM survey s
LEFT JOIN survey_template st ON s.survey_template_id = st.survey_template_id
LEFT JOIN survey_template_question stq ON stq.survey_template_id = st.survey_template_id
LEFT JOIN svey_tmpl_question_text qt ON stq.survey_template_question_id = qt.survey_template_question_id
LEFT JOIN survey_response sr ON s.survey_id = sr.survey_id AND sr.template_question_id = stq.survey_template_question_id
LEFT JOIN survey_template_answer sta ON sta.survey_template_answer_id = sr.survey_template_answer_id
LEFT JOIN svey_tmpl_answer_text stt ON stt.survey_template_answer_id = sta.survey_template_answer_id
WHERE qt.question_text = 'Admit Date'
AND st.title = 'Request To Move') sad ON sad.survey_id = i.survey_id
LEFT JOIN(SELECT s.survey_id,s.client_id,qt.question_text,COALESCE(sr.answer_text,stt.answer_text) rtm_decision_reason
FROM survey s
LEFT JOIN survey_template st ON s.survey_template_id = st.survey_template_id
LEFT JOIN survey_template_question stq ON stq.survey_template_id = st.survey_template_id
LEFT JOIN svey_tmpl_question_text qt ON stq.survey_template_question_id = qt.survey_template_question_id
LEFT JOIN survey_response sr ON s.survey_id = sr.survey_id AND sr.template_question_id = stq.survey_template_question_id
LEFT JOIN survey_template_answer sta ON sta.survey_template_answer_id = sr.survey_template_answer_id
LEFT JOIN svey_tmpl_answer_text stt ON stt.survey_template_answer_id = sta.survey_template_answer_id
WHERE  qt.question_text = 'Decision Reason'
AND st.title = 'Request To Move') sdr ON sdr.survey_id = i.survey_id
where
i.INCIDENT_HEADER_TYPE_CD = 'OUTREACH REQUEST'
and i.AFFECTED_PARTY_TYPE_CD in ( 'NSARTM', 'SARTM' )
and i.STATUS_CD in ( 'INITIATED_NSARTM', 'SARTM_INITIATED', 'SIGN_NSARTM', 'SARTM_SIGN', 'SUBMIT_CLINIC_NSARTM',
'SARTM_SUBMIT_CLINIC', 'REVIEW_NSARTM', 'SARTM_REVIEW', 'APPROVED_NSARTM', 'SARTM_APPROVED',
'INFO_NSARTM', 'RTM_DENIED_CLINIC', 'RTM_DENIED_ADMIN', 'RTM_COMPLETE', 'RTM_CANCEL',
'RTM_WITHDRAWN' );

grant select on D_REQUEST_TO_MOVE_SV to MAXDATSUPPORT_READ_ONLY;

grant select on D_REQUEST_TO_MOVE_SV to MAXDAT_REPORTS;

------------------------------------------------------------------------------------------------------------------------------------------
DROP VIEW F_REQUEST_TO_MOVE_BY_STATUS_DATE_SV;
CREATE OR REPLACE VIEW F_REQUEST_TO_MOVE_BY_STATUS_DATE_SV 
AS
SELECT request_status_code
       ,request_status_description
       ,record_date      
       ,COUNT(DISTINCT urgent_request) urgent_request_count
       ,COUNT(DISTINCT non_urgent_request) non_urgent_request_count
       ,COUNT(DISTINCT incident_header_id) request_count
       ,COUNT(DISTINCT provider_non_urgent_request) provider_non_urgent_request_count
       ,COUNT(DISTINCT client_non_urgent_request) client_non_urgent_request_count
       ,COUNT(DISTINCT unknown_non_urgent_request) unknown_non_urgent_request_count
       ,COUNT(DISTINCT provider_urgent_request) provider_urgent_request_count
       ,COUNT(DISTINCT unknown_urgent_request) unknown_urgent_request_count
FROM (
SELECT i.incident_header_id 
       ,h.status_cd request_status_code
       ,TRUNC(h.create_ts) record_date
       ,CASE WHEN i.affected_party_type_cd = 'SARTM' THEN i.incident_header_id ELSE null END urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'NSARTM'  THEN i.incident_header_id ELSE null END non_urgent_request 
       ,apt.report_label referral_desc            
       ,s.report_label request_status_description       
       ,CASE WHEN i.affected_party_type_cd = 'NSARTM'  AND dt.doc_form_type_cd = 'TP_NS_PRV' THEN i.incident_header_id ELSE null END provider_non_urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'NSARTM'  AND dt.doc_form_type_cd = 'TP_NS_MEM' THEN i.incident_header_id ELSE null END client_non_urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'NSARTM'  AND dt.doc_form_type_cd IS NULL THEN i.incident_header_id ELSE null END unknown_non_urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'SARTM' and dt.doc_form_type_cd = 'TP_SA_PRV' THEN i.incident_header_id ELSE null END provider_urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'SARTM' and dt.doc_form_type_cd IS NULL THEN i.incident_header_id ELSE null END unknown_urgent_request
FROM incident_header i
  JOIN (SELECT *
        FROM(SELECT incident_header_id,status_cd,create_ts
               ,ROW_NUMBER() OVER (PARTITION BY h.incident_header_id,h.status_cd,TRUNC(h.create_ts) ORDER BY h.create_ts DESC,incident_header_stat_hist_id DESC) rrn 
             FROM incident_header_stat_hist h
             --WHERE request_status_code IN('OUTREACH_REQUEST_APPROVED','OUTREACH_COMPLETE','OUTREACH_REQUEST_DENIED','OUTREACH_REQUEST_PENDING')
         )
         WHERE rrn = 1  ) h  ON i.incident_header_id = h.incident_header_id
  JOIN (SELECT * FROM eb.enum_affected_party_type
        WHERE effective_end_date IS NULL AND scope = 'OUTREACHREQUEST') apt    ON (apt.value=i.affected_party_type_cd)
  LEFT JOIN eb.enum_incident_header_status s   ON (s.value=h.status_cd)  
 LEFT JOIN (
	SELECT * FROM (SELECT dl.*,tt.value doc_form_type_cd,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY dl.doc_link_id DESC) rnum FROM doc_link dl
		JOIN document d ON dl.document_id = d.document_id
		JOIN enum_document_type t1 ON t1.value = d.doc_form_type
		JOIN enum_doc_code_to_type tt ON t1.value = tt.value
		WHERE tt.value IN ('TP_NS_PRV','TP_NS_MEM','TP_SA_PRV')
			AND link_type_cd = 'INCIDENT_HEADER') dd WHERE rnum = 1	) dt ON i.incident_header_id = dt.link_ref_id
WHERE  i.incident_header_type_cd = 'OUTREACH REQUEST'
AND i.affected_party_type_cd IN('NSARTM', 'SARTM')
AND i.status_cD in ('INITIATED_NSARTM','SARTM_INITIATED','SIGN_NSARTM','SARTM_SIGN','SUBMIT_CLINIC_NSARTM','SARTM_SUBMIT_CLINIC','REVIEW_NSARTM','SARTM_REVIEW','APPROVED_NSARTM','SARTM_APPROVED','INFO_NSARTM','RTM_DENIED_CLINIC','RTM_DENIED_ADMIN','RTM_COMPLETE'
,'RTM_CANCEL','RTM_WITHDRAWN')
UNION ALL
SELECT NULL incident_header_id
      ,s.value request_status_code      
      ,d_date record_date
      ,NULL urgent_request
      ,NULL non_urgent_request
      ,apt.report_label referral_desc
      ,s.report_label request_status_description      
      ,NULL provider_non_urgent_request
      ,NULL client_non_urgent_request
      ,NULL unknown_non_urgent_request   
      ,NULL provider_urgent_request
      ,NULL unknown_urgent_request
FROM MAXDAT_SUPPORT.D_DATES
  CROSS JOIN eb.enum_affected_party_type apt        
  CROSS JOIN eb.enum_incident_header_status s 
WHERE apt.value in ('NSARTM', 'SARTM')
AND d_date >= ADD_MONTHS(TRUNC(SYSDATE), -13)
AND d_date <= TRUNC(sysdate)
)
GROUP BY request_status_code,request_status_description,record_date;

GRANT SELECT ON maxdat_support.F_REQUEST_TO_MOVE_BY_STATUS_DATE_SV  TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.F_REQUEST_TO_MOVE_BY_STATUS_DATE_SV  TO MAXDATSUPPORT_READ_ONLY;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP VIEW F_REQUEST_TO_MOVE_SUBMITTED_DATE_SV;
CREATE OR REPLACE VIEW F_REQUEST_TO_MOVE_SUBMITTED_DATE_SV 
AS
WITH submitted AS (
SELECT h.incident_header_id
      ,MIN(h.create_ts) submitted_date
    FROM incident_header_stat_hist h
    WHERE h.status_cd in ('OUTREACH_REQUEST_PENDING','OUTREACH_REQUEST_INITIATED','INITIATED_NSARTM','SARTM_INITIATED')
    GROUP BY h.incident_header_id
)
SELECT distinct i.incident_header_id 
       ,h.status_cd request_status_code
       ,h.create_ts record_date
       ,CASE WHEN i.incident_header_id = submitted.incident_header_id  THEN submitted.submitted_date END submitted_date
       ,CASE WHEN i.affected_party_type_cd = 'SARTM'  THEN i.incident_header_id ELSE null END urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'NSARTM' THEN i.incident_header_id ELSE null END non_urgent_request                     
       ,apt.report_label referral_desc            
       ,s.report_label request_status_description       
       ,CASE WHEN i.affected_party_type_cd = 'NSARTM' AND dt.doc_form_type_cd = 'TP_NS_PRV' THEN i.incident_header_id ELSE null END provider_non_urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'NSARTM' AND dt.doc_form_type_cd = 'TP_NS_MEM' THEN i.incident_header_id ELSE null END client_non_urgent_request      
       ,CASE WHEN i.affected_party_type_cd = 'NSARTM' AND dt.doc_form_type_cd IS NULL THEN i.incident_header_id ELSE null END unknown_non_urgent_request     
       ,CASE WHEN i.affected_party_type_cd = 'SARTM'  AND dt.doc_form_type_cd = 'TP_SA_PRV' THEN i.incident_header_id ELSE null END provider_urgent_request 
       ,CASE WHEN i.affected_party_type_cd = 'SARTM' and dt.doc_form_type_cd IS NULL THEN i.incident_header_id ELSE null END unknown_urgent_request
FROM incident_header i
  JOIN (SELECT *
        FROM(SELECT incident_header_id,status_cd,create_ts
               ,ROW_NUMBER() OVER (PARTITION BY h.incident_header_id,h.status_cd,TRUNC(h.create_ts) ORDER BY h.create_ts DESC,incident_header_stat_hist_id DESC) rrn 
             FROM incident_header_stat_hist h
             --WHERE request_status_code IN('OUTREACH_REQUEST_APPROVED','OUTREACH_COMPLETE','OUTREACH_REQUEST_DENIED','OUTREACH_REQUEST_PENDING')
         )
         WHERE rrn = 1  ) h  ON i.incident_header_id = h.incident_header_id
  JOIN (SELECT * FROM eb.enum_affected_party_type
        WHERE effective_end_date IS NULL AND scope = 'OUTREACHREQUEST') apt    ON (apt.value=i.affected_party_type_cd)
  LEFT JOIN eb.enum_incident_header_status s   ON (s.value=h.status_cd)        
  LEFT JOIN submitted ON submitted.incident_header_id = i.incident_header_id
   LEFT JOIN (
	SELECT * FROM (SELECT dl.*,tt.value doc_form_type_cd,ROW_NUMBER() OVER (PARTITION BY link_ref_id ORDER BY dl.doc_link_id DESC) rnum FROM doc_link dl
		JOIN document d ON dl.document_id = d.document_id
		JOIN enum_document_type t1 ON t1.value = d.doc_form_type
		JOIN enum_doc_code_to_type tt ON t1.value = tt.value
		WHERE tt.value IN ('TP_NS_PRV','TP_NS_MEM','TP_SA_PRV')
			AND link_type_cd = 'INCIDENT_HEADER') dd WHERE rnum = 1	) dt ON i.incident_header_id = dt.link_ref_id
WHERE  i.incident_header_type_cd = 'OUTREACH REQUEST'
AND i.affected_party_type_cd IN( 'SARTM','NSARTM')
AND i.status_cd IN ('INITIATED_NSARTM','SARTM_INITIATED','SIGN_NSARTM','SARTM_SIGN','SUBMIT_CLINIC_NSARTM','SARTM_SUBMIT_CLINIC','REVIEW_NSARTM','SARTM_REVIEW','APPROVED_NSARTM','SARTM_APPROVED','INFO_NSARTM','RTM_DENIED_CLINIC','RTM_DENIED_ADMIN','RTM_COMPLETE'
,'RTM_CANCEL','RTM_WITHDRAWN')
UNION ALL
SELECT NULL incident_header_id
      ,s.value request_status_code      
      ,d_date record_date
      ,NULL submitted_date
      ,NULL urgent_request
      ,NULL non_urgent_request
      ,apt.report_label referral_desc
      ,s.report_label request_status_description  
      ,NULL provider_non_urgent_request
      ,NULL client_non_urgent_request
      ,NULL unknown_non_urgent_request
      ,NULL provider_urgent_request
      ,NULL unknown_urgent_request
FROM MAXDAT_SUPPORT.D_DATES
  CROSS JOIN eb.enum_affected_party_type apt        
  CROSS JOIN eb.enum_incident_header_status s 
WHERE apt.value in ('NSARTM', 'SARTM')
AND d_date >= ADD_MONTHS(TRUNC(SYSDATE), -13)
AND d_date <= TRUNC(sysdate);

GRANT SELECT ON maxdat_support.F_REQUEST_TO_MOVE_SUBMITTED_DATE_SV  TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.F_REQUEST_TO_MOVE_SUBMITTED_DATE_SV  TO MAXDATSUPPORT_READ_ONLY;