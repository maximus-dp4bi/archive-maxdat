CREATE OR REPLACE PROCEDURE UPDATE_PAEAP_CUR_ENROLLEES
AS
BEGIN
    execute immediate 'TRUNCATE TABLE MAXDAT_SUPPORT.PAEAP_CUR_ENROLLEES';    
    INSERT INTO MAXDAT_SUPPORT.PAEAP_CUR_ENROLLEES
      (ELIG_SEGMENT_AND_DETAILS_ID,
        CLIENT_ID,
        CLNT_CIN,
        CLNT_DOB,
        CLNT_GENDER_CD,
        PROGRAM_CD,
        AID_CATEGORY,
        PLAN_ID_EXT,
        START_ND,
        END_ND,
        COUNTY_CD)
with 
-- MI records (Plan, Plan Start Date, Plan End Date) for the prior month
MI as ( 
    SELECT mi.elig_segment_and_details_id,                  
            mi.client_id ,
            mi.segment_detail_value_2 plan_Id_Ext ,
            mi.START_ND ,
            mi.END_ND
          FROM elig_segment_and_details mi
          WHERE mi.SEGMENT_TYPE_CD = 'MI' 
          AND mi.segment_detail_value_2 IN (select plan_id_ext
                                                from eb.plans p
                                                where plan_id in (select plan_id from eb.contract c where c.status_cd = 'ACTIVE')) 
          -- MI end date is after 1st day of reporting month
          AND mi.END_ND > to_number(to_char(ADD_MONTHS(TRUNC(sysdate, 'mm'), -4), 'yyyymmdd')) --20170201, 20161201
          -- MI start date is before or on first day of reporting month
          AND mi.START_ND <= to_number(to_char(TRUNC(sysdate, 'mm'), 'yyyymmdd')) --20170201, 20170401
          AND EXISTS (select 1 from elig_segment_and_details meseg 
                       where meseg.CLIENT_ID = mi.CLIENT_ID 
                         and meseg.SEGMENT_TYPE_CD = 'ME'
                         -- ME end date is after the 1st day of reporting month
                         and meseg.END_ND > mi.START_ND  --20170201, 20161201
                         -- ME start date is before or on the 1st day of reporting month
                         and meseg.START_ND <= mi.END_ND  --20170201, 20170401
                        )
        ),
-- CASE_CLIENT records (Aid Category) the prior month
AC as (select client_id, aid_Category, rnk 
        from (select cscl_clnt_client_id client_id, c.CSCL_ADLK_ID aid_Category, RANK() OVER (PARTITION BY c.cscl_clnt_client_id ORDER BY c.cscl_id desc) rnk
              from case_client c 
              where TO_NUMBER (TO_CHAR (c.CSCL_STATUS_BEGIN_DATE, 'yyyymmdd')) <= to_number(to_char(TRUNC(sysdate, 'mm'), 'yyyymmdd')) --20170201, 20170401
              AND COALESCE ( TO_NUMBER (TO_CHAR (CSCL_STATUS_END_DATE, 'yyyymmdd')),99991231) > to_number(to_char(ADD_MONTHS(TRUNC(sysdate, 'mm'), -4), 'yyyymmdd')) --20170201, 20161201
              )
        where  rnk = 1
        )

-- Retrieve Enrollment County using ME, PL segments
select ELIG_SEGMENT_AND_DETAILS_ID
  , CLIENT_ID
  , CLNT_CIN
  , CLNT_DOB
  , CLNT_GENDER_CD
  , 'MEDICAID' PROGRAM_CD
  , AID_CATEGORY
  , PLAN_ID_EXT
  , START_ND
  , END_ND
  , COUNTY_CD
    from (
        SELECT MI.ELIG_SEGMENT_AND_DETAILS_ID
        , MI.CLIENT_ID
        , c.CLNT_CIN
        , c.CLNT_DOB
        , c.CLNT_GENDER_CD
        , AC.AID_CATEGORY
        , MI.PLAN_ID_EXT
        , MI.START_ND
        , MI.END_ND
        , CASE PL.SEGMENT_DETAIL_VALUE_5
            WHEN 'Placement'
            THEN pl.segment_detail_value_1
            WHEN 'Residence'
            THEN me.segment_detail_value_1
            WHEN 'Waiver'
            THEN pl.segment_detail_value_4
          END AS COUNTY_CD,  
          rank() over(partition BY c.clnt_client_id, c.clnt_cin , c.clnt_dob , c.clnt_gender_cd , 'MEDICAID' , AC.aid_category , MI.plan_id_ext , MI.start_nd , MI.end_nd order by me.elig_segment_and_details_id desc, rownum DESC) AS rnk
        FROM MI
        JOIN AC ON MI.CLIENT_ID = AC.CLIENT_ID -- to get aid category
        JOIN CLIENT c ON c.clnt_client_id = MI.client_id -- to get client cin, dob, gender
        JOIN elig_segment_and_details pl ON (pl.client_id = MI.client_id AND pl.segment_type_cd = 'PL'  
                                            AND pl.END_ND > mi.START_ND
                                            AND pl.START_ND <= mi.END_ND
                                            AND pl.END_ND > pl.START_ND)
        JOIN elig_segment_and_details me ON (me.CLIENT_ID = pl.CLIENT_ID AND me.segment_type_cd = 'ME' 
                                            AND me.END_ND > mi.START_ND
                                            AND me.START_ND <= mi.END_ND  
                                            AND me.END_ND > me.START_ND)
) where rnk = 1;

COMMIT;
END;


