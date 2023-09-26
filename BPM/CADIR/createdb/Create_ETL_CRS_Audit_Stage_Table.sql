CREATE TABLE S_CRS_IMR_AUDIT_STAGE
(
 SCIAS_ID                                          NUMBER(19,0) NOT NULL
,ID_BASE                                           NUMBER(19,0) 
,C_TABLE                                           VARCHAR2(255)
,C_TIMESTAMP                                       DATE
,CREATE_DT                                         DATE
,CREATED_BY                                        VARCHAR2(100)
,LAST_UPDATE_DT                                    DATE
,LAST_UPDATED_BY                                   VARCHAR2(100)
);

ALTER TABLE S_CRS_IMR_AUDIT_STAGE ADD CONSTRAINT S_CRS_IMR_AUDIT_PK PRIMARY KEY
(
  SCIAS_ID
);

CREATE INDEX ID_BASE_INDX ON S_CRS_IMR_AUDIT_STAGE
  (
    ID_BASE
  );
  
CREATE INDEX C_TABLE_INDX ON S_CRS_IMR_AUDIT_STAGE
  (
    C_TABLE
  );  
