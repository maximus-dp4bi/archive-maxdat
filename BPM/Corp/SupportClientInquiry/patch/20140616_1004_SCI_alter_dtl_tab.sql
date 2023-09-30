-- TXEB-2576 SCI region attributes for Client Outreach

ALTER TABLE corp_etl_client_inquiry_dtl ADD
(supp_addr_id     NUMBER(18)
,residence_county VARCHAR2(32)
,service_area     VARCHAR2(64)
,region           VARCHAR2(64));

ALTER TABLE corp_etl_clnt_inqry_dtl_oltp ADD
(supp_addr_id     NUMBER(18)
,residence_county VARCHAR2(32)
,service_area     VARCHAR2(64)
,region           VARCHAR2(64));

ALTER TABLE corp_etl_clnt_inqry_dtl_wip ADD
(supp_addr_id     NUMBER(18)
,residence_county VARCHAR2(32)
,service_area     VARCHAR2(64)
,region           VARCHAR2(64));

create or replace view D_SCID_CURRENT_SV as
select 
  CONTACT_RECORD_ID,
  CONTACT_RECORD_LINK_ID,
  CLIENT_ID,
  CASE_ID,
  PROGRAM_TYPE program,
  PROGRAM_SUBTYPE subprogram,
  CLIENT_UNDER_TWENTYONE,
  RESIDENCE_COUNTY,
  SERVICE_AREA,
  REGION
from CORP_ETL_CLIENT_INQUIRY_DTL
with read only;

