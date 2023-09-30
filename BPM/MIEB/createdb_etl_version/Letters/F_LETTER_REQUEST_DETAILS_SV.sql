create or replace view F_LETTER_REQUEST_DETAILS_SV
as
with lr as (
select 
lmreq.DP_LETTER_REQUEST_ID LETTER_REQUEST_DETAIL_ID
,trunc(coalesce(lmreq.sent_next_bus_date, lmreq.sent_on, lmreq.mailed_date))   REPORT_DATE
,lmreq.LETTER_REQUEST_ID    LETTER_REQUEST_ID
,lmreq.REQUESTED_ON REQUEST_DATE
,lmreq.LMDEF_ID LETTER_DEFINITION_ID
,lmreq.STATUS_CD  LETTER_STATUS
,lmreq.UPDATE_TS  LETTER_STATUS_DATE
,lmreq.SENT_ON  SENT_DATE
, lmreq.sent_next_bus_date
,lmreq.PRINTED_ON PRINT_DATE
,lmreq.MAILED_DATE  MAILED_DATE
,lmreq.RETURN_DATE  RETURN_DATE
,lmreq.RETURN_REASON_CD RETURN_REASON
,lmreq.REJECT_REASON_CD REJECTION_REASON
,lmreq.STATUS_ERR_SRC REQUEST_ERROR_REASON
,lmreq.PROGRAM_CON_XWALK_CODE
,null CON_FILE_NAME
,null CON_FILE_CREATION_DATE
,null CON_FILE_LOAD_DATE
,null CON_CARD_REQUEST_FILE_NAME
,null CON_STATUS_CODE
,null CON_UPDATE_CODE
,null CON_CASE_ID
,null CON_MAILING_DATE
,null CON_CONTROL_NUMBER
,null CON_RECIPIENT_ID
,null CON_MI_CARD_ID
, lmreq.program_type_cd
, lmreq.material_request_id
, lmreq.is_digital_ind
, lmreq.mailing_address_id
, lmreq.parent_lmreq_id
, lmreq.reprint_parent_lmreq_id
, lmreq.dp_created_by
, lmreq.dp_date_created
, lmreq.eyr_job_ctrl_id
, lmreq.eyr_row_num
, lmreq.eyr_filename
, lmreq.eyr_source_system
, lmreq.eyr_source_filename
, lmreq.eyr_record_number
, lmreq.eyr_letter_type
, lmreq.eyr_printed_date
, lmreq.eyr_mailed_date
, (case when lmreq.eyr_mailed_date is not null then trunc(lmreq.dp_date_updated) else null end) eyr_received_date
, lmreq.eyr_tran_date
, lmdef.letter_invoice_group_code
, lmdef.letter_source_code
, lmdef.letter_program_group
, lig.report_label letter_invoice_group_label
, lig.LETTER_INVOICE_GROUP_NAME
, lmdef.name letter_name
, lmdef.report_label letter_label
, null subprogram_label
, LMDEF.PROJECT_CODE
, LMDEF.PROGRAM_CODE
from
d_letter_request lmreq 
join d_letter_definition lmdef on lmdef.lmdef_id = lmreq.lmdef_id
join D_LETTER_INVOICE_GROUP lig on lig.letter_invoice_group_code = lmdef.letter_invoice_group_code
where lmreq.program_con_xwalk_code is null
and (lmdef.letter_source_code is null or lmdef.letter_source_code <> 'EYR')
AND SYSDATE BETWEEN LMDEF.EFFECTIVE_FROM_DATE AND LMDEF.EFFECTIVE_THRU_DATE
)
, eyrl as (
select 
lmreq.DP_LETTER_REQUEST_ID LETTER_REQUEST_DETAIL_ID
,trunc(coalesce((lmreq.eyr_tran_date - decode(to_number(to_char(lmreq.eyr_tran_date,'D')),1,2,2,3,1)),(lmreq.PRINTED_ON - decode(to_number(to_char(lmreq.PRINTED_ON,'D')),1,2,2,3,1)), lmreq.mailed_date))   REPORT_DATE
,lmreq.LETTER_REQUEST_ID    LETTER_REQUEST_ID
,lmreq.REQUESTED_ON REQUEST_DATE
,lmreq.LMDEF_ID LETTER_DEFINITION_ID
,lmreq.STATUS_CD  LETTER_STATUS
,lmreq.UPDATE_TS  LETTER_STATUS_DATE
,lmreq.SENT_ON  SENT_DATE
, lmreq.sent_next_bus_date
,lmreq.PRINTED_ON PRINT_DATE
,lmreq.MAILED_DATE  MAILED_DATE
,lmreq.RETURN_DATE  RETURN_DATE
,lmreq.RETURN_REASON_CD RETURN_REASON
,lmreq.REJECT_REASON_CD REJECTION_REASON
,lmreq.STATUS_ERR_SRC REQUEST_ERROR_REASON
,lmreq.PROGRAM_CON_XWALK_CODE
,null CON_FILE_NAME
,null CON_FILE_CREATION_DATE
,null CON_FILE_LOAD_DATE
,null CON_CARD_REQUEST_FILE_NAME
,null CON_STATUS_CODE
,null CON_UPDATE_CODE
,null CON_CASE_ID
,null CON_MAILING_DATE
,null CON_CONTROL_NUMBER
,null CON_RECIPIENT_ID
,null CON_MI_CARD_ID
, lmreq.program_type_cd
, lmreq.material_request_id
, lmreq.is_digital_ind
, lmreq.mailing_address_id
, lmreq.parent_lmreq_id
, lmreq.reprint_parent_lmreq_id
, lmreq.dp_created_by
, lmreq.dp_date_created
, lmreq.eyr_job_ctrl_id
, lmreq.eyr_row_num
, lmreq.eyr_filename
, lmreq.eyr_source_system
, lmreq.eyr_source_filename
, lmreq.eyr_record_number
, lmreq.eyr_letter_type
, lmreq.eyr_printed_date
, lmreq.eyr_mailed_date
, (case when lmreq.eyr_mailed_date is not null then trunc(lmreq.dp_date_updated) else null end) eyr_received_date
, lmreq.eyr_tran_date
, lmdef.letter_invoice_group_code
, lmdef.letter_source_code
, lmdef.letter_program_group
, lig.report_label letter_invoice_group_label
, lig.LETTER_INVOICE_GROUP_NAME
, lmdef.name letter_name
, lmdef.report_label letter_label
, null subprogram_label
, LMDEF.PROJECT_CODE
, LMDEF.PROGRAM_CODE
from
d_letter_request lmreq 
join d_letter_definition lmdef on lmdef.lmdef_id = lmreq.lmdef_id
join D_LETTER_INVOICE_GROUP lig on lig.letter_invoice_group_code = lmdef.letter_invoice_group_code
where lmreq.program_con_xwalk_code is null
and lmdef.letter_source_code = 'EYR'
AND SYSDATE BETWEEN LMDEF.EFFECTIVE_FROM_DATE AND LMDEF.EFFECTIVE_THRU_DATE
)
, lhc as (
select 
lmreq.DP_LETTER_REQUEST_ID LETTER_REQUEST_DETAIL_ID
, trunc(coalesce(lmreq.CON_FILE_LOAD_DATE,lmreq.con_mailing_date, lmreq.mailed_date))    REPORT_DATE
,lmreq.LETTER_REQUEST_ID    LETTER_REQUEST_ID
,lmreq.REQUESTED_ON REQUEST_DATE
,lmreq.LMDEF_ID LETTER_DEFINITION_ID
,lmreq.STATUS_CD  LETTER_STATUS
,lmreq.UPDATE_TS  LETTER_STATUS_DATE
,lmreq.SENT_ON  SENT_DATE
, lmreq.sent_next_bus_date
,lmreq.PRINTED_ON PRINT_DATE
,lmreq.MAILED_DATE  MAILED_DATE
,lmreq.RETURN_DATE  RETURN_DATE
,lmreq.RETURN_REASON_CD RETURN_REASON
,lmreq.REJECT_REASON_CD REJECTION_REASON
,lmreq.STATUS_ERR_SRC REQUEST_ERROR_REASON
, lmreq.PROGRAM_CON_XWALK_CODE
, lmreq.CON_FILE_NAME
, lmreq.CON_FILE_CREATION_DATE
, lmreq.CON_FILE_LOAD_DATE
, lmreq.CON_CARD_REQUEST_FILE_NAME
, lmreq.CON_STATUS_CODE
, lmreq.CON_UPDATE_CODE
, lmreq.CON_CASE_ID
, lmreq.CON_MAILING_DATE
, lmreq.CON_CONTROL_NUMBER
, lmreq.CON_RECIPIENT_ID
, lmreq.CON_MI_CARD_ID
, lmreq.program_type_cd
, lmreq.material_request_id
, lmreq.is_digital_ind
, lmreq.mailing_address_id
, lmreq.parent_lmreq_id
, lmreq.reprint_parent_lmreq_id
, lmreq.dp_created_by
, lmreq.dp_date_created
, lmreq.eyr_job_ctrl_id
, lmreq.eyr_row_num
, lmreq.eyr_filename
, lmreq.eyr_source_system
, lmreq.eyr_source_filename
, lmreq.eyr_record_number
, lmreq.eyr_letter_type
, lmreq.eyr_printed_date
, lmreq.eyr_mailed_date
, (case when lmreq.eyr_mailed_date is not null then trunc(lmreq.dp_date_updated) else null end) eyr_received_date
, lmreq.eyr_tran_date
, lmdef.letter_invoice_group_code
, lmdef.letter_source_code
, lmdef.letter_program_group
, lig.report_label letter_invoice_group_label
, lig.LETTER_INVOICE_GROUP_NAME
, lmdef.name letter_name
, lmdef.report_label letter_label
, ls.report_label subprogram_label
, LMDEF.PROJECT_CODE
, LMDEF.PROGRAM_CODE
from
d_letter_request lmreq 
left join d_subprogram_con_xwalk ls on ls.lmdef_id = lmreq.lmdef_id and ls.program_con_xwalk_code = lmreq.program_con_xwalk_code and sysdate >= ls.effective_date and sysdate <= ls.end_date
left join d_letter_definition lmdef on lmdef.lmdef_id = lmreq.lmdef_id
left join D_LETTER_INVOICE_GROUP lig on lig.letter_invoice_group_code = lmdef.letter_invoice_group_code
AND SYSDATE BETWEEN LMDEF.EFFECTIVE_FROM_DATE AND LMDEF.EFFECTIVE_THRU_DATE
where 1=1
and lmreq.program_con_xwalk_code is not null
)
, lall as
(select * from lr
union
select * from eyrl
union
select * from lhc
)
--select * from lall where program_con_xwalk_code in ('MED RF','MED FS')
 select lall.*
