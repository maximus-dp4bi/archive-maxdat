CREATE OR REPLACE VIEW D_TRAN_QA_PENDING_SV AS 
SELECT 
 h.tran_date
, d.tran_job_id
, lmdt.REPORT_LABEL letter_type_label
, h.tran_header_id
, h.project_code
, h.program_code
--, h.comments 
, h.create_ts tran_header_created_ts
, d.tran_detail_id
, d.subprogram_code
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
, adj.report_label adjust_reason_label
FROM D_TRAN_HEADER H
JOIN D_TRAN_dETAIL D ON H.TRAN_HEADER_ID = D.TRAN_HEADER_ID
LEFT JOIN D_LETTER_DEFINITION LMDEF ON LMDEF.LMDEF_ID = D.LMDEF_ID
LEFT JOIN D_LETTER_TYPE_SV LMDT ON LMDT.LETTER_DEFINITION_ID = D.LMDEF_ID
left join d_letter_adjust_reason adj on adj.letter_adjust_reason_code = d.adjust_reason_code
where (d.qa_signed is null or d.qa_signed = 'N')
order by h.tran_date, lmdef.name
;

grant select on D_TRAN_QA_PENDING_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on D_TRAN_QA_PENDING_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_TRAN_QA_PENDING_SV to MAXDAT_MITRAN_READ_ONLY;

--select * from f_TRAN_QA_PENDING_SV;
--drop view f_TRAN_QA_PENDING_SV;

