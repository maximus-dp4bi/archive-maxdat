CREATE TABLE txeb2649_co_oltp_event_temp
(event_id NUMBER NOT NULL
,call_record_id NUMBER NOT NULL
, CONSTRAINT txeb2649_oltp_event_pk PRIMARY KEY (event_id)
  USING INDEX TABLESPACE MAXDAT_INDX);