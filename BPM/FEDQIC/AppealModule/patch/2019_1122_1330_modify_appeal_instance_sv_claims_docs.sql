CREATE OR REPLACE VIEW D_MW_APPEAL_INSTANCE_SV
AS
SELECT 
  a.APPEAL_ID
, a.CREATE_DATE
, a.COMPLETE_DATE
, a.CANCELLED_DATE
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.ADJUDICATOR) as ADJUDICATOR  
, a.DEADLINE_DATE 
, issues.ISSUE_NAME as APPEAL_ISSUE
, items.ITEM_SERVICE_NAME as APPEAL_ITEM  
, a.APPEAL_NUMBER
, priorities.PRIORITY_NAME as APPEAL_PRIORITY
, a.REQUEST_RECEIVED 
, stages.STAGE_NAME as APPEAL_STAGE  
, statuses.STATUS_NAME as APPEAL_STATUS 
, types.TYPE_NAME as APPEAL_TYPE
, dismissals.DISMISSAL_NAME as APPEAL_DISMISSAL 
, dismissal_reasons.DISMISS_REASON_NAME as APPEAL_DISMISSAL_REASON
, case when a.auto_forward is not null then 'Y' else 'N' end as AUTO_FORWARD
, a.CASE_FILE_REQUEST_DATE 
, a.ACKNOWLEDGEMENT_LETTER_DATE 
, a.DECISION_MAILED_DATE 
, a.DECISION_SENT_PLAN_DATE 
, a.MEDICAL_REVIEW_CHECK 
, parts.PART_NAME as APPEAL_PART
, reasons.REASON_NAME as APPEAL_REASON 
, a.APPEAL_TOLLING_DATE
, a.APPEAL_NOTICE_DATE 
, a.CASE_FILE_RECEIVED_DATE
, a.PRECHECK_COMPLETED
,a.ACKNOWLEDGEMENT_LETTER_AGE_IN_BUS_DAYS
,a.ACKNOWLEDGEMENT_LETTER_AGE_IN_CAL_DAYS
, 'C' as ACKNOWLEDGEMENT_LETTER_DAYS_TYPE	
,a.ACKNOWLEDGEMENT_LETTER_TIMELINESS_STATUS
, 999 as ACKNOWLEDGEMENT_LETTER_JEOPARDY_DAYS
,a.ACKNOWLEDGEMENT_LETTER_JEOPARDY_FLAG
, 999 as ACKNOWLEDGEMENT_LETTER_TIMELINESS
,a.CASE_FILE_AGE_IN_BUS_DAYS
,a.CASE_FILE_AGE_IN_CAL_DAYS
, 'C' as CASE_FILE_DAYS_TYPE
,a.CASE_FILE_TIMELINESS_STATUS
, 999 as CASE_FILE_JEOPARDY_DAYS
,a.CASE_FILE_JEOPARDY_FLAG
, 999 as CASE_FILE_TIMELINESS_THRESHOLD
,a.APPEAL_AGE_IN_BUS_DAYS
,a.APPEAL_AGE_IN_CAL_DAYS
, 'C' as APPEAL_DAYS_TYPE
,case when (a.complete_date is not null and a.complete_date <= a.deadline_date) then 'Timely' when (a.complete_date is not null and a.complete_date > a.deadline_date) then 'Untimely' else null end as APPEAL_TIMELINESS_STATUS
, 999 as APPEAL_JEOPARDY_DAYS
,a.APPEAL_JEOPARDY_FLAG
, 999 as APPEAL_TIMELINESS_THRESHOLD
,a.CASE_FILE_ENTRY_AGE_IN_BUS_DAYS
,a.CASE_FILE_ENTRY_AGE_IN_CAL_DAYS
, 'C' as CASE_FILE_ENTRY_DAYS_TYPE
,a.CASE_FILE_ENTRY_TIMELINESS_STATUS
, 999 as CASE_FILE_ENTRY_JEOPARDY_DAYS
,a.CASE_FILE_ENTRY_JEOPARDY_FLAG
,999 as CASE_FILE_ENTRY_TIMELINESS_THRESHOLD
,a.DECISION_LETTER_AGE_IN_BUS_DAYS
,a.DECISION_LETTER_AGE_IN_CAL_DAYS
, 'C' as DECISION_LETTER_DAYS_TYPE
,a.DECISION_LETTER_TIMELINESS_STATUS
,999 as DECISION_LETTER_JEOPARDY_DAYS
,a.DECISION_LETTER_JEOPARDY_FLAG
, 999 as DECISION_LETTER_TIMELINESS_THRESHOLD
,a.REQUEST_HPMS_AGE_IN_BUS_DAYS
,a.REQUEST_HPMS_AGE_IN_CAL_DAYS
, 'C' as REQUEST_HPMS_DAYS_TYPE
,a.REQUEST_HPMS_TIMELINESS_STATUS
, 999 as REQUEST_HPMS_JEOPARDY_DAYS
,a.REQUEST_HPMS_JEOPARDY_FLAG
, 999 as REQUEST_HPMS_TIMELINESS_THRESHOLD
,a.ADJUDICATOR_PROCESS_AGE_IN_BUS_DAYS
,a.ADJUDICATOR_PROCESS_AGE_IN_CAL_DAYS
, 'C' as ADJUDICATOR_PROCESS_DAYS_TYPE
,a.ADJUDICATOR_PROCESS_TIMELINESS_STATUS
, 999 as ADJUDICATOR_PROCESS_JEOPARDY_DAYS
,a.ADJUDICATOR_PROCESS_JEOPARDY_FLAG
, 999 as ADJUDICATOR_PROCESS_TIMELINESS_THRESHOLD
,a.CASE_FILE_REQUEST_AGE_IN_BUS_DAYS
,a.CASE_FILE_REQUEST_AGE_IN_CAL_DAYS
, 'C' as CASE_FILE_REQUEST_DAYS_TYPE
,a.CASE_FILE_REQUEST_TIMELINESS_STATUS
, 999 as CASE_FILE_REQUEST_JEOPARDY_DAYS
,a.CASE_FILE_REQUEST_JEOPARDY_FLAG
, 999 as CASE_FILE_REQUEST_TIMELINESS_THRESHOLD
, a.CLAIMED_DATE
, decisions.DECISION_NAME as DECISION
, dec_notif_methods.DEC_NOTIF_METHOD_NAME as DECISION_NOTIFICATION_METHOD
, hpmss.HPMS_NAME as HPMS
, a.HPMS_REQUESTED_DATE
, a.IS_REQUEST_FOR_INFORMATION_P
, macs.MAC_NAME as MAC
, medicare_types.MEDICARE_TYPE_NAME as MEDICARE_TYPE
, msps.MSP_NAME as MSP
, a.NEW_DOCUMENTATION_REVIEWED
, a.PHYSICIAN_SPECIALTY
, a.REASON_FOR_APPEAL
, a.WITHDRAWAL
, withdraw_req_subms.WITHDRAW_REQ_SUBM_NAME as WITHDRAWAL_REQUEST_SUBMITTED
, non_englishes.NON_ENGLISH_NAME as NON_ENGLISH
, a.NON_ENGLISH_OTHER
, dispositions.DISPOSITION_NAME as DISPOSITION
, disposition_exps.DISPOSITION_EXP_NAME as DISPOSITION_EXPLANATION
, proc_dec_reasons.PROC_DEC_REASON_NAME as PROCEDURAL_DECISION_REASON
, sub_reasons.SUBSTANTIVE_REASON_NAME as SUBSTANTIVE_REASON
, a.FIRST_REVIEW_CASE_ATTESTATIO
, (select ft_med_rev_ds.FT_MED_REV_NAME from D_APPEAL_FT_MED_REV_DS ft_med_rev_ds where a.FIRST_MEDICAL_REVIEW_DECISIO = ft_med_rev_ds.FT_MED_REV_ID) as FIRST_MEDICAL_REVIEW_DECISIO
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.FIRST_REVIEWER) as FIRST_REVIEWER
, (select ft_med_rev_ds.FT_MED_REV_NAME from D_APPEAL_FT_MED_REV_DS ft_med_rev_ds where a.THIRD_MEDICAL_REVIEW_DECISIO = ft_med_rev_ds.FT_MED_REV_ID) as THIRD_MEDICAL_REVIEW_DECISIO
, a.THIRD_REVIEW_CASE_ATTESTATIO
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.THIRD_REVIEWER) as THIRD_REVIEWER
, a.EXPERT_REVIEW_CASE_ATTESTATI
, a.EXPERT_REVIEW_CITATION
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = a.EXPERT_REVIEWER_MD_ID) as EXPERT_REVIEWER_MD_ID,
a.STG_LAST_UPDATE_DATE,
(select sum (ti.task_claimed_time) from d_mw_task_instance ti where ti.source_reference_id = a.appeal_id) as CLAIMED_TIME,
(select sum (ti.task_unclaimed_time) from d_mw_task_instance ti where ti.source_reference_id = a.appeal_id) as UNCLAIMED_TIME,
a.closed_date as CLOSED_DATE,
a.withdrawn_date as WITHDRAWN_DATE,
case when (a.create_date is null or trunc(a.create_date) <= trunc(sysdate)) and (a.closed_date is null or trunc(a.closed_date) > trunc(sysdate)) 
and (a.withdrawn_date is null or trunc(a.withdrawn_date) > trunc(sysdate)) and (a.cancelled_date is null or trunc(a.cancelled_date) > trunc(sysdate))
then 1 else 0 end as INVENTORY_FLAG,
case when (a.create_date is null or trunc(a.create_date) <= trunc(sysdate)) and (a.complete_date is null or trunc(a.complete_date) > trunc(sysdate)) 
and (a.closed_date is null or trunc(a.closed_date) > trunc(sysdate)) and (a.withdrawn_date is null or trunc(a.withdrawn_date) > trunc(sysdate)) 
and (a.cancelled_date is null or trunc(a.cancelled_date) > trunc(sysdate))
then 1 else 0 end as SLA_INVENTORY_FLAG,
ds.doc_source_name as DOCUMENT_SOURCE,
(select count(distinct (document_id)) from d_qic_document qd where qd.appeal_id = a.appeal_id) as document_count,
(select count(distinct (claim_id)) from d_qic_claim qc where qc.appeal_id = a.appeal_id) as claim_count
from D_MW_APPEAL_INSTANCE a
LEFT OUTER JOIN D_APPEAL_PRIORITIES priorities ON a.APPEAL_PRIORITY_ID = priorities.PRIORITY_ID
LEFT OUTER JOIN D_APPEAL_PARTS parts ON a.APPEAL_PART_ID = parts.PART_ID
LEFT OUTER JOIN D_APPEAL_ISSUES issues ON a.APPEAL_ISSUE = issues.ISSUE_ID
LEFT OUTER JOIN D_APPEAL_ITEM_SERVICES items ON a.APPEAL_ITEM = items.ITEM_SERVICE_ID
LEFT OUTER JOIN D_APPEAL_STAGES stages ON a.APPEAL_STAGE = stages.STAGE_ID
LEFT OUTER JOIN D_APPEAL_STATUSES statuses ON a.APPEAL_STATUS = statuses.STATUS_ID
LEFT OUTER JOIN D_APPEAL_TYPES types ON a.APPEAL_TYPE = types.TYPE_ID
LEFT OUTER JOIN D_APPELLANT_DISMISSALS dismissals ON a.APPEAL_DISMISSAL = dismissals.DISMISSAL_ID
LEFT OUTER JOIN D_APPELLANT_DISMISS_REASONS dismissal_reasons ON a.APPEAL_DISMISSAL_REASON = dismissal_reasons.DISMISS_REASON_ID
LEFT OUTER JOIN D_APPEAL_REASONS reasons ON a.APPEAL_REASON = reasons.REASON_ID
LEFT OUTER JOIN D_APPEAL_DECISIONS decisions ON a.DECISION = decisions.DECISION_ID
LEFT OUTER JOIN D_APPEAL_DEC_NOTIF_METHODS dec_notif_methods ON a.DECISION_NOTIFICATION_METHOD = dec_notif_methods.DEC_NOTIF_METHOD_ID
LEFT OUTER JOIN D_APPEAL_HPMSS hpmss ON a.HPMS = hpmss.HPMS_ID
LEFT OUTER JOIN D_APPEAL_MACS macs ON a.MAC = macs.MAC_ID
LEFT OUTER JOIN D_APPEAL_MEDICARE_TYPES medicare_types ON a.MEDICARE_TYPE = medicare_types.MEDICARE_TYPE_ID
LEFT OUTER JOIN D_APPEAL_MSPS msps ON a.MSP = msps.MSP_ID
LEFT OUTER JOIN D_APPEAL_WITHDRAW_REQ_SUBMS withdraw_req_subms ON a.WITHDRAWAL_REQUEST_SUBMITTED = withdraw_req_subms.WITHDRAW_REQ_SUBM_ID
LEFT OUTER JOIN D_APPEAL_NON_ENGLISHES non_englishes ON a.NON_ENGLISH = non_englishes.NON_ENGLISH_ID
LEFT OUTER JOIN D_APPEAL_DISPOSITIONS dispositions ON a.DISPOSITION = dispositions.DISPOSITION_ID
LEFT OUTER JOIN D_APPEAL_DISPOSITION_EXPS disposition_exps ON a.DISPOSITION_EXPLANATION = disposition_exps.DISPOSITION_ExP_ID
LEFT OUTER JOIN D_APPEAL_PROC_DEC_REASONS proc_dec_reasons ON a.PROCEDURAL_DECISION_REASON = proc_dec_reasons.PROC_DEC_REASON_ID
LEFT OUTER JOIN D_APPEAL_SUBSTANTIVE_REASONS sub_reasons ON a.SUBSTANTIVE_REASON = sub_reasons.SUBSTANTIVE_REASON_ID
LEFT OUTER JOIN d_qic_document doc ON doc.appeal_id = a.appeal_id and doc.document_type = 1891 
LEFT OUTER JOIN D_DOC_SOURCE ds ON doc.SOURCE = ds.DOC_SOURCE_ID
with read only;
GRANT SELECT ON D_MW_APPEAL_INSTANCE_SV TO MAXDAT_READ_ONLY;

commit;