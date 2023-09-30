CREATE OR REPLACE VIEW EMRS_D_PLAN_SV
AS
  SELECT pl.plan_id source_record_id,
    ca.created_by record_name,
    pl.plan_id,
    c.program_type_cd managed_care_program,
    '0' csda,
    pl.plan_code,
    pl.plan_name,
    c.contract_name plan_abbreviation,
    ca.start_date plan_effective_date,
    contact.address1,
    contact.address2,
    contact.city,
    contact.state,
    contact.zip,
    CASE
      WHEN ca.status_cd = 'CLOSED'
      THEN 'N'
      ELSE 'Y'
    END active,
    contact.contact_first_name,
    contact.contact_initial,
    contact.contact_last_name,
    contact.contact_full_name,
    contact.contact_phone,
    NULL contact_extension,
    contact.member_contact_phone, --contact info
    CASE
      WHEN ca.auto_assignment_type_cd <> 'NO_TRANSACTIONS'
      THEN 'Y'
      ELSE 'N'
    END enrollok,
    CASE
      WHEN ca.auto_assignment_type_cd = 'ALL_TRANSACTIONS'
      THEN 'Y'
      ELSE 'N'
    END plan_assign,
    ca.create_ts record_date,
    TO_CHAR(ca.create_ts,'HH24MI') record_time,
    NULL plan_type_id,
    CASE
      WHEN c.plan_service_type_cd = 'DENTAL'
      THEN 'DENTAL'
      ELSE 'MEDICAL'
    END plan_type,
    c.plan_service_type_cd plan_service_type,
    COALESCE(TRIM(pl.comments), '0') AS program_zone_code
  FROM eb.plans pl
  JOIN eb.contract c            ON pl.plan_id = c.plan_id
  JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
  LEFT OUTER JOIN
    (SELECT contract_id, 
            pc.first_name contact_first_name,
            pc.last_name contact_last_name, 
            pc.middle_name contact_initial, 
            pc.first_name||pc.middle_name||pc.last_name contact_full_name,
            pc.phone contact_phone, 
            pc.phone member_contact_phone, 
            pca.street_1 address1,
            pca.street_2 address2,
            pca.city,pca.state,
            pca.zipcode zip 
    FROM eb.contact pc
    LEFT JOIN eb.contact_address pca ON pca.contact_id = pc.contact_id
    WHERE pc.end_date IS NULL
    AND pca.end_date IS NULL
    AND pc.contact_id =
      (SELECT MAX(contact_id)
      FROM eb.contact pc1
      WHERE pc.contract_id = pc1.contract_id
      AND pc.end_date IS NULL
      )
    ) contact ON c.contract_id = contact.contract_id
  WHERE 1=1
  AND ca.end_date IS NULL
  AND ca.status_cd = 'ACTIVE'
  AND c.end_date IS NULL
  UNION
  SELECT pl.plan_id source_record_id,
    c.created_by record_name,
    pl.plan_id,
    c.program_type_cd managed_care_program,
    '0' csda,
    pl.plan_code,
    pl.plan_name,
    c.contract_name plan_abbreviation,
    c.start_date plan_effective_date,
    contact.address1,
    contact.address2,
    contact.city,
    contact.state,
    contact.zip,
     'N'  active,
    contact.contact_first_name,
    contact.contact_initial,
    contact.contact_last_name,
    contact.contact_full_name,
    contact.contact_phone,
    NULL contact_extension,
    contact.member_contact_phone, --contact info
    'N' enrollok,
    'N' plan_assign,
    c.create_ts record_date,
    TO_CHAR(c.create_ts,'HH24MI') record_time,
    NULL plan_type_id,
    CASE
      WHEN c.plan_service_type_cd = 'DENTAL'
      THEN 'DENTAL'
      ELSE 'MEDICAL'
    END plan_type,
    c.plan_service_type_cd plan_service_type,
    COALESCE(TRIM(pl.comments), '0') AS program_zone_code
  FROM eb.plans pl
  JOIN eb.contract c            ON pl.plan_id = c.plan_id
  LEFT OUTER JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
  LEFT OUTER JOIN
    (SELECT contract_id, 
            pc.first_name contact_first_name,
            pc.last_name contact_last_name, 
            pc.middle_name contact_initial, 
            pc.first_name||pc.middle_name||pc.last_name contact_full_name,
            pc.phone contact_phone, 
            pc.phone member_contact_phone, 
            pca.street_1 address1,
            pca.street_2 address2,
            pca.city,pca.state,
            pca.zipcode zip 
    FROM eb.contact pc
    LEFT OUTER JOIN eb.contact_address pca ON pca.contact_id = pc.contact_id
    WHERE pc.end_date IS NULL
    AND pca.end_date IS NULL
    AND pc.contact_id =
      (SELECT MAX(contact_id)
      FROM eb.contact pc1
      WHERE pc.contract_id = pc1.contract_id
      AND pc.end_date IS NULL
      )
    ) contact ON c.contract_id = contact.contract_id
WHERE (ca.contract_id IS NULL
  OR ( ca.end_date IS NOT NULL AND NOT EXISTS(SELECT 1 FROM contract_amendment ca1 WHERE ca1.contract_id = c.contract_id AND ca1.end_date IS NULL AND status_cd != 'DISREGARD')) )
UNION
  SELECT 0 source_record_id,
    NULL record_name,
    0 plan_id,
    'MEDICAID' managed_care_program,
    '0' csda,
    '0' plan_code,
    'Not Defined' plan_name,
    'Not Defined' plan_abbreviation,
    TO_DATE('01/01/1900','MM/DD/YYYY') plan_effective_date,
    NULL address1,
    NULL address2,
    NULL city,
    NULL state,
    NULL zip,
     'N'  active,
    NULL contact_first_name,
    NULL contact_initial,
    NULL contact_last_name,
    NULL contact_full_name,
    NULL contact_phone,
    NULL contact_extension,
    NULL member_contact_phone, --contact info
    'N' enrollok,
    'N' plan_assign,
    NULL record_date,
    NULL record_time,
    NULL plan_type_id,
    NULL plan_type,
    NULL plan_service_type,
    '0' AS program_zone_code
 FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_SV TO EB_MAXDAT_REPORTS; 