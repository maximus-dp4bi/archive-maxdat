CREATE OR REPLACE VIEW MAXDAT.RTN_MAIL_BY_DAY_SV
AS
WITH prev_flag AS (
     SELECT  c.modified_date date_requested
      , c.mails_returned 
      , c.case_id
      FROM EMRS_D_CASE_HIST c
      GROUP BY  c.CASE_ID, c.modified_date, c.mails_returned
), ord_flag AS (
SELECT TRUNC(a.date_requested) d_date
      , rank() OVER (ORDER BY a.case_id,a.date_requested) rankno
      , a.mails_returned
      , a.case_id
 FROM prev_flag a
   GROUP BY TRUNC(a.date_requested), a.case_id, a.mails_returned,a.date_requested
), new_flag as ( --- first, get a list of records that setted up a new flag 
SELECT a.d_date
      , a.case_id
      , b.d_date as date_to_check
FROM ord_flag a
JOIN ord_flag b 
    ON (a.case_id = b.case_id)
WHERE b.rankno = a.rankno -1
and a.mails_returned = 'Y' 
AND b.mails_returned = 'N'
GROUP BY a.d_date, a.case_id, b.d_date
), flags AS (
SELECT a.d_date
      , CASE WHEN a.mails_returned = 'N' AND b.mails_returned = 'Y' THEN 1 ELSE 0 END unset_flag
      , NULL reset_flag
      , NULL lrl_flag
      , NULL lsp_flag
      , NULL lmer_flag 
      , NULL prl_flag
      , NULL psp_flag
      , NULL pmer_flag 
      , NULL ia_flag
FROM ord_flag a 
JOIN ord_flag b ON a.case_id = b.case_id 
WHERE b.rankno = a.rankno -1
UNION all 
 --- given this list of case ID, find if they ever have a flag before, count distinct case_ids by date that do.
SELECT  a.d_date
      , null
      , 1
      , null
      , null
      , null
      , null
      , null
      , null
      , null
FROM  new_flag a
JOIN ord_flag c
    ON (a.case_id = c.case_id) and a.date_to_check > c.d_date and  c.mails_returned = 'Y'
    GROUP BY a.d_date,a.case_id
UNION all
SELECT    TRUNC(h.DATE_REQUESTED)
        , NULL
        , null
        , CASE WHEN c.mails_returned = 'Y' AND h.bad_address_flag = 'Y' AND h.letter_type_code = 'RL' THEN 1 ELSE 0 END
        , CASE WHEN c.mails_returned = 'Y' AND h.bad_address_flag = 'Y' AND h.letter_type_code = 'SP' THEN 1 ELSE 0 END
        , CASE WHEN c.mails_returned = 'Y' AND h.bad_address_flag = 'Y' AND h.letter_type_code IN ('E1','E2','E3','E4','E5','E6','E7','ED') THEN 1 ELSE 0 END 
        , null
        , null
        , null
        , NULL 
        FROM hco_d_letter_mailing h
        JOIN emrs_d_case_hist c ON ((h.DATE_REQUESTED BETWEEN c.RECORD_START_DATE AND c.RECORD_END_DATE ) AND (c.case_id = h.CASE_ID))
        GROUP BY  TRUNC(h.DATE_REQUESTED), h.case_id, h.LETTER_TYPE_CODE, h.bad_address_flag, c.mails_returned
UNION ALL 
SELECT    TRUNC(p.DATE_REQUESTED)
        , NULL
        , null
        , null
        , null
        , null
        , CASE WHEN c.mails_returned = 'Y' AND p.bad_address_flag = 'Y' AND p.packet_type = 'RL' THEN 1 ELSE 0 END
        , CASE WHEN c.mails_returned = 'Y' AND p.bad_address_flag = 'Y' AND p.packet_type = 'SP' THEN 1 ELSE 0 END
        , CASE WHEN c.mails_returned = 'Y' AND p.bad_address_flag = 'Y' AND p.packet_type IN ('E1','E2','E3','E4','E5','E6','E7','ED') THEN 1 ELSE 0 END 
        , NULL 
        FROM HCO_D_PACKET_MAILING p
        JOIN emrs_d_case_hist c ON ((p.DATE_REQUESTED BETWEEN c.RECORD_START_DATE AND c.RECORD_END_DATE ) AND (c.case_id = p.CASE_ID))
        GROUP BY  TRUNC(p.DATE_REQUESTED), p.case_id, p.PACKET_TYPE, p.BAD_ADDRESS_FLAG, c.mails_returned
UNION ALL 
SELECT    TRUNC(r.RECORD_DATE)
        , null
        , NULL 
        , null
        , null
        , null
        , null
        , null
        , null
        , CASE WHEN r.MAIL_RETURNED_OUTCOME_ID = 6 AND r.MAIL_TYPE = 'IA' THEN 1 ELSE 0 END IA_flag
        FROM hco_d_mail_returned r 
        WHERE r.MAIL_RETURNED_OUTCOME_ID = 6 
        AND r.MAIL_TYPE = 'IA'
        GROUP BY TRUNC(r.RECORD_DATE), r.mail_TYPE,  r.case_id, r.MODIFIED_DATE, r.MAIL_RETURNED_OUTCOME_ID
) , flag_ltr_type AS (
SELECT d_date
     , nvl(sum(unset_flag),0) flag_cnt
     , nvl(sum(reset_flag),0) reflag_cnt  
     , nvl(sum(lrl_flag),0) + nvl(sum(prl_flag),0) RL_cnt
     , nvl(sum(lsp_flag),0) + nvl(sum(psp_flag),0) SP_cnt
     , nvl(sum(lmer_flag),0) + nvl(sum(pmer_flag),0) MER_cnt
     , nvl(sum(IA_FLAG),0) IA_cnt
    FROM flags 
    GROUP BY d_date
    ORDER BY d_date
)
SELECT DISTINCT d.D_DATE
, b.flag_cnt
, b.reflag_cnt
, b.rl_cnt
, b.sp_cnt
, b.mer_cnt
, b.ia_cnt
, d.d_week_num Business_week
, d.last_weekday Last_Weekday
, d.d_week_num Week_of_Year
, d.d_day Day
, d.d_date Date_ID
, d.d_day_name Date_Name
, d.d_day_of_month Day_of_Month
, d.d_day_of_week Day_of_Week
, d.d_day_of_year Day_of_Year
, d.d_month_name Month_Name
, d.d_month_num Month_Num
, to_number(to_char(d.d_date, 'YYYYMMDD')) Date_Num
, d.d_week_of_month Week_of_Month
--, d.d_week_num Week_of_Year
, d.weekend_flag Weekend_Flag
, d.d_year Year
FROM D_DATES_sv d 
JOIN flag_ltr_type b ON (d.D_DATE = b.d_date) 
GROUP BY d.d_date
, b.flag_cnt
, b.reflag_cnt
, b.rl_cnt
, b.sp_cnt
, b.mer_cnt
, b.ia_cnt
, d.d_week_num
, d.last_weekday
, d.d_week_num
, d.d_day
, d.d_date
, d.d_day_name
, d.d_day_of_month
, d.d_day_of_week
, d.d_day_of_year
, d.d_month_name
, d.d_month_num
, to_number(to_char(d.d_date, 'YYYYMMDD'))
, d.d_week_of_month
--, d.d_week_num Week_of_Year
, d.weekend_flag
, d.d_year
ORDER BY d.d_date;
/

GRANT SELECT ON MAXDAT.RTN_MAIL_BY_DAY_SV TO MAXDAT_READ_ONLY;
