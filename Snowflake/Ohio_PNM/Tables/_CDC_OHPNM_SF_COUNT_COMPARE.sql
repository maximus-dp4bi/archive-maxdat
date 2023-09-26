CREATE TABLE "_CDC_OHPNM_SF_COUNT_COMPARE" (
    "TABLE_SCHEMA" STRING,
    "TABLE_NAME" STRING,
    "OHPNM_COUNT" NUMBER(38,0),
    "SF_COUNT" NUMBER(38,0),
    "LAST_UPDATED_DTM" TIMESTAMP DEFAULT current_timestamp(),
    OHPNM_MAX_UPDATE_DATE TIMESTAMP_NTZ(9),
    SF_MAX_UPDATE_DATE TIMESTAMP_NTZ(9)
);

CREATE OR REPLACE VIEW D_CDC_OHPNM_SF_TABLE_COMPARISON_SV
AS
SELECT c.table_name,ohpnm_count,CONVERT_TIMEZONE('America/Los_Angeles', 'America/New_York',ohpnm_max_update_date) ohpnm_max_update_date,sf_count,
CONVERT_TIMEZONE('UTC', 'America/New_York',sf_max_update_date) sf_max_update_date,
CONVERT_TIMEZONE('UTC', 'America/New_York',last_updated_dtm) last_updated_dtm
FROM ohpnm_dp4bi._CDC_OHPNM_SF_COUNT_COMPARE c;
