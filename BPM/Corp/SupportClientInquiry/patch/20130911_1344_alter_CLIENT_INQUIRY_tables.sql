-- 9/11/13 Fix "ORA-20114: Value and supplementary do not match: SUPP_CREATED_BY/CREATED_BY"

ALTER TABLE corp_etl_client_inquiry MODIFY
(supp_created_by NULL, created_by NULL, supp_update_by NULL, last_update_by_name NULL, last_update_dt NULL, create_dt NULL)
/

ALTER TABLE corp_etl_clnt_inqry_wip MODIFY
(supp_created_by NULL, created_by NULL, supp_update_by NULL, last_update_by_name NULL, last_update_dt NULL, create_dt NULL)
/

ALTER TABLE corp_etl_clnt_inqry_oltp MODIFY
(supp_created_by NULL, supp_update_by NULL, create_dt NULL)
/


ALTER TABLE corp_etl_client_inquiry_event MODIFY
(supp_event_created_by NULL, event_created_by NULL, EVENT_CREATE_DT NULL)
/

ALTER TABLE corp_etl_clnt_inqry_event_wip MODIFY
(supp_event_created_by NULL, event_created_by NULL, EVENT_CREATE_DT NULL)
/

ALTER TABLE corp_etl_clnt_inqry_event_oltp MODIFY
(supp_event_created_by NULL, EVENT_CREATE_DT NULL)
/

