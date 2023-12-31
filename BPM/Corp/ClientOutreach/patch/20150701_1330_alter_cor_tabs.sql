ALTER TABLE CORP_ETL_CLNT_OUTREACH
ADD (IMAGE_REFERENCE_ID NUMBER);

ALTER TABLE CORP_ETL_CLNT_OUTREACH_OLTP
ADD (IMAGE_REFERENCE_ID NUMBER);

ALTER TABLE CORP_ETL_CLNT_OUTREACH_WIP_BPM
ADD (IMAGE_REFERENCE_ID NUMBER);

ALTER TABLE D_COR_CURRENT
ADD (IMAGE_REFERENCE_ID NUMBER);

create index DCORCUR_IX8 ON D_COR_CURRENT(IMAGE_REFERENCE_ID) TABLESPACE MAXDAT_INDX;


create or replace view D_COR_CURRENT_SV as
select * 
from D_COR_CURRENT
with read only;

create or replace public synonym D_COR_CURRENT_SV for D_COR_CURRENT_SV;
grant select on D_COR_CURRENT_SV to MAXDAT_READ_ONLY;
