ALTER TABLE TXEB_ETL_CHIP_ELIG_EVENTS
ADD (FEE_STATUS VARCHAR2(10));

ALTER TABLE TXEB_ETL_CHIP_ELIG_EVENT_OLTP
ADD (FEE_STATUS VARCHAR2(10));

ALTER TABLE TXEB_CHIP_ELIG_EVENTS_WIP_BPM
ADD (FEE_STATUS VARCHAR2(10));

ALTER TABLE D_CEE_CURRENT 
ADD (FEE_STATUS VARCHAR2(10));

ALTER TABLE D_CEE_HISTORY
ADD (FEE_STATUS VARCHAR2(10));

CREATE OR REPLACE view D_CEE_HISTORY_SV 
AS
SELECT h.DCEEBD_ID,
  h.BUCKET_START_DATE,
  h.BUCKET_END_DATE,
  h.CEEBI_ID,
  h.ENROLL_STAT_DENTAL,
  h.ENROLL_STAT_MED, 
  h.CASE_STATUS , 
  h.LAST_EVENT_DATE,
  h.fee_status
FROM D_CEE_HISTORY h join BPM_D_DATES bdd ON (bdd.D_DATE >= h.BUCKET_START_DATE AND bdd.D_DATE <= h.BUCKET_END_DATE);

CREATE OR REPLACE VIEW D_CEE_CURRENT_SV AS
SELECT * FROM D_CEE_CURRENT
WITH read only;

grant select on D_CEE_CURRENT_SV to MAXDAT_READ_ONLY;