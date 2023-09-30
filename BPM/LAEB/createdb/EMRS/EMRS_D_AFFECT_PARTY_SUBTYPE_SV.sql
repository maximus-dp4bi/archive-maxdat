DROP VIEW MAXDAT_SUPPORT.EMRS_D_AFFECT_PARTY_SUBTYPE_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_AFFECT_PARTY_SUBTYPE_SV
AS
SELECT value AS AFFECTED_PARTY_SUBTYPE_CD
      , description AS AFFECTED_PARTY_SUBTYPE
FROM eb.ENUM_AFFECTED_PARTY_SUBTYPE
UNION ALL
SELECT 'UD' AS AFFECTED_PARTY_SUBTYPE_CD
      , 'Undefined' AS AFFECTED_PARTY_SUBTYPE
FROM DUAL;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AFFECT_PARTY_SUBTYPE_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AFFECT_PARTY_SUBTYPE_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AFFECT_PARTY_SUBTYPE_SV TO MAXDAT_SUPPORT_READ_ONLY;
