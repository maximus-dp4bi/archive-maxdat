CREATE OR REPLACE VIEW WR_SMS_OPT_INOUT_SV 
AS
WITH ph AS(
SELECT CASE WHEN p.created_by = '-5003' THEN 'SMS Keyword' 
            WHEN p.created_by = '-5002' THEN 'IVR'
           -- WHEN p.created_by = '-5004' THEN 'SMS Failure'
            WHEN p.created_by = 'WEB' THEN 'Website'
            ELSE 'CSR/Form' END opt_inout_source,
       1 opt_in_count,
       0 opt_out_count,
       creation_date,
       last_update_date,
       phon_end_date,       
       created_by,       
       last_updated_by,
       TRUNC(creation_date) report_date  
FROM phone_number p  
WHERE p.phon_type_cd = 'CS'
AND p.sms_enabled_ind = 1
UNION ALL
SELECT CASE WHEN p.last_updated_by = '-5003' THEN 'SMS Keyword' 
            WHEN p.last_updated_by = '-5002' THEN 'IVR'
            WHEN p.last_updated_by = '-5004' THEN 'SMS Failure'
            WHEN p.last_updated_by = 'WEB' THEN 'Website'
            ELSE 'CSR/Form' END opt_inout_source,
       0 opt_in_count,
       1 opt_out_count,            
       creation_date,
       last_update_date,
       phon_end_date,       
       created_by,       
       last_updated_by,
       TRUNC(last_update_date) report_date
FROM phone_number p
WHERE p.phon_type_cd = 'CS'
AND  p.sms_enabled_ind = 1
AND p.phon_end_date IS NOT NULL
AND TRUNC(p.phon_end_date,'MM') = TRUNC(p.last_update_date,'MM'))
SELECT  opt_inout_source,
        opt_in_count,
        opt_out_count,        
       creation_date,
       last_update_date,
       phon_end_date,       
       created_by,
       stc.staff_name created_by_staff_name,
       last_updated_by,
       stu.staff_name updated_by_staff_name,
       report_date 
FROM ph
LEFT JOIN (SELECT TO_CHAR(staff_id) staff_id, 
                    CASE WHEN last_name = 'System' AND first_name LIKE '%IVR' THEN 'IVR'
                         WHEN last_name = 'System' AND first_name LIKE '%SMSFail' THEN 'SMSFail'
                         WHEN last_name = 'System' AND first_name LIKE '%SMS' THEN 'SMS' 
                         WHEN last_name = 'System' AND first_name LIKE '%WEB' THEN 'WEB'
                     ELSE first_name||' '||last_name END staff_name 
              FROM staff) stc ON stc.staff_id = ph.created_by
  LEFT JOIN (SELECT TO_CHAR(staff_id) staff_id, 
                    CASE WHEN last_name = 'System' AND first_name LIKE '%IVR' THEN 'IVR'
                         WHEN last_name = 'System' AND first_name LIKE '%SMSFail' THEN 'SMSFail'
                         WHEN last_name = 'System' AND first_name LIKE '%SMS' THEN 'SMS' 
                         WHEN last_name = 'System' AND first_name LIKE '%WEB' THEN 'WEB'
                     ELSE first_name||' '||last_name END staff_name 
              FROM staff) stu ON stu.staff_id = ph.last_updated_by;

 GRANT SELECT ON MAXDAT_SUPPORT.WR_SMS_OPT_INOUT_SV TO MAXDAT_REPORTS;
 GRANT SELECT ON MAXDAT_SUPPORT.WR_SMS_OPT_INOUT_SV TO MAXDATSUPPORT_READ_ONLY;