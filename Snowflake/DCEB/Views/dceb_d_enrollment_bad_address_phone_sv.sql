create or replace view DCEB.DCEB_D_ENROLLMENT_BAD_ADDRESS_PHONE_SV(
	EXTERNAL_CONSUMER_ID,
	CONSUMER_FIRST_NAME,
	CONSUMER_LAST_NAME,
	BAD_PHONE,
	BAD_ADDRESS,
	PHONE_NUMBER,
	ADDRESS_STREET_1,
	ADDRESS_STREET_2,
	ADDRESS_CITY,
	ADDRESS_STATE,
	ADDRESS_ZIP,
	ADDRESS_ZIP_FOUR,
	ADDRESS_COUNTY,
	MAIL_QUADRANT,
	AA_OR_CHOICE,
	SUB_PROGRAM_TYPE,
	ENROLLMENT_CREATE_DATE
) as
SELECT DISTINCT cin.external_consumer_id,
  cnvw.consumer_first_name,
  cnvw.consumer_last_name,
  COALESCE(bad_phone,'No') bad_phone,
  COALESCE(bad_address, 'No') bad_address,
  bp.phone_number,
  baddr.address_street_1,
  baddr.address_street_2,
  baddr.address_city,
  baddr.address_state,
  baddr.address_zip,
  baddr.address_zip_four,
  baddr.address_county,
  baddr.sda_name mail_quadrant,  
  CASE WHEN evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','STATE_ELIGIBILITY_SYSTEM') THEN 'Choice' ELSE 'AA' END aa_or_choice,
  stvw.report_label sub_program_type,
  CAST(evw.created_on AS DATE) enrollment_create_date
FROM (SELECT * FROM marsdb.marsdb_enrollments_vw 
      WHERE project_id = 120
      AND status IN('ACCEPTED','SELECTION_MADE','SUBMITTED_TO_STATE') )evw   
  LEFT JOIN marsdb.marsdb_consumer_vw cnvw ON evw.consumer_id = cnvw.consumer_id AND evw.project_id = cnvw.project_id
  LEFT JOIN marsdb.marsdb_consumer_identification_number_vw cin ON cnvw.consumer_id = cin.consumer_id AND cnvw.project_id = cin.project_id AND cin.identification_number_type = 'MEDICAID'
  LEFT JOIN marsdb.marsdb_enum_sub_program_type_vw stvw ON evw.sub_program_type_cd = stvw.value AND evw.project_id = stvw.project_id
  LEFT JOIN marsdb.marsdb_enum_enrollment_update_reasons_vw uvw ON evw.plan_end_date_reason = uvw.value AND evw.project_id = uvw.project_id
  LEFT JOIN marsdb.marsdb_enum_plan_selection_channels_vw cvw ON evw.channel = cvw.value AND evw.project_id = cvw.project_id
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw pnvw ON evw.plan_code = pnvw.value AND evw.project_id = pnvw.project_id
  LEFT JOIN marsdb.marsdb_enum_transaction_status_vw tsvw ON evw.txn_status = tsvw.value AND evw.project_id = tsvw.project_id
  LEFT JOIN (SELECT b.address_id,b.external_ref_type,b.external_ref_id,b.project_id,
                   b.address_street_1,b.address_street_2,b.address_city,b.address_state,b.address_zip,b.address_zip_four,b.address_county,b.sda_name,
                   CASE WHEN (b.address_street_1 = ('                      0')
              OR b.address_street_1 like '899 N%Capitol%' 
              OR b.address_street_1 like '3851 ALABAMA%'
              OR replace(b.address_street_1,'.',' ') like '645 H %'
              OR b.address_street_1 like '1207 Taylor%'
              OR b.address_street_1 like '2100%M%L%K%'
              OR b.address_street_1 like '4001 S%Capitol%'
              OR b.address_street_1 like '425 Mitch%Snyder%'
              OR b.address_street_1 like '1900 Mass%'
              OR b.address_street_1 like '1234 Mass%'
              OR b.address_street_1 like '425 2nd%'
              OR b.address_street_1 like '425 Second%'
              OR b.address_street_1 like '1355 N%Y%'
              OR b.address_street_1 like '1448 Park%'
              OR b.address_street_1 like '1200 N%Capitol%' 
			  OR replace(b.address_street_1,'.',' ') like '1430 G %'
			  OR b.address_street_1 like '2840 Langston%'
			  OR b.address_street_1 like '2844 Langston%'
			  OR b.address_street_1 like '2850 Langston%'
			  OR b.address_street_1 like '2700 N%Y%'
			  OR b.address_street_1 like '2700 M%L%K%'
			  OR b.address_street_1 like '1910 Mass%'
			  OR b.address_street_1 like '1600 N%Y%'
              OR replace(b.address_street_1,'.',' ') like '609 H%'
			  OR b.address_street_1 like '4049 S%Cap%' ) THEN 'Yes' ELSE 'No' END bad_address
             FROM  (SELECT *
                    FROM (SELECT b.*,davw.sda_name,co.external_ref_type,co.external_ref_id  
                          FROM marsdb.marsdb_address_vw b                            
                              JOIN marsdb.marsdb_project_vw p ON p.project_id = b.project_id
                              JOIN marsdb.marsdb_contacts_vw ct ON b.contact_type_id = ct.contact_type_id AND b.project_id = ct.project_id
                              JOIN marsdb.marsdb_contacts_owner_vw co ON ct.owner_id = co.contact_owner_id AND ct.project_id = co.project_id   
                            LEFT JOIN marsdb.marsdb_sda_county_zip_vw davw ON b.address_zip = davw.zipcode AND b.project_id = davw.project_id
                          WHERE p.project_name = 'DC-EB'
                          AND b.address_type = 'Mailing'
                          AND UPPER(co.external_ref_type) = 'CONSUMER'                          
                          QUALIFY ROW_NUMBER() OVER(PARTITION BY co.external_ref_id ORDER BY b.effective_end_date DESC NULLS FIRST,address_id DESC ) =1) b ) b ) baddr ON evw.consumer_id = baddr.external_ref_id AND evw.project_id = baddr.project_id
  LEFT JOIN(SELECT p.*,CASE WHEN (SUBSTR(p.phone_number,1,1) = '0' OR LENGTH(RTRIM(LTRIM(p.phone_number))) < 10) THEN 'Yes' ELSE 'No' END bad_phone
            FROM(SELECT p.*,co.external_ref_type,co.external_ref_id                   
                 FROM marsdb.marsdb_phone_vw p 
                   JOIN marsdb.marsdb_project_vw pr ON p.project_id = pr.project_id
                   JOIN marsdb.marsdb_contacts_vw ct ON p.contact_type_id = ct.contact_type_id AND p.project_id = ct.project_id
                   JOIN marsdb.marsdb_contacts_owner_vw co ON ct.owner_id = co.contact_owner_id AND ct.project_id = co.project_id 
                 WHERE pr.project_name = 'DC-EB'
                 AND UPPER(co.external_ref_type) = 'CONSUMER'
                 QUALIFY ROW_NUMBER() OVER(PARTITION BY co.external_ref_id ORDER BY p.effective_end_date DESC NULLS FIRST,phone_id DESC ) =1) p ) bp ON evw.consumer_id = bp.external_ref_id AND evw.project_id = bp.project_id
WHERE (COALESCE(bad_phone,'No') = 'Yes' OR COALESCE(bad_address, 'No') = 'Yes');