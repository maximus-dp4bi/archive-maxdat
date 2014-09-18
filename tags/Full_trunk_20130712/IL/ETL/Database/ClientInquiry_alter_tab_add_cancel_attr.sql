ALTER TABLE corp_etl_client_inquiry ADD(cancel_method VARCHAR2(50), cancel_reason VARCHAR2(256), cancel_by VARCHAR2(50));
ALTER TABLE corp_etl_clnt_inqry_wip ADD(cancel_method VARCHAR2(50), cancel_reason VARCHAR2(256), cancel_by VARCHAR2(50));
