CREATE TABLE CORP_MJ_FILE_CAL_LKUP
(
  ROW_ID                         NUMBER,
  FILE_NAME                      VARCHAR2(50 BYTE),
  SLA_RECEIPT_INTERVAL           VARCHAR2(50 BYTE),
  SLA_TIME                       DATE,
  LATE_FILE_ALERT_TIME           DATE,
  TIMELY_PROCESSING_ALERT_TIME   DATE,
  MINIMUM_RECORDS_EXPECTED       NUMBER,
  MAXIMUM_RECORDS_EXPECTED       NUMBER,
  PERCENTAGE_OF_ERRORS_TO_ALERT  NUMBER
);

CREATE UNIQUE INDEX XPKILEB_FILE_CAL_LKUP ON CORP_MJ_FILE_CAL_LKUP
(FILE_NAME)
TABLESPACE "MAXDAT_DATA" ;