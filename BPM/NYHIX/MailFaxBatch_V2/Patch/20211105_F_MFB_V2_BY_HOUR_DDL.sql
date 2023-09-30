DROP SEQUENCE  MAXDAT.SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID ;

CREATE SEQUENCE  MAXDAT.SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID 
-- FROM p_FMFBBH_ID := SEQ_FMFBBH_ID.nextval;
MINVALUE 1 MAXVALUE 999999999999999999999999999 
INCREMENT BY 1 
START WITH 374368
NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

GRANT SELECT ON MAXDAT.SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID TO MAXDAT_REPORTS;

DROP TABLE MAXDAT.F_MFB_V2_BY_HOUR;

CREATE TABLE MAXDAT.F_MFB_V2_BY_HOUR 
 NOCOMPRESS NOLOGGING 
  TABLESPACE MAXDAT_DATA 
AS
SELECT * FROM MAXDAT.F_MFB_BY_HOUR;

ALTER TABLE F_MFB_V2_BY_HOUR
RENAME COLUMN FMFBBH_ID TO F_MFB_V2_FBH_ID;

ALTER TABLE F_MFB_V2_BY_HOUR
RENAME COLUMN MFB_BI_ID TO MFB_V2_BI_ID;


--CREATE INDEX MAXDAT.FMFBBH_V2_IXL1 
--ON MAXDAT.F_MFB_V2_BY_HOUR (BUCKET_END_DATE) 
--TABLESPACE MAXDAT_INDX; 

CREATE INDEX MAXDAT.FMFBBH_V2_IXL2 
ON MAXDAT.F_MFB_V2_BY_HOUR (MFB_V2_BI_ID) 
TABLESPACE MAXDAT_INDX; 

CREATE UNIQUE INDEX MAXDAT.FMFBBH_V2_UIX1 
ON MAXDAT.F_MFB_V2_BY_HOUR (MFB_V2_BI_ID, D_DATE) 
TABLESPACE MAXDAT_INDX; 

CREATE UNIQUE INDEX MAXDAT.FMFBBH_V2_UIX2 
ON MAXDAT.F_MFB_V2_BY_HOUR (MFB_V2_BI_ID, BUCKET_START_DATE) 
TABLESPACE MAXDAT_INDX; 

GRANT SELECT ON MAXDAT.F_MFB_V2_BY_HOUR TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.F_MFB_V2_BY_HOUR TO MAXDAT_REPORTS;
