
-- Synonym
CREATE PUBLIC SYNONYM corp_etl_client_inquiry FOR corp_etl_client_inquiry;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_wip FOR corp_etl_clnt_inqry_wip;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_oltp FOR corp_etl_clnt_inqry_oltp;

CREATE PUBLIC SYNONYM corp_etl_client_inquiry_dtl FOR corp_etl_client_inquiry_dtl;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_dtl_wip FOR corp_etl_clnt_inqry_dtl_wip;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_dtl_oltp FOR corp_etl_clnt_inqry_dtl_oltp;

CREATE PUBLIC SYNONYM corp_etl_client_inquiry_event FOR corp_etl_client_inquiry_event;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_event_wip FOR corp_etl_clnt_inqry_event_wip;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_event_oltp FOR corp_etl_clnt_inqry_event_oltp;

CREATE PUBLIC SYNONYM seq_ceci_id FOR seq_ceci_id;
CREATE PUBLIC SYNONYM seq_cecid_id FOR seq_cecid_id;
CREATE PUBLIC SYNONYM seq_cecie_id FOR seq_cecie_id;


-- Grants
GRANT SELECT ON corp_etl_client_inquiry TO MAXDAT_READ_ONLY;
GRANT SELECT ON corp_etl_clnt_inqry_wip TO MAXDAT_READ_ONLY;
GRANT SELECT ON corp_etl_clnt_inqry_oltp TO MAXDAT_READ_ONLY;

GRANT SELECT ON corp_etl_client_inquiry_dtl TO MAXDAT_READ_ONLY;
GRANT SELECT ON corp_etl_clnt_inqry_dtl_wip TO MAXDAT_READ_ONLY;
GRANT SELECT ON corp_etl_clnt_inqry_dtl_oltp TO MAXDAT_READ_ONLY;

GRANT SELECT ON corp_etl_client_inquiry_event TO MAXDAT_READ_ONLY;
GRANT SELECT ON corp_etl_clnt_inqry_event_wip TO MAXDAT_READ_ONLY;
GRANT SELECT ON corp_etl_clnt_inqry_event_oltp TO MAXDAT_READ_ONLY;

GRANT SELECT ON seq_ceci_id TO MAXDAT_READ_ONLY;
GRANT SELECT ON seq_cecid_id TO MAXDAT_READ_ONLY;
GRANT SELECT ON seq_cecie_id TO MAXDAT_READ_ONLY;




