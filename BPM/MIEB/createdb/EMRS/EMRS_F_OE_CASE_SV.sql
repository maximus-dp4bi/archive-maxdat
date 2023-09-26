
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_F_OE_CASE_SV" ("D_MONTH", "OE_MONTH", "OE_YEAR", "CASE_ID", "CLIENT_ID", "SUBPROGRAM_CODE", "SENT_ON", "PLAN_ID", "PRIOR_PLAN_ID", "CLIENT_AGE", "RECORD_DATE", "CUTOFF_DATE", "LETTER_NAME", "CLIENT_IN_OE_MONTH", "CASE_IN_OE_MONTH", "CASE_OUTSIDE_OE_MONTH", "CLIENT_OUTSIDE_OE_MONTH", "CLIENT_TRANSFER", "CASE_UNDER_21", "OE_MONTH_DIGIT") AS 
  SELECT p.oe_year||TO_CHAR(ADD_MONTHS(sent_on,1),'mm') AS d_month --p.OE_YEAR || p.OE_MONTH AS D_MONTH
      , p."OE_MONTH",p."OE_YEAR",p."CASE_ID",p."CLIENT_ID",p."SUBPROGRAM_CODE",p."SENT_ON",p."PLAN_ID",p."PRIOR_PLAN_ID",p."CLIENT_AGE",p."RECORD_DATE",p."CUTOFF_DATE",p."LETTER_NAME"
      ,CASE WHEN TO_CHAR(ADD_MONTHS(sent_on,1),'mm') = oe_month THEN 1 ELSE 0 END client_in_oe_month
      ,CASE WHEN TO_CHAR(ADD_MONTHS(sent_on,1),'mm') = oe_month THEN case_id END case_in_oe_month
      ,CASE WHEN TO_CHAR(ADD_MONTHS(sent_on,1),'mm') != oe_month THEN case_id END case_outside_oe_month
      ,CASE WHEN TO_CHAR(ADD_MONTHS(sent_on,1),'mm') != oe_month THEN 1 ELSE 0 END client_outside_oe_month
      ,CASE WHEN TRUNC(record_date) BETWEEN sent_on  AND LAST_DAY(ADD_MONTHS(sent_on,1)) THEN client_id END client_transfer
      ,CASE WHEN client_age < 21 THEN case_id END case_under_21
      ,TO_NUMBER(TO_CHAR(ADD_MONTHS(sent_on,1),'mm')) oe_month_digit
