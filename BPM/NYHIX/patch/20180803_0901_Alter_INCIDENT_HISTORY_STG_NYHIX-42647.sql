-- NYHIX-42647
ALTER TABLE MAXDAT.INCIDENT_HISTORY_STG 
modify (OLD_VALUE VARCHAR2 (4000)
      , NEW_VALUE VARCHAR2 (4000)
);

CREATE or REPLACE VIEW MAXDAT.INCIDENT_HISTORY_STG_SV
AS SELECT
      INCIDENT_HISTORY_ID
    , TRANSACTION_ID
    , INCIDENT_HEADER_ID
    , FIELD_REF_TYPE
    , FIELD
    , OLD_VALUE
    , NEW_VALUE
    , CREATED_BY
    , CREATE_TS
    , IH_DTL_DESC_EXT_ID
    , CHILD_SL_NO
FROM MAXDAT.INCIDENT_HISTORY_STG WITH READ ONLY;

