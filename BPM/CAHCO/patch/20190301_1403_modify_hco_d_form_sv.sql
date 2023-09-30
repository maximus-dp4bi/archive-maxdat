CREATE OR REPLACE VIEW HCO_D_FORM_SV
AS
WITH fmsv
AS (SELECT df.*
          ,cl.out_var sla_days
          ,dr.change_reason reason_code_desc
          ,ss.selection_source
          ,ss.selection_source_id
          ,CASE WHEN reference_type = 'OCRRECORD' THEN df.record_date
                WHEN form_manually_entered = 'Y' THEN manual_enr_create_date
                WHEN form_incomplete = 'Y' THEN form_incomplete_create_date
             ELSE processed_date END new_processed_date
          ,CASE WHEN TRUNC(CASE WHEN reference_type = 'OCRRECORD' THEN record_date
                WHEN form_manually_entered = 'Y' THEN manual_enr_create_date
                WHEN form_incomplete = 'Y' THEN form_incomplete_create_date
              ELSE processed_date END) >= date_form_received THEN 
                (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
                 FROM D_DATES_SV
                 WHERE business_day_flag = 'Y'
                 AND d_date BETWEEN TRUNC(date_form_received) AND TRUNC(CASE WHEN reference_type = 'OCRRECORD' THEN df.record_date
                                                                             WHEN form_manually_entered = 'Y' THEN manual_enr_create_date
                                                                             WHEN form_incomplete = 'Y' THEN form_incomplete_create_date
                                                                          ELSE processed_date END) ) ELSE 0 END days_to_process
          ,ROW_NUMBER() OVER (PARTITION BY dcn ORDER BY record_date DESC,processed_date NULLS LAST) frn                  
    FROM hco_d_form df
      JOIN corp_etl_list_lkup cl ON df.form_type = cl.name AND cl.list_type = 'FORM_SLA_DAYS'
      LEFT JOIN emrs_d_change_reason dr ON df.change_reason_code = dr.change_reason_code
      LEFT JOIN emrs_d_selection_source ss ON df.selection_source_code = ss.selection_source_code) 
SELECT reference_id ocr_record_id,
client_number,
date_form_received,
plan_type_a plan_type,
envelope_id,
form_incomplete,
form_manually_entered,
dcn,
form_phone_number,
form_type,
incomplete_reason_code_a incomplete_reason,
form_signed,
file_rcvd_from_hyland,
campaign_completed,
record_date,
record_name,
modified_name,
modified_date,
created_by,
date_created,
updated_by,
date_updated,
dp_form_id,
esr_id,
verifier_id,
new_processed_date processed_date,
CASE WHEN processed_date IS NULL THEN 'Not Processed'
  ELSE CASE WHEN days_to_process <= sla_days THEN 'Timely' ELSE 'Untimely' END END timeliness_status,
days_to_process cycle_time,
sla_days,
days_to_process,
CASE WHEN days_to_process <= sla_days THEN 'Y' ELSE 'N' END meet_sla_flag,
created_by_agent_flag,
date_form_received arrival_date,
plan_id_a plan_id,
plan_originated_flag,
county_code,
change_reason_code reason_code,
reason_code_desc,
notes,
case_number,
enrollment_id,
selection_source,
selection_source_id
FROM fmsv
WHERE frn = 1
  ;

GRANT SELECT ON "HCO_D_FORM_SV" TO "MAXDAT_READ_ONLY";