--UAT Deployment

CREATE or Replace VIEW MAXDAT_SUPPORT.D_CLIENT_SV
AS SELECT cl.clnt_client_id client_id
  ,cl.clnt_cin client_cin
  ,cl.clnt_fname first_name
  ,cl.clnt_mi middle_initial
  ,cl.clnt_lname last_name
  ,CASE WHEN LENGTH(TRIM(cl.clnt_lname)) < 1 THEN TRIM(cl.clnt_fname)
        WHEN LENGTH(TRIM(cl.clnt_fname)) < 1 THEN TRIM(cl.clnt_lname)
        ELSE TRIM(cl.clnt_lname) || ', ' || TRIM(cl.clnt_fname)
        END AS full_name
  ,cl.clnt_ssn ssn
  ,cl.clnt_dob dob
  ,cl.clnt_generic_field4_num sec_id
  ,cl.clnt_generic_field6_txt MEDICAID_ID
  ,cl.clnt_generic_field5_txt harmony_case_id
  ,COALESCE(cl.client_language, 'UD') language_code
  ,cl.clnt_ethnicity AS CLNT_ETHNICITY 
  ,cl.clnt_race AS RACE
  ,cl.clnt_gender_cd AS GENDER
FROM client cl;

GRANT SELECT ON D_CLIENT_SV TO MAXDAT_REPORTS;

CREATE or replace VIEW MAXDAT_SUPPORT.D_PA_CLIENT_SV
AS SELECT cl.clnt_client_id client_id
  ,cl.clnt_cin client_cin
  ,cl.clnt_fname first_name
  ,cl.clnt_mi middle_initial
  ,cl.clnt_lname last_name
  ,CASE WHEN LENGTH(TRIM(cl.clnt_lname)) < 1 THEN TRIM(cl.clnt_fname) 
        WHEN LENGTH(TRIM(cl.clnt_fname)) < 1 THEN TRIM(cl.clnt_lname)
        ELSE TRIM(cl.clnt_lname) || ', ' || TRIM(cl.clnt_fname) 
        END AS full_name
  ,cl.clnt_ssn ssn
  ,cl.clnt_dob dob
  ,cl.clnt_generic_field4_num sec_id
  ,cl.clnt_generic_field6_txt ma_id
  ,cl.clnt_generic_field5_txt harmony_case_id
  ,COALESCE(cl.client_language, 'UD') language_code
  ,cl.clnt_ethnicity AS CLNT_ETHNICITY 
  ,cl.clnt_race AS RACE
  ,cl.clnt_gender_cd AS GENDER
FROM client cl;

GRANT SELECT ON D_PA_CLIENT_SV TO MAXDAT_REPORTS;

commit;
