CREATE OR REPLACE VIEW f_digital_subscriptions_by_month_sv
AS
WITH d_date AS(
SELECT d_month_start d_month, TRUNC(d_month_start-1,'mm') report_month
FROM d_months
WHERE d_month_start>= ADD_MONTHS(TRUNC(sysdate,'mm'),-6)),
evnt AS(SELECT d_month,ev.case_id ,ev.create_ts,event_type_cd
FROM d_date
  JOIN d_digital_event ev ON TRUNC(ev.create_ts) >= d_month
WHERE  ev.event_type_cd IN ('OPT_IN_SMS','OPT_IN_EMAIL') ),
email AS
(SELECT  c.case_status, c.case_id,TRUNC(email_begin_date) email_begin_date,COALESCE(e.email_end_date,TO_DATE('12/31/2099','mm/dd/yyyy')) email_end_date
 FROM emrs_d_case c
 JOIN emrs_d_email_address e  ON c.case_id = e.email_case_id
 WHERE c.pref_contact_method_cd='DIGITAL'
 AND ((TRUNC(SYSDATE, 'DDD') < TRUNC(e.email_end_date, 'DDD')) OR (e.email_end_date is null))
 AND e.email_bad_date IS null
 AND e.contact_method_ind = 1),
txt AS 
(SELECT c.case_status, c.case_id,TRUNC(phon_begin_date) phon_begin_date,COALESCE(phon_end_date,TO_DATE('12/31/2099','mm/dd/yyyy')) phon_end_date
 FROM emrs_d_case c
   JOIN emrs_d_phone ph ON c.case_id = ph.case_id
 WHERE c.pref_contact_method_cd='DIGITAL'
 AND ((TRUNC(SYSDATE, 'DDD') < TRUNC(ph.phon_end_date, 'DDD')) OR (ph.phon_end_date is null))
 AND ph.phon_bad_date IS null
 AND ph.sms_enabled_ind = 1
 AND ph.phon_type_cd='CM'),
 rslt AS(
SELECT d_date.report_month,case_status,'Email Only' contact_type, COUNT(DISTINCT email.case_id)
FROM d_date
 CROSS JOIN email   
WHERE NOT EXISTS(SELECT 1 FROM txt WHERE txt.case_id = email.case_id)
AND NOT EXISTS(SELECT 1 FROM evnt WHERE evnt.case_id = email.case_id AND evnt.d_month = d_date.d_month AND evnt.event_type_cd = 'OPT_IN_EMAIL')
GROUP BY d_date.report_month,case_status,'Email Only'
UNION ALL
SELECT d_date.report_month,case_status,'SMS Only' contact_type, COUNT(DISTINCT txt.case_id)
FROM  d_date
 CROSS JOIN txt   
WHERE NOT EXISTS(SELECT 1 FROM email WHERE txt.case_id = email.case_id)
AND NOT EXISTS(SELECT 1 FROM evnt WHERE evnt.case_id = txt.case_id AND evnt.d_month = d_date.d_month AND evnt.event_type_cd = 'OPT_IN_SMS')
GROUP BY d_date.report_month,case_status,'SMS Only'
UNION ALL
SELECT d_date.report_month,t.case_status,'Both SMS and Email' contact_type, COUNT(DISTINCT t.case_id)
FROM  d_date
 CROSS JOIN (SELECT email.* FROM email
                JOIN txt ON email.case_id = txt.case_id) t
WHERE NOT EXISTS(SELECT 1 FROM evnt WHERE evnt.case_id = t.case_id AND evnt.d_month = d_date.d_month AND evnt.event_type_cd = 'OPT_IN_SMS')
AND NOT EXISTS(SELECT 1 FROM evnt WHERE evnt.case_id = t.case_id AND evnt.d_month = d_date.d_month AND evnt.event_type_cd = 'OPT_IN_EMAIL')
GROUP BY d_date.report_month,t.case_status,'Both SMS and Email'
)
SELECT * FROM rslt;

GRANT SELECT ON f_digital_subscriptions_by_month_sv to MAXDAT_LAEB_READ_ONLY;	

