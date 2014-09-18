-- Synonyms
DROP PUBLIC SYNONYM seq_ceci_id;
DROP PUBLIC SYNONYM seq_cecid_id;
DROP PUBLIC SYNONYM seq_cecie_id;
DROP PUBLIC SYNONYM corp_etl_client_inquiry;
DROP PUBLIC SYNONYM corp_etl_client_inquiry_dtl;
DROP PUBLIC SYNONYM corp_etl_client_inquiry_event;

-- Sequences
DROP SEQUENCE seq_ceci_id;
DROP SEQUENCE seq_cecid_id;
DROP SEQUENCE seq_cecie_id;


-- BPM Tables
DROP TABLE corp_etl_client_inquiry_event;
DROP TABLE corp_etl_client_inquiry_dtl;
DROP TABLE corp_etl_client_inquiry;

-- WIP Tables
DROP TABLE corp_etl_clnt_inqry_oltp;
DROP TABLE corp_etl_clnt_inqry_wip;
DROP TABLE corp_etl_clnt_inqry_dtl_oltp;
DROP TABLE corp_etl_clnt_inqry_dtl_wip;
DROP TABLE corp_etl_clnt_inqry_event_oltp;
DROP TABLE corp_etl_clnt_inqry_event_wip;
