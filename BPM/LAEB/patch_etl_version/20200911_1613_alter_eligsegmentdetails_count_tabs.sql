ALTER TABLE EMRS_S_ELIG_SEGMENT_DETAILS_COUNT_STG ADD(segment_type_cd VARCHAR2(32));

ALTER TABLE EMRS_D_ELIG_SEGMENT_DETAILS_DPCOUNT ADD(segment_type_cd VARCHAR2(32));

DROP INDEX ELIGSEGMENT_DPCOUNT_UDX01;
DROP INDEX ELIGSEGMENT_STGCOUNT_IDX01;

CREATE UNIQUE INDEX ELIGSEGMENT_DPCOUNT_UDX01 ON EMRS_D_ELIG_SEGMENT_DETAILS_DPCOUNT(RECORD_DATE,SEGMENT_TYPE_CD) TABLESPACE MAXDAT_LAEB_DATA;
CREATE INDEX ELIGSEGMENT_STGCOUNT_IDX01 ON EMRS_S_ELIG_SEGMENT_DETAILS_COUNT_STG(RECORD_DATE,SEGMENT_TYPE_CD) TABLESPACE MAXDAT_LAEB_DATA;    