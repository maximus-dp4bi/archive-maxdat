
CREATE OR REPLACE VIEW D_QIC_DOCUMENT_SV
AS
SELECT
d.APPEAL_ID
, d.DOCUMENT_ID
, dt.doc_type_name as document_type
, d.ICN 
, ds.doc_source_name as source 
, d.MAILED_DATE  
, d.DUE_DATE 
, d.UPLOADED_DATE  
, d.DOCUMENT_CLAIMED_DATE
, d.SCANNED_DATE 
, d.CLASSIFIED_DATE 
, d.ASSOCIATED_DATE  
, d.DATE_RECEIVED 
, dri.doc_req_information_name as request_information  
, drs.doc_req_sent_to_name  as request_sent_to
, (select trim(st.first_name) || ' ' || (case when st.middle_name is not null then (trim(st.middle_name) || ' ') else '' end) || trim(st.last_name) from d_staff st where st.staff_id = d.REQUESTOR) as REQUESTOR  
, d.DATE_OF_REQUEST
, ap.part_name as APPEAL_PART
, d.STG_LAST_UPDATE_DATE
from D_QIC_DOCUMENT d
LEFT OUTER JOIN D_DOC_TYPES dt 
ON d.document_type = dt.doc_type_id
LEFT OUTER JOIN D_DOC_SOURCE ds 
ON d.SOURCE = ds.DOC_SOURCE_ID
LEFT OUTER JOIN D_DOC_REQ_INFORMATION dri 
ON d.request_information = dri.doc_req_information_id
LEFT OUTER JOIN D_DOC_REQ_SENT_TO drs ON d.REQUEST_SENT_TO = drs.DOC_REQ_SENT_TO_ID
LEFT OUTER JOIN D_MW_APPEAL_INSTANCE A ON d.APPEAL_ID = A.APPEAL_ID
LEFT OUTER JOIN D_APPEAL_PARTS ap ON A.APPEAL_PART_ID = ap.PART_ID
with read only;

GRANT SELECT ON D_QIC_DOCUMENT_SV TO MAXDAT_READ_ONLY;