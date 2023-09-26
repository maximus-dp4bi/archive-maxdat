CREATE OR REPLACE VIEW d_pa_agency_sv
AS
  SELECT agency_id
         ,agency_cd
         ,agency_name
         ,first_name
         ,last_name
         ,street_address_1
         ,street_address_2
         ,state_cd
         ,city
         ,zipcode
         ,county_cd
         ,phone_number
         ,fax_number
         ,email
         ,preferred_comm_mode
         ,TRUNC(begin_date) AS agency_begin_date
         ,TRUNC(end_date) AS agency_end_date
         ,created_by AS agency_created_by
         ,TRUNC(create_ts) AS agency_created_date
         ,updated_by AS agency_updated_by
         ,TRUNC(update_ts) AS agency_update_date
         ,CAST(comments AS VARCHAR(4000)) AS agency_comments --(note this is a clob)
  FROM ats.agency
  UNION ALL
  SELECT -1 AS agency_id
         ,'UD' AS agency_cd
         ,'Undefined' AS agency_name
         ,'Undefined' AS First_name
         ,'Undefined' AS last_name
         ,'Undefined' AS street_address_1
         ,'' AS street_address_2
         ,'UD' AS state_cd
         ,'Undefined' AS city
         ,'' AS zipcode
         ,'UD' AS county_cd
         ,NULL AS phone_number
         ,NULL AS fax_number
         ,'' AS email
         ,'' AS preferred_comm_mode
         ,to_date('01/01/1900', 'mm/dd/yyyy') AS agency_begin_date
         ,to_date('12/31/2050', 'mm/dd/yyyy') AS agency_end_date
         ,NULL AS agency_created_by
         ,to_date('01/01/1900', 'mm/dd/yyyy') AS agency_created_date
         ,NULL AS agency_updated_by
         ,to_date('01/01/1900', 'mm/dd/yyyy') AS agency_update_date
         ,NULL AS agency_comments
  FROM DUAL;

GRANT SELECT ON D_PA_AGENCY_SV TO MAXDAT_REPORTS;