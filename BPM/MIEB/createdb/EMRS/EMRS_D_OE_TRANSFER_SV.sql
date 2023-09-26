
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_OE_TRANSFER_SV" ("PROGRAM_TYPE_CD", "TO_SUBPROGRAM_CODE", "TO_PLAN_ID", "FROM_SUBPROGRAM_CODE", "FROM_PLAN_ID", "RECORD_DATE", "SELECTION_TRANSACTION_ID", "OE_MONTH", "OE_LETTER_SENT_DATE", "CLIENT_ID", "CASE_ID", "CASE_CIN", "OE_TRANSFER") AS 
  select program_type_cd
       , subprogram_code to_subprogram_code
       , plan_id to_plan_id
       , prior_subprogram_code from_subprogram_code
       , prior_plan_id from_plan_id
       , record_date
       , selection_txn_id selection_transaction_id
       , oe_month
       , oe_letter_sent_date
       , client_id
       , case_id
       , case_cin
       , case when oe_letter_sent_date is not null then 'Y'
              else 'N'
              end oe_transfer
from (
     SELECT COALESCE(s.program_type_cd, '0') AS program_type_cd,
    case when s.plan_type_cd = 'DENTAL' then 'DEN' else COALESCE(ca.subprogram_codes,'0') end AS subprogram_code,
    s.county county_code,
    COALESCE(s.plan_id, 0) AS plan_id,
    s.plan_type_cd plan_type,
    s.plan_id_ext ,
   COALESCE(s.prior_plan_id, 0) AS prior_plan_id,
    s.prior_plan_id_ext ,
    case when s.plan_type_cd = 'DENTAL' then 'DEN' else COALESCE(ca.subprogram_codes,COALESCE(ca.subprogram_codes,'0')) end AS prior_subprogram_code,
    s.status_cd ,
    s.transaction_type_cd ,
    s.selection_source_cd ,
    s.choice_reason_cd ,
    COALESCE(ca.value, COALESCE(s.client_aid_category_cd, '0')) AS client_aid_category_cd,
    COALESCE(s.disenroll_reason_cd_1, s.disenroll_reason_cd_2,'0') AS disenroll_reason_cd_1,
    s.disenroll_reason_cd_2 ,
    s.selection_txn_id  ,
    s.client_id,
    s.status_date,
    s.record_date ,
    (to_number(decode(substr( csi.case_cin,length(csi.case_cin)), '0','10', substr(csi.case_cin, length(csi.case_cin))))) oe_month,
    csi.case_id,
    csi.case_cin,
    (
          select max(sent_on) oe_letter
          from letter_request r
          join letter_definition d on d.lmdef_id = r.lmdef_id
          and d.name in ('OE','OEC','OECM' ,'OEHC','OEHM','OEM','OED')
          where r.status_cd in ('SENT','MAIL')
          and r.case_id = csi.case_id
          and r.sent_on >=
          ( select maximus_cutoff_date_1 + 1
                    from cutoff_calendar
                    where plan_service_types = 'MAINSTREAM'
                    and transaction_type_cd = 'Transfer'
                    and  month_year = to_number(to_char(add_months(record_date,-2),'MMYYYY')) )
          and r.sent_on < record_Date
     ) oe_letter_sent_date
     , cscl.cscl_id
     , ca.value
  FROM (
       select st.*, uh.record_date
       from eb.selection_txn st
        LEFT JOIN (SELECT MIN(sh.create_ts) record_date, sh.selection_txn_id
            FROM selection_txn_status_history sh
            WHERE sh.status_cd = 'uploadedToState'
            group by sh.selection_txn_id
            ) uh ON uh.selection_txn_id = st.selection_txn_id
        WHERE (st.create_ts >= add_months(TRUNC(sysdate,'mm'),-2) OR st.status_date >= add_months(TRUNC(sysdate,'mm'),-2) )
        and st.transaction_type_cd = 'Transfer'
        and st.status_cd = 'acceptedByState'
        ) s
  INNER JOIN client cl ON s.client_id = cl.clnt_client_id
--  INNER JOIN SELECTION_SEGMENT ss ON (ss.client_id = s.client_id and ss.plan_id = s.plan_id and ss.plan_type_cd = s.plan_type_cd and ss.start_date = s.start_date and ss.start_date < nvl(ss.end_date, ss.start_date + 1))
--  INNER JOIN SELECTION_SEGMENT ssp ON ssp.client_id = s.client_id and ssp.plan_id = s.prior_plan_id and ssp.plan_type_cd = s.plan_type_cd and ssp.end_date = ss.start_date-1 and ssp.start_date < nvl(ssp.end_date, ssp.start_date + 1)
  INNER JOIN client_supplementary_info csi ON csi.client_id = s.client_id
  INNER JOIN case_client cscl ON csi.case_client_id = cscl.cscl_id --and greatest(ss.create_ts, ss.start_date) >= cscl.cscl_status_begin_date
  INNER JOIN enum_aid_category ca ON  ca.value = cscl.cscl_adlk_id
  where ca.subprogram_codes in ('DEN','MED','MC','CSHCS','HMP')
)
where oe_letter_sent_date is not null;
