CREATE OR REPLACE VIEW D_PI_OTHER_PARTY_TYPE_SV
AS
  SELECT value OTHER_PARTY_TYPE_CD,
    report_label OTHER_PARTY_TYPE
  FROM ats.ENUM_OTHER_PARTY_TYPE
  UNION ALL 
  SELECT '0' AS OTHER_PARTY_TYPE_CD,
  'Not Defined' AS OTHER_PARTY_TYPE
  FROM DUAL;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_OTHER_PARTY_TYPE_SV TO MAXDAT_REPORTS ; 