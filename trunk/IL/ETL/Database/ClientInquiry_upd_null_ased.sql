-- 6/13/13 Data fix for nul ASED
UPDATE corp_etl_client_inquiry SET ased_handle_contact = contact_end_dt
 WHERE ased_handle_contact is null
   AND asf_handle_contact = 'Y';
COMMIT;