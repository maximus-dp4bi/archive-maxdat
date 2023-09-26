create or replace force view f_letter_counts_by_day_sv as
with lr as
(
select /*+ parallel(10)*/
 lmreq.dp_letter_request_id letter_id
, lmreq.lmdef_id
, null program_con_xwalk_code
, null con_status_code
, null con_update_code
, lmreq.requested_on
, lmreq.sent_on
, lmreq.mailed_date
, trunc(coalesce(lmreq.sent_next_bus_date, lmreq.sent_on, lmreq.mailed_date))   REPORT_DATE
, case when lmreq.mailed_date is not null then 1 else 0 end mailed_count
, case when lmreq.con_mailing_date is not null then 1 else 0 end confirmed_count
, 0 adjustment_count
, 0 adjustment_flag
, lmdef.letter_invoice_group_code
, lmdef.letter_source_code
, lmdef.letter_program_group
, lig.report_label letter_invoice_group_label
, lig.LETTER_INVOICE_GROUP_NAME
, lmdef.name letter_name
, lmdef.report_label letter_label
, null subprogram_label
from
d_letter_request lmreq
left join d_letter_definition lmdef on lmdef.lmdef_id = lmreq.lmdef_id
left join D_LETTER_INVOICE_GROUP lig on lig.letter_invoice_group_code = lmdef.letter_invoice_group_code
where lmreq.program_con_xwalk_code is null
and (lmdef.letter_source_code is null or lmdef.letter_source_code <> 'EYR')
and SENT_ON >= TO_DATE('11/1/2020','MM/DD/YYYY')
and lmreq.status_cd <> 'REJ'
--and lmreq.lmdef_id = 63
--and letter_request_id = 21968210
)
, eyrl as
(
select /*+ parallel(10)*/
 lmreq.dp_letter_request_id letter_id
, lmreq.lmdef_id
, null program_con_xwalk_code
, null con_status_code
, null con_update_code
, lmreq.requested_on
, lmreq.sent_on
, lmreq.mailed_date
,trunc(coalesce((lmreq.eyr_tran_date - decode(to_number(to_char(lmreq.eyr_tran_date,'D')),1,2,2,3,1)),(lmreq.PRINTED_ON - decode(to_number(to_char(lmreq.PRINTED_ON,'D')),1,2,2,3,1)), lmreq.mailed_date))   REPORT_DATE
, case when lmreq.mailed_date is not null then 1 else 0 end mailed_count
, case when lmreq.con_mailing_date is not null then 1 else 0 end confirmed_count
, 0 adjustment_count
, 0 adjustment_flag
, lmdef.letter_invoice_group_code
, lmdef.letter_source_code
, lmdef.letter_program_group
, lig.report_label letter_invoice_group_label
, lig.LETTER_INVOICE_GROUP_NAME
, lmdef.name letter_name
, lmdef.report_label letter_label
, null subprogram_label
from
d_letter_request lmreq
left join d_letter_definition lmdef on lmdef.lmdef_id = lmreq.lmdef_id
left join D_LETTER_INVOICE_GROUP lig on lig.letter_invoice_group_code = lmdef.letter_invoice_group_code
where lmreq.program_con_xwalk_code is null
and lmdef.letter_source_code = 'EYR'
and MAILED_dATE >= TO_DATE('11/1/2020','MM/DD/YYYY')
--and lmreq.lmdef_id = 63
--and letter_request_id = 21968210
)
, lhc as
(
select /*+ parallel(10)*/
 lmreq.dp_letter_request_id letter_id
--, lmreq.letter_request_id
, lmreq.lmdef_id
, ls.program_con_xwalk_code program_con_xwalk_code
, ls.con_status_code
, ls.con_update_code
, lmreq.requested_on
, lmreq.sent_on
, lmreq.mailed_date
, trunc(coalesce(lmreq.CON_FILE_LOAD_DATE,lmreq.con_mailing_date, lmreq.mailed_date)) report_date
, case when lmreq.mailed_date is not null then 1 else 0 end mailed_count
, case when lmreq.con_mailing_date is not null then 1 else 0 end confirmed_count
, 0 adjustment_count
, 0 adjustment_flag
, lmdef.letter_invoice_group_code
, lmdef.letter_source_code
, lmdef.letter_program_group
, lig.report_label letter_invoice_group_label
, lig.LETTER_INVOICE_GROUP_NAME
, lmdef.name letter_name
, lmdef.report_label letter_label
, ls.report_label subprogram_label
from
d_letter_request lmreq
left join d_subprogram_con_xwalk ls on ls.lmdef_id = lmreq.lmdef_id and ls.program_con_xwalk_code = lmreq.program_con_xwalk_code and sysdate >= ls.effective_date and sysdate <= ls.end_date
left join d_letter_definition lmdef on lmdef.lmdef_id = lmreq.lmdef_id
left join D_LETTER_INVOICE_GROUP lig on lig.letter_invoice_group_code = lmdef.letter_invoice_group_code
where 1=1
and lmreq.program_con_xwalk_code is not null
--where ls.program_con_xwalk_code in ('MED RF','MED FS')
--and MAILED_dATE = TO_DATE('12/16/2020','MM/DD/YYYY')
--and letter_request_id = 21936110
)
, lf as
(select /*+ parallel(10)*/
 laf.letter_adjustment_form_id letter_id
, laf.lmdef_id
, ls.program_con_xwalk_code program_con_xwalk_code
, ls.con_status_code
, ls.con_update_code
,  null requested_on
, null sent_on
, null mailed_date
, trunc(laf.adjustment_date) report_date
, 0 mailed_count
, 0 confirmed_count
, laf.adjustment_count adjustment_count
, 1 adjustment_flag
, lmdef.letter_invoice_group_code
, lmdef.letter_source_code
, lmdef.letter_program_group
, lig.report_label letter_invoice_group_label
, lig.LETTER_INVOICE_GROUP_NAME
, lmdef.name letter_name
, lmdef.report_label letter_label
, ls.report_label subprogram_label
from
letter_adjustment_form laf
left join d_subprogram_con_xwalk ls on ls.lmdef_id = laf.lmdef_id and ls.program_con_xwalk_code = laf.program_con_xwalk_code and sysdate >= ls.effective_date and sysdate <= ls.end_date
left join d_letter_definition lmdef on lmdef.lmdef_id = laf.lmdef_id
left join D_LETTER_INVOICE_GROUP lig on lig.letter_invoice_group_code = lmdef.letter_invoice_group_code
--where ls.program_con_xwalk_code in ('MED RF','MED FS')
)
, zeroc as
(
 select /*+ parallel(10)*/
to_number(to_char(dd.d_date,'YYYYMMDD') || lpad(lmdef.lmdef_id + 0 + ascii(nvl(sc.con_status_code,0)) + ascii(nvl(sc.con_update_code,0)),'7','0'))  LETTER_id
, lmdef.lmdef_id
, sc.program_con_xwalk_code program_con_xwalk_code
, sc.con_status_code
, sc.con_update_code
, null requested_on
, null sent_on
, null mailed_date
, dd.d_date REPORT_DATE
, 0 mailed_count
, 0 confirmed_count
, 0 adjustment_count
, 0 adjustment_flag
, lmdef.letter_invoice_group_code
, lmdef.letter_source_code
, lmdef.letter_program_group
, lig.report_label letter_invoice_group_label
, lig.LETTER_INVOICE_GROUP_NAME
, lmdef.name letter_name
, lmdef.report_label letter_label
, sc.report_label subprogram_label
from
d_dates dd
left join d_letter_definition lmdef on 1=1
left join d_subprogram_con_xwalk sc on sc.lmdef_id = lmdef.lmdef_id
left join D_LETTER_INVOICE_GROUP lig on lig.letter_invoice_group_code = lmdef.letter_invoice_group_code
where dd.d_date between trunc(add_months(sysdate,-13),'YYYY') and trunc(sysdate)
--and lig.letter_invoice_group_code = 'HC'
)
, lall as
(select * from lr
union
select * from eyrl
union
select * from lhc
union
select * from lf
union
select * from zeroc
)
--select * from lall where program_con_xwalk_code in ('MED RF','MED FS')
 select to_number(to_char(report_date,'YYYYMMDD') || lpad(sum(nvl(lall.letter_id,0)) + lall.lmdef_id + ascii(nvl(lall.con_status_code,0)) + ascii(nvl(lall.con_update_code,0)),'7','0'))  LETTER_COUNT_BY_DAY_ID
