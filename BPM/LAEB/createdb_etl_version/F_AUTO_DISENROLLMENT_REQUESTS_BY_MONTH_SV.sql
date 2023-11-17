CREATE OR REPLACE VIEW f_auto_disenrollment_requests_by_month_sv
AS
WITH d_date AS(
SELECT d_month_start current_month, TRUNC(d_month_start-1,'mm') report_month_start,d_month_start-1 report_month_end
FROM d_months
WHERE d_month_start>= ADD_MONTHS(TRUNC(sysdate,'mm'),-6)),
swp AS(
SELECT 'SWP' AS request_type, record_date,auto_disenrollment_request_id
FROM emrs_d_auto_disenrollment_request
WHERE ad_request_notes_1 like '%SWP%'),
mobile AS(SELECT 'Mobile' AS request_type, record_date,auto_disenrollment_request_id
FROM emrs_d_auto_disenrollment_request
WHERE ad_request_notes_1 like '%Mobile%')
SELECT report_month_start,request_type,COUNT(*) total_requests
FROM d_date
  JOIN swp ON swp.record_date >= report_month_start AND swp.record_date < current_month
GROUP BY report_month_start,request_type  
UNION
SELECT report_month_start,request_type,COUNT(*) total_requests
FROM d_date
  JOIN mobile ON mobile.record_date >= report_month_start AND mobile.record_date < current_month
GROUP BY report_month_start,request_type  
;

GRANT SELECT ON f_auto_disenrollment_requests_by_month_sv to MAXDAT_LAEB_READ_ONLY;	