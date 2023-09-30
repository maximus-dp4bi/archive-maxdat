CREATE OR REPLACE VIEW f_letters_sent_by_type_sv
AS
SELECT ld.name letter_name,
       ld.description letter_description,
       TRUNC(lr.sent_on) sent_on,
       CASE WHEN lr.language_cd = 'ES' THEN 'ES' ELSE 'EN' END language_cd,
       COALESCE(dc.district_id,'99') district,
       COALESCE(sda.csda_name,'Out of State') district_name,
       CASE WHEN dc.district_id IN('1','9') THEN 'Service Area A'
            WHEN dc.district_id IN('2','3','4') THEN 'Service Area B'
            WHEN dc.district_id IN('5','6','7','8') THEN 'Service Area C'
        ELSE 'Out Of Service Area' END district_area,
        COUNT(lr.letter_request_id) letter_count
FROM d_letter_request lr
   JOIN d_letter_definition ld ON lr.lmdef_id = ld.lmdef_id
   LEFT JOIN emrs_d_address da ON lr.mailing_address_id = da.addr_id
   LEFT JOIN (SELECT *
             FROM(SELECT case_id,addr_ctlk_id,RANK() OVER (PARTITION BY case_id ORDER BY addr_begin_date DESC,dp_address_id DESC) rnk
              FROM emrs_d_address
              WHERE addr_end_date IS NULL
              AND addr_type_cd = 'ML')
             WHERE rnk = 1) csadd ON lr.case_id = csadd.case_id
   LEFT JOIN emrs_d_county dc ON COALESCE(da.addr_ctlk_id,csadd.addr_ctlk_id) = dc.county_code
   LEFT JOIN emrs_d_care_serv_deliv_area sda ON dc.district_id = sda.csda_code
WHERE TRUNC(lr.create_ts) >= ADD_MONTHS(TRUNC(sysdate),-13)
AND lr.sent_on IS NOT NULL
 GROUP BY ld.name,
       ld.description,
       TRUNC(lr.sent_on),
       CASE WHEN lr.language_cd = 'ES' THEN 'ES' ELSE 'EN' END,
       COALESCE(dc.district_id,'99'),
       COALESCE(sda.csda_name,'Out of State'),
       CASE WHEN dc.district_id IN('1','9') THEN 'Service Area A'
            WHEN dc.district_id IN('2','3','4') THEN 'Service Area B'
            WHEN dc.district_id IN('5','6','7','8') THEN 'Service Area C'
        ELSE 'Out Of Service Area' END; 
        
GRANT SELECT ON f_letters_sent_by_type_sv to MAXDAT_LAEB_READ_ONLY;	        