FROM(
SELECT
      CASE WHEN TRUNC(r.sent_on) BETWEEN TO_DATE('10/01/'||TO_CHAR(sysdate,'YYYY'),'mm/dd/yyyy') AND TO_DATE('11/30/'||TO_CHAR(sysdate,'YYYY'),'mm/dd/yyyy')
         AND NOT EXISTS(SELECT 1 FROM  letter_request oer JOIN letter_definition oed ON oed.lmdef_id = oer.lmdef_id
                        WHERE oer.case_id = r.case_id
                        AND oed.name in('OED','OE','OEC','OECM' ,'OEHC','OEHM','OEM')
                        AND oer.status_cd in ('SENT','MAIL')
                        AND TRUNC(oer.sent_on) BETWEEN ADD_MONTHS(TO_DATE('10/01/'||TO_CHAR(sysdate,'YYYY'),'mm/dd/yyyy'),-12) AND TO_DATE('10/01/'||TO_CHAR(sysdate,'YYYY'),'mm/dd/yyyy')-1)
      THEN TO_CHAR(ADD_MONTHS(sent_on,1),'mm')
          ELSE oe_month  END oe_month
      ,CASE WHEN TO_CHAR(sent_on,'mm') = '12' THEN TO_CHAR(ADD_MONTHS(sent_on,1),'YYYY') ELSE TO_CHAR(sent_on,'YYYY')  END oe_year
--      , (r.sent_on ) sent_on
      ,r.case_id
      ,client_id
      ,subprogram_code
      ,CASE WHEN TRUNC(sent_on) >= previous_cutoff_date AND TRUNC(sent_on) < current_cutoff_date THEN LEAST(TRUNC(sent_on),previous_cutoff_date) ELSE TRUNC(sent_on) END sent_on
      ,plan_id
      ,prior_plan_id
      ,client_age
      ,record_date
      ,cutoff_date
      ,r.name letter_name
FROM (select r1.case_id, m.external_num client_cin, d.name, case when to_number(to_char(r1.sent_on,'DD')) <= 4 then sent_on -4 else r1.sent_on end sent_on
--                         , row_number() over (partition by r1.case_id,d.name, trunc(case when to_number(to_char(r1.sent_on,'DD')) <= 4 then sent_on -4 else r1.sent_on end,'MM') order by case when to_number(to_char(r1.sent_on,'DD')) <= 4 then sent_on -4 else r1.sent_on end desc) rown
       from letter_request r1
       JOIN letter_definition d ON d.lmdef_id = r1.lmdef_id
       left join letter_out_header h on h.letter_req_id = r1.lmreq_id and trunc(r1.sent_on) = trunc(h.create_ts)
       left join letter_out_member m on m.letter_header_id = h.letter_header_id
        WHERE 1=1
        AND d.name in('OED','OE','OEC','OECM' ,'OEHC','OEHM','OEM')
        AND r1.status_cd in ('SENT','MAIL')
        AND TRUNC(r1.sent_on) BETWEEN ADD_MONTHS(TRUNC(sysdate,'mm'),-12) AND TRUNC(sysdate)
        ) r
  JOIN (SELECT case_id
              ,LPAD(decode(substr( regexp_replace(i.case_cin, '[^0-9]', ''),LENGTH(i.case_cin)), '0','10', substr(regexp_replace(i.case_cin, '[^0-9]', ''), LENGTH(i.case_cin))),2,'0') oe_month
              ,CASE WHEN st.PLAN_TYPE_CD = 'DENTAL' then 'DEN' when ac.subprogram_codes = 'MC' then 'MED' else ac.subprogram_codes END subprogram_code
              ,i.client_id
              , i.client_cin
              ,FLOOR(months_between(TRUNC(sysdate),i.dob)/12)  client_age --ask if this is age at the time the report is ran or at the time of open enrollment
              ,st.plan_id
              ,st.prior_plan_id
              ,st.record_date
              ,(SELECT maximus_cutoff_date_1 + 1
                FROM cutoff_calendar
                WHERE plan_service_types = 'MAINSTREAM'
                and transaction_type_cd = 'Transfer'
                AND  month_year = TO_NUMBER(decode(substr( regexp_replace(i.case_cin, '[^0-9]', ''),LENGTH(i.case_cin)), '0','10', substr(regexp_replace(i.case_cin, '[^0-9]', ''), LENGTH(i.case_cin)))-1||TO_CHAR(sysdate,'yyyy') ) ) cutoff_date
              ,(SELECT maximus_cutoff_date_1
                FROM cutoff_calendar
                WHERE plan_service_types = 'MAINSTREAM'
                and transaction_type_cd = 'Transfer'
                AND  month_year = TO_NUMBER(TO_CHAR(sysdate,'mmyyyy') ) ) current_cutoff_date
              ,(SELECT maximus_cutoff_date_1 + 1
                FROM cutoff_calendar
                WHERE plan_service_types = 'MAINSTREAM'
                and transaction_type_cd = 'Transfer'
                AND  month_year = TO_NUMBER(TO_CHAR(ADD_MONTHS(TRUNC(sysdate,'mm'),-1),'mmyyyy') ) ) previous_cutoff_date
              , ac.database_object_name letter_list
        FROM client_supplementary_info i
         JOIN case_client cc on case_client_id = cc.cscl_id
         JOIN enum_aid_category ac on cc.cscl_adlk_id = ac.value
         LEFT JOIN (SELECT st.*, COALESCE(uh.record_date,st.create_ts) record_date
                    FROM eb.selection_txn st
                    LEFT JOIN (SELECT MIN(sh.create_ts) record_date, sh.selection_txn_id
                                 FROM selection_txn_status_history sh
                                 WHERE sh.status_cd = 'uploadedToState'
                                 GROUP BY sh.selection_txn_id
                                 ) uh ON uh.selection_txn_id = st.selection_txn_id
                    WHERE (st.create_ts >= add_months(TRUNC(sysdate,'mm'),-12) OR st.status_date >= add_months(TRUNC(sysdate,'mm'),-12) )
                    AND st.transaction_type_cd = 'Transfer'
                    AND st.status_cd = 'acceptedByState' ) st ON i.client_id = st.client_id
        WHERE ac.subprogram_codes IN('DEN','MED','CSHCS','MC','HMP')
         ) cs ON r.case_id = cs.case_id --and r.rown = 1
                 and cs.client_cin = nvl(r.client_cin, cs.client_cin)
                 and (r.client_cin is not null or (r.client_cin is null and instr(cs.letter_list, r.name||',') > 0))
) p
UNION ALL
SELECT TO_CHAR(d_month) d_month
       ,d_month_num oe_month
       ,d_year oe_year
       ,null case_id
       ,null client_id
       ,'MED' subprogram_code
       ,null sent_on
       ,null plan_id
       ,null prior_plan_id
       ,null client_age
       ,null record_date
       ,null cutoff_date
       ,'OE' letter_name
       ,0 client_in_oe_month
       ,null case_in_oe_month
       ,null case_outside_oe_month
      ,0 client_outside_oe_month
      ,null client_transfer
      ,null case_under_21
      ,TO_NUMBER(d_month_num) oe_month_digit
FROM d_months

UNION ALL
SELECT TO_CHAR(d_month) d_month
       ,d_month_num oe_month
       ,d_year oe_year
       ,null case_id
       ,null client_id
       ,'DEN' subprogram_code
       ,null sent_on
       ,null plan_id
       ,null prior_plan_id
       ,null client_age
       ,null record_date
       ,null cutoff_date
       ,'OED' letter_name
       ,0 client_in_oe_month
       ,null case_in_oe_month
       ,null case_outside_oe_month
      ,0 client_outside_oe_month
      ,null client_transfer
      ,null case_under_21
      ,TO_NUMBER(d_month_num) oe_month_digit
FROM d_months;