, REPORT_DATE
, lmdef_id LETTER_DEFINITION_ID
, PROGRAM_CON_XWALK_CODE
, sum(nvl(lall.mailed_count,0)) EB_MAILED_COUNT
, sum(nvl(lall.confirmed_count,0)) CON_CONFIRMED_COUNT
, sum(nvl(lall.adjustment_count,0)) FORM_ADJUSTMENT_COUNT
, sum(nvl(lall.adjustment_flag, 0)) NOF_FORM_ADJUSTMENTS
, case when letter_invoice_group_code = 'HC' then sum(nvl(lall.confirmed_count,0)) else sum(nvl(lall.mailed_count,0)) end + sum(nvl(lall.adjustment_count, 0)) LETTER_COUNT_BY_TOTAL
, case when letter_invoice_group_code in ('MAXEB','HC') then 1 else 0 end MAXEB_IND
, case when letter_source_code = 'EYR' then 1 else 0 end EYR_IND
, case when letter_invoice_group_code = 'HC' then 1 else 0 end HC_IND
, letter_invoice_group_label
, letter_invoice_group_code
, letter_program_group
--- Keep the letter_type_name and Report_label below same as D_LETTER_TYPE_SV
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
--where program_con_xwalk_code in ('MED RF','MED FS')
--where mailed_count > 0
group by report_date, lmdef_id,letter_name,letter_label, program_con_xwalk_code, subprogram_label, letter_invoice_group_code,letter_program_group,letter_invoice_group_label, LETTER_INVOICE_GROUP_NAME,  letter_source_code, con_status_code, con_update_code
;
grant select on F_LETTER_COUNTS_BY_DAY_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on F_LETTER_COUNTS_BY_DAY_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on F_LETTER_COUNTS_BY_DAY_SV to MAXDAT_MITRAN_READ_ONLY;


