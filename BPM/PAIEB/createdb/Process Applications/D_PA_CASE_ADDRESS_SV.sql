CREATE OR REPLACE VIEW D_PA_CASE_ADDRESS_SV
AS
SELECT ac.case_id
 ,ac.application_id as app_id
 ,COALESCE(ad.addr_type_cd, mad.addr_type_cd, fad.addr_type_cd) as addr_type_cd
 ,COALESCE(ad.addr_street_1, mad.addr_street_1, fad.addr_street_1) street
 ,COALESCE(ad.addr_street_2, mad.addr_street_2, fad.addr_street_2) street_2
 ,COALESCE(ad.addr_city, mad.addr_city, fad.addr_city) city
 ,COALESCE(ad.addr_state_cd, mad.addr_state_cd, fad.addr_state_cd) state
 ,COALESCE(ad.addr_zip, mad.addr_zip, fad.addr_zip) zip_code
 ,COALESCE(ad.addr_ctlk_id, mad.addr_ctlk_id, fad.addr_ctlk_id, 'UD') AS county_code
 ,COALESCE(ad.fa_active, mad.fa_active, fad.fa_active) fa_active
FROM  app_case_link ac
LEFT JOIN (SELECT a.addr_case_id, a.addr_type_cd, a.addr_street_1,a.addr_street_2,a.addr_city,a.addr_state_cd,a.addr_zip,a.addr_ctlk_id, 'N' as fa_active
           FROM (SELECT ad.addr_case_id,ad.addr_type_cd, ad.addr_street_1,ad.addr_street_2,ad.addr_city,ad.addr_state_cd,ad.addr_zip,ad.addr_ctlk_id
                  ,ROW_NUMBER() OVER (PARTITION BY addr_case_id ORDER BY ad.creation_date DESC,ad.addr_id DESC) rn
           FROM address ad 
           WHERE ad.addr_type_cd IN('RS','MR')
           AND ad.end_ndt > TO_NUMBER(TO_CHAR(sysdate, 'yyyymmddHH24misssss'))) a
           WHERE rn = 1) ad
 ON (ac.case_id = ad.addr_case_id)
LEFT JOIN (SELECT m.addr_case_id, m.addr_type_cd,m.addr_street_1,m.addr_street_2,m.addr_city,m.addr_state_cd,m.addr_zip,m.addr_ctlk_id, 'N' as fa_active
           FROM (SELECT ad.addr_case_id,ad.addr_type_cd,ad.addr_street_1,ad.addr_street_2,ad.addr_city,ad.addr_state_cd,ad.addr_zip,ad.addr_ctlk_id
                  ,ROW_NUMBER() OVER (PARTITION BY addr_case_id ORDER BY ad.creation_date DESC,ad.addr_id DESC) rn
           FROM address ad 
           WHERE ad.addr_type_cd IN('MM','ML')
           AND ad.end_ndt > TO_NUMBER(TO_CHAR(sysdate, 'yyyymmddHH24misssss'))) m
           WHERE rn = 1) mad
 ON (ac.case_id = mad.addr_case_id) 
LEFT JOIN (SELECT f.addr_case_id, f.addr_type_cd,f.addr_street_1,f.addr_street_2,f.addr_city,f.addr_state_cd,f.addr_zip,f.addr_ctlk_id, 'Y' as fa_active
           FROM (SELECT ad.addr_case_id,ad.addr_type_cd,ad.addr_street_1,ad.addr_street_2,ad.addr_city,ad.addr_state_cd,ad.addr_zip,ad.addr_ctlk_id
                  ,ROW_NUMBER() OVER (PARTITION BY ad.addr_case_id ORDER BY ad.ADDR_END_DATE DESC,ad.addr_id DESC) rn
           FROM address ad 
           WHERE ad.addr_type_cd IN('RS','MR','MM','ML')
           AND NOT EXISTS (SELECT 1 FROM address 
                                        WHERE addr_type_cd IN('RS','MR','MM','ML') AND end_ndt > TO_NUMBER(TO_CHAR(sysdate, 'yyyymmddHH24misssss'))
                                        AND addr_case_id = ad.addr_case_id)
           AND EXISTS (SELECT 1 FROM address 
                                        WHERE addr_type_cd = 'FA' AND end_ndt > TO_NUMBER(TO_CHAR(sysdate, 'yyyymmddHH24misssss'))
                                        AND addr_case_id = ad.addr_case_id)) f
           WHERE rn = 1) fad
 ON (ac.case_id = fad.addr_case_id);
    
GRANT SELECT ON D_PA_CASE_ADDRESS_SV TO MAXDAT_REPORTS;  


