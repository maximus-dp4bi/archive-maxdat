/*
Created on 12-Oct-2017 by Guy T.
Description: This sequence is used to populate CORP_ETL_MW.cemw_id
*/

CREATE SEQUENCE SEQ_CEMW_ID
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    MAXVALUE 999999999
    NOCYCLE
    NOORDER
    CACHE 10;

CREATE SEQUENCE SEQ_D_BPM_FLOW_instance
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    MAXVALUE 999999999
    NOCYCLE
    NOORDER
    CACHE 10;



CREATE SEQUENCE SEQ_D_BPM_segment_instance
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    MAXVALUE 999999999
    NOCYCLE
    NOORDER
    CACHE 10;

