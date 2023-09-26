/*
Created on 09/22/2016 by Raj A.
Description: MFD Doc V2 has been hanging up everyday at ProcessMailFaxDoc_CDC_MAXe6.ktr.
This is because the sql is taking a long time due to missing index DOC_LINK_STG.document_id
*/
create index MAXDAT.IDX4_DOC_ID on MAXDAT.DOC_LINK_STG (DOCUMENT_ID);