CREATE OR REPLACE VIEW D_CLIENT_SV AS
SELECT 
client_id
,case_id
,case_cin state_case_id
,clnt_fname first_name
,clnt_lname last_name
,clnt_mi middle_initial
,clnt_gender_cd gender_code
,clnt_citizen citizen_code
,clnt_dob dob
,clnt_ssn ssn
,clnt_cin rids_id
,created_by
,creation_date
,last_updated_by
,last_update_date
,clnt_display_name display_name
,client_type_cd
,supplemental_nbr coverkids_id
,client_language 
,clnt_generic_field1_date
,clnt_generic_field2_date
,clnt_generic_field3_num
,clnt_generic_field4_num
,clnt_generic_field5_txt
,clnt_generic_field6_txt
,clnt_generic_field7_txt
,clnt_generic_field8_txt
,clnt_generic_field9_txt
,clnt_generic_field10_txt
,clnt_generic_ref11_id
,clnt_generic_ref12_id
,suffix
,CASE WHEN clnt_generic_field8_txt IS NOT NULL THEN
  (SELECT cscl_adlk_id
   FROM case_client_stg cc
   WHERE cc.client_id =  cl.client_id 
   AND cc.cscl_adlk_id != '00'
   AND cscl_id = (SELECT MAX(cscl_id) FROM case_client_stg cc1 
                  WHERE cc.client_id = cc1.client_id
                  AND cc1.cscl_adlk_id != '00'))||' '||clnt_generic_field8_txt 
 ELSE (SELECT adlk_subprogram
       FROM case_client_stg cc
       WHERE cc.client_id =  cl.client_id 
       AND cc.cscl_adlk_id != '00'
       AND cscl_id = (SELECT MAX(cscl_id) FROM case_client_stg cc1 
                      WHERE cc.client_id = cc1.client_id
                      AND cc1.cscl_adlk_id != '00')) END  previous_aid_category
FROM client_stg cl;

GRANT SELECT ON D_CLIENT_SV to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_AUTHORIZED_CONTACT_SV AS
SELECT 
authorized_contact_id
,ac_type_code
,ac_case_id
,ac_mail_process_code
,ac_first_name
,ac_last_name
,ac_address_street_1
,ac_address_street_2
,ac_address_attn
,ac_address_city
,ac_address_state_code
,ac_address_zip	
,ac_address_zip4
,ac_address_country
,ac_phone_area_code
,ac_phone_number
,ac_status_code
,ac_status_date	
,ac_generic_field1_date
,ac_generic_field2_date
,ac_generic_field3_num
,ac_generic_field4_num
,ac_generic_field5_txt
,ac_generic_field6_txt
,ac_generic_field7_txt
,ac_generic_field8_txt
,ac_generic_field9_txt
,ac_generic_field10_txt
,ac_start_date
,ac_end_date
,ac_create_ts
,ac_created_by
,ac_update_ts
,ac_updated_by
FROM authorized_contact_stg;

GRANT SELECT ON D_AUTHORIZED_CONTACT_SV to MAXDAT_READ_ONLY;