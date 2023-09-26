CREATE OR REPLACE VIEW PUBLIC.D_PM_PROVIDER_INSTANCE_SV AS
SELECT  d.PROVIDER_ID                                                                                                       AS  PROVIDER_ID,        
        d.PROVIDER_FIRST_NAME                                                                                               AS  PROVIDER_FIRST_NAME,        
        d.PROVIDER_LAST_NAME                                                                                                AS  PROVIDER_LAST_NAME,
        d.PROVIDER_NAME                                                                                                     AS  PROVIDER_NAME,
        d.PROVIDER_NPI                                                                                                      AS  PROVIDER_NPI,
        d.PROVIDER_SPECIALTY                                                                                                AS  PROVIDER_SPECIALTY,                       
        d.PROVIDER_PRIMARY_SPECIALTY                                                                                        AS  PROVIDER_PRIMARY_SPECIALTY,                               
        pt.PROVIDER_TYPE_NAME                                                                                               AS  PROVIDER_TYPE,
        ra.CITY                                                                                                             AS  PROVIDER_CITY,
        c.COUNTY_NAME                                                                                                       AS  PROVIDER_COUNTY,
        cr.COUNTY_REGION                                                                                                    AS  PROVIDER_REGION,
        d.PROVIDER_LANGUAGE                                                                                                 AS  PROVIDER_LANGUAGE,
	d.PROVIDER_ID													    AS	APPLICATION_ID,			
        es.ENROLL_STATUS_DESC                                                                                               AS  ENROLLMENT_STATUS,
        pt.MMIS_PROVIDER_TYPE_ID                                                                                            AS PROVIDER_TYPE_CODE_MMIS,
        d.DELEGATED_PROVIDER_INDICATOR                                                                                      AS DELEGATED_PROVIDER_INDICATOR
  FROM  (
            SELECT  rp.REG_ID                                                                                               AS  PROVIDER_ID,                    
                    rp.FIRST_NAME                                                                                           AS  PROVIDER_FIRST_NAME,                    
                    rp.LAST_NAME                                                                                            AS  PROVIDER_LAST_NAME,
                    CASE WHEN LEN(rp.LAST_NAME) > 0  THEN NULL ELSE rp.NAME END                                             AS  PROVIDER_NAME,
                    rp.NPI                                                                                                  AS  PROVIDER_NPI,    
                    rp.CONTACT_CITY                                                                                         AS  PROVIDER_CITY,
                    rp.CONTACT_COUNTY                                                                                       AS  PRODIVER_COUNTY,
                    rp.CONTACT_QUADRANT                                                                                     AS  PROVIDER_REGION,                    
                    (
                        SELECT  MAX(ro.REG_ADDRESS_ID)    
                          FROM  OHPNM_DP4BI.REG_OWNER                   ro
                                INNER JOIN OHPNM_DP4BI.REG_ADDRESS      ra ON (ro.REG_ID = ra.REG_ID)
                         WHERE  ro.REG_ID = rp.REG_ID
                           AND  TO_DATE(SYSDATE()) BETWEEN ro.BEGIN_DATE AND ro.END_DATE
                           AND  ra.COUNTY != '99'
                    )                                                                                                       AS  REG_ADDRESS_ID,
                    (
                        SELECT  LISTAGG(st.SPECIALTY_TYPE_NAME, ', ') WITHIN GROUP (ORDER BY st.SPECIALTY_TYPE_NAME)
                          FROM  OHPNM_DP4BI.REG_SPECIALTY               rs
                                INNER JOIN OHPNM_DP4BI.SPECIALTY_TYPE   st ON (rs.SPECIALTY_TYPE_ID = st.SPECIALTY_TYPE_ID)
                         WHERE  rs.REG_ID = rp.REG_ID
                           AND  TO_DATE(SYSDATE()) BETWEEN rs.START_DATE AND rs.END_DATE
                                
                    )                                                                                                       AS  PROVIDER_SPECIALTY, 
                    (
                        SELECT  MAX(st.SPECIALTY_TYPE_NAME)
                          FROM  OHPNM_DP4BI.REG_SPECIALTY               rs
                                INNER JOIN OHPNM_DP4BI.SPECIALTY_TYPE   st ON (rs.SPECIALTY_TYPE_ID = st.SPECIALTY_TYPE_ID)
                         WHERE  rs.REG_ID = rp.REG_ID
                           AND  rs.PRIMARY_FLAG = TRUE
                           AND  TO_DATE(SYSDATE()) BETWEEN rs.START_DATE AND rs.END_DATE
                                
                    )                                                                                                       AS  PROVIDER_PRIMARY_SPECIALTY,                      
                    (
                        SELECT  LISTAGG(ls.DESC_LANGUAGES_SPOKEN, ', ') WITHIN GROUP (ORDER BY ls.DESC_LANGUAGES_SPOKEN)
                          FROM  OHPNM_DP4BI.REG_LANGUAGE                rl
                                INNER JOIN OHPNM_DP4BI.LANGUAGES_SPOKEN ls ON (rl.LANGUAGE_CODE = ls.LANGUAGES_SPOKEN_ID)
                         WHERE  rl.REG_ID = rp.REG_ID
                           AND  TO_DATE(SYSDATE()) BETWEEN rl.START_DATE AND rl.END_DATE
                    )                                                                                                       AS  PROVIDER_LANGUAGE,                    
                    rp.PROVIDER_TYPE_ID                                                                                     AS  PROVIDER_TYPE_ID,
                    rp.ENROLLMENT_STATUS_CODE                                                                               AS  ENROLLMENT_STATUS_CODE,
                    CASE WHEN rp.odm_credentialing_delegates_ischecked = 'TRUE' THEN 'Y' ELSE 'N' END                       AS  DELEGATED_PROVIDER_INDICATOR
              FROM  OHPNM_DP4BI.REG_PROVIDER                                        rp               
        ) d        
        LEFT JOIN OHPNM_DP4BI.PROVIDER_TYPE pt ON (d.PROVIDER_TYPE_ID = pt.PROVIDER_TYPE_ID)
        LEFT JOIN OHPNM_DP4BI.REG_ADDRESS ra ON (d.REG_ADDRESS_ID = ra.REG_ADDRESS_ID)
        LEFT JOIN OHPNM_DP4BI.COUNTY c ON (ra.COUNTY = c.MMIS_COUNTY_CODE AND c.MMIS_COUNTY_CODE != '99')
        LEFT JOIN OHPNM_DP4BI.COUNTY_REGION cr ON (cr.COUNTY_NAME || ' County'= c.COUNTY_NAME)
        LEFT JOIN OHPNM_DP4BI.ENROLL_STATUS es ON (d.ENROLLMENT_STATUS_CODE = es.ENROLL_STATUS_ID);