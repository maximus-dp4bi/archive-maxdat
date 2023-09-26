CREATE OR REPLACE VIEW OE_ELIGIBILITY_DENTAL_MEMBER_COUNT_BY_PLAN_SV AS
SELECT oe_eligibility_dental_member_count
       ,region_id
       ,region_name
       ,report_year
       ,plan_id
       ,plan_id_ext
       ,plan_name
FROM(
  SELECT COUNT (lrl.client_id) as oe_eligibility_dental_member_count
         ,COALESCE(d.region_id,4) region_id
         ,r.region_name
         ,TO_CHAR(lr.REQUESTED_ON,'YYYY') report_year       
  FROM D_LETTER_REQUEST_LINK lrl
    INNER JOIN D_LETTER_REQUEST lr on (lrl.letter_request_id = lr.letter_request_id)
    INNER JOIN D_LETTER_DEFINITION ld on (lr.LMDEF_ID = ld.LMDEF_ID and ld.name IN('OED','OWD','BWD','OBD','DEO','OE','OB'))
    LEFT JOIN EMRS_D_ADDRESS a on (lr.mailing_address_id = a.addr_id)
    LEFT JOIN EMRS_D_ZIPCODE z on (a.ADDR_ZIP = z.zip_code)
    LEFT JOIN EMRS_D_COUNTY c on (z.zip_county = c.county_code)
    LEFT JOIN EMRS_D_CARE_SERV_DELIV_AREA d on (c.district_id = d.csda_code)
    LEFT JOIN EMRS_D_REGION r ON COALESCE(d.region_id,4) = r.region_code
  WHERE TRUNC(lr.requested_on) >= TO_DATE('01/01/2020','mm/dd/yyyy')
  AND lr.status_cd IN ('SENT', 'COMBND', 'MAIL','PDF-GEN')
  GROUP BY COALESCE(d.region_id,4), r.region_name,TO_CHAR(lr.REQUESTED_ON,'YYYY') ) ltr
CROSS JOIN (SELECT plan_id,plan_id_ext, plan_name
            FROM emrs_d_plan
            WHERE plan_service_type_cd = 'DENTAL') pl;

GRANT SELECT ON OE_ELIGIBILITY_DENTAL_MEMBER_COUNT_BY_PLAN_SV to MAXDAT_LAEB_READ_ONLY;	

