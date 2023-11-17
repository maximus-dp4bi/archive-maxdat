CREATE OR REPLACE VIEW f_digital_opt_outs_by_month_sv
AS
WITH d_date AS(
SELECT d_month_start current_month, TRUNC(d_month_start-1,'mm') report_month_start,d_month_start-1 report_month_end
FROM d_months
WHERE d_month_start>= ADD_MONTHS(TRUNC(sysdate,'mm'),-6)),
txt_evnt AS(
SELECT case_id,create_ts
FROM d_digital_event ev
WHERE (ev.event_type_cd IN ('OPT_OUT_SMS', 'DIG_OPT_OUT_SMS')
       AND ev.comments like '%{PHONE_TYPE:CM}%')
AND ev.created_by not in ('-11')),
eml_evnt AS(
SELECT case_id,create_ts
FROM d_digital_event ev
WHERE ev.event_type_cd IN ('OPT_OUT_EMAIL', 'DIG_OPT_OUT_EMAIL')       
AND ev.created_by not in ('-11') ),
pstl_evnt AS(
SELECT case_id,create_ts
FROM d_digital_event ev
WHERE ev.event_type_cd = 'CASE_PREFERRED_TO_POSTAL'     
AND ev.created_by not in ('-11') )
SELECT report_month_start, 'SMS Only' AS contact_type, COUNT(DISTINCT ev.case_id) AS total_opt_out_cases
FROM d_date
 JOIN txt_evnt ev ON ev.create_ts >= report_month_start AND ev.create_ts < current_month
GROUP BY report_month_start, 'SMS Only'
UNION ALL
SELECT report_month_start, 'Email Only' AS contact_type, COUNT(DISTINCT ev.case_id) AS total_opt_out_cases
FROM d_date
 JOIN eml_evnt ev ON ev.create_ts >= report_month_start AND ev.create_ts < current_month
GROUP BY report_month_start, 'Email Only'
UNION ALL
SELECT report_month_start, 'Both SMS and Email'  AS contact_type, COUNT(DISTINCT ev.case_id) AS total_opt_out_cases
FROM d_date
 JOIN pstl_evnt ev ON ev.create_ts >= report_month_start AND ev.create_ts < current_month
GROUP BY report_month_start, 'Both SMS and Email';

GRANT SELECT ON f_digital_opt_outs_by_month_sv to MAXDAT_LAEB_READ_ONLY;	

