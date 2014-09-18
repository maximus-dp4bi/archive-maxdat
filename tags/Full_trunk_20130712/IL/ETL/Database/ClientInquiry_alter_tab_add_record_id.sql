/* 5/31 Add column for MircoStrategy reports
   - Add CONTACT_RECORD_ID to children ETL tables.
   - Populate children tables of the values.
   - Updating remaining Active instances where ASF_HANDL_CONTACT is null.
*/

ALTER TABLE corp_etl_client_inquiry_dtl ADD (contact_record_id NUMBER(18));
ALTER TABLE corp_etl_client_inquiry_event ADD (contact_record_id NUMBER(18));
-- Temp tables
TRUNCATE TABLE corp_etl_clnt_inqry_dtl_wip;
TRUNCATE TABLE corp_etl_clnt_inqry_dtl_oltp;
TRUNCATE TABLE corp_etl_clnt_inqry_event_wip;
TRUNCATE TABLE corp_etl_clnt_inqry_event_oltp;
ALTER TABLE corp_etl_clnt_inqry_dtl_wip ADD (contact_record_id NUMBER(18) NOT NULL);
ALTER TABLE corp_etl_clnt_inqry_dtl_oltp ADD (contact_record_id NUMBER(18) NOT NULL);
ALTER TABLE corp_etl_clnt_inqry_event_wip ADD (contact_record_id NUMBER(18) NOT NULL);
ALTER TABLE corp_etl_clnt_inqry_event_oltp ADD (contact_record_id NUMBER(18) NOT NULL);

DECLARE
  v_cnt INTEGER := 0;
BEGIN
  FOR ci IN (SELECT ceci_id, contact_record_id FROM corp_etl_client_inquiry)
  LOOP UPDATE corp_etl_client_inquiry_dtl dt
          SET contact_record_id = ci.contact_record_id
        WHERE dt.ceci_id = ci.ceci_id;
       UPDATE corp_etl_client_inquiry_event ev
          SET contact_record_id = ci.contact_record_id
        WHERE ev.ceci_id = ci.ceci_id;
       v_cnt := v_cnt + 1;
       IF v_cnt = 500
       THEN COMMIT; v_cnt := 0;
       END IF;
  END LOOP;
  commit;
END;
/

-- Stamp remaining Active Handle Contact ASF
UPDATE corp_etl_client_inquiry SET asf_handle_contact = 'N'
 WHERE instance_status = 'Active' AND contact_end_dt IS NULL
   AND asf_handle_contact IS NULL
   AND ceci_id >= 448;
COMMIT;
