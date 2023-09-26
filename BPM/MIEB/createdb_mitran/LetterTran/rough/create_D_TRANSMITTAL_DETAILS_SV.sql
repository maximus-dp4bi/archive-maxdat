CREATE OR REPLACE VIEW D_TRANSMITTAL_DETAILS_SV AS 
SELECT h.tran_header_id
, h.project_code
, h.program_code
, h.tran_date
--, h.comments 
, h.create_ts tran_header_created_ts
, d.tran_detail_id
, d.subprogram_code
, d.tran_job_id
, d.lmdef_id
, lmdef.name
, d.ltr_filename
, d.requested_qty
, d.resent
, d.preqa_eyr_ltr_filename
, d.preqa_eyr_ltr_qty
, d.preqa_eyr_extra
, d.qa_abort_userid
, d.qa_split_qty
, d.qa_rejected_qty
, d.qa_comments
, d.qa_signed
, d.qa_date
, d.qa_userid
, d.eyr_mailed_date
, d.eyr_mailed_qty
, d.eyr_ps_checked
, d.eyr_ps_comments
, d.invoiced
, d.invoiced_date
, d.adjust_reason_code
, d.comments
, d.form_created_by mstr_created_by
, d.form_updated_by mstr_updated_by
, d.create_ts detail_create_ts
, d.update_ts detail_update_ts
, d.created_by detail_created_by
, d.updated_by  detail_updated_by
, lmdt.PROGRAM_CON_XWALK_CODE
, lmdt.LETTER_INVOICE_GROUP_CODE
, lmdt.REPORT_LABEL Program_xwalk_report_label
, lmdt.LETTER_TYPE_NAME
, proj.project_name project_name
, proj.report_label project_label
, prog.program_name program_name
, prog.report_label program_label
, prog.program_category
, sp.subprogram_name
, sp.report_label subprogram_label
, he.initiated_dt
, he.initiated_filename
, he.initiated_source
, he.jobid_assigned_event_id
, he.JOBID_ASSIGNED_DT
, he.jobid_filename
, he.jobid_source
, he.rcvd_conf_eyr_dt
, he.rcvd_conf_eyr_id
, he.conf_filename
, he.conf_source
, he.sent_qa_dt
, he.sent_qa_id
, he.qa_filename
, he.qa_source
, he.rcvd_mail_eyr_dt
, he.rcvd_mail_eyr_id
, he.mail_filename
, he.mail_source
, ar.report_label adjust_reason_label
, lig.report_label letter_invoice_group_label
, lig.LETTER_INVOICE_GROUP_NAME
FROM D_TRAN_HEADER H
JOIN D_TRAN_dETAIL D ON H.TRAN_HEADER_ID = D.TRAN_HEADER_ID
LEFT JOIN D_LETTER_DEFINITION LMDEF ON LMDEF.LMDEF_ID = D.LMDEF_ID
LEFT JOIN D_LETTER_TYPE_SV LMDT ON LMDT.LETTER_DEFINITION_ID = D.LMDEF_ID
LEFT JOIN D_HEADER_LATEST_EVENTS_SV HE ON HE.tran_header_id = h.tran_header_id
left join d_project proj on h.project_code = proj.project_code
left join d_program prog on h.program_code = prog.program_code
left join d_subprogram sp on d.subprogram_code = sp.subprogram_code
left join d_letter_adjust_Reason ar on d.adjust_reason_code = ar.letter_adjust_reason_code
left join D_LETTER_INVOICE_GROUP lig on lig.letter_invoice_group_code = lmdef.letter_invoice_group_code
;

grant select on D_TRANSMITTAL_DETAILS_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on D_TRANSMITTAL_DETAILS_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_TRANSMITTAL_DETAILS_SV to MAXDAT_MITRAN_READ_ONLY;

--select * from D_TRANSMITTAL_DETAILS_SV;
