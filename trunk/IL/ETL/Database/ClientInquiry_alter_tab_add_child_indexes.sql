/* 5/31 Add column for MircoStrategy reports
   - Add CONTACT_RECORD_ID to children ETL tables.
   - Populate children tables of the values.
   - Updating remaining Active instances where ASF_HANDL_CONTACT is null.
*/

-- Make columns required
ALTER TABLE corp_etl_client_inquiry_dtl MODIFY (contact_record_id NOT NULL);
ALTER TABLE corp_etl_client_inquiry_event MODIFY (contact_record_id NOT NULL);
-- Add indexes
CREATE INDEX corp_etl_clnt_inqry_dtl_idx01 ON corp_etl_client_inquiry_dtl
 ( contact_record_id )
  LOGGING TABLESPACE MAXDAT_INDX;
CREATE INDEX corp_etl_clnt_inqry_eve_idx01 ON corp_etl_client_inquiry_event
 ( contact_record_id )
  LOGGING TABLESPACE MAXDAT_INDX;



