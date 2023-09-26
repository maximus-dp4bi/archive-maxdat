SELECT DISTINCT 
pl.plan_id source_record_id,
ca.created_by record_name,
pl.plan_id,
program_type_cd managed_care_program,
'0' csda,
pl.plan_code,
pl.plan_name,
c.contract_name plan_abbreviation,
ca.start_date plan_effective_date,
pca.street_1 address1,
pca.street_2 address2,
pca.city,
pca.state,
pca.zipcode zip,
CASE WHEN ca.status_cd = 'CLOSED' THEN 'N' ELSE 'Y' END active,
pc.first_name contact_first_name,
pc.middle_name contact_initial,
pc.last_name contact_last_name,
pc.first_name||pc.middle_name||pc.last_name contact_full_name,
pc.phone contact_phone,
null contact_extension,
pc.phone member_contact_phone,  --contact info
CASE WHEN auto_assignment_type_cd != 'NO_TRANSACTIONS' THEN 'Y' ELSE 'N' END enrollok,
CASE WHEN auto_assignment_type_cd = 'ALL_TRANSACTIONS' THEN 'Y' ELSE 'N' END plan_assign,
ca.create_ts record_date,
TO_CHAR(ca.create_ts,'HH24MI') record_time,
NULL plan_type_id,
CASE WHEN plan_service_type_cd = 'DENTAL' THEN 'DENTAL' ELSE 'MEDICAL' END plan_type,
c.plan_service_type_cd plan_service_type               
   FROM eb.plans pl
     INNER JOIN eb.contract c
       ON pl.plan_id = c.plan_id
     INNER JOIN eb.contract_amendment ca
       ON c.contract_id =ca.contract_id   
     LEFT OUTER JOIN eb.contact pc
       ON pc.contract_id = c.contract_id
     LEFT OUTER JOIN eb.contact_address pca
       ON pca.contact_id = pc.contact_id        
WHERE ca.end_date IS NULL 
AND ca.status_cd = 'ACTIVE'
AND c.end_date IS NULL
AND pc.end_date IS NULL
AND pca.end_date IS NULL