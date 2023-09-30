CREATE OR REPLACE VIEW D_LETTER_REQUEST_SV
AS
SELECT 
letter_id
,letter_requested_on
,letter_status_cd
,letter_status
,letter_create_ts
,letter_update_ts
,letter_sent_on
,program_code
,program
,driver_table_name
,letter_mailed_date
,letter_reject_reason
,letter_printed_on
,letter_error_codes
,residence_county
,residence_zip_code
,letter_case_id
,letter_type_cd
,letter_type
,letter_request_type
,language
,letter_driver_type
,letter_created_by
,letter_return_reason_cd
,return_reason
,letter_updated_by
,letter_return_date
,reprint_parent_lmreq_id
,parent_lmreq_mailed_date
,response_due_date
,lr.reference_type letter_reference_type
,lr.reference_id letter_reference_id
,CASE WHEN st.staff_id IS NULL THEN letter_created_by ELSE st.first_name||' '||st.last_name END created_by_staff_name
,st.staff_type_cd
,cls.case_cin state_case_id
,ai.client_cin rids_id
FROM letters_stg s
  INNER JOIN app_case_link_stg cls
    ON s.letter_case_id = cls.case_id
  INNER JOIN letter_request_link_stg lr
    ON s.letter_id = lr.lmreq_id
    AND reference_type = 'APP_HEADER'
    AND lr.reference_id = cls.application_id
  LEFT JOIN app_individual_stg ai
    ON cls.application_id = ai.application_id
    AND applicant_ind = 1
  LEFT OUTER JOIN d_staff st
  ON s.letter_created_by = TO_CHAR(st.staff_id)    
--WHERE lr.reference_id >= 320
with read only;

grant select on D_LETTER_REQUEST_SV to MAXDAT_READ_ONLY;