CREATE TABLE LAEB_413_REPORT_OE_ELIG 
( OE_ELIG_MEMBER_CNT INT NOT NULL,
  REGION_ID          INT NOT NULL,
  REGION_NAME    VARCHAR2(15) NOT NULL,
  REPORT_YEAR        INT NOT NULL
) tablespace &tablespace_name;
  

GRANT SELECT ON LAEB_413_REPORT_OE_ELIG to &role_name;

/*Create or replace view LAEB_413_REPORT_OE_ELIG_SV AS
select OE_ELIG_MEMBER_CNT AS OE_ELIG_MEMBER_COUNT,
   REGION_ID AS REGION_ID,
   REGION_NAME AS REGION_NAME,
   REPORT_YEAR AS REPORT_YEAR
FROM LAEB_413_REPORT_OE_ELIG;*/

CREATE OR REPLACE VIEW LAEB_413_REPORT_OE_ELIG_SV AS
SELECT COUNT (lrl.client_id) as OE_ELIG_MEMBER_COUNT
       ,COALESCE(d.region_id,4) region_id
       ,r.region_name
       ,TO_CHAR(lr.REQUESTED_ON,'YYYY') report_year       
FROM D_LETTER_REQUEST_LINK lrl
INNER JOIN D_LETTER_REQUEST lr on (lrl.letter_request_id = lr.letter_request_id)
INNER JOIN D_LETTER_DEFINITION ld on (lr.LMDEF_ID = ld.LMDEF_ID and ld.LMDEF_ID in (5,79,80,81,66,71))
LEFT JOIN EMRS_D_ADDRESS a on (lr.mailing_address_id = a.addr_id)
LEFT JOIN EMRS_D_ZIPCODE z on (a.ADDR_ZIP = z.zip_code)
LEFT JOIN EMRS_D_COUNTY c on (z.zip_county = c.county_code)
LEFT JOIN EMRS_D_CARE_SERV_DELIV_AREA d on (c.district_id = d.csda_code)
LEFT JOIN EMRS_D_REGION r ON COALESCE(d.region_id,4) = r.region_code
WHERE TRUNC(lr.requested_on) >= TO_DATE('01/01/2018','mm/dd/yyyy')
GROUP BY COALESCE(d.region_id,4), r.region_name,TO_CHAR(lr.REQUESTED_ON,'YYYY');

GRANT SELECT ON LAEB_413_REPORT_OE_ELIG_SV to &role_name;	
