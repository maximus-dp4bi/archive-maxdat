CREATE OR REPLACE VIEW EMRS_ENROLLMENT_SERVICE_REPRESENTATIVE_HOURS_BY_DATE_SV
AS
SELECT esrch_id
       ,esr.esr_id
       ,trunc(esr.esr_combined_hours_date) esr_combined_hours_date
       ,esr.esr_site_code
       ,st.esr_site_name
       ,esr.county_name
       ,esr.hours - (COALESCE(esr.floater,0) + COALESCE(esr.training,0) + COALESCE(esr.unapproved_vacation,0) + COALESCE(esr.approved_sick,0) + COALESCE(esr.unapproved_sick,0)
                       + COALESCE(esr.leave_without_pay,0) + COALESCE(esr.fmla,0) + COALESCE(esr.kin_care,0) + COALESCE(tor.timeoff_request,0) ) esr_billable_hours
       ,COALESCE(esr.floater,0) + COALESCE(esr.training,0) + COALESCE(esr.unapproved_vacation,0) + COALESCE(esr.approved_sick,0) 
        + COALESCE(esr.unapproved_sick,0) + COALESCE(esr.leave_without_pay,0) + COALESCE(esr.fmla,0) + COALESCE(esr.kin_care,0) + COALESCE(tor.timeoff_request,0) esr_non_billable_hours_count
       ,esr.hours esr_scheduled_hours_count            
       ,ee.first_name
       ,ee.last_name
FROM emrs_d_esr_hours esr
  -- JOIN emrs_d_esr_employee ee ON substr(esr.esr_id,2) = ee.esr_id --dev version, source data esrid in dev has a letter at the beginning
  JOIN emrs_d_esr_employee ee ON esr.esr_id = ee.esr_id --uat/prd version, source data is all numeric
  LEFT JOIN emrs_d_esr_site st ON esr.esr_site_code = st.esr_site_code
  --LEFT JOIN emrs_d_esr_timeoff_request tor ON trunc(esr.esr_combined_hours_date) = trunc(tor.timeoff_date) AND substr(esr.esr_id,2) = tor.esr_id AND esr.esr_site_code = tor.esr_site_code AND tor.approved = 'Y'
    LEFT JOIN (SELECT TRUNC(tor.timeoff_date) timeoff_date,tor.esr_id,tor.esr_site_code,SUM(timeoff_request) timeoff_request
             FROM  emrs_d_esr_timeoff_request tor
             WHERE tor.approved = 'Y'
             GROUP BY TRUNC(tor.timeoff_date),tor.esr_id,tor.esr_site_code) tor 
     -- ON trunc(esr.esr_combined_hours_date) = trunc(tor.timeoff_date) AND substr(esr.esr_id,2) = tor.esr_id AND esr.esr_site_code = tor.esr_site_code
      ON trunc(esr.esr_combined_hours_date) = tor.timeoff_date AND esr.esr_id = tor.esr_id AND esr.esr_site_code = tor.esr_site_code 
WHERE esr.is_valid = 'Y' 
AND esr.modified_date IS NULL;

GRANT SELECT ON "EMRS_ENROLLMENT_SERVICE_REPRESENTATIVE_HOURS_BY_DATE_SV" TO "MAXDAT_READ_ONLY";