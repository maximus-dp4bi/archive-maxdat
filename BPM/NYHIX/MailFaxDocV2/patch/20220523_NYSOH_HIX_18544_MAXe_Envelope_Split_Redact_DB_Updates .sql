ALTER TABLE MAXDAT.APP_DOC_DATA_EXT_STG
ADD  SPLIT_IN_MAXE_IND               NUMBER(1);

-------------------------------------------------------

select 
(select value from CORP_ETL_CONTROL
where name = 'MAXE_SPLIT_ENV_DETAILS' ) MAXE_SPLIT_ENV_DETAILS
from dual; 

INSERT INTO MAXDAT.CORP_ETL_CONTROL (
   NAME, 
   VALUE_TYPE, 
   VALUE, 
   DESCRIPTION, CREATED_TS, UPDATED_TS) 
VALUES ( 'MAXE_SPLIT_ENV_DETAILS', --< NAME 
 'D', -- << VALUE_TYPE 
 (TO_DATE('2022/01/01 00:00:00','YYYY/MM/DD HH24:MI:SS') - 15/24/60), -- << VALUE
 'Last date from APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS', -- << DESCRIPTION
 sysdate, -- << CREATED_TS
 sysdate -- << UPDATED_TS 
 );
 
commit; 

--------------------------------------------------------------

DROP TABLE MAXDAT.APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS;

CREATE TABLE MAXDAT.APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS
(
  MAXE_SPLIT_ENV_DETAILS_ID  NUMBER(18)         NOT NULL,
  MAXE_SPLIT_REDACT_IND      NUMBER(1),
  CHILD_ECN                  VARCHAR2(256 BYTE),
  PARENT_ECN                 VARCHAR2(256 BYTE),
--  XML_META_DATA              CLOB,
  CREATED_BY                 VARCHAR2(50 BYTE),
  CREATED_TS                 DATE,
  UPDATED_BY                 VARCHAR2(50 BYTE),
  UPDATED_TS                 DATE,
  ENV_NUM                    NUMBER(10),
  MAXDAT_CREATED_DATE		 DATE,
  MAXDAT_UPDATED_DATE		 DATE
)
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON MAXDAT.APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS TO MAXDAT_READ_ONLY;

---------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER MAXDAT.BIU_APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS 
    BEFORE INSERT OR UPDATE ON MAXDAT.APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS
    FOR EACH ROW
BEGIN
	IF INSERTING THEN
		:NEW.MAXDAT_CREATED_DATE := SYSDATE;
		:NEW.MAXDAT_UPDATED_DATE := NULL;
	END IF;

	IF UPDATING
	THEN
		:NEW.MAXDAT_UPDATED_DATE := SYSDATE;
	END IF;	

END;
/

---------------------------------------------------------------------------

CREATE INDEX MAXDAT.APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS_IDX 
ON MAXDAT.APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS
(MAXE_SPLIT_ENV_DETAILS_ID)
TABLESPACE MAXDAT_INDX;

ALTER TABLE MAXDAT.APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS ADD (
  CONSTRAINT APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS_PK
  PRIMARY KEY
  (MAXE_SPLIT_ENV_DETAILS_ID)
  USING INDEX MAXDAT.APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS_IDX
  ENABLE VALIDATE);

---------------------------------------------------------------------------

CREATE OR REPLACE VIEW APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS_SV
AS SELECT * FROM MAXDAT.APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS;

GRANT SELECT ON APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS_SV TO MAXDAT_REPORTS;
GRANT SELECT ON APP_DOC_DATA_MAXE_SPLIT_ENV_DETAILS_SV TO MAXDAT_READ_ONLY;

----------------------------------------------------------------------------