--Ammendment tables

CREATE TABLE S_CRS_IMR_CERT_SPECIALTY
  (
    SCICS_ID   	   		        NUMBER (19) NOT NULL ,
    EXPERT_CERT_SPECIALTY_ID       	NUMBER (19) NOT NULL ,
    EXPERT_REVIEW_ID             	NUMBER (19) ,
    LIST_ORDER		             	NUMBER (19),
    SUBSPECIALTY_CODE		   	VARCHAR2(255),
    CREATE_DT                           DATE NOT NULL,
    CREATED_BY                          VARCHAR2(100) NOT NULL,
    UPDATE_DT                           DATE NOT NULL,
    UPDATED_BY                          VARCHAR2(100) NOT NULL
);

ALTER TABLE S_CRS_IMR_CERT_SPECIALTY ADD CONSTRAINT SCICS_ID_PK PRIMARY KEY
(
  SCICS_ID
)
;

ALTER TABLE S_CRS_IMR_CERT_SPECIALTY ADD CONSTRAINT SCICS__UN UNIQUE
(
  EXPERT_CERT_SPECIALTY_ID
)
;

CREATE TABLE S_CRS_IMR_EXPERT_LICENSE_STATE
  (
    SCIELS_ID   	   		NUMBER (19) NOT NULL ,
    EXPERT_STATE_ID       		NUMBER (19) NOT NULL ,
    EXPERT_REVIEW_ID             	NUMBER (19) ,
    LIST_ORDER		             	NUMBER (19),
    STATE_ID		   		NUMBER (19),
    CREATE_DT                           DATE NOT NULL,
    CREATED_BY                          VARCHAR2(100) NOT NULL,
    UPDATE_DT                           DATE NOT NULL,
    UPDATED_BY                          VARCHAR2(100) NOT NULL
  );

ALTER TABLE S_CRS_IMR_EXPERT_LICENSE_STATE ADD CONSTRAINT SCIELS_ID_PK PRIMARY KEY
(
  SCIELS_ID
)
;

ALTER TABLE S_CRS_IMR_EXPERT_LICENSE_STATE ADD CONSTRAINT SCIELS__UN UNIQUE
(
  EXPERT_STATE_ID
)
;

CREATE TABLE D_CRS_IMR_EXPERT_SUBSPECIALTY
  (
    DCIES_ID   	   		NUMBER (19) NOT NULL ,
    EXPERT_CERT_SPECIALTY_ID    NUMBER (19) NOT NULL ,
    SUBSPECIALTY_CODE		VARCHAR2 (255),
    SUBSPECIALTY_NAME           VARCHAR2 (255),
    SUBSPECIALTY_ACTIVE_FLAG	NUMBER (1),
    SUBSPECIALTY_ORDER		NUMBER (19),
    CREATE_DT                           DATE NOT NULL ,
    UPDATE_DT                           DATE NOT NULL
  );

ALTER TABLE D_CRS_IMR_EXPERT_SUBSPECIALTY ADD CONSTRAINT DCIES_ID_PK PRIMARY KEY
(
  DCIES_ID
)
;

ALTER TABLE D_CRS_IMR_EXPERT_SUBSPECIALTY ADD CONSTRAINT DCIES__UN UNIQUE
(
  EXPERT_CERT_SPECIALTY_ID
)
;
