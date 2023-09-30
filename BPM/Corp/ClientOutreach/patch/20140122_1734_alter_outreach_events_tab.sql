ALTER TABLE CORP_ETL_CLNT_OUTREACH_EVENTS
ADD (EVENT_EVENT_ID NUMBER,
     EVENT_OUTREACH_ID NUMBER);

ALTER TABLE CORP_ETL_CLNT_OUTREACH_EVENTS
MODIFY (EVENT_REF_ID NULL, EVENT_REF_TYPE NULL);

CREATE SEQUENCE SEQ_EVENT_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;


CREATE OR REPLACE TRIGGER TRG_BI_CORP_ETL_CLNT_OR_EVENT BEFORE
  INSERT ON CORP_ETL_CLNT_OUTREACH_EVENTS FOR EACH ROW
BEGIN  
    IF :NEW.EVENT_ID IS NULL THEN
      SELECT SEQ_EVENT_ID.Nextval INTO :NEW.EVENT_ID FROM Dual;
    END IF;
END;
/
ALTER TRIGGER TRG_BI_CORP_ETL_CLNT_OR_EVENT ENABLE;


create or replace view D_COR_OR_EVENT_SV as
select * 
from CORP_ETL_CLNT_OUTREACH_EVENTS
with read only;

create or replace public synonym D_COR_OR_EVENT_SV for D_COR_OR_EVENT_SV;
grant select on D_COR_OR_EVENT_SV to MAXDAT_READ_ONLY;

CREATE INDEX CORP_ETL_CLNT_OUT_EVENTS_IDX3 ON CORP_ETL_CLNT_OUTREACH_EVENTS (EVENT_OUTREACH_ID) TABLESPACE MAXDAT_INDX ;