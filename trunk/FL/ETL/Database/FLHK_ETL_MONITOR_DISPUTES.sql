Create table FLHK_ETL_MONITOR_DISPUTES
(
MD_ID	NUMBER(18,0) NOT NULL,
DISPUTE_ID	NUMBER(18,0) NOT NULL,
DISPUTE_ID_CREATE_DATE	DATE NOT NULL,
ACCOUNT_ID	VARCHAR2(38 BYTE),
CHANNEL	VARCHAR2(80 BYTE),
WORK_REQUEST_ID	NUMBER(18,0),
DISPUTE_CREATE_DATE	DATE NOT NULL,
RECEIPT_DATE	DATE,
STAFF_USERID	VARCHAR2(100 BYTE),
STAFF_ROLE	VARCHAR2(100 BYTE),
REPORTER_TYPE	VARCHAR2(100 BYTE),
DISPUTE_STATUS	VARCHAR2(100 BYTE),
DISPUTE_STATUS_DATE	DATE,
CANCEL_DATE	DATE,
DISPUTE_LEVEL	VARCHAR2(100 BYTE),
DISPUTE_LIABILITY	VARCHAR2(20 BYTE),
SENT_TO_STATE_DATE	DATE,
DISPUTE_RESOLUTION	VARCHAR2(100 BYTE),
DISPUTE_ACKNOWLEDGE_REQ_ID	NUMBER,
DISPUTE_DISPOSITION	VARCHAR2(100 BYTE),
ASSD_PROCESS_DISPUTES	DATE NOT NULL,
ASED_PROCESS_DISPUTES	DATE,
ASF_PROCESS_DISPUTES	VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL,
STAGE_DONE_DATE	DATE,
STG_EXTRACT_DATE	DATE,
STG_LAST_UPDATE_DATE	DATE,
INSTANCE_STATUS	VARCHAR2(100 BYTE) DEFAULT 'ACTIVE' NOT NULL,
INSTANCE_COMPLETE_DATE	DATE,
ACCOUNT_NUMBER	VARCHAR2(38 BYTE),
UPDATED	VARCHAR2(1 BYTE),
COMPLETE_DATE	DATE,
INSTANCE_STATUS_DATE	DATE,
AGE_CALENDER_DAYS	NUMBER(18,0),
AGE_BUSINESS_DAYS	NUMBER(18,0)
);

--------------------------------------------------------
--  DDL for Index DISPUTE_ID_PK
--------------------------------------------------------

  
CREATE UNIQUE INDEX "DISPUTE_ID_PK" ON "FLHK_ETL_MONITOR_DISPUTES" ("DISPUTE_ID");

/

--------------------------------------------------------
--  Constraints for Table FLHK_ETL_MONITOR_DISPUTES
--------------------------------------------------------

  
ALTER TABLE "FLHK_ETL_MONITOR_DISPUTES" ADD CONSTRAINT "DISPUTE_ID_PK" PRIMARY KEY ("DISPUTE_ID") ENABLE;

/


--------------------------------------------------------
--  DDL for Trigger FLHK_ETL_MONITOR_DISPUTES_TRG
--------------------------------------------------------

  
CREATE OR REPLACE TRIGGER "FLHK_ETL_MONITOR_DISPUTES_TRG" before
  INSERT ON "FLHK_ETL_MONITOR_DISPUTES" FOR EACH row BEGIN IF inserting THEN IF :NEW."MD_ID" IS NULL THEN
  SELECT FLHK_ETL_MONITOR_DISPUTES_SEQ.nextval INTO :NEW."MD_ID" FROM dual;
END IF;
END IF;
END;
/
ALTER TRIGGER "FLHK_ETL_MONITOR_DISPUTES_TRG" ENABLE;
/
