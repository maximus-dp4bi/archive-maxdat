CREATE OR REPLACE PROCEDURE UPDATE_PAEAP_CUR_ENR_CNTYS
AS
BEGIN
    execute immediate 'TRUNCATE TABLE MAXDAT_SUPPORT.PAEAP_CUR_ENROLL_COUNTIES';    
    INSERT INTO MAXDAT_SUPPORT.PAEAP_CUR_ENROLL_COUNTIES
          (
            CLIENT_ID,
            START_ND,
            END_ND,
            COUNTY_CD,
            RNK
          )
    WITH tmp AS
      (SELECT DISTINCT mi.client_id ,
        mi.START_ND ,
        mi.END_ND
      FROM elig_segment_and_details mi
      JOIN client c       ON (c.CLNT_CLIENT_ID = mi.CLIENT_ID)
      WHERE mi.SEGMENT_TYPE_CD = 'MI'
      AND mi.START_ND <= to_number(to_char(LAST_DAY(sysdate), 'yyyymmdd'))
      AND mi.END_ND >= to_number(to_char(ADD_MONTHS(TRUNC(sysdate, 'mm'), -3), 'yyyymmdd')) -- still enrolled at the last day of the month
      AND mi.START_ND < mi.END_ND
      AND mi.CREATE_TS < sysdate
      AND (mi.SEGMENT_DETAIL_VALUE_1 = 'B'
      OR mi.SEGMENT_DETAIL_VALUE_1 = 'C')
      AND NOT EXISTS
        ( -- to exclude the new eligibles
        SELECT 1
        FROM elig_segment_and_details mi2
        WHERE mi2.client_id = mi.client_id
        AND mi2.CREATE_TS < sysdate
        AND mi2.SEGMENT_TYPE_CD = 'MI'
        AND mi2.START_ND > mi.START_ND
        AND mi2.START_ND < mi2.END_ND
        AND (mi2.SEGMENT_DETAIL_VALUE_1 = 'A'
        OR mi2.SEGMENT_DETAIL_VALUE_1 = 'M')
        AND mi2.ELIG_SEGMENT_AND_DETAILS_ID < mi.ELIG_SEGMENT_AND_DETAILS_ID
        )
      )
    SELECT tmp.client_id,
      tmp.start_nd ,
      tmp.end_nd ,
      CASE PL.SEGMENT_DETAIL_VALUE_5
        WHEN 'Placement'
        THEN pl.segment_detail_value_1
        WHEN 'Residence'
        THEN me.segment_detail_value_1
        WHEN 'Waiver'
        THEN pl.segment_detail_value_4
      END AS COUNTY_CD ,
      rank() over(partition BY tmp.client_id, tmp.start_nd , tmp.end_nd order by me.elig_segment_and_details_id DESC) AS rnk
    FROM tmp
    JOIN elig_segment_and_details pl ON (pl.client_id = tmp.client_id AND pl.segment_type_cd = 'PL')
    JOIN elig_segment_and_details me ON (me.CLIENT_ID = pl.CLIENT_ID AND me.segment_type_cd = 'ME' )
    WHERE pl.END_ND >= to_number(to_char(ADD_MONTHS(TRUNC(sysdate, 'mm'), -3), 'yyyymmdd')) --? may not be accurate
    AND pl.START_ND <= to_number(to_char(LAST_DAY(sysdate), 'yyyymmdd'))
    AND pl.START_ND < pl.END_ND
    AND pl.START_ND <= tmp.START_ND
    AND pl.END_ND > tmp.START_ND
    AND pl.CREATE_TS <= sysdate
    AND me.END_ND > to_number(to_char(ADD_MONTHS(TRUNC(sysdate, 'mm'), -3), 'yyyymmdd')) --?
    AND me.START_ND < me.END_ND
    AND me.START_ND <= tmp.START_ND
    AND me.END_ND >= tmp.START_ND
    AND me.END_ND <= tmp.END_ND --? may not be accurate
    AND me.CREATE_TS <= sysdate; 
COMMIT;
END;


