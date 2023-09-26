DROP VIEW MAXDAT_SUPPORT.EMRS_D_AFFECTED_PARTY_TYPE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_AFFECTED_PARTY_TYPE_SV
AS
SELECT value AS AFFECTED_PARTY_TYPE_CD
      , description AS AFFECTED_PARTY_TYPE
FROM eb.ENUM_AFFECTED_PARTY_TYPE
UNION ALL
SELECT 'UD' AS AFFECTED_PARTY_TYPE_CD
      , 'Undefined' AS AFFECTED_PARTY_TYPE
FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AFFECTED_PARTY_TYPE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AFFECTED_PARTY_TYPE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AFFECTED_PARTY_TYPE_SV TO MAXDAT_SUPPORT_READ_ONLY;
