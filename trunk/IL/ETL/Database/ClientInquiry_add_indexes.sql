-- 5/30 New indexes
CREATE INDEX corp_etl_clnt_inqry_dtl_idx01 ON corp_etl_client_inquiry_dtl
 ( ceci_id )
  LOGGING TABLESPACE MAXDAT_INDX
  NOPARALLEL;

CREATE INDEX corp_etl_clnt_inqry_eve_idx01 ON corp_etl_client_inquiry_event
 ( ceci_id )
  LOGGING TABLESPACE MAXDAT_INDX
  NOPARALLEL;
