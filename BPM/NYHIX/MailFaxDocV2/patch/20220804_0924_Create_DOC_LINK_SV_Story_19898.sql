-- Create new view DOC_LINK_SV IAW User Story 19898 
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."DOC_LINK_SV" ("DOC_LINK_ID", "DOCUMENT_ID", "LINK_TYPE_CD", "AUTO_LINKED_IND", "CREATED_BY", "CREATE_TS", "CASE_ID", "CASE_CIN", "CLIENT_ID", "CLNT_CIN", "LINK_REF_ID", "ACCOUNT_ID", "HX_ID") AS 
  SELECT D.DOC_LINK_ID,
D.DOCUMENT_ID,
D.LINK_TYPE_CD,
D.AUTO_LINKED_IND,
D.CREATED_BY,
D.CREATE_TS,
ca.CASE_ID,
CA.CASE_CIN ,
c.clnt_CLIENT_ID,
C.CLNT_CIN,
D.LINK_REF_ID,
d.ACCOUNT_ID,
d.HX_ID
FROM MAXDAT.DOC_LINK_STG D
LEFT JOIN MAXDAT.CLIENT_STG C ON C.CLNT_CLIENT_ID = D.CLIENT_ID
LEFT JOIN MAXDAT.CASES_STG CA ON CA.CASE_ID = D.CASE_ID
WITH read only;
GRANT SELECT ON MAXDAT.DOC_LINK_SV TO DP_SCORECARD;
GRANT INSERT ON MAXDAT.DOC_LINK_SV TO MAXDAT_OLTP_SIU;
GRANT SELECT ON MAXDAT.DOC_LINK_SV TO MAXDAT_OLTP_SIU;
GRANT UPDATE ON MAXDAT.DOC_LINK_SV TO MAXDAT_OLTP_SIU;
GRANT DELETE ON MAXDAT.DOC_LINK_SV TO MAXDAT_OLTP_SIUD;
GRANT INSERT ON MAXDAT.DOC_LINK_SV TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON MAXDAT.DOC_LINK_SV TO MAXDAT_OLTP_SIUD;
GRANT UPDATE ON MAXDAT.DOC_LINK_SV TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON MAXDAT.DOC_LINK_SV TO MAXDAT_READ_ONLY;
