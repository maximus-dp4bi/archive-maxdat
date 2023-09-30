-- 6/10/13 Client Inquiry make ASF attributes required

ALTER TABLE corp_etl_client_inquiry
MODIFY(asf_handle_contact NOT NULL, asf_create_route_work NOT NULL, asf_cancel_contact NOT NULL);