CREATE OR REPLACE VIEW dceb.dceb_d_provider_details_sv
AS
SELECT LTRIM(RTRIM(COALESCE(pn.first_name, ''))) AS FirstName
      ,LTRIM(RTRIM(COALESCE(pn.last_name, '')))  AS LastName
      ,CASE WHEN pn.gender_cd = 'M' THEN 'Male'
            WHEN pn.gender_cd = 'F' THEN 'Female'
            ELSE 'Unknown' END              AS Gender
      ,CASE WHEN pt.provider_type_cd = 'M' THEN LTRIM(RTRIM(COALESCE(pn.last_name, '')))
            WHEN pt.provider_type_cd = 'P' THEN CONCAT(LTRIM(RTRIM(COALESCE(pn.first_name, ''))),' ',LTRIM(RTRIM(COALESCE(pn.last_name, ''))))
        ELSE NULL END  AS Organization   -- defaulted to null    
      ,pn.npi                               AS ProviderID
      ,pn.age_high_limit                    AS MaxAge
      ,LTRIM(RTRIM((SUBSTRING(COALESCE(pn.middle_name, ''),1,1)))) AS MiddleInit
      ,pn.age_low_limit                     AS MinAge
      ,LTRIM(RTRIM(COALESCE(pn.name_suffix,''))) AS NameSuffix
      ,pn.pcp_flag
      ,enpt.report_label                    AS ProviderType
      ,pt.provider_type_cd                  AS ProviderTypeCode
      ,pn.accepts_new_patients_ind          AS MCOAcceptingNew
      ,pn.plan_name                         AS MCOName
      ,pn.program_type_cd                   AS ProgramName
      ,COALESCE(enps.report_label,'')            AS Specialty
      ,LTRIM(RTRIM(COALESCE(pa.address_line_1,''))) AS Addr1
      ,LTRIM(RTRIM(COALESCE(pa.address_line_2,''))) AS Addr2
      ,LTRIM(RTRIM(COALESCE(pa.city,'')))        AS City
      ,COALESCE(enc.report_label,'')             AS County
      ,ppn.phone_number                     AS Phone
      ,pa.state                             AS State
      ,CASE WHEN LTRIM(RTRIM(zip_code4)) = '' THEN pa.zip_code ELSE pa.zip_code||'-'||pa.zip_code4 END AS ZipCode
      ,enpl.report_label                    AS Language
      ,CASE WHEN pn.handicapped_accesible_ind = 1 THEN 'Y' ELSE 'N' END AS WheelchairAccess
      ,pn.effective_start_date
      ,pn.effective_end_date
FROM  marsdb.marsdb_provider_network_vw pn
LEFT JOIN marsdb.marsdb_project_vw p ON (p.project_id = pn.project_id)
LEFT JOIN marsdb.marsdb_provider_type_vw pt ON (pt.plan_provider_id = pn.plan_provider_id AND pt.project_id = p.project_id)
LEFT JOIN marsdb.marsdb_enum_provider_type_vw enpt ON (pt.provider_type_cd = enpt.value AND enpt.project_id = p.project_id)
LEFT JOIN marsdb.marsdb_provider_speciality_vw ps ON (ps.plan_provider_id = pn.plan_provider_id AND ps.project_id = p.project_id)
LEFT JOIN marsdb.marsdb_enum_provider_speciality_vw enps ON (ps.speciality_cd = enps.value AND enps.project_id = p.project_id)
LEFT JOIN marsdb.marsdb_provider_address_vw pa ON (pa.plan_provider_id = pn.plan_provider_id AND pa.project_id = p.project_id)
LEFT JOIN marsdb.marsdb_enum_county_vw enc ON (pa.county_cd = substr(enc.value,2,2) AND enc.project_id = p.project_id)
LEFT JOIN marsdb.marsdb_provider_phone_number_vw ppn ON (pa.address_id = ppn.address_id AND ppn.project_id = p.project_id)
LEFT JOIN marsdb.marsdb_provider_language_vw pl ON (pl.plan_provider_id = pn.plan_provider_id AND pl.project_id = p.project_id)
LEFT JOIN marsdb.marsdb_enum_language_code_v2_vw enpl ON (pl.language_type_cd = enpl.value AND enpl.project_id = p.project_id)
WHERE  p.project_name = 'DC-EB'
;