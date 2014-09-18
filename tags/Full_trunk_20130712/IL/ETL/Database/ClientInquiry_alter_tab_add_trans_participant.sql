-- 6/3/13 Make participant status an ETL attribute.
-- 6/4/13 Add attributes to child detail table.

ALTER TABLE corp_etl_client_inquiry ADD (participant_status VARCHAR2(15));
ALTER TABLE corp_etl_clnt_inqry_wip ADD (participant_status VARCHAR2(15));

--
ALTER TABLE corp_etl_client_inquiry_dtl ADD (translation_req VARCHAR2(1), participant_status VARCHAR2(15));
ALTER TABLE corp_etl_clnt_inqry_dtl_wip ADD (translation_req VARCHAR2(1), participant_status VARCHAR2(15));
