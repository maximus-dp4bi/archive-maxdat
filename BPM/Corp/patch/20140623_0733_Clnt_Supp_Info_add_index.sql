-- TXEB-2576 SCI region attributes for Client Outreach

create index  CLNT_SUPPL_INFO_INDX1 on CLIENT_SUPPLEMENTARY_INFO_STG (CASE_ID) tablespace MAXDAT_INDX;

