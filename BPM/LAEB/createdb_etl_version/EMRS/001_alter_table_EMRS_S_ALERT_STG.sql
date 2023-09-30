ALTER TABLE EMRS_S_ALERT_STG ADD
(
    CREATED_BY                      VARCHAR2(80) 
    ,CREATE_TS                      DATE 
    ,UPDATED_BY                     VARCHAR2(80) 
    ,UPDATE_TS                      DATE 
);

DROP INDEX STG_IDX2_ALERTNUM;

CREATE UNIQUE INDEX EMRS_S_ALERT_STG_PK ON EMRS_S_ALERT_STG (ALERT_ID) TABLESPACE MAXDAT_LAEB_DATA;
ALTER TABLE EMRS_S_ALERT_STG ADD CONSTRAINT EMRS_S_ALERT_STG_PK PRIMARY KEY (ALERT_ID) USING INDEX EMRS_S_ALERT_STG_PK ENABLE;

