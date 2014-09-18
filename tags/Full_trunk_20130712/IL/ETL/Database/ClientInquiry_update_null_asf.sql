-- 6/10/13

 
UPDATE corp_etl_client_inquiry
   SET asf_handle_contact = 'N'
 WHERE asf_handle_contact IS NULL;
COMMIT;

UPDATE corp_etl_client_inquiry
   SET asf_create_route_work = 'N'
 WHERE asf_create_route_work IS NULL;
COMMIT;

UPDATE corp_etl_client_inquiry
   SET asf_cancel_contact = 'N'
 WHERE asf_cancel_contact IS NULL;
COMMIT;
