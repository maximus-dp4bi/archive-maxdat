-- 5/30 New indexes
CREATE INDEX corp_etl_clnt_inqry_dtl_idx02 ON corp_etl_client_inquiry_dtl
 ( contact_record_id )
  LOGGING TABLESPACE MAXDAT_INDX;

CREATE INDEX corp_etl_clnt_inqry_eve_idx02 ON corp_etl_client_inquiry_event
 ( contact_record_id )
  LOGGING TABLESPACE MAXDAT_INDX;
