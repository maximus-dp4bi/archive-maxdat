CREATE OR REPLACE PROCEDURE MAXDAT_SUPPORT.INS_LAEB_413_REPORT_OE_ELIG(
REPORT_YEAR_IN IN INT,      -- yyyy ex: 2018
REPORT_DATE_IN IN VARCHAR2) -- date format dd-mmm-yyyy, ex: 19-may-2018
IS
 ECODE   NUMBER;
 EMESG   VARCHAR2(200);
BEGIN
    INSERT
INTO LAEB_413_REPORT_OE_ELIG
  (
    OE_ELIG_MEMBER_CNT,
    REGION_ID,
    REGION_NAME,
    REPORT_YEAR
  )
select COUNT (lrl.client_id) as OE_ELIG_MEMBER_CNT
       ,CASE WHEN d.VALUE IN(2,9) THEN 1
             WHEN d.VALUE IN(1,3) THEN 2
             WHEN d.VALUE IN(7,8) THEN 3
             WHEN d.VALUE IN(4,5,6) THEN 4 -- add the nulls here
             else 4
        end as region_id
       ,CASE WHEN d.VALUE IN(2,9) THEN 'Capital'
             WHEN d.VALUE IN(1,3) THEN 'Gulf'
             WHEN d.VALUE IN(7,8) THEN 'North'
             WHEN d.VALUE IN(4,5,6) THEN 'South Central'
             else 'South Central'
        end as region_name,
        REPORT_YEAR_IN AS REPORT_YEAR ---- Update report year to match the reporting dates entered below in the 'between' statement
from EB.LETTER_REQUEST_LINK lrl
inner join EB.LETTER_REQUEST lr on (lrl.LMREQ_ID = lr.LMREQ_ID and TRUNC(lr.REQUESTED_ON) between REPORT_DATE_IN and REPORT_DATE_IN) -- Enter dates here will need to be modified to meet the OE mailing dates for this year - crrent planned for 9-23-2019
inner join EB.LETTER_DEFINITION ld on (lr.LMDEF_ID = ld.LMDEF_ID and ld.LMDEF_ID in (5,79,80,81,66,71))
LEFT join EB.ADDRESS a on (lr.mailing_address_id = a.addr_id)
LEFT JOIN EB.enum_zipcode z on (a.ADDR_ZIP = z.VALUE)
LEFT join EB.enum_county c on (z.ATTRIB_county = c.VALUE)
LEFT join EB.enum_district d on (c.attrib_district_cd = d.VALUE)
group by CASE WHEN d.VALUE IN(2,9) THEN 1
             WHEN d.VALUE IN(1,3) THEN 2
             WHEN d.VALUE IN(7,8) THEN 3
             WHEN d.VALUE IN(4,5,6) THEN 4
             else 4
        end
       ,CASE WHEN d.VALUE IN(2,9) THEN 'Capital'
             WHEN d.VALUE IN(1,3) THEN 'Gulf'
             WHEN d.VALUE IN(7,8) THEN 'North'
             WHEN d.VALUE IN(4,5,6) THEN 'South Central'
             else 'South Central'
        end;
COMMIT;
EXCEPTION
 WHEN OTHERS THEN
  ECODE := SQLCODE;
  EMESG := SQLERRM;
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(ECODE) || '-' || EMESG);
END;