--- Keep the letter_type_name and Report_label below same as D_LETTER_TYPE_SV
, case when letter_invoice_group_code in ('MAXEB','HC') then 1 else 0 end MAXEB_IND
, case when letter_source_code = 'EYR' then 1 else 0 end EYR_IND
, case when letter_invoice_group_code = 'HC' then 1 else 0 end HC_IND
,(
  (CASE WHEN LETTER_INVOICE_GROUP_NAME = LETTER_NAME THEN LETTER_INVOICE_GROUP_NAME ELSE LETTER_INVOICE_GROUP_NAME || ' - ' || LETTER_NAME END) 
  || 
  case when PROGRAM_CON_XWALK_CODE is not null then ' - ' || PROGRAM_CON_XWALK_CODE else '' end
    ) 
   LETTER_TYPE_NAME
,(
  CASE WHEN letter_invoice_group_label = letter_LABEL  THEN letter_invoice_group_label ELSE letter_invoice_group_label|| ' - ' || letter_LABEL END
     || 
     case when PROGRAM_CON_XWALK_CODE is not null then ' - ' || subprogram_label else '' end
       ) LETTER_TYPE_LABEL
from lall
;



grant select on F_LETTER_REQUEST_DETAILS_SV to MAXDAT_MIEB_READ_ONLY;
--f_letter_requests
